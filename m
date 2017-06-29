Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQZ0V-0003XH-7R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQZ0R-0004Ew-Nx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQZ0R-0004Db-F4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:57:11 -0400
Date: Thu, 29 Jun 2017 09:57:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170629125706.GT12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<20170628174158.GG12152@localhost.localdomain>
	<87mv8r2sii.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mv8r2sii.fsf@dusky.pond.sub.org>
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

On Thu, Jun 29, 2017 at 08:54:29AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Wed, Jun 28, 2017 at 11:05:26AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
[...]
> >> > I understand the reason we need to support errp==NULL, as it
> >> > makes life simpler for callers that don't want any extra error
> >> > information.  However, this has the cost of making the functions
> >> > that report errors more complex and error-prone.
> >> >
> >> > (Evidence of that: the 34 ERR_IS_* cases handled by the "use
> >> > ERR_IS_* macros" patches in the series.  Where existing code will
> >> > crash or behave differently if errp is NULL.)
> >> 
> >> Which of them could *not* use a suitable return value instead of *errp?
> >
> > I don't know.  But I'm not trying to improve those 34 ERR_IS_* cases.  I
> > am trying to improve the 700+ functions that need the
> > local_err/error_propagate() boilerplate code today.  This series already
> > handles 346 of them automatically (see patch 14/15).
> 
> I agree the goal is reducing error_propagate() boilerplate.  I latched
> onto the 34 ERR_IS_* cases only because you presented them as examples.

The 34 ERR_IS_* cases were evidence of how easy it is to introduce
mistakes with the current API.  Probably most of them are instances of
(1) and (2) below.

> 
[...]
> >> > The Proposal
> >> > ------------
> >> >
> >> > I'm proposing replacing NULL errp with a special macro:
> >> > IGNORE_ERRORS.  The macro will trigger special behavior in the
> >> > error API that will make it not save any error information in the
> >> > error pointer, but still keep track of boolean error state in
> >> > *errp.
> >> >
> >> > This will allow us to simplify the documented method to propagate errors
> >> > from:
> >> >
> >> >     Error *err = NULL;
> >> >     foo(arg, &err);
> >> >     if (err) {
> >> >         handle the error...
> >> >         error_propagate(errp, err);
> >> >     }
> >> >
> >> > to:
> >> >
> >> >     foo(arg, errp);
> >> >     if (ERR_IS_SET(errp)) {
> >> >         handle the error...
> >> >     }
> >> >
> >> > This will allow us to stop using local_err variables and
> >> > error_propagate() on hundreds of cases.
> >> 
> >> Getting rid of unnecessary local_err boilerplate is good.  The question
> >> is how.  A possible alternative to your proposal is to follow GLib and
> >> make functions return success/failure.
> >> 
> >> How do the two compare?
> >
> > This proposal proposal already gets rid of 346 error_propagate() calls
> > automatically, and we probably can get rid of many others with
> > additional Coccinelle scripts.
> >
> > Making functions return success/failure, on the other hand, would
> > require rewriting them manually.
> 
> Yes, but how would the *result* compare?  I feel we should at least
> explore this.  I'll try to find some time to play with it.

I think the results of using the return value to indicate errors are
possibly better.  But even on that case, I think ERR_IS_SET will be
useful to avoid error_propagate() boilerplate until we convert all of
them.


> 
> Coccinelle might let us automate some, but determining success
> vs. failure will commonly require human smarts.
> 
> How many such functions we have?  Hmm...
> 
>     @r@
>     identifier fun, errp;
>     typedef Error;
>     position p;
>     @@
>      void fun(..., Error **errp)@p
>      {
>          ...
>      }
>     @script:python@
>         p << r.p;
>         fun << r.fun;
>     @@
>     print("%s:%s:%s: %s()" % (p[0].file, p[0].line, p[0].column, fun))
> 
> Finds 1525.  Correcting the void mistake will be a huge pain, but
> procrastinating can only make it grow.
> 
> >                                   This proposal doesn't even prevent
> > that from happening.  I'd say it helps on that, because we can now find
> > cases that still need to be converted by grepping for ERR_IS_SET.
> 
> I honestly doubt finding the cases is a problem.  We just grep for
> error_propagate().

True.  But I think finding low-hanging fruits will still be a problem. e.g.:

  void f1(Error *errp);

  void f2(Error *errp)
  {
      do_something();
      f1(errp);
  }

The Coccinelle script above will find f1() and f2() (grep won't find
either, but will probably find f2() callers).  We will probably want to
convert f1() before f2(), as converting f2() before f1() would require
adding error_propagete() boilerplate to f2().


> 
[...]
> >> > Desirable side-effects
> >> > ----------------------
> >> >
> >> > Some of additional benefits from parts of this series:
> >> >
> >> > * Making code that ignore error information more visible and
> >> >   greppable (using IGNORE_ERRORS).
> >> 
> >> True.
> >> 
> >> Drawback: Passing an address takes more code than passing null.  Not
> >> sure it matters.
> >
> > I don't know what you mean by "more code".  It requires just replacing
> > NULL with IGNORE_ERRORS.  The magic is hidden behind the macro.
> 
> Creating the IGNORE_ERRORS value and passing it requires more machine
> instructions than passing NULL.  When ignored_error_unset is in another
> DSO, it also requires a relocation.

Yes, it requires a few more machine instructions.  Is this a problem in
practice?


