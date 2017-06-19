Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMwhy-0004Jk-31
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMwhs-0002hR-Tt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMwhs-0002eI-Ns
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:27:04 -0400
Date: Mon, 19 Jun 2017 10:26:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619132654.GP5016@thinpad.lan.raisama.net>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<20170613165313.20954-16-ehabkost@redhat.com>
	<20170615121407.GA2399@work-vm>
	<20170617193349.GM22043@thinpad.lan.raisama.net>
	<20170619084843.GB2104@work-vm>
	<CAFEAcA8G475i8JE_X+5UHGfz7HP8gbOkmQJ8bbSFOoGbULy_tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8G475i8JE_X+5UHGfz7HP8gbOkmQJ8bbSFOoGbULy_tA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 15/15] [test only] Use 'Error *err[static 1]'
 instead of 'Error **errp' to catch NULL errp arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Mon, Jun 19, 2017 at 10:43:51AM +0100, Peter Maydell wrote:
> On 19 June 2017 at 09:48, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Eduardo Habkost (ehabkost@redhat.com) wrote:
> >> On Thu, Jun 15, 2017 at 01:14:15PM +0100, Dr. David Alan Gilbert wrote:
> >> > * Eduardo Habkost (ehabkost@redhat.com) wrote:
> >> > >  void visit_start_struct(Visitor *v, const char *name, void **obj,
> >> > > -                        size_t size, Error **errp);
> >> > > +                        size_t size, Error *errp[static 1]);
> >> > >
> >> >
> >> > Is it possible to typedef that to something that hides the magic syntax?
> >> > Then we could get that down to QError errp   or something like that?
> >>
> >> Unfortunately it is not possible to hide it in a typedef: the
> >> "static" keyword inside the square brackets is a feature of
> >> function parameter declarations only.  Using it on a typedef
> >> results in:
> >>
> >> a.c:3:16: error: static or type qualifiers in non-parameter array declarator
> >>  typedef Error *ErrorPtr[static 1];
> >
> > That's a shame; it's rather odd looking; still I think it's
> > worth it if it simplifies the error code.
> 
> Is gcc's __attribute__((nonnull)) any better? It seems to apply
> to the whole function prototype rather than an individual argument
> though so probably not :-(

It's possible to specify which arguments are non-null with
nonnull(<arg-index>, ...).  It's harder to use, but probably more
Coccinelle-friendly.

-- 
Eduardo
