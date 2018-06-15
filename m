Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTtiF-0003U2-AT
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTtiC-000484-6f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTtiB-00046p-Tc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7466230C10E7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 18:44:38 +0000 (UTC)
Date: Fri, 15 Jun 2018 15:44:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180615184434.GD7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org>
	<87k1r4use2.fsf@dusky.pond.sub.org> <20180612125254.GB2512@work-vm>
	<878t7gxc6v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t7gxc6v.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Abandon our QMP first policy? (was: [PATCH v3 5/7]
 hmp: Add info commands for preconfig)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jun 15, 2018 at 06:10:48PM +0200, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Gerd Hoffmann <kraxel@redhat.com> writes:
> >> 
> >> >   Hi,
> >> >
> >> >> > Now let's review the three commands:
> >> >> > 
> >> >> > * Gerd, why does "info usbhost" have no QMP equivalent?
> >> >
> >> > Works only when running qemu directly, in the libvirt sandbox qemu
> >> > hasn't the permissions needed to scan the host usb bus so that would be
> >> > rather pointless ...
> >> 
> >> I don't think this meets either of the two criteria:
> >> 
> >> * I meets "makes no sense in QMP" only if QMP implies "can't scan host
> >>   USB bus".  Libvirt implies it, but QMP doesn't imply libvirt; it's its
> >>   most important, not its sole user.
> >> 
> >> * It meets "of use only for human users" only if we're convinced it's of
> >>   no use to programs.
> >> 
> >>   To avoid speculation and endless arguments about what could or could
> >>   not be of use, we've always stuck to "when in doubt, assume it could
> >>   be of use".
> >> 
> >>   "Libvirt can't use it" falls short.
> >> 
> >>   "Any management application worth anything would deny QEMU the
> >>   capability to scan the USB host bus, and thus wouldn't be able to use
> >>   it" is exactly the argument we intended to avoid.
> >> 
> >> QMP falling short of completeness in relatively unimportant ways like
> >> this one isn't exactly terrible.  The most serious effect is probably
> >> serving as a bad example that leads to further arguments like this one.
> >> These are well worth avoiding, though.
> >
> > Markus:
> >   a) This is a separate discussion; info usbhost has been there for many
> > years;  this patch set doesn't change that.
> 
> Yes, it's separate.
> 
> >   b) From HMP, if someone wants to add a command like 'info usbhost' to
> > make their debugging of USB easy, then HMP is all for that and there's
> > no way I'm going to require QMP implementations for a debug command.
> 
> As I said before, said someone is welcome to make his case for why the
> command is of use only for human users in the commit message.
> 
> If the QMP maintainer gets a say in judging that case, good.
> 
> But if your "no way" means what I have to assume it means, namely "no
> way I'm taking no for an answer", then we're at an impasse.

Is this really an impasse?  Dave says he isn't going to require
QMP implementations of debug commands.  Isn't a debug command
just for humans, by definition?

(Which I think is true in the specific case of "info usbhost",
because it's really just a wrapper around libusb.  I'm 100% sure
QEMU doesn't need to provide a QMP interface for libusb.)



> 
> Evolving HMP without consideration for QMP's mission makes carrying out
> that mission harder.  Specifically, me having to watch for new HMP
> commands bypassing QMP, then judge and maybe debate whether that's okay
> is beyond my capacity.  The debate part in particular.  I expect to fail
> as a QMP maintainer in that case.

What's QMP mission, exactly?

Do we have any signs of HMP evolving without consideration for
QMP's mission, recently?

Would it help if the HMP maintainer makes sure commit messages or
comments document more clearly why a QMP equivalent is not
necessary?


> 
> Avoiding QMP maintenance balloon out of control was one of our reasons
> for the rule "HMP commands must be implemented in terms of QMP".  We pay
> a modest amount of extra developer effort for a much-needed
> simplification of the maintainers' job.

I don't understand why "HMP commands must be implemented in terms
of QMP" helps avoiding QMP maintenance to balloon out of control.
My impression is that it's the opposite.

I fail to see the benefits of that policy.  What exactly is the
goal here?


> 
> Regarding "modest amount of effort": I already told you I'm prepared to
> back that claim with patches whenever requiring QMP blocks HMP patches.
> If that can't shake your conviction that requiring QMP is impractical, I
> figure nothing will.
> 
> Ways out of the impasse:
> 
> 1. Find a more capable maintainer for QMP (MAINTAINERS sections QMP and
> QAPI Schema).  To give you an idea of the work involved, almost 10% of
> the commits in 2.9 touched the latter.
> 
> 2. Split the work differently: make the HMP maintainer responsible for
> keeping QMP complete.

This sounds like a reasonable way to split responsibilities, to
me.


> 
> 3. Abandon QMP's goal to be complete.  Tell management applications to
> use HMP where QMP falls short.

What "complete" means here?  Why would we ever tell management
applications to use HMP?  We can always implement new QMP
commands if management applications need them.


> 
> To be brutally frank, 2. requires more trust in your willingness to care
> about QMP than I have right now.
> 
> By refusing to cooperate, you can force 3.
> 
> The solution most conducive to my personal well-being is probably 1.
> 
> Any other bright ideas?
> 
> Separate discussion, does not block this series.

-- 
Eduardo
