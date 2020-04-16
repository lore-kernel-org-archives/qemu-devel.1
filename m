Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE94C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0038F2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/7ryVn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0038F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5GR-0001sD-3i
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jP5Fg-0000fd-1L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jP5Fd-0003k3-Bb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:12:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jP5Fd-0003jb-2v
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587046340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deAgRMha9vbO84oPPQUTZiiRddZsD9MmZmXDB5M67RE=;
 b=S/7ryVn04EU/FdfBIARHT8nO21E3voJI0zQqPhrJu2MgmKV2Afcc9HWUDXKHnTd3BByzIY
 Q/Ol4OW2l9kLipf71dVGcB4QMgPmlJSShBmDENoRNE7F/xk7vUavxGn+a7qShGqCs9qx+h
 ftaNPNzl3Yp6gbjMFCVaIXn2iciv8tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-74vu1PQvNn6Ub20Vtcxqew-1; Thu, 16 Apr 2020 10:12:10 -0400
X-MC-Unique: 74vu1PQvNn6Ub20Vtcxqew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DB718FF665;
 Thu, 16 Apr 2020 14:12:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-225.ams2.redhat.com
 [10.36.114.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1494E60BEC;
 Thu, 16 Apr 2020 14:12:03 +0000 (UTC)
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Hou Qiming <hqm03ster@gmail.com>
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <CABSdmr=u9QeNA6jy29e2pkiqnGH=xw1n+Hkkrd=AH1RRvj92Ng@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2941f608-7e0f-1190-cccb-2b17d9ea20bf@redhat.com>
Date: Thu, 16 Apr 2020 16:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABSdmr=u9QeNA6jy29e2pkiqnGH=xw1n+Hkkrd=AH1RRvj92Ng@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 discuss@edk2.groups.io, valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/16/20 06:38, Hou Qiming wrote:
> Very good point, I did neglect ramfb resolution changes... But there is one
> important thing: it *can* cause a QEMU crash, a potentially exploitable
> one, not always a guest crash. That's what motivated my heavy-handed
> approach since allowing resolution change would have necessitated a good
> deal of security checks. It has crashed my host *kernel* quite a few times.
> 
> The point is, while the QemuRamfbDxe driver may behave properly, nothing
> prevents the guest from writing garbage or *malicious* values to the ramfb
> config space. Then the values are sent to the display component without any
> sanity check. For some GUI frontends, this means allocating an OpenGL
> texture with guest-supplied dimensions and uploading guest memory content
> to it, which means that guest memory content goes straight into a *kernel
> driver*, *completely unchecked*. Some integer overflow and a lenient GPU
> driver later, and the guest escapes straight to kernel.
> 
> The proper way to enable ramfb resolution change again is adding sanity
> checks for ramfb resolution / pointer / etc. on the QEMU side. We have to
> make sure it doesn't exceed what the host GPU driver supports. Maybe clamp
> both width and height to between 1 and 2048? We also need to validate that
> OpenGL texture dimension update succeeds. Note that OpenGL is not obliged
> to validate anything and everything has to be checked on the QEMU side.

I agree that QEMU should sanity check the resolution requested by the
guest. I also agree that "arbitrary" limits are acceptable, for
preventing integer overflows and -- hopefully -- memory allocation
failures too.

But I don't see the host kernel / OpenGL / physical GPU angle, at least
not directly. That angle seems to be specific to your particular use
case (particular choice of display backend).

For example, if you nest QEMU/TCG in QEMU/TCG, with no KVM and no device
assignment in the picture anywhere, and OVMF drives ramfb in L2, and the
display *backend* (such as GTK or SDL GUI window) for the QEMU process
running in L1 sits on top of a virtual device (such as bochs-display)
provided by QEMU running in L0, then the ramfb stuff (including the
resolution changes and the range checks) should work just the same,
between L2 and L1.

I kinda feel like ramfb has been hijacked for providing a boot time
display crutch for kvmgt. (I might not be using the correct terminology
here; sorry about that). That's *not* what ramfb was originally intended
for, as far as I recall. Compare:

- 59926de9987c ("Merge remote-tracking branch
'remotes/kraxel/tags/vga-20180618-pull-request' into staging", 2018-06-19)

- dddb37495b84 ("Merge remote-tracking branch
'remotes/awilliam/tags/vfio-updates-20181015.0' into staging", 2018-10-15)

IIRC, Gerd originally invented ramfb for giving AARCH64 Windows the
linear framebuffer that the latter so badly wants, in particular so that
the framebuffer exist in guest RAM (not in guest MMIO), in order to
avoid the annoying S1/S2 caching behavior of AARCH64/KVM when the guest
maps an area as MMIO that is mapped as RAM on the host [1]. See:

- https://bugzilla.tianocore.org/show_bug.cgi?id=785#c4
- https://bugzilla.tianocore.org/show_bug.cgi?id=785#c7
- https://bugzilla.tianocore.org/show_bug.cgi?id=785#c8

and the further references given in those bugzilla comments.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1679680#c0

Component reuse is obviously *hugely* important, and it would be silly
for me to argue against reusing ramfb wherever it applies. Just please
don't break the original use case.

Should I file a bug report in LaunchPad, or is this thread enough for
tracking the QEMU regression?

Thanks
Laszlo

> 
> Qiming
> 
> 
> On Wed, Apr 15, 2020 at 11:05 PM Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> (CC Gerd, Qiming, Marcel, qemu-devel for ramfb:)
>>
>> On 04/14/20 23:20, valerij zaporogeci wrote:
>>
>> [snip]
>>
>>> There is a Boot Manager UI display problem, I don't know if this is
>>> qemu problem, but with the ARM (both 32 and 64 bits, the qemu version
>>> is 4.2.0, the OVMF is fresh), and using "ramfb" device, the Boot
>>> Manager has troubles with drawing - it's interfase looks entirely
>>> broken, like this (I'll try to attach the screenshot). UEFI shell
>>> doesn't have this problem. switching to "serial" (which is -serial vc)
>>> doesn't produce it too. Only when ramfb is chosen, the Boot Manager UI
>>> gets smeared. But it takes input and presumable works properly, except
>>> displaying things. qemu writes these messages in the command prompt:
>>> ramfb_fw_cfg_write: 640x480 @ 0x4bd00000
>>> ramfb_fw_cfg_write: resolution locked, change rejected
>>> ramfb_fw_cfg_write: 800x600 @ 0x4bd00000
>>> ramfb_fw_cfg_write: resolution locked, change rejected
>>
>> Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit
>> 1d25ff51af5c ("OvmfPkg: add QemuRamfbDxe", 2018-06-14). Note the date:
>> June 2018.
>>
>> The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /
>> v3.0.0 were in the making.
>>
>> At that time, the resolution change definitely worked -- note my
>> "Tested-by" on the edk2 commit message.
>>
>>
>> Running "git blame" on the QEMU source, I now find commit a9e0cb67b7f4
>> ("hw/display/ramfb: lock guest resolution after it's set", 2019-05-24).
>>
>> Again, note the date: May 2019 (and this commit was released with QEMU
>> v4.1.0).
>>
>> So I would say that the symptom you see is a QEMU v4.1.0 regression. The
>> QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver
>> certainly needs the QemuFwCfgWriteBytes() call to work, for changing the
>> resolution.
>>
>>
>> Now, I'm not familiar with the reasons behind QEMU commit a9e0cb67b7f4.
>> It says it intends to "prevent[] a crash when the guest writes garbage
>> to the configuration space (e.g. when rebooting)".
>>
>> But I don't understand why locking the resolution was necessary for
>> preventing "a crash":
>>
>> (1) Registering a device reset handler in QEMU seems sufficient, so that
>> QEMU forget about the currently shared RAMFB area at platform reset.
>>
>> (2) The crash in question is apparently not a *QEMU* crash -- which
>> might otherwise justify a heavy-handed approach. Instead, it is a
>> *guest* crash. See the references below:
>>
>> (2a)
>> http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com
>>      https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html
>>
>> (2b) https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476
>>
>> Therefore, I don't think that locking the resolution was justified!
>>
>> Importantly:
>>
>> - The QemuRamfbDxe driver allocates the framebuffer in *reserved*
>> memory, therefore any well-behaving OS will *never* touch the
>> framebuffer.
>>
>> - The QemuRamfbDxe driver allocates the framebuffer memory only once,
>> namely for such a resolution that needs the largest amount of
>> framebuffer memory. Therefore, framebuffer re-allocations in the guest
>> driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*
>> necessary, upon resolution change.
>>
>> The ramfb device reset handler in QEMU is justified (for unmapping /
>> forgetting the previously shared RAMFB area).
>>
>> The resolution locking is *NOT* justified, and it breaks the OVMF
>> driver. I suggest backing out the resolution locking from QEMU.
>>
>> Reference (2a) above indicates 'It could be a misguided attempt to
>> "resize ramfb" by the guest Intel driver'. If that is the case, then
>> please fix the Intel guest driver, without regressing the QEMU device
>> model.
>>
>> I'm sad that the QEMU device model change was not regression-tested
>> against the *upstream* OVMF driver (which, by then, had been upstream
>> for almost a year).
>>
>> Laszlo
>>
>>
> 


