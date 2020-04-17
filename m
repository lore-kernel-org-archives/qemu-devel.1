Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91831C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 03:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AE221D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 03:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNaZgFXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AE221D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPHb6-0002Rw-DR
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 23:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jPHaI-0001kH-KB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 23:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hqm03ster@gmail.com>) id 1jPHaF-0006JZ-TQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 23:22:30 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:46763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1jPHaF-0006JN-NZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 23:22:27 -0400
Received: by mail-qv1-xf44.google.com with SMTP id bu9so240249qvb.13
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 20:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bQ06fEooVh7sOXvVPToFswSsEZOXrqTuD9McfgI5eOk=;
 b=kNaZgFXQ2md7aC3YDo3kHD1OK1DX77bPIB3CADolX2NrfFmQIJZYEWH/pIXa96ZvXt
 WqWbZ11gb3C9ZpUcb0w+D3YpxVVLPgeowglhirzjE1aK4+XcVH7rMRQ8TU2walQZjs4D
 +PrA0nLcxQYNWrBOCJGcekz0cz0M3GyNF6j+jUaI9oPdxUrTSs90sTYSPQPc4pqvauLx
 kVOPpr1Lr3KtTDukwmu1UEvVtNyIgqYBy7WevK5VFGVrciDwWmDeqxGmxtspre0VLiAQ
 DdhVGCwl7/e8LnhB9GXgxhUsvFKU2CEOAVL6v7x3oW39cuDgtUVdkb9AwdLuALXPoiD1
 AKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bQ06fEooVh7sOXvVPToFswSsEZOXrqTuD9McfgI5eOk=;
 b=c34NyyKzpUJpLunlVtBDJ3QslB0Vhgb/sSI2h58GoGdVk7vgRsE+kXFGA35dGcMalL
 o+b/5TC70FyJV5uZZ3tDGst8ydg36XC0HvAWl0YJN862K/d6+8fm2pxtkhqpWXPO0GtP
 YgyYmhsQzSI4AimzyKVdmHZrqGREFJpi5T5eDxqjlz6oIlBDho4P5Nmufpvspk2eBebU
 zu1o8i08EgzdYyMNdh+V896mKFd37QGD4aFzYHiUJL3mWIZWl0KKPCPgXFvm+mjce+bQ
 zOrraAwSFXpkUmXvLs+uz1nXvRTyygm4xL9HbTWe5SMWNBZI4VS8dyxiN396JRbWg0Pe
 GCdg==
X-Gm-Message-State: AGi0PuatE1hjA6qqWzZODdF7cE+i2rUgCLZZuDLt5WRy0yu03xpH6dK7
 7NkucJPLK3r/Y/bJvWTsKGquNxw4nImMfMRkea0=
X-Google-Smtp-Source: APiQypIikDH5adz5Op/eOzz9Aorvz50SZEN5f1d7DMhllBnBVl0gELRMxXFxSP5kCF9JlDrs3txpFclxhEsNZeWQlM8=
X-Received: by 2002:a05:6214:1801:: with SMTP id
 o1mr792861qvw.224.1587093746984; 
 Thu, 16 Apr 2020 20:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <CABSdmr=u9QeNA6jy29e2pkiqnGH=xw1n+Hkkrd=AH1RRvj92Ng@mail.gmail.com>
 <2941f608-7e0f-1190-cccb-2b17d9ea20bf@redhat.com>
In-Reply-To: <2941f608-7e0f-1190-cccb-2b17d9ea20bf@redhat.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Fri, 17 Apr 2020 11:22:14 +0800
Message-ID: <CABSdmrk2L8L-J-JmKQC-kyswOq9Bh3AUnM_+FkiHpW9c1EuxwQ@mail.gmail.com>
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000003aa9005a3740fc1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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

--00000000000003aa9005a3740fc1
Content-Type: text/plain; charset="UTF-8"

I'm glad we can reach a consensus that ramfb needs sanity checks. And well,
I'm probably at fault with the hijacking.

Your QEMU/TCG in QEMU/TCG example also made me realize a deeper problem,
though: your setting still can't escape the host display / physical GPU
issue. The middle display layers be bochs or whatever, but as long as the
framebuffer content and resolution values are propagated, and the end
result is displayed at all on the host, the host GPU attack surface remains
exposed to the L2 guest, and checks are needed. Everything shown on the
screen involves the display driver - GPU stack, GTK or SDL or tty, you
can't avoid that. ramfb-kvmgt just happened to be the shortest pipeline
where every stage neglected the checks, which exposed this problem. Blaming
this on ramfb is unfair since in your scenario the checks are better done
in the display subsystems.

