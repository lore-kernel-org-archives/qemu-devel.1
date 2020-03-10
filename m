Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E1C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E471821D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc+HIJYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E471821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkzJ-00070Q-4w
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBkyX-00069v-D9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBkyV-0002fV-RZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:55:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBkyV-0002c5-L4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:55:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id a6so6526287otb.10
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1pyw82QS4ZZRYkQoubeSy5bpQaJIvgsbJXLiwnBer6U=;
 b=fc+HIJYdVkCYOTrYvlOo7T843VljKHeIv0loZkpsnl+wGh30u7v/tleEOUVD6/1GEb
 qSfroeWsmJvjmFvBpXdAElyFdpjs+KxKY9wGRhDylxot2286wHRt2glb4hOkKmhaC94I
 7ANpY7sRDtkdy1rRxeTTdoYa+WzT/l+FGJoob4p6/9M98+258mVsVbBx3OuqV3I8VC6x
 H/CgqileeLEt532plA9/hmqy9JScCFWZYYdTZrJTnHqTDHNjmmELHyb2ze420V6A3nUM
 yy2tlQOh5DoAREGjkBbRk+3Zc0gzLMe469Noz1/RJrh3dHyMYNytmKSKuUUPYR6fSEAc
 bVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1pyw82QS4ZZRYkQoubeSy5bpQaJIvgsbJXLiwnBer6U=;
 b=A2lCIdZwtByRbAGkEz+LJibWudFaiAYDQGZFShTLx8St3Gv5Xau60Cewyy3TMUeNKY
 cn0jA+tKMFUSXENww3ev8L4fdlWhwR9u5OJrHxMgyNyhzLB7gr3Lru4SHdN8atdjpn0c
 n7h93cV6+/ndcZvLT3wCCmwIm70izdUFcJ9VRak5PbAxo/J8y7UsKJJJCTmqDD+OGnlU
 Ng+JsNpzJQcl4iFiiQUIZcTV3/AzeS7EjyOhPl95w3TafQROXCLbZ0PaYAHtz01ZnFJH
 q3dOPlsDVjQP4Cfw1JIN3SIWU6Br7CmFFUHfaMTgMnjgzVPwdFFoMHryZTF49KCBIMEn
 C+ug==
X-Gm-Message-State: ANhLgQ3gDe6kiJ4YagKTCBTJKeQko8rSklpDQFOiw3m0xWXU7skWqBCj
 Ah4bHtF0VbOUO4vc0pK5XH5LkUAw3OoktPY7GnH+PA==
X-Google-Smtp-Source: ADFU+vu4ZyzkOyhsv4TOmd51m64FKP2+iXJlcpAfHVg4Jinj8iCne9uMGk3h41kKxkxyd06qwu23xfad1w/oECJCF8Q=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr9462411ota.221.1583870134403; 
 Tue, 10 Mar 2020 12:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-6-eric.auger@redhat.com>
 <CAFEAcA-XD9LiokquaHj+kCYWA3N=7k3V3R8r5gA1HZM9Adus1A@mail.gmail.com>
 <1370e0bc-ae17-c891-72b5-4cbc58ff3247@redhat.com>
In-Reply-To: <1370e0bc-ae17-c891-72b5-4cbc58ff3247@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 19:55:22 +0000
Message-ID: <CAFEAcA9W9=5s4Bfr9otP1p984AUxYxckgzZkhgOxzFOwSPfj3Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 18:02, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 3/9/20 2:28 PM, Peter Maydell wrote:
> > On Mon, 2 Mar 2020 at 10:55, Eric Auger <eric.auger@redhat.com> wrote:
> >>
> >> Restructure the finalize_gic_version with switch cases and, in
> >> KVM mode, explictly check whether the chosen version is supported
> >> by the host.
> >>
> >> if the end-user explicitly sets v2/v3 and this is not supported by
> >> the host, then the user gets an explicit error message.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Reviewed-by: Andrew Jones <drjones@redhat.com>
> >>
> >> ---
> >>
> >> v2 -> v3:
> >> - explictly list V2 and V3 in the switch/case
> >> - fix indent
> >> ---
> >>  hw/arm/virt.c | 77 +++++++++++++++++++++++++++++++++++----------------
> >>  1 file changed, 53 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index eb8c57c85e..aeb6c45e51 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -1542,33 +1542,62 @@ static void virt_set_memmap(VirtMachineState *vms)
> >>   */
> >>  static void finalize_gic_version(VirtMachineState *vms)
> >>  {
> >> -    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
> >> -        vms->gic_version == VIRT_GIC_VERSION_MAX) {
> >> -        if (!kvm_enabled()) {
> >> -            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
> >> -                error_report("gic-version=host requires KVM");
> >> -                exit(1);
> >> -            } else {
> >> -                /* "max": currently means 3 for TCG */
> >> -                vms->gic_version = VIRT_GIC_VERSION_3;
> >> -            }
> >> -        } else {
> >> -            int probe_bitmap = kvm_arm_vgic_probe();
> >> +    if (kvm_enabled()) {
> >> +        int probe_bitmap = kvm_arm_vgic_probe();
> >
> > Previously we would only do kvm_arm_vgic_probe() if the
> > user asked for 'host' or 'max'. Now we do it always,
> > which means that if the user is on a really old kernel
> > where the CREATE_DEVICE ioctl doesn't exist then we
> > will now fail if the user specifically asked for gicv2,
> > where previously we (probably) would have succeeded.
> > I don't think we should put too much weight on continuing
> > to theoretically support ancient kernels which we're not
> > actually testing against, but it does seem a bit odd to
> > probe even if we don't need to know the answer.
> >
> > More relevant to actual plausible use cases, if
> > kvm_irqchip_in_kernel() == false, we shouldn't be
> > probing the kernel to ask what kind of GIC to use.
> I think the existing code also does the same:
> kvm_arm_vgic_probe() gets called as soon as vms->gic_version <= 0 &&
> kvm_enabled() whatever the state of kvm_irqchip_in_kernel().

Yes, but your change here makes it call kvm_arm_vgic_probe()
even if the gic_version was explicitly set to 2 or 3
by the user, doesn't it ? That's what I was commenting on.

> So in case the host only supports GICv2, in kvm mode with userspace
> irqchip we would use GICV2 in host/max mode. If host supports GICv3 we
> would select GICv3 which is not supported in !kvm_irqchip_in_kernel().

> So do I understand correctly that you want me to change that behavior
> and always set v2 in KVM/!kvm_irqchip_in_kernel() max/host mode?

I think:
(1) we should retain the current behaviour that if the user
asked for userspace-irqchip and specifically chose gic
version 2, then we don't probe the kernel for its capabilities,
we just create a userspace gicv2.

(2) we should also retain the current behaviour that we
default to "2" if the user requests userspace-irqchip but
doesn't specify the gic-version.

(3) the ideal-world behaviour would be that we correctly
handle the user asking for userspace-irqchip plus either "max"
(choose '2') or "3" (produce a useful error message if we
don't do so already). I'm not sure what "host" should mean
here. But this point (3) is separate from what this series is
doing, I think, and is basically fixing the bug that we didn't
think about the userspace-irqchip case when we implemented
"host" and "max" or when we added GICv3 support.

thanks
-- PMM

