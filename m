Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv6kk-0002mu-0N
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv6kf-0000xu-45
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:30:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cv6ke-0000wt-VT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:30:53 -0400
Date: Mon, 3 Apr 2017 15:30:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170403183043.GF1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
	<CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Apr 03, 2017 at 03:08:06PM +0100, Peter Maydell wrote:
> On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Mon, Apr 03, 2017 at 02:38:15PM +0100, Peter Maydell wrote:
> >> On 3 April 2017 at 14:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> >> Wouldn't it be better to just not add that, rather than
> >> >> add it and then delete it?
> >> >
> >> > The device was already user-creatable
> >>
> >> It doesn't seem to be:
> >>
> >>  ./build/x86/arm-softmmu/qemu-system-arm -M virt -device
> >> unimplemented-device,size=1024,name=foo
> >> qemu-system-arm: Device unimplemented-device can not be dynamically instantiated
> >
> > This restriction is implemented by the "virt" machine, not by the
> > device type itself.
> >
> > This, on the other hand, currently works:
> >   $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo
> 
> That's a bug in the q35 machine or the handling of -device
> on non-platform-bus systems, though, isn't it? The default
> for all sysbus devices has always been "you can't use
> -device with this", [...]

This was true until 2014, only. commit
33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 changed sys-bus-device
to have cannot_instantiate_with_device_add_yet=false. See patch
03/19 for more detailed info.

>               [...] there's never been a requirement to
> mark them as such separately (because it would require
> touching the files for a huge number of devices for no
> particularly good reason when you can default the whole
> set of devices subclassing SysBusDevice).

Yes, and this is the whole point of this series. At the end of
this series, only the few devices that are actually usable with
some machine will have an explicit user_creatable=true
assignment. See cover letter for details.

-- 
Eduardo
