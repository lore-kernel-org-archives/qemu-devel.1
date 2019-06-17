Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38272C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056D7206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP7rJT42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056D7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsHt-0001kX-R9
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsFg-0000cb-Jx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsFe-00051S-MS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:04:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsFe-0004tf-C2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:04:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id x4so10101416wrt.6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hrdEodOEdUkO3HOIUN3wsMAtVxKGYbDhibykAZ0dN3k=;
 b=YP7rJT42PnecfK2emDSm8l4mJWjRD0y3bnCJQ4bcDvTGpE4Q4cuLN5UOMbw1TjBNr3
 PEXGAwhLPOKkiv+9bYUqGP8e9UGEDsQMqV786KbGASwSKiZ8yTm6OKO5TrAr5ShIxudx
 HtYcjM48M6pWXF9auYlPFYpPJI5/eUarez9O3sL/nlFCDcaKD+vIe7BP6oPtX0hiJ1f5
 aeJJ7POEzYGrqmKAsMXG4/+ESlCB9Ah5GboVMzw23aMPhExxIKjc1r6tiPjvDSlYXKh+
 PkSZL3aXDtfSfjaxMYgrz+2F6061cLnQbBk190afyNP2mu1Yjki1Jyfp8NFPylQveKVS
 kkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hrdEodOEdUkO3HOIUN3wsMAtVxKGYbDhibykAZ0dN3k=;
 b=MFMy6E6bL2tcHyljf4Q8QnjcLlP4XqfrpzXCsc+zZZfTYRVqQG5LxlChK0/xw3/FjJ
 ibmQPnlbS7E/mjPP1NgBuZ4JpbiftBxN1RIjQ8EqJM8LZ15yj6LcxUkj8mn/1TX1Zg3t
 cTr5MtBNU0nEUHxivVTQTFLtYMqAkLNBsT8L4cts7ZiApbHLbAhrIBI3vHqpT5tuvIb9
 AOcH8BONpKT6pRJ3Ksqy/YyIsqtzApGNbTY8qbAvRJEnGRZfS9KDYQSBP/ITiQcrO9pP
 9u6e/eWflnhuTNM6tvuCPH/1c5a04UUuVCTjd9ZlwS03IoTx+0G1IsOCOLjgumxnbz09
 0BcA==
X-Gm-Message-State: APjAAAX8j5yIVioPeYKYHLCR6PIp2CjRXqd7HiTm1d1uLJ/hjl+zaK0w
 VDkDdqhctC9RxQtnSHBo/W6Xtg==
X-Google-Smtp-Source: APXvYqxXT+J+CAZ8K0gDItZu9Xm7L5/wiiJQL3ycJS7zKRFsGy1HwWttCuN+9LYxJj6TxsbPI5Nt0g==
X-Received: by 2002:a05:6000:1c9:: with SMTP id
 t9mr53311947wrx.187.1560780286933; 
 Mon, 17 Jun 2019 07:04:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t140sm9461121wmt.0.2019.06.17.07.04.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:04:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9F3F1FF87;
 Mon, 17 Jun 2019 15:04:45 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-24-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-24-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:04:45 +0100
Message-ID: <87y3209uki.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [NOTFORMERGE PATCH v2 23/23] Missing
 symbols when building with --disable-tcg
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> While it might be normal to disable PSCI on KVM, I doubt the
> VFP helpers are correct ;)
>
> Anyway this allow to link the binary and run a KVM guest.

But also:

/home/alex/lsrc/qemu.git/target/arm/helper.c: In function =E2=80=98S1_ptw_t=
ranslate=E2=80=99:
/home/alex/lsrc/qemu.git/target/arm/helper.c:8794:15: note: parameter passi=
ng for argument of type =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct M=
emTxAttrs=E2=80=99} changed in GCC 9.1
 8794 | static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
      |               ^~~~~~~~~~~~~~~~
  LINK    x86_64-linux-user/qemu-x86_64
  LINK    xtensa-linux-user/qemu-xtensa
/home/alex/lsrc/qemu.git/target/arm/helper.c: In function =E2=80=98S1_ptw_t=
ranslate=E2=80=99:
/home/alex/lsrc/qemu.git/target/arm/helper.c:8794:15: note: parameter passi=
ng for argument of type =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct M=
emTxAttrs=E2=80=99} changed in GCC 9.1
 8794 | static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
      |               ^~~~~~~~~~~~~~~~
  LINK    xtensaeb-linux-user/qemu-xtensaeb
  LINK    arm-linux-user/qemu-arm
  LINK    aarch64-linux-user/qemu-aarch64
  LINK    armeb-linux-user/qemu-armeb
  LINK    aarch64_be-linux-user/qemu-aarch64_be
  LINK    arm-softmmu/qemu-system-arm
  LINK    aarch64-softmmu/qemu-system-aarch64
