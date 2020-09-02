Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D102C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1D72084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="UY+DkVK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1D72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNEa-0001ul-QX
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDNDv-0001Mw-7d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:30:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDNDs-0005JN-Mq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:30:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id m5so2103090pgj.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=kWVpW+gWWWBqDl5SebnLaaj25XD9fLzA5xyD4D9dZ/A=;
 b=UY+DkVK3uF9f0U5U3Weikz8Z8pT/zNTx73X6sIYQ2qj8qOjIgjD2SJxRG7+FCTdIxx
 7XKWNPZ0DHOiekwuN+I4pq0Mhiv7y3QV6UmIERTIaAZBTqZtzIL6jIRlldnTTRco4pf6
 41VLleNVjgydDF1gSj1TI64E2YlHkX9TqJAtVb5rjwxVR/1lUMaGyaDcBFR0L/MzGL5U
 4YDJRAHG4x5PH16yAQlu0kB+s9M+Z/C41uXtFmXmjGyT92zJ1MJCBOxfutpKiuJOmXGR
 zbzv9X3Yq5HLvXJYX8mJ6IESNW9GLX6gIV/sRrYpEnifD0Jw0GuTNx+bkjybkpkPGaXO
 wdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=kWVpW+gWWWBqDl5SebnLaaj25XD9fLzA5xyD4D9dZ/A=;
 b=neWcfSBCna0u2Msm88kYyeNnNh3hXWSZhC4kLv7m2Y403Cw3wVLSAiYIuWon2x4XGE
 AV5UK1/Nt8dRhGNP/eSQWFL61fc3D074OjdxjGFAYgefSwItHLRzC7GppEKGR9btzDRY
 vA0kWrTKrnTmDZmm8VQXtbaK0e33HRcuceiKI3zJcz8NulKCSCa5IyqFZICl9fguwScb
 j6NO7Tfq+UcVFHn224BFL8nrRGQJv6nAkdk3hW5g+5MeysOpwUy+4qEJgSLmiWdc0C5j
 5EgzTXPgrj9mdsxFNnifY/qc/8nZWRa/dTonbLpCL/amAQKFt9oC6Hb+mtAUrjI0NR7s
 dUwQ==
X-Gm-Message-State: AOAM532XUev8fh+AnYpkJnfpYzhETl1kSDvpe8uV+SbJcIvwH1Nf/UlG
 FMrT0djfdcPtmyR6vyhXFNLyNI7GqZzT4Q1/
X-Google-Smtp-Source: ABdhPJxMWlrrDSVMdfzYi+ZfxQyZ1d9z/AoiVcFyqbs+lIFFaA5De12VbikmrxGNxrURW7lLez257g==
X-Received: by 2002:a63:344f:: with SMTP id b76mr922270pga.388.1599031822805; 
 Wed, 02 Sep 2020 00:30:22 -0700 (PDT)
Received: from [2401:4900:110e:f9c1:40ce:e686:200:0]
 ([2401:4900:110e:f9c1:9c90:3089:1abf:7d25])
 by smtp.gmail.com with ESMTPSA id 8sm3816551pjx.14.2020.09.02.00.30.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Sep 2020 00:30:22 -0700 (PDT)