TL;DR You made me realize right now, it's a very real risk that an AARCH64
Windows guest could exploit a x64 host's display driver by specifying a
crafted framebuffer with overflowing resolution. I don't want to break it,
but I'd prefer a broken state over an insecure state.

I'm not quite sure what this thread is. But I think with the scope this
discussion is going, maybe it's more of a bug than a regression.


On Thu, Apr 16, 2020 at 10:12 PM Laszlo Ersek <lersek@redhat.com> wrote:

> On 04/16/20 06:38, Hou Qiming wrote:
> > Very good point, I did neglect ramfb resolution changes... But there is
> one
> > important thing: it *can* cause a QEMU crash, a potentially exploitable
> > one, not always a guest crash. That's what motivated my heavy-handed
> > approach since allowing resolution change would have necessitated a good
> > deal of security checks. It has crashed my host *kernel* quite a few
> times.
> >
> > The point is, while the QemuRamfbDxe driver may behave properly, nothing
> > prevents the guest from writing garbage or *malicious* values to the
> ramfb
> > config space. Then the values are sent to the display component without
> any
> > sanity check. For some GUI frontends, this means allocating an OpenGL
> > texture with guest-supplied dimensions and uploading guest memory content
> > to it, which means that guest memory content goes straight into a *kernel
> > driver*, *completely unchecked*. Some integer overflow and a lenient GPU
> > driver later, and the guest escapes straight to kernel.
> >
> > The proper way to enable ramfb resolution change again is adding sanity
> > checks for ramfb resolution / pointer / etc. on the QEMU side. We have to
> > make sure it doesn't exceed what the host GPU driver supports. Maybe
> clamp
> > both width and height to between 1 and 2048? We also need to validate
> that
> > OpenGL texture dimension update succeeds. Note that OpenGL is not obliged
> > to validate anything and everything has to be checked on the QEMU side.
>
> I agree that QEMU should sanity check the resolution requested by the
> guest. I also agree that "arbitrary" limits are acceptable, for
> preventing integer overflows and -- hopefully -- memory allocation
> failures too.
>
> But I don't see the host kernel / OpenGL / physical GPU angle, at least
> not directly. That angle seems to be specific to your particular use
> case (particular choice of display backend).
>
> For example, if you nest QEMU/TCG in QEMU/TCG, with no KVM and no device
> assignment in the picture anywhere, and OVMF drives ramfb in L2, and the
> display *backend* (such as GTK or SDL GUI window) for the QEMU process
> running in L1 sits on top of a virtual device (such as bochs-display)
> provided by QEMU running in L0, then the ramfb stuff (including the
> resolution changes and the range checks) should work just the same,
> between L2 and L1.
>
> I kinda feel like ramfb has been hijacked for providing a boot time
> display crutch for kvmgt. (I might not be using the correct terminology
> here; sorry about that). That's *not* what ramfb was originally intended
> for, as far as I recall. Compare:
>
> - 59926de9987c ("Merge remote-tracking branch
> 'remotes/kraxel/tags/vga-20180618-pull-request' into staging", 2018-06-19)
>
> - dddb37495b84 ("Merge remote-tracking branch
> 'remotes/awilliam/tags/vfio-updates-20181015.0' into staging", 2018-10-15)
>
> IIRC, Gerd originally invented ramfb for giving AARCH64 Windows the
> linear framebuffer that the latter so badly wants, in particular so that
> the framebuffer exist in guest RAM (not in guest MMIO), in order to
> avoid the annoying S1/S2 caching behavior of AARCH64/KVM when the guest
> maps an area as MMIO that is mapped as RAM on the host [1]. See:
>
> - https://bugzilla.tianocore.org/show_bug.cgi?id=785#c4
> - https://bugzilla.tianocore.org/show_bug.cgi?id=785#c7
> - https://bugzilla.tianocore.org/show_bug.cgi?id=785#c8
>
> and the further references given in those bugzilla comments.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1679680#c0
>
> Component reuse is obviously *hugely* important, and it would be silly
> for me to argue against reusing ramfb wherever it applies. Just please
> don't break the original use case.
>
> Should I file a bug report in LaunchPad, or is this thread enough for
> tracking the QEMU regression?
>
> Thanks
> Laszlo
>
> >
> > Qiming
> >
> >
> > On Wed, Apr 15, 2020 at 11:05 PM Laszlo Ersek <lersek@redhat.com> wrote:
> >
> >> (CC Gerd, Qiming, Marcel, qemu-devel for ramfb:)
> >>
> >> On 04/14/20 23:20, valerij zaporogeci wrote:
> >>
> >> [snip]
> >>
> >>> There is a Boot Manager UI display problem, I don't know if this is
> >>> qemu problem, but with the ARM (both 32 and 64 bits, the qemu version
> >>> is 4.2.0, the OVMF is fresh), and using "ramfb" device, the Boot
> >>> Manager has troubles with drawing - it's interfase looks entirely
> >>> broken, like this (I'll try to attach the screenshot). UEFI shell
> >>> doesn't have this problem. switching to "serial" (which is -serial vc)
> >>> doesn't produce it too. Only when ramfb is chosen, the Boot Manager UI
> >>> gets smeared. But it takes input and presumable works properly, except
> >>> displaying things. qemu writes these messages in the command prompt:
> >>> ramfb_fw_cfg_write: 640x480 @ 0x4bd00000
> >>> ramfb_fw_cfg_write: resolution locked, change rejected
> >>> ramfb_fw_cfg_write: 800x600 @ 0x4bd00000
> >>> ramfb_fw_cfg_write: resolution locked, change rejected
> >>
> >> Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit
> >> 1d25ff51af5c ("OvmfPkg: add QemuRamfbDxe", 2018-06-14). Note the date:
> >> June 2018.
> >>
> >> The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /
> >> v3.0.0 were in the making.
> >>
> >> At that time, the resolution change definitely worked -- note my
> >> "Tested-by" on the edk2 commit message.
> >>
> >>
> >> Running "git blame" on the QEMU source, I now find commit a9e0cb67b7f4
> >> ("hw/display/ramfb: lock guest resolution after it's set", 2019-05-24).
> >>
> >> Again, note the date: May 2019 (and this commit was released with QEMU
> >> v4.1.0).
> >>
> >> So I would say that the symptom you see is a QEMU v4.1.0 regression. The
> >> QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver
> >> certainly needs the QemuFwCfgWriteBytes() call to work, for changing the
> >> resolution.
> >>
> >>
> >> Now, I'm not familiar with the reasons behind QEMU commit a9e0cb67b7f4.
> >> It says it intends to "prevent[] a crash when the guest writes garbage
> >> to the configuration space (e.g. when rebooting)".
> >>
> >> But I don't understand why locking the resolution was necessary for
> >> preventing "a crash":
> >>
> >> (1) Registering a device reset handler in QEMU seems sufficient, so that
> >> QEMU forget about the currently shared RAMFB area at platform reset.
> >>
> >> (2) The crash in question is apparently not a *QEMU* crash -- which
> >> might otherwise justify a heavy-handed approach. Instead, it is a
> >> *guest* crash. See the references below:
> >>
> >> (2a)
> >>
> http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com
> >>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html
> >>
> >> (2b)
> https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476
> >>
> >> Therefore, I don't think that locking the resolution was justified!
> >>
> >> Importantly:
> >>
> >> - The QemuRamfbDxe driver allocates the framebuffer in *reserved*
> >> memory, therefore any well-behaving OS will *never* touch the
> >> framebuffer.
> >>
> >> - The QemuRamfbDxe driver allocates the framebuffer memory only once,
> >> namely for such a resolution that needs the largest amount of
> >> framebuffer memory. Therefore, framebuffer re-allocations in the guest
> >> driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*
> >> necessary, upon resolution change.
> >>
> >> The ramfb device reset handler in QEMU is justified (for unmapping /
> >> forgetting the previously shared RAMFB area).
> >>
> >> The resolution locking is *NOT* justified, and it breaks the OVMF
> >> driver. I suggest backing out the resolution locking from QEMU.
> >>
> >> Reference (2a) above indicates 'It could be a misguided attempt to
> >> "resize ramfb" by the guest Intel driver'. If that is the case, then
> >> please fix the Intel guest driver, without regressing the QEMU device
> >> model.
> >>
> >> I'm sad that the QEMU device model change was not regression-tested
> >> against the *upstream* OVMF driver (which, by then, had been upstream
> >> for almost a year).
> >>
> >> Laszlo
> >>
> >>
> >
>
>

--00000000000003aa9005a3740fc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m glad we can reach a consensus that ramfb need=
s sanity checks. And well, I&#39;m probably at fault with the hijacking.<br=
></div><div><br></div><div>Your QEMU/TCG in QEMU/TCG example also made me r=
ealize a deeper problem, though: your setting still can&#39;t escape the ho=
st display / physical GPU issue. The middle display layers be bochs or what=
ever, but as long as the framebuffer content and resolution values are prop=
agated, and the end result is displayed at all on the host, the host GPU at=
tack surface remains exposed to the L2 guest, and checks are needed. Everyt=
hing shown on the screen involves the display driver - GPU stack, GTK or SD=
L or tty, you can&#39;t avoid that.=20
ramfb-kvmgt just happened to be the shortest pipeline where every stage neg=
lected the checks, which exposed this problem. Blaming this on ramfb is unf=
air since in your scenario the checks are better done in the display subsys=
tems.<br></div><div><br></div><div>TL;DR You made me realize right now, it&=
#39;s a very real risk that=20
an AARCH64 Windows guest could exploit a x64 host&#39;s display driver by s=
pecifying a crafted framebuffer with overflowing resolution. I don&#39;t wa=
nt to break it, but I&#39;d prefer a broken state over an insecure state.<b=
r></div><div><br></div><div>I&#39;m not quite sure what this thread is. But=
 I think with the scope this discussion is going, maybe it&#39;s more of a =
bug than a regression.<br></div><div></div><div><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 16, 2=
020 at 10:12 PM Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com">lerse=
k@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 04/16/20 06:38, Hou Qiming wrote:<br>
&gt; Very good point, I did neglect ramfb resolution changes... But there i=
s one<br>
&gt; important thing: it *can* cause a QEMU crash, a potentially exploitabl=
e<br>
&gt; one, not always a guest crash. That&#39;s what motivated my heavy-hand=
ed<br>
&gt; approach since allowing resolution change would have necessitated a go=
od<br>
&gt; deal of security checks. It has crashed my host *kernel* quite a few t=
imes.<br>
&gt; <br>
&gt; The point is, while the QemuRamfbDxe driver may behave properly, nothi=
ng<br>
&gt; prevents the guest from writing garbage or *malicious* values to the r=
amfb<br>
&gt; config space. Then the values are sent to the display component withou=
t any<br>
&gt; sanity check. For some GUI frontends, this means allocating an OpenGL<=
br>
&gt; texture with guest-supplied dimensions and uploading guest memory cont=
ent<br>
&gt; to it, which means that guest memory content goes straight into a *ker=
nel<br>
&gt; driver*, *completely unchecked*. Some integer overflow and a lenient G=
PU<br>
&gt; driver later, and the guest escapes straight to kernel.<br>
&gt; <br>
&gt; The proper way to enable ramfb resolution change again is adding sanit=
y<br>
&gt; checks for ramfb resolution / pointer / etc. on the QEMU side. We have=
 to<br>
&gt; make sure it doesn&#39;t exceed what the host GPU driver supports. May=
be clamp<br>
&gt; both width and height to between 1 and 2048? We also need to validate =
that<br>
&gt; OpenGL texture dimension update succeeds. Note that OpenGL is not obli=
ged<br>
&gt; to validate anything and everything has to be checked on the QEMU side=
.<br>
<br>
I agree that QEMU should sanity check the resolution requested by the<br>
guest. I also agree that &quot;arbitrary&quot; limits are acceptable, for<b=
r>
preventing integer overflows and -- hopefully -- memory allocation<br>
failures too.<br>
<br>
But I don&#39;t see the host kernel / OpenGL / physical GPU angle, at least=
<br>
not directly. That angle seems to be specific to your particular use<br>
case (particular choice of display backend).<br>
<br>
For example, if you nest QEMU/TCG in QEMU/TCG, with no KVM and no device<br=
>
assignment in the picture anywhere, and OVMF drives ramfb in L2, and the<br=
>
display *backend* (such as GTK or SDL GUI window) for the QEMU process<br>
running in L1 sits on top of a virtual device (such as bochs-display)<br>
provided by QEMU running in L0, then the ramfb stuff (including the<br>
resolution changes and the range checks) should work just the same,<br>
between L2 and L1.<br>
<br>
I kinda feel like ramfb has been hijacked for providing a boot time<br>
display crutch for kvmgt. (I might not be using the correct terminology<br>
here; sorry about that). That&#39;s *not* what ramfb was originally intende=
d<br>
for, as far as I recall. Compare:<br>
<br>
- 59926de9987c (&quot;Merge remote-tracking branch<br>
&#39;remotes/kraxel/tags/vga-20180618-pull-request&#39; into staging&quot;,=
 2018-06-19)<br>
<br>
- dddb37495b84 (&quot;Merge remote-tracking branch<br>
&#39;remotes/awilliam/tags/vfio-updates-20181015.0&#39; into staging&quot;,=
 2018-10-15)<br>
<br>
IIRC, Gerd originally invented ramfb for giving AARCH64 Windows the<br>
linear framebuffer that the latter so badly wants, in particular so that<br=
>
the framebuffer exist in guest RAM (not in guest MMIO), in order to<br>
avoid the annoying S1/S2 caching behavior of AARCH64/KVM when the guest<br>
maps an area as MMIO that is mapped as RAM on the host [1]. See:<br>
<br>
- <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D785#c4" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bug.c=
gi?id=3D785#c4</a><br>
- <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D785#c7" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bug.c=
gi?id=3D785#c7</a><br>
- <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D785#c8" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bug.c=
gi?id=3D785#c8</a><br>
<br>
and the further references given in those bugzilla comments.<br>
<br>
[1] <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1679680#c0" re=
l=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi=
?id=3D1679680#c0</a><br>
<br>
Component reuse is obviously *hugely* important, and it would be silly<br>
for me to argue against reusing ramfb wherever it applies. Just please<br>
don&#39;t break the original use case.<br>
<br>
Should I file a bug report in LaunchPad, or is this thread enough for<br>
tracking the QEMU regression?<br>
<br>
Thanks<br>
Laszlo<br>
<br>
&gt; <br>
&gt; Qiming<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Apr 15, 2020 at 11:05 PM Laszlo Ersek &lt;<a href=3D"mailto:le=
rsek@redhat.com" target=3D"_blank">lersek@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; (CC Gerd, Qiming, Marcel, qemu-devel for ramfb:)<br>
&gt;&gt;<br>
&gt;&gt; On 04/14/20 23:20, valerij zaporogeci wrote:<br>
&gt;&gt;<br>
&gt;&gt; [snip]<br>
&gt;&gt;<br>
&gt;&gt;&gt; There is a Boot Manager UI display problem, I don&#39;t know i=
f this is<br>
&gt;&gt;&gt; qemu problem, but with the ARM (both 32 and 64 bits, the qemu =
version<br>
&gt;&gt;&gt; is 4.2.0, the OVMF is fresh), and using &quot;ramfb&quot; devi=
ce, the Boot<br>
&gt;&gt;&gt; Manager has troubles with drawing - it&#39;s interfase looks e=
ntirely<br>
&gt;&gt;&gt; broken, like this (I&#39;ll try to attach the screenshot). UEF=
I shell<br>
&gt;&gt;&gt; doesn&#39;t have this problem. switching to &quot;serial&quot;=
 (which is -serial vc)<br>
&gt;&gt;&gt; doesn&#39;t produce it too. Only when ramfb is chosen, the Boo=
t Manager UI<br>
&gt;&gt;&gt; gets smeared. But it takes input and presumable works properly=
, except<br>
&gt;&gt;&gt; displaying things. qemu writes these messages in the command p=
rompt:<br>
&gt;&gt;&gt; ramfb_fw_cfg_write: 640x480 @ 0x4bd00000<br>
&gt;&gt;&gt; ramfb_fw_cfg_write: resolution locked, change rejected<br>
&gt;&gt;&gt; ramfb_fw_cfg_write: 800x600 @ 0x4bd00000<br>
&gt;&gt;&gt; ramfb_fw_cfg_write: resolution locked, change rejected<br>
&gt;&gt;<br>
&gt;&gt; Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit<br>
&gt;&gt; 1d25ff51af5c (&quot;OvmfPkg: add QemuRamfbDxe&quot;, 2018-06-14). =
Note the date:<br>
&gt;&gt; June 2018.<br>
&gt;&gt;<br>
&gt;&gt; The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /=
<br>
&gt;&gt; v3.0.0 were in the making.<br>
&gt;&gt;<br>
&gt;&gt; At that time, the resolution change definitely worked -- note my<b=
r>
&gt;&gt; &quot;Tested-by&quot; on the edk2 commit message.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Running &quot;git blame&quot; on the QEMU source, I now find commi=
t a9e0cb67b7f4<br>
&gt;&gt; (&quot;hw/display/ramfb: lock guest resolution after it&#39;s set&=
quot;, 2019-05-24).<br>
&gt;&gt;<br>
&gt;&gt; Again, note the date: May 2019 (and this commit was released with =
QEMU<br>
&gt;&gt; v4.1.0).<br>
&gt;&gt;<br>
&gt;&gt; So I would say that the symptom you see is a QEMU v4.1.0 regressio=
n. The<br>
&gt;&gt; QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver=
<br>
&gt;&gt; certainly needs the QemuFwCfgWriteBytes() call to work, for changi=
ng the<br>
&gt;&gt; resolution.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Now, I&#39;m not familiar with the reasons behind QEMU commit a9e0=
cb67b7f4.<br>
&gt;&gt; It says it intends to &quot;prevent[] a crash when the guest write=
s garbage<br>
&gt;&gt; to the configuration space (e.g. when rebooting)&quot;.<br>
&gt;&gt;<br>
&gt;&gt; But I don&#39;t understand why locking the resolution was necessar=
y for<br>
&gt;&gt; preventing &quot;a crash&quot;:<br>
&gt;&gt;<br>
&gt;&gt; (1) Registering a device reset handler in QEMU seems sufficient, s=
o that<br>
&gt;&gt; QEMU forget about the currently shared RAMFB area at platform rese=
t.<br>
&gt;&gt;<br>
&gt;&gt; (2) The crash in question is apparently not a *QEMU* crash -- whic=
h<br>
&gt;&gt; might otherwise justify a heavy-handed approach. Instead, it is a<=
br>
&gt;&gt; *guest* crash. See the references below:<br>
&gt;&gt;<br>
&gt;&gt; (2a)<br>
&gt;&gt; <a href=3D"http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9U=
k=3D8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com" rel=3D"noreferrer" target=3D"_bl=
ank">http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=3D8nQxNLHgzvD=
sNYdp_QLogA@mail.gmail.com</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.gnu.org/archive/html/=
qemu-devel/2019-05/msg02299.html" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html</a><br>
&gt;&gt;<br>
&gt;&gt; (2b) <a href=3D"https://github.com/intel/gvt-linux/issues/23#issue=
comment-483651476" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
intel/gvt-linux/issues/23#issuecomment-483651476</a><br>
&gt;&gt;<br>
&gt;&gt; Therefore, I don&#39;t think that locking the resolution was justi=
fied!<br>
&gt;&gt;<br>
&gt;&gt; Importantly:<br>
&gt;&gt;<br>
&gt;&gt; - The QemuRamfbDxe driver allocates the framebuffer in *reserved*<=
br>
&gt;&gt; memory, therefore any well-behaving OS will *never* touch the<br>
&gt;&gt; framebuffer.<br>
&gt;&gt;<br>
&gt;&gt; - The QemuRamfbDxe driver allocates the framebuffer memory only on=
ce,<br>
&gt;&gt; namely for such a resolution that needs the largest amount of<br>
&gt;&gt; framebuffer memory. Therefore, framebuffer re-allocations in the g=
uest<br>
&gt;&gt; driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*<=
br>
&gt;&gt; necessary, upon resolution change.<br>
&gt;&gt;<br>
&gt;&gt; The ramfb device reset handler in QEMU is justified (for unmapping=
 /<br>
&gt;&gt; forgetting the previously shared RAMFB area).<br>
&gt;&gt;<br>
&gt;&gt; The resolution locking is *NOT* justified, and it breaks the OVMF<=
br>
&gt;&gt; driver. I suggest backing out the resolution locking from QEMU.<br=
>
&gt;&gt;<br>
&gt;&gt; Reference (2a) above indicates &#39;It could be a misguided attemp=
t to<br>
&gt;&gt; &quot;resize ramfb&quot; by the guest Intel driver&#39;. If that i=
s the case, then<br>
&gt;&gt; please fix the Intel guest driver, without regressing the QEMU dev=
ice<br>
&gt;&gt; model.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m sad that the QEMU device model change was not regression-t=
ested<br>
&gt;&gt; against the *upstream* OVMF driver (which, by then, had been upstr=
eam<br>
&gt;&gt; for almost a year).<br>
&gt;&gt;<br>
&gt;&gt; Laszlo<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000003aa9005a3740fc1--