> 
> >> >                                     I believe many of those cases
> >> >   are actually bugs and should use &error_abort or &error_fatal
> >> >   instead.
> >> 
> >> I've seen such bugs.
> >> 
> >> Of course, making possible offenders more greppable doesn't necessarily
> >> mean existing ones will get fixed and new ones will be avoided.
> >> 
> >> > * Making code that depends on errp more visible and
> >> >   greppable (using ERR_IS_* macros).  Some of those cases are
> >> >   also likely to be bugs, and need to be investigated.
> >> 
> >> Grepping for (local_)?errp? works well enough, doesn't it?
> >
> > I don't see how.
> 
> Full list of possible Error ** variables not named errp:
> 
>     $ git-grep -E '\bError \*\*' | grep -vE '\bError \*\*(errp\b|\))'
>     HACKING:the eyes than propagating an Error object through an Error ** parameter.
>     HACKING:only the function really knows, use Error **, and set suitable errors.
>     block/quorum.c:    /* XXX - would be nice if we could pass in the Error **
>     block/snapshot.c:                             Error **err)
>     blockjob.c:/* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
>     docs/devel/writing-qmp-commands.txt:3. It takes an "Error **" argument. This is required. Later we will see how to
>     hw/core/qdev.c:static bool check_only_migratable(Object *obj, Error **err)
>     hw/core/qdev.c:        Error **local_errp = NULL;
>     hw/core/qdev.c:static bool device_get_hotplugged(Object *obj, Error **err)
>     hw/i386/amd_iommu.c:static void amdvi_realize(DeviceState *dev, Error **err)
>     hw/sd/sdhci.c:static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
>     hw/usb/dev-network.c:static void usb_net_realize(USBDevice *dev, Error **errrp)
>     include/block/snapshot.h:                             Error **err);
>     include/qapi/error.h:void error_propagate(Error **dst_errp, Error *local_err);
>     include/qom/object.h:                                    const uint64_t *v, Error **Errp);
>     include/qom/object.h:                                          const uint64_t *v, Error **Errp);
>     qga/commands-posix.c:GuestUserList *qmp_guest_get_users(Error **err)
>     qga/commands-win32.c:GuestUserList *qmp_guest_get_users(Error **err)
>     qga/commands.c:GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **err)
>     qga/commands.c:                       Error **err)
>     qga/commands.c:GuestHostName *qmp_guest_get_host_name(Error **err)
>     qmp.c:void qmp_system_powerdown(Error **erp)
>     util/error.c:void error_propagate(Error **dst_errp, Error *local_err)
> 
> I'll post a patch to rename the offenders.
> 
> >                   I'm talking about two cases:
> >
> > 1) Code like this:
> >
> >   int func1(..., Error **errp)
> >   {
> >       do_something(errp);
> >       if (errp && *errp) {
> >           /* handle error */
> >           return;
> >       }
> >       /* do something else */
> >   }
> >
> > func1() is buggy because it behaves differently if errp is NULL.
> 
> Does your series fix any such bugs?  We hunted them all down long ago...
> Perhaps a few new ones have crept in since.  Hmm... I can see two:
> 
>     $ git-grep -F 'errp && *errp'
>     exec.c:        if (errp && *errp) {
>     hw/mem/pc-dimm.c:        if (errp && *errp) {
>     util/error.c:    assert(errp && *errp);

This RFC doesn't fix those bugs, but just makes them more obvious and
easier to fix.  I plan to fix them in the final version of the series.

> 
> > 2) Code like this:
> >
> >   int func2(..., Error **errp)
> >   {
> >       do_something(errp);
> >       if (*errp) {
> >           /* handle error */
> >       }
> >   }
> >
> > func2() is buggy because if crashes if errp is NULL.
> 
> Does your series fix any such bugs?  grep coughs up quite a few
> candidates...
> 
> > I don't see an easy way to grep for them with the current code.  With
> > this series, (1) can be detected by grepping for ERR_IS_IGNORED,
> 
> How would example (1) look like then?


  diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
  index 92fb482..4e5e2c9 100644
  --- a/hw/mem/pc-dimm.c
  +++ b/hw/mem/pc-dimm.c
  @@ -316,7 +316,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
           uint64_t dimm_size = object_property_get_int(OBJECT(dimm),
                                                        PC_DIMM_SIZE_PROP,
                                                        errp);
  -        if (errp && *errp) {
  +        if (!ERR_IS_IGNORED(errp) && ERR_IS_SET(errp)) {
               goto out;
           }

Without this series, the fix for (1) requires adding error_propagate()
boilerplate.  With this series, the fix is to just drop the
!ERR_IS_IGNORED check and keep the ERR_IS_SET check


> 
> >                                                                  and (2)
> > is fixed because ERR_IS_SET(errp) will work even if errp is NULL.
> >
> >> > TODO
> >> > ----
> >> >
> >> > * Simplify more cases of local_error/error_propagate() to use
> >> >   errp directly.
> >> > * Update API documentation and code examples.
> >> > * Add a mechanism to ensure errp is never NULL.
> >> >
> >> > Git branch
> >> > ----------
> >> >
> >> > This series depend on a few extra cleanups that I didn't submit
> >> > to qemu-devel yet.  A git branch including this series is
> >> > available at:
> >> >
> >> >   git://github.com/ehabkost/qemu-hacks.git work/err-api-rework-ignore-ptr-v1

-- 
Eduardo