Date: Wed, 2 Sep 2020 13:00:01 +0530
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Message-ID: <07c02231-daa5-4822-8003-f15fe21dad5f@Spark>
In-Reply-To: <20200829081233.10120-1-ani@anisinha.ca>
References: <20200829081233.10120-1-ani@anisinha.ca>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
X-Readdle-Message-ID: 07c02231-daa5-4822-8003-f15fe21dad5f@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f4f49ff_12200854_239"
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, jusual@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f4f49ff_12200854_239
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Can someone please review this?
On Aug 29, 2020, 13:42 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> When ACPI hotplug for the root bus is disabled, the bsel property for that
> bus is not set. Please see the following commit:
>
> 3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").
>
> As a result, when acpi_pcihp_find_hotplug_bus() is called
> with bsel set to 0, it may return the root bus. This would be wrong since the
> root bus is not hotpluggable. In general, this can potentially happen to other
> buses as well.
> In this patch, we fix the issue in this function by checking if the bus returned
> by the function is actually hotpluggable. If not, we simply return NULL. This
> avoids the scenario where we are actually returning a non-hotpluggable bus.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
> hw/acpi/pcihp.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 39b1f74442..f148e73c89 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
> if (!bsel && !find.bus) {
> find.bus = s->root;
> }
> +
> + /*
> + * Check if find.bus is actually hotpluggable. If bsel is set to
> + * NULL for example on the root bus in order to make it
> + * non-hotpluggable, find.bus will match the root bus when bsel
> + * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
> + * bus is not hotpluggable however, we should not select the bus.
> + * Instead, we should set find.bus to NULL in that case. In the check
> + * below, we generalize this case for all buses, not just the root bus.
> + * The callers of this function check for a null return value and
> + * handle them appropriately.
> + */
> + if (!qbus_is_hotpluggable(BUS(find.bus))) {
> + find.bus = NULL;
> + }
> return find.bus;
> }
>
> --
> 2.17.1
>

--5f4f49ff_12200854_239
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Can someone please review this=3F</div>
</div>
<div name=3D=22messageReplySection=22>On Aug 29, 2020, 13:42 +0530, Ani S=
inha &lt;ani=40anisinha.ca&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>When ACPI hotplug for the root bus is disabled, the bsel proper=
ty for that<br />
bus is not set. Please see the following commit:<br />
<br />
3d7e78aa7777f (=22Introduce a new flag for i440fx to disable PCI hotplug =
on the root bus=22).<br />
<br />
As a result, when acpi=5Fpcihp=5Ffind=5Fhotplug=5Fbus() is called<br />
with bsel set to 0, it may return the root bus. This would be wrong since=
 the<br />
root bus is not hotpluggable. In general, this can potentially happen to =
other<br />
buses as well.<br />
In this patch, we fix the issue in this function by checking if the bus r=
eturned<br />
by the function is actually hotpluggable. If not, we simply return NULL. =
This<br />
avoids the scenario where we are actually returning a non-hotpluggable bu=
s.<br />
<br />
Signed-off-by: Ani Sinha &lt;ani=40anisinha.ca&gt;<br />
---<br />
hw/acpi/pcihp.c =7C 15 +++++++++++++++<br />
1 file changed, 15 insertions(+)<br />
<br />
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c<br />
index 39b1f74442..f148e73c89 100644<br />
--- a/hw/acpi/pcihp.c<br />
+++ b/hw/acpi/pcihp.c<br />
=40=40 -147,6 +147,21 =40=40 static PCIBus *acpi=5Fpcihp=5Ffind=5Fhotplug=
=5Fbus(AcpiPciHpState *s, int bsel)<br />
if (=21bsel &amp;&amp; =21find.bus) =7B<br />
find.bus =3D s-&gt;root;<br />
=7D<br />
+<br />
+ /*<br />
+ * Check if find.bus is actually hotpluggable. If bsel is set to<br />
+ * NULL for example on the root bus in order to make it<br />
+ * non-hotpluggable, find.bus will match the root bus when bsel<br />
+ * is 0. See acpi=5Fpcihp=5Ftest=5Fhotplug=5Fbus() above. Since the<br /=
>
+ * bus is not hotpluggable however, we should not select the bus.<br />
+ * Instead, we should set find.bus to NULL in that case. In the check<br=
 />
+ * below, we generalize this case for all buses, not just the root bus.<=
br />
+ * The callers of this function check for a null return value and<br />
+ * handle them appropriately.<br />
+ */<br />
+ if (=21qbus=5Fis=5Fhotpluggable(BUS(find.bus))) =7B<br />
+ find.bus =3D NULL;<br />
+ =7D<br />
return find.bus;<br />
=7D<br />
<br />
--<br />
2.17.1<br />
<br /></blockquote>
</div>
</body>
</html>

--5f4f49ff_12200854_239--


