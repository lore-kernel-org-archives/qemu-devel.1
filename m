Received: from eggs.gnu.org ([2001:4830:134:3::10]:38904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv7s3-0004Sh-NE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv7s2-0002gk-OK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:42:35 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv7s2-0002gQ-Ge
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:42:34 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k6so179233698wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:42:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403183043.GF1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
	<CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
	<20170403183043.GF1910@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 20:42:12 +0100
Message-ID: <CAFEAcA9s6+WMEsMxK0Twac=TCfU-Wf4ouB1CNvJ9uDj++fGJVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 3 April 2017 at 19:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Apr 03, 2017 at 03:08:06PM +0100, Peter Maydell wrote:
>> On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > This, on the other hand, currently works:
>> >   $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo
>>
>> That's a bug in the q35 machine or the handling of -device
>> on non-platform-bus systems, though, isn't it? The default
>> for all sysbus devices has always been "you can't use
>> -device with this", [...]
>
> This was true until 2014, only. commit
> 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 changed sys-bus-device
> to have cannot_instantiate_with_device_add_yet=false. See patch
> 03/19 for more detailed info.

That commit shouldn't cause this problem -- unless the
machine sets has_dynamic_sysbus then the machine_init_notify()
that commit adds will cause it to complain.

I think the bug was introduced much later, in bf8d4924 in 2016,
when q35 had the has_dynamic_sysbus flag added but without
any code to restruct this to a whitelist of working
devices. (In fact you can see in that commit a very
minimal attempt to blacklist a few devices.)

The commit message says only intel-iommu was supposed to
be -device creatable, so it should have been the only
thing on the whitelist. Commit 9e3f9733 shows how this
should be done (that's where spapr got has_dynamic_sysbus).

Maybe we should just fix the q35 bug first?

>>               [...] there's never been a requirement to
>> mark them as such separately (because it would require
>> touching the files for a huge number of devices for no
>> particularly good reason when you can default the whole
>> set of devices subclassing SysBusDevice).
>
> Yes, and this is the whole point of this series. At the end of
> this series, only the few devices that are actually usable with
> some machine will have an explicit user_creatable=true
> assignment. See cover letter for details.

...OK, but in that case why not just set that where it should
be set, rather than having a big long patchset that touches
a lot of devices that in the end are right back where
they started? I think a lot of why I'm confused by
this patchset is that it seems like it's changing
behaviour on devices like this one which don't need
any changes...

thanks
-- PMM