/usr/lib/gcc/aarch64-unknown-linux-gnu/9.1.0/../../../../aarch64-unknown-li=
nux-gnu/bin/ld: target/arm/kvm-missing.o: in function `arm_is_psci_call':
/home/alex/lsrc/qemu.git/target/arm/kvm-missing.c:17: multiple definition o=
f `arm_is_psci_call'; target/arm/psci.o:/home/alex/lsrc/qemu.git/target/arm=
/psci.c:36: first defined here
/usr/lib/gcc/aarch64-unknown-linux-gnu/9.1.0/../../../../aarch64-unknown-li=
nux-gnu/bin/ld: target/arm/kvm-missing.o: in function `arm_handle_psci_call=
':
/home/alex/lsrc/qemu.git/target/arm/kvm-missing.c:20: multiple definition o=
f `arm_handle_psci_call'; target/arm/psci.o:/home/alex/lsrc/qemu.git/target=
/arm/psci.c:77: first defined here
/usr/lib/gcc/aarch64-unknown-linux-gnu/9.1.0/../../../../aarch64-unknown-li=
nux-gnu/bin/ld: target/arm/vfp_helper.o: in function `vfp_get_fpscr':
/home/alex/lsrc/qemu.git/target/arm/vfp_helper.c:75: multiple definition of=
 `vfp_get_fpscr'; target/arm/kvm-missing.o:/home/alex/lsrc/qemu.git/target/=
arm/kvm-missing.c:8: first defined here
/usr/lib/gcc/aarch64-unknown-linux-gnu/9.1.0/../../../../aarch64-unknown-li=
nux-gnu/bin/ld: target/arm/vfp_helper.o: in function `vfp_set_fpscr':
/home/alex/lsrc/qemu.git/target/arm/vfp_helper.c:185: multiple definition o=
f `vfp_set_fpscr'; target/arm/kvm-missing.o:/home/alex/lsrc/qemu.git/target=
/arm/kvm-missing.c:12:
first defined here
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:204: qemu-system-aarch64] Error 1
make: *** [Makefile:472: subdir-aarch64-softmmu] Error 2

On AArch64 host with TCG enabled....

>
> Tested using:
>
>   $ make pc-bios/edk2-aarch64-code.fd
>   $ dd if=3D/dev/zero of=3Dflash1.img bs=3D1M count=3D64
>   $ aarch64-softmmu/qemu-system-aarch64 \
>     -nographic \
>     -enable-kvm \
>     -M virt,gic-version=3D3 \
>     -cpu host \
>     \
>     -pflash pc-bios/edk2-aarch64-code.fd \
>     -pflash flash1.img \
>     -drive if=3Dnone,file=3Dbionic-server-cloudimg-arm64.img,id=3Dhd0 \
>     -device virtio-blk-device,drive=3Dhd0 \
>     \
>     -netdev type=3Duser,id=3Dnet0 \
>     -device virtio-net-device,netdev=3Dnet0
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/Makefile.objs |  1 +
>  target/arm/kvm-missing.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 target/arm/kvm-missing.c
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index b8aa9c032a..bf1cad2909 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_dump.o monitor.=
o arm-powerctl.o
>  obj-$(call land,$(CONFIG_TCG),$(CONFIG_SOFTMMU)) +=3D psci.o
>
>  obj-$(CONFIG_KVM) +=3D kvm.o
> +obj-$(CONFIG_KVM) +=3D kvm-missing.o
>  obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
>  obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
>  obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
> diff --git a/target/arm/kvm-missing.c b/target/arm/kvm-missing.c
> new file mode 100644
> index 0000000000..0b32cd4e9c
> --- /dev/null
> +++ b/target/arm/kvm-missing.c
> @@ -0,0 +1,22 @@
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "internals.h"
> +
> +uint32_t vfp_get_fpscr(CPUARMState *env)
> +{
> +    return 0;
> +}
> +
> +void vfp_set_fpscr(CPUARMState *env, uint32_t val)
> +{
> +}
> +
> +bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
> +{
> +    return false;
> +}
> +
> +void arm_handle_psci_call(ARMCPU *cpu)
> +{
> +    abort();
> +}


--
Alex Benn=C3=A9e

