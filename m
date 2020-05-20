Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9735C20884
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="XHY9LehI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9735C20884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbXqV-0001Ij-Nl
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbXpe-0000fp-Hq
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:09:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbXpd-00019s-7H
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:09:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id r10so2168246pgv.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=NyzjDPASPXGnu8G4f+hmdEiime8KfL28FVPix/H5nzc=;
 b=XHY9LehIwqdH8BXsXHkDWVzNo+DraJQYaAFvTh11nRlza+goAqDZi6UFZDKpYnT/rh
 IVo/yLq5mDTpxi+BIRZuZf82PumqFJFbzIyg0QBFk+FaVbGNWY1uSxZl7iAin3pn7bW5
 rejHB1gl2/tv4xPzidLeyheSnFnQA3aI0Wp8uEF+UOD2DW+OSE7i6d+GYMNbvMMPWkmc
 8q0LET9Mhav0BTXOivMoPP9GQK58whIITZgnG/QUQTivArEkEmoEI4+QXV6gNUHA0IGR
 Vtp0tDisHe2eGuYldN77bIkJTp/yanmLfWWQYxibP1NDKwhjxp4IfaUmu+g2wNcXzmWD
 m0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=NyzjDPASPXGnu8G4f+hmdEiime8KfL28FVPix/H5nzc=;
 b=kEvj2hf9/rh1RAb1ZWmwYEX+L6xfTwokPInVnlNIbC8Hqx/WctHg01W4sZ3ontwuRX
 xxk+Kdj8WTgPGb1j1uH2ft9NqaxZWQqjynEZseMrd8TRT8remUA6t0t5L6v875Cm7zh/
 WhVAQTl6DFX/7M3xt9cmVb7Sxs05jYNimMuMK/nQA5eU9b/9uvKEVOtqSeZG0SA1krW1
 Hdwwc2apg7kT+q/zPYStJE2yGCvrOgCVQZoNnLcDZcTq3kInQAHjRv6jbCvf66XSlwmJ
 JW1CyXcn5DJQig9nyiZLE1ICwB6J5H0gTCz9X71YmSIBSMoNePK8NgqxsSp3/vHQiLcP
 dwyg==
X-Gm-Message-State: AOAM532MB+VeELNO69lTSXFeehr0IGXaK/Qud/1/AsURdMB5salb+ctx
 Sw1Eei52qk6+1QpYJB+x0TMoS2VeS73aeg==
X-Google-Smtp-Source: ABdhPJzJuD9fLCkLB560Cz8VjLd/k8PqmiNKdos/deE/dEA0pSVtjdP7uq30U+deQF72xf8blk8VOg==
X-Received: by 2002:a63:f750:: with SMTP id f16mr5848161pgk.136.1590016139358; 
 Wed, 20 May 2020 16:08:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id l2sm423547pga.44.2020.05.20.16.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:08:58 -0700 (PDT)
Date: Wed, 20 May 2020 16:08:58 -0700 (PDT)
X-Google-Original-Date: Wed, 20 May 2020 16:08:52 PDT (-0700)
Subject: Re: [PATCH v1 2/2] sifive_e: Support the revB machine
In-Reply-To: <925bdcd2b3536014306a8800975fb63592fd051a.1589489213.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-8a09dc11-68b8-4e28-9b50-3fc5a52837e6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 13:47:10 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
>  include/hw/riscv/sifive_e.h |  1 +
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 472a98970b..cb7818341b 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -98,10 +98,14 @@ static void riscv_sifive_e_init(MachineState *machine)
>          memmap[SIFIVE_E_DTIM].base, main_mem);
>
>      /* Mask ROM reset vector */
> -    uint32_t reset_vec[2] = {
> -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
> -        0x00028067,        /* 0x1004: jr      t0 */
> -    };
> +    uint32_t reset_vec[2];
> +
> +    if (s->revb) {
> +        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
> +    } else {
> +        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
> +    }
> +    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
>
>      /* copy in the reset vector in little_endian byte order */
>      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> @@ -115,8 +119,31 @@ static void riscv_sifive_e_init(MachineState *machine)
>      }
>  }
>
> +static bool sifive_e_machine_get_revb(Object *obj, Error **errp)
> +{
> +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> +
> +    return s->revb;
> +}
> +
> +static void sifive_e_machine_set_revb(Object *obj, bool value, Error **errp)
> +{
> +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> +
> +    s->revb = value;
> +}
> +
>  static void sifive_e_machine_instance_init(Object *obj)
>  {
> +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> +
> +    s->revb = false;
> +    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
> +                             sifive_e_machine_set_revb, NULL);
> +    object_property_set_description(obj, "revb",
> +                                    "Set on to tell QEMU that it should model "
> +                                    "the revB HiFive1 board",
> +                                    NULL);
>  }
>
>  static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 414992119e..0d3cd07fcc 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -45,6 +45,7 @@ typedef struct SiFiveEState {
>
>      /*< public >*/
>      SiFiveESoCState soc;
> +    bool revb;
>  } SiFiveEState;
>
>  #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")

IIRC there are way more differences between the un-suffixed FE310 and the Rev
B, specifically the interrupt map is all different.

