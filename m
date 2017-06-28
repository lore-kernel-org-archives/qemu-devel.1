Received: from eggs.gnu.org ([2001:4830:134:3::10]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQGyd-00054J-MF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQGyZ-0004Fn-9b
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQGyZ-0004Ey-0S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:42:03 -0400
Date: Wed, 28 Jun 2017 14:41:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628174158.GG12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9t8qy7d.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, Jun 28, 2017 at 11:05:26AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Rationale
> > ---------
> >
> > I'm often bothered by the fact that we can't write the following:
> >
> >     foo(arg, errp);
> >     if (*errp) {
> >         handle the error...
> >         error_propagate(errp, err);
> >     }
> >
> > because errp can be NULL.
> 
> If foo() additionally returned an indication of success, you could write
> 
>       if (!foo(arg, errp)) {    // assuming foo() returns a bool
>           handle the error...
>       }
> 
> Nicely concise.
> 
> For what it's worth, this is how GLib wants GError to be used.  We
> deviated from it, and it has turned out to be a self-inflicted wound.

Interesting, I didn't know about that.


> 
> > I understand the reason we need to support errp==NULL, as it
> > makes life simpler for callers that don't want any extra error
> > information.  However, this has the cost of making the functions
> > that report errors more complex and error-prone.
> >
> > (Evidence of that: the 34 ERR_IS_* cases handled by the "use
> > ERR_IS_* macros" patches in the series.  Where existing code will
> > crash or behave differently if errp is NULL.)
> 
> Which of them could *not* use a suitable return value instead of *errp?

I don't know.  But I'm not trying to improve those 34 ERR_IS_* cases.  I
am trying to improve the 700+ functions that need the
local_err/error_propagate() boilerplate code today.  This series already
handles 346 of them automatically (see patch 14/15).

> 
> > I considered suggesting forbidding NULL errp, and just changing
> > all callers that use NULL to have an err variable and call
> > error_free(), but this would mean changing 690 function callers
> > that pass NULL errp as argument.
> 
> Would also add lots of pointless malloc churn.  The ability to ignore
> errors is a feature.

Exactly.  My proposal keeps that ability.


> 
> > Here I'm proposing a mechanism to have the best of both worlds:
> > allow callers to ignore errors easily while allowing functions to
> > propagate errors without an intermediate local_err variable.
> >
> > The Proposal
> > ------------
> >
> > I'm proposing replacing NULL errp with a special macro:
> > IGNORE_ERRORS.  The macro will trigger special behavior in the
> > error API that will make it not save any error information in the
> > error pointer, but still keep track of boolean error state in
> > *errp.
> >
> > This will allow us to simplify the documented method to propagate errors
> > from:
> >
> >     Error *err = NULL;
> >     foo(arg, &err);
> >     if (err) {
> >         handle the error...
> >         error_propagate(errp, err);
> >     }
> >
> > to:
> >
> >     foo(arg, errp);
> >     if (ERR_IS_SET(errp)) {
> >         handle the error...
> >     }
> >
> > This will allow us to stop using local_err variables and
> > error_propagate() on hundreds of cases.
> 
> Getting rid of unnecessary local_err boilerplate is good.  The question
> is how.  A possible alternative to your proposal is to follow GLib and
> make functions return success/failure.
> 
> How do the two compare?

This proposal proposal already gets rid of 346 error_propagate() calls
automatically, and we probably can get rid of many others with
additional Coccinelle scripts.

Making functions return success/failure, on the other hand, would
require rewriting them manually.  This proposal doesn't even prevent
that from happening.  I'd say it helps on that, because we can now find
cases that still need to be converted by grepping for ERR_IS_SET.


> 
> > Implementation
> > --------------
> >
> > This replaces NULL errp arguments on function calls with a
> > IGNORE_ERRORS macro.  Checks for (!errp) are replaced by
> > ERR_IS_IGNORED(errp).  Checks for (*errp) are replaced by
> > ERR_IS_SET(errp).  No extra changes are required on function
> > callers.
> 
> That's a lot of churn.  One time pain, of course.

Yes, and it was automated using Coccinelle.

> 
> > Then IGNORE_ERRORS is implemend as:
> >
> >   (& { &ignored_error_unset })
> >
> > When error_set() is called and IGNORE_ERRORS was used, we set
> > error state using:
> >
> >   *errp = &ignored_error_set;
> >
> > This way, we can make ERR_IS_SET work even if errp was
> > IGNORE_ERRORS.  The ERR_IS_* macros are reimplemented as:
> >
> >   #define ERR_IS_SET(e) (*(e) && *(e) != &ignored_error_unset)
> >   #define ERR_IS_IGNORED(e) (!(e) || *(e) == &ignored_error_unset || *(e) == &ignored_error_set)
> >
> > Ensuring errp is never NULL
> > ---------------------------
> >
> > The last patch on this series changes the (Error **errp)
> > parameters in functions to (Error *errp[static 1]), just to help
> > validate the existing code, as clang warns about NULL arguments
> > on that case.  I don't think we should apply that patch, though,
> > because the "[static 1]" syntax confuses Coccinelle.
> >
> > I have a branch where I experimented with the idea of replacing
> > (Error **errp) parameters with an opaque type (void*, or a struct
> > type).  I gave up when I noticed it would require touching all
> > callers to replace &err with a wrapper macro to convert to the
> > right type.  Suggestions to make NULL errp easier to detect at
> > build time are welcome.
> >
> > (Probably the easiest solution for that is to add assert(errp)
> > lines to the ERR_IS_*() macros.)
> 
> We'll obviously struggle with null arguments until all the developers
> adjusted to the new interface.  Possibly with occasional mistakes
> forever.  Compile-time checking would really, really help.

True.  I'm investigating the possibility of using
__attribute__((nonull(...))) with Coccinelle's help.


> 
> > Desirable side-effects
> > ----------------------
> >
> > Some of additional benefits from parts of this series:
> >
> > * Making code that ignore error information more visible and
> >   greppable (using IGNORE_ERRORS).
> 
> True.
> 
> Drawback: Passing an address takes more code than passing null.  Not
> sure it matters.

I don't know what you mean by "more code".  It requires just replacing
NULL with IGNORE_ERRORS.  The magic is hidden behind the macro.


> 
> >                                     I believe many of those cases
> >   are actually bugs and should use &error_abort or &error_fatal
> >   instead.
> 
> I've seen such bugs.
> 
> Of course, making possible offenders more greppable doesn't necessarily
> mean existing ones will get fixed and new ones will be avoided.
> 
> > * Making code that depends on errp more visible and
> >   greppable (using ERR_IS_* macros).  Some of those cases are
> >   also likely to be bugs, and need to be investigated.
> 
> Grepping for (local_)?errp? works well enough, doesn't it?

I don't see how.  I'm talking about two cases:

1) Code like this:

  int func1(..., Error **errp)
  {
      do_something(errp);
      if (errp && *errp) {
          /* handle error */
          return;
      }
      /* do something else */
  }

func1() is buggy because it behaves differently if errp is NULL.


2) Code like this:

  int func2(..., Error **errp)
  {
      do_something(errp);
      if (*errp) {
          /* handle error */
      }
  }

func2() is buggy because if crashes if errp is NULL.


I don't see an easy way to grep for them with the current code.  With
this series, (1) can be detected by grepping for ERR_IS_IGNORED, and (2)
is fixed because ERR_IS_SET(errp) will work even if errp is NULL.


> 
> > TODO
> > ----
> >
> > * Simplify more cases of local_error/error_propagate() to use
> >   errp directly.
> > * Update API documentation and code examples.
> > * Add a mechanism to ensure errp is never NULL.
> >
> > Git branch
> > ----------
> >
> > This series depend on a few extra cleanups that I didn't submit
> > to qemu-devel yet.  A git branch including this series is
> > available at:
> >
> >   git://github.com/ehabkost/qemu-hacks.git work/err-api-rework-ignore-ptr-v1

-- 
Eduardo
