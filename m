Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F3C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AC12075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2OMCo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0ww-0003AQ-RG
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 12:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jS0w9-00028X-Op
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jS0w5-0002QV-KF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:12:21 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:38351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jS0w5-0002Mf-6h; Fri, 24 Apr 2020 12:12:17 -0400
Received: by mail-il1-x144.google.com with SMTP id u5so9792369ilb.5;
 Fri, 24 Apr 2020 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vnS1xMxlQ4q45LRVxXqTXJ2TAoqMdjMxBJhULLriIWI=;
 b=Fh2OMCo7bNBNrNHOPzJwUF7JJZS2kiAWhCCPBSbQy4501QHAu8qUhnJCzkOySj0q9m
 TWVL/1WM1RbwPsipP6SFzz4sTLE3hukTrCN280dFyR5zRPZaN68VHYVzD+bmBMrb5QF5
 qjVUVguRVYOUa+AkD+u98swyQpNHDpSSmvCPlw3L9ErlBQ3JMxoTXr0G6yHGKNQ48XTj
 eskOMs6IjRgCij3E4AjbrD87DJROu7uPGiyOkj/Art+IN23F70u8bd2UVgilwImmMZr2
 KoWb735Z/EwvyQ2bYQ2Pu1stxH3LnWy/H1/BQojseQ7pHc0JPeaFuqH0jDmDxtjys0dc
 yUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnS1xMxlQ4q45LRVxXqTXJ2TAoqMdjMxBJhULLriIWI=;
 b=Gjf9Yu0wzCll6HwGSu3q1B7poXpeZxamcwjaCy05woiKFjhADquroKs09lWamMFmWE
 K+OQgHI+tPX/1WlNPXnrD+720JCZCBs2DkflT3dZeGKp6uKT3SSSQPckMXKAAfd6jn67
 XBZLgV8B9dXc8U77KsWo53aePq0Fjsv5U9UQFYqFFbvvRqzhTaayYGlBHORUSbV/lgki
 fPkMlInsTYUxmjjjXdlEnp23cOZ8b2sJotMyxwMlHRn7hIScexBvsZY7gGXZN+fJIHqJ
 e7GBRF5W4E30buwNle1G6KGTk/PNh5wtbaWUe/BPC1VbE5/D7PUYF+6PlibD0SLAjvLF
 hb5g==
X-Gm-Message-State: AGi0PubK2tA2NzZCSD5D+2lYgAAD+NR10EKCmslugKv51lZ1hHHm4JsM
 Uc+fScu9+gWWZeBvb4i2QA03x5JbepozNNko4as=
X-Google-Smtp-Source: APiQypJqbIiKXLG7j6zoCJkgktVpkmZGCfcIcWqg4HMQ73fC/UwJqgipBdKCPkGMB7FG2tQs+2MbQMbs5J9qJyrnNCU=
X-Received: by 2002:a92:ad09:: with SMTP id w9mr9761771ilh.177.1587744735084; 
 Fri, 24 Apr 2020 09:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200313193429.8035-1-coreyw7@fb.com>
 <20200313193429.8035-2-coreyw7@fb.com>
In-Reply-To: <20200313193429.8035-2-coreyw7@fb.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 24 Apr 2020 09:03:41 -0700
Message-ID: <CAKmqyKNGLOE_UKWVuJzrBDRkRXj74XfOace+K5ab4-5HTWg_KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 12:35 PM Corey Wharton <coreyw7@fb.com> wrote:
>
> Allows the CPU to be changed from the default via the -cpu command
> line option.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the patch.

Unfortunately this fails `make check`.

The problem is that the machine has the `default_cpu_type` set but
then you set "cpu-type" from the SoC.

This diff fixes the make check failure for me:

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1fd08f325c..b53109521e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -123,8 +123,6 @@ static void riscv_sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
-                            &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
     sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
@@ -141,6 +139,8 @@ static void riscv_sifive_e_soc_realize(DeviceState
*dev, Error **errp)
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();

+    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
+                            &error_abort);
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
                             &error_abort);


I'm happy to just squash that into the patch. Let me know if you don't
want me to do that and I'll drop these patches and let you re-send
them.

Alistair

> ---
>  hw/riscv/sifive_e.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index a254cad489..b0a611adb9 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -123,7 +123,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
>      object_initialize_child(obj, "cpus", &s->cpus,
>                              sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
>                              &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
> @@ -220,6 +220,7 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V Board compatible with SiFive E SDK";
>      mc->init = riscv_sifive_e_init;
>      mc->max_cpus = 1;
> +    mc->default_cpu_type = SIFIVE_E_CPU;
>  }
>
>  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> --
> 2.21.1
>
>

