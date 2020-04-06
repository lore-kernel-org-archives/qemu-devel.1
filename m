Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F414C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF612072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3AuocZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF612072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXPz-0001fn-2y
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLXPE-00018V-RB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLXPD-0004Bg-5z
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:27:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLXPD-0004Al-2W
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586201254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9hw2r3XuMhxu2ceFMlh/GIizVndXsI7JRHHEnB3mAA=;
 b=e3AuocZegbS6Ox3tVMA8duTdkApnSnFjjC2SZDU1zhIh4e4CAbBTHlQKDtF6+8YfWfi14/
 qO7HJeSrinCPcxh+hX/lIhVAwpdSI3XIdLV2HBtipvKHJQ/NMxO8H9jCcRgPX1YxvfGFh/
 0B8q2zztumduTyopvepIKsEk29vGQRY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131--PzYOG5GPG62tFLMU_C6jw-1; Mon, 06 Apr 2020 15:27:32 -0400
X-MC-Unique: -PzYOG5GPG62tFLMU_C6jw-1
Received: by mail-wr1-f72.google.com with SMTP id w12so315050wrl.23
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 12:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vH4S252xlwVt7yZRZ9TyCpmMOxuJpaiKL9uzvrcOkCE=;
 b=S4bf4igxmzynsaht5vwPTqTG0MzH33u9WDdJO6eBsyjGoHZecqKhqchhf56P/5mIBh
 27dzksqXGTrBaY0Pg43I/n0Ma7EnMF4le4ZieJjUeWig7PFWQsz1TjzfTEETKR5XjvkG
 hsTBafHs0crYUU4CJc75izEfNlGdBJXF0I815Ifr+VX4n4lAX6kw3HJ42ynLnXK0+PfD
 yC5v+9ihbPuem4eGeLmhs0Ezo5IbDV/cHFxVR3JV9YVjTNKGu8yRuekFOw7N1Oy0pPRC
 fVlgqx9wRBnSBOhXNHvI2Orr1P0SW6bKidiVkYvTANda3R2KuimZCPjxBFtDxA+PyK6A
 FUfw==
X-Gm-Message-State: AGi0PuZgxj8ReInQgnZg5XYdtTU+W2tFIVUL7wf32Eg4zkcFwG4gKP3z
 /mGuZPa61vrnFIH8VJdL/ZL0NA+Kf1JgnqbTYP6FzloHwyy+a7bqL/ziz3YlGpUjMzvP2m86gIE
 s8iuLH33BLuPiNr0=
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr981223wmj.106.1586201251660; 
 Mon, 06 Apr 2020 12:27:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWELSVNY6vBl86FOR9guhtYNl3YGicNR4fu8QaQ7NWyM7d3YQ19TwMqSRkrioG0iKggLuSyg==
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr981200wmj.106.1586201251417; 
 Mon, 06 Apr 2020 12:27:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s6sm675188wmh.17.2020.04.06.12.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 12:27:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 53/54] hw/mips/mips_malta: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-54-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4772e76b-04ea-50f5-8df5-50e930e0eb80@redhat.com>
Date: Mon, 6 Apr 2020 21:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-54-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 7:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Running the coccinelle script produced:
>=20
>    $ spatch \
>      --macro-file scripts/cocci-macro-file.h --include-headers \
>      --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
>      --keep-comments --smpl-spacing --dir .
>    HANDLING: ./hw/mips/mips_malta.c
>    [[manual check required: error_propagate() might be missing in object_=
property_set_int() ./hw/mips/mips_malta.c:1193:4]]
>    [[manual check required: error_propagate() might be missing in object_=
property_set_str() ./hw/mips/mips_malta.c:1192:4]]
>=20
> Add the missing error_propagate() after review by adding
> a Error* parameter to create_cps().
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/mips/mips_malta.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..8d43cfd41b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1183,18 +1183,27 @@ static void create_cpu_without_cps(MachineState *=
ms,
>   }
>  =20
>   static void create_cps(MachineState *ms, MaltaState *s,
> -                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> +                       qemu_irq *cbus_irq, qemu_irq *i8259_irq,
> +                       Error **errp)
>   {
>       Error *err =3D NULL;
>  =20
>       sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->=
cps),
>                             TYPE_MIPS_CPS);
>       object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", =
&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &e=
rr);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -    if (err !=3D NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
>       }
>  =20
>       sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
> @@ -1207,7 +1216,7 @@ static void mips_create_cpu(MachineState *ms, Malta=
State *s,
>                               qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>   {
>       if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
> -        create_cps(ms, s, cbus_irq, i8259_irq);
> +        create_cps(ms, s, cbus_irq, i8259_irq, &error_fatal);
>       } else {
>           create_cpu_without_cps(ms, cbus_irq, i8259_irq);
>       }
>=20

This patch also requires:

-- >8 --
@@ -1241,7 +1241,7 @@ void mips_malta_init(MachineState *machine)
      int64_t kernel_entry, bootloader_run_addr;
      PCIBus *pci_bus;
      ISABus *isa_bus;
-    qemu_irq cbus_irq, i8259_irq;
+    qemu_irq cbus_irq, i8259_irq =3D NULL;
      I2CBus *smbus;
      DriveInfo *dinfo;
      int fl_idx =3D 0;
---

else it fails building with gcc -O3:

hw/mips/mips_malta.c: In function =E2=80=98mips_malta_init=E2=80=99:
hw/mips/mips_malta.c:1419:5: warning: =E2=80=98i8259_irq=E2=80=99 may be us=
ed=20
uninitialized in this function [-Wmaybe-uninitialized]
      1419 |     qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
           |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


