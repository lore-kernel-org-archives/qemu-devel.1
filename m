Received: from eggs.gnu.org ([2001:4830:134:3::10]:41732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTre4-0000ee-L7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTre0-0005gH-M8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:32:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTre0-0005fb-Ei
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D26BB402312B
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 16:32:11 +0000 (UTC)
Date: Fri, 15 Jun 2018 17:32:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615163207.GF2615@work-vm>
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
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
> 
> Evolving HMP without consideration for QMP's mission makes carrying out
> that mission harder.  Specifically, me having to watch for new HMP
> commands bypassing QMP, then judge and maybe debate whether that's okay
> is beyond my capacity.  The debate part in particular.  I expect to fail
> as a QMP maintainer in that case.

I feel currently I have exactly the same problem as an HMP maintainer,
since it seems impossible to get small changes in without tripping over
QMP.

> Avoiding QMP maintenance balloon out of control was one of our reasons
> for the rule "HMP commands must be implemented in terms of QMP".  We pay
> a modest amount of extra developer effort for a much-needed
> simplification of the maintainers' job.
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

I had considered asking the same question for HMP; but the only reason I
didn't is because I don't want HMP to die.

> 2. Split the work differently: make the HMP maintainer responsible for
> keeping QMP complete.
> 
> 3. Abandon QMP's goal to be complete.  Tell management applications to
> use HMP where QMP falls short.
> 
> To be brutally frank, 2. requires more trust in your willingness to care
> about QMP than I have right now.
> 
> By refusing to cooperate, you can force 3.
> 
> The solution most conducive to my personal well-being is probably 1.
> 
> Any other bright ideas?

IMHO the problem is that 'QMP be complete' is a fine goal but you're
applying it too strongly by not giving me the trust that I *DO* have the
willingness to care for QMP - but to be able to make reasonable
decisions for cases that really are debugging tools.

I strongly agree that all management tools should be using QMP, and
anything that they need should always be added to QMP (whether or
not they're also added to HMP, I'd prefer if they are, but I'm not
going to stop QMP only commands).

Look at this series; all it did was enable long standing existing HMP 'info'
commands to be used in the new context.  I chose only the info commands
because they looked like the type of thing developers would want to be
able to see the current state of qemu; I carefully did not enable
anything that changed the state.

How was any of that 'Abandoning QMP's goal to be complete'?

The way I see it, this series just fixes the HMP breakage in preconfig
mode - because I care that HMP doesn't decay.

HMP is for debugging and easy use;  my judgement is that if the
developer of a device/subsection wants a command to make their
life easier when debugging then I'm happy for them to add it to HMP.
I want it to be simple and easy for those devs to be able to add
that debug.

But I'll only allow that as an HMP command if it's clearly
a convenient debugging tool rather than implementing some new feature
that should be in QMP.

> Separate discussion, does not block this series.

Good; please let me know if there are any other changes needed in this
series.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
