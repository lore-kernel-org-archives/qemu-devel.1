Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E686BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8933C2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bnmGrBYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933C2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9HP-0005Ec-G1
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jJ9Gd-0004np-Fk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1jJ9Gb-0006Gg-Im
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:16:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1jJ9Gb-0006DP-3p
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:16:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id c195so218068wme.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XDVphgSccmvYcqFyScudPHlOHHRlMUeMdNPPF1BkBPk=;
 b=bnmGrBYqxAQkUCIae67D73qblc5THSKXJnDPGTIljlPuPOzZp2vymVOvwEU+9NuaOz
 qsEL2jwiJz36OQvIXqAkB0gJWbd6mYgrnLPLkF9jOlBXC9yMQ7jtTmkEnlBov42RJ1e/
 xgZaJNbwhcO4GGBAkoJDuYkj3yLQItMyf6sq1AabEpSH2AvbOCXwiK75XN4u+gVH53V1
 yJkrC4Mr5AGpCS9B0utMcGKMOUEFNtli5S3ESOGjpZhATgQqh9Y6GOWnMUUDwCTvhSSm
 mZFZY2fk5mGI0ni1fqoJtNoOZjEKyFVYgdGp2tVM6mxwwOUBn/NL/bP7akNuABURp/MS
 PwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XDVphgSccmvYcqFyScudPHlOHHRlMUeMdNPPF1BkBPk=;
 b=kJI8wX793DbepoAudMpmL+QJ6c4cimecU1E3nRAlqmlNnuRUZnEqOxMJQOhHyi7fBd
 9uf6M1ew+BmUtPdqggY2ap4GiMsuefmZkLYEJPOs6NZIHCjr4tUz5Sh0uDMotV86vZ5H
 S4W2ZuCUF66sE4cGKSdEACLEmiLz2IjbAKt6Z8ZH2yYeUAS8rx2mb/995BTOK5aSu1F3
 ght1YhjjNwQN8jgfu7B0/V7VbM6LsF6z3jqOX0Dmfvv6N/JqDtXm601gFbYCyHlhnpv9
 rqfUUgujgaDmUz+x+9VK83PTImPIcmp93LktalzXs1TB3/CvTeMWgt3pFAeWjOKc8pgJ
 TXjA==
X-Gm-Message-State: ANhLgQ3/1s/q1jPTFcElV9Jng4TEK0PkM6yOTWNHAnxmkIYuWMJsHmCu
 lAI1z7zBT8MIkERHb+P2yFaIxJOhulvy3zuZQLk96A==
X-Google-Smtp-Source: ADFU+vvd2njPlrWxTZF97cgeZmHgYyLh6LgsQXjiwYBgIHxI9cRvsYMNUNHwUbHFSnXtAX0OMkCjhr1cZFXkxBZ0zJw=
X-Received: by 2002:a1c:6385:: with SMTP id x127mr1455502wmb.141.1585631804849; 
 Mon, 30 Mar 2020 22:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <20200313034949.3028-9-jiangyifei@huawei.com>
In-Reply-To: <20200313034949.3028-9-jiangyifei@huawei.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 31 Mar 2020 10:46:32 +0530
Message-ID: <CAAhSdy3EE+2V+e0po7kmdEau_88CEJ-D9yu7=PQ4ZJQ=zWr9YA@mail.gmail.com>
Subject: Re: [PATCH RFC 8/9] target/riscv: Handler KVM_EXIT_RISCV_SBI exit
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: victor.zhangxiaofeng@huawei.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 zhang.zhanghailiang@huawei.com, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng1@huawei.com,
 Palmer Dabbelt <palmer@dabbelt.com>, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 9:23 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Use char-fe handler console sbi call, which implement early
> console io while apply 'earlycon=sbi' into kernel parameters.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> ---
>  target/riscv/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 0f429fd802..1df70fbb29 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -38,6 +38,7 @@
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "kvm_riscv.h"
> +#include "chardev/char-fe.h"
>
>  static __u64 kvm_riscv_reg_id(__u64 type, __u64 idx)
>  {
> @@ -61,6 +62,19 @@ static __u64 kvm_riscv_reg_id(__u64 type, __u64 idx)
>
>  #define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id(KVM_REG_RISCV_FP_D, idx)
>
> +enum sbi_ext_id {
> +    SBI_EXT_0_1_SET_TIMER = 0x0,
> +    SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> +    SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> +    SBI_EXT_0_1_CLEAR_IPI = 0x3,
> +    SBI_EXT_0_1_SEND_IPI = 0x4,
> +    SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> +    SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> +    SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> +    SBI_EXT_0_1_SHUTDOWN = 0x8,
> +    SBI_EXT_BASE = 0x10,
> +};
> +

Please add separate SBI ecall interface header (similar to OpenSBI).
This header will only have SBI spec related defines.

Refer,
https://github.com/riscv/opensbi/blob/master/include/sbi/sbi_ecall_interface.h

>  static int kvm_riscv_get_regs_core(CPUState *cs)
>  {
>      int ret = 0;
> @@ -423,9 +437,47 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
>      return true;
>  }
>
> +static int kvm_riscv_handle_sbi(struct kvm_run *run)
> +{
> +    int ret = 0;
> +    unsigned char ch;
> +    switch (run->riscv_sbi.extension_id) {
> +    case SBI_EXT_0_1_CONSOLE_PUTCHAR:
> +        ch = run->riscv_sbi.args[0];
> +        qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
> +        break;
> +    case SBI_EXT_0_1_CONSOLE_GETCHAR:
> +        ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> +        if (ret == sizeof(ch)) {
> +            run->riscv_sbi.args[0] = ch;
> +        } else {
> +            run->riscv_sbi.args[0] = -1;
> +        }
> +        break;

Please emulate SBI v0.1 Shutdown call as well.

> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> +                      __func__, run->riscv_sbi.extension_id);
> +        ret = -1;
> +        break;
> +    }
> +    return ret;
> +}
> +
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
> -    return 0;
> +    int ret = 0;
> +    switch (run->exit_reason) {
> +    case KVM_EXIT_RISCV_SBI:
> +        ret = kvm_riscv_handle_sbi(run);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
> +                      __func__, run->exit_reason);
> +        ret = -1;
> +        break;
> +    }
> +    return ret;
>  }
>
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
> --
> 2.19.1
>
>
>

Regards,
Anup

