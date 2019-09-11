Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608CC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DFE206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c/2EyqVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DFE206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84bO-0000xO-OZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i846f-0000QL-AJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i846d-0003Ud-JI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:00:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i846d-0003UH-Dr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:00:27 -0400
Received: by mail-io1-xd41.google.com with SMTP id f12so46436284iog.12
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A4W+uwqmFQL3Fl94MJldRvkiHT0JnYIMySqsIaI9inc=;
 b=c/2EyqVRC7TV1AsCB5wxrkYVp9fJkvaq63AXcQwHdbvrVEjyzkudfqvDd48wwi8QVT
 NOw38ZbBO7ySUEM5DA+dtyrEDYGbrPCUH/b2U8ucFmTUUIfeW93Y63gq6blbB8l9ZXXA
 6RQVAae0VJeJGMLM9NCs8N9lpPuNu+Ipq1ZkS1G6RQds7Tsn3APnuUMgVjVoWjj6cQ6o
 BmET3nQwUJPSeFxaHf+gEDdQfmpXvdrfDq2fehslJ7LvOa9kXgCTrN/AyrCUGvOu+cGI
 ptfaXcN1klB5VW0f3vxrrVilkR5t2TDWRXcS+isRc7dUsQ3cHN4Drc6XU9cDGp6H2rtl
 2ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A4W+uwqmFQL3Fl94MJldRvkiHT0JnYIMySqsIaI9inc=;
 b=iXxT+UzTMks0EkglUsWvRZ9ODN1/LTqAtQh6z7yNPxjY6CJ6giwmVlCih7Pl9g5sKk
 7LJth+CO/Ut0Oz/BR+K1HIB6WhdirC3H8kPImNrYIvZ75ZaKBGrJBkWfmprH+5kZocJ1
 5WTeJdqWa6YEZDl6lhj8gdqxJH7Iy+M7uFiAp2ze5iMbXMDioFyerOOZ1LVFy6P71iD4
 WNSr8pVdM4nQmzUhY3/DhWDGIvF9J1Fv2yN/KTR9o2T+6dRRKrN9a0JJLKpssbmMghYe
 Zbdw7EXMmIZxN4sdRxopAWFUwRpkFTp9BH/NcLzjDCzODJmk9mfKtV6HI84mc2eTvbLO
 rnzg==
X-Gm-Message-State: APjAAAWz01gS51jWxMbVBNY9AfsFQ9ehgDlgyXbP3bpVjk2Yx5fI1UzK
 NSBn/UmjFYaC/L2rspCgh7E5/Ujmk4NQcag8NcddHw==
X-Google-Smtp-Source: APXvYqw54930mTdOMUZckpG8BtuhYzYbJxtjN1ywoyTeKEmtG0hV4gIW7yh/ddeQqoTvY7gtWLvaTlYDQKEXhjDXRHE=
X-Received: by 2002:a02:170a:: with SMTP id 10mr10463458jah.65.1568214025709; 
 Wed, 11 Sep 2019 08:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-3-git-send-email-zhiwei_liu@c-sky.com>
In-Reply-To: <1568183141-67641-3-git-send-email-zhiwei_liu@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 11 Sep 2019 23:00:15 +0800
Message-ID: <CAEiOBXUE4-gq1850=LXj5sWyy=b6JgoKNiVr3LEN-+e8rqbjUg@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 02/17] RISC-V: turn on vector extension
 from command line by cfg.ext_v Property
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 2:36 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:

> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.c | 6 +++++-
>  target/riscv/cpu.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd..9f93ce7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -109,7 +109,7 @@ static void set_resetvec(CPURISCVState *env, int
> resetvec)
>  static void riscv_any_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU | RVV);
>      set_priv_version(env, PRIV_VERSION_1_11_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
> @@ -406,6 +406,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error
> **errp)
>          if (cpu->cfg.ext_u) {
>              target_misa |= RVU;
>          }
> +        if (cpu->cfg.ext_v) {
> +            target_misa |= RVV;
> +        }
>
>          set_misa(env, RVXLEN | target_misa);
>      }
> @@ -441,6 +444,7 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
>      DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, true),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c992b1d..2c7072a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -67,6 +67,7 @@
>  #define RVC RV('C')
>  #define RVS RV('S')
>  #define RVU RV('U')
> +#define RVV RV('V')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there
> @@ -250,6 +251,7 @@ typedef struct RISCVCPU {
>          bool ext_c;
>          bool ext_s;
>          bool ext_u;
> +        bool ext_v;
>          bool ext_counters;
>          bool ext_ifencei;
>          bool ext_icsr;
> --
> 2.7.4
>
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
