Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sGV-0001bz-Lg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sGD-0005wI-Cg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9sGD-0005sy-0b
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:41:17 -0400
Date: Tue, 9 Oct 2018 14:41:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009134112.GE22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org>
	<87zhvntg6k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhvntg6k.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Oct 09, 2018 at 03:14:59PM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
> >>> When compiling with "--disable-tcg", we currently still use "tcg"
> >>> as default accelerator. "kvm" should be used in this case instead.
> >>
> >> This part is non-controversial and makes good sense.
> >
> > Agreed.
> >
> >>> Also, some downstream distros provide QEMU binaries which have "kvm"
> >>> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
> >>> KVM by default - and some users might want to do something similar
> >>> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
> >>> default when we detect such a binary name.
> >>
> >> This part is much riskier and less clearly a good plan --
> >> do we really want our behaviour to vary based on the name
> >> of the executable? Distros who want that sort of qemu-kvm
> >> wrapper generally are providing it already (the Ubuntu one
> >> is a 2-line shell script).
> >
> > I hate it when argv[0] affects behavior[*].  I hate shell wrappers less.
> >
> > If a system provides just one qemu executable, and its default
> > accelerator should be something other than tcg:kvm, then there's a use
> 
> Correction: "other than tcg".  See configure_accelerator().
> 
> Remind me, why is "tcg" a good default?

Note that when libvirt is driving QEMU, the default is not used. Libvirt
will always explicitly ask for either KVM or TCG. Libvirt reports whether
each host supports TCG or KVM or both, and management applications will
look at this and usually pick KVM, only use TCG if KVM isn't there.

IOW, most users of libvirt have effectively had the behaviour of
'-accel kvm:tcg' for years. Only direct users of QEMU have suffered
from '-accel tcg:kvm'.

The only time we've had trouble with this is with buggy nested virt
implementations, which expose /dev/kvm but then crash & burn when it
is used. I don't think that's an argument against prioritizing
KVM though. Its an argument for not exposing broken nested virt to VMs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
