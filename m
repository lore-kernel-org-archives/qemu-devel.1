Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5280C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FA42076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="nApo7SCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA42076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQ0t-00078I-O1
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGQ04-0006dd-Ka
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:04:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGQ02-0006BP-CX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:04:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so4546873pgm.11
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=JLtNcEiFh93vI78JLVP0wj1De6Nb4dIdkfShV924vkE=;
 b=nApo7SCVl10VZrAFsHoilQLZSY2CuBBhp6joKzMlxFinbb7wa0XNSi+v+69Rhlxcaq
 45nkMh1PMasuXfZc6AOyx5ocXARsOSdnhYlkKawBbpDRT/fJZ+R/SNjBCEFP0Zcn9oBA
 hhp/YTr4iiud5uNfiGpY6pf+Y6/gse8w3CzqS462cDkJ6QRHo9HWDYPj0Ho7tmtGa4dz
 6LAYKqitzGPNSZVqW+nT4HAbeP0WGv7SUnx8XkQOwKeMfdfoykogUHxnXKGJQ0J9+cuV
 rdV5a/jxPVvca8jS+/KF291dYCWvlzqfjFYA7XpbSc/96wlDcWeJgUy3JIODFliRZjD+
 H0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=JLtNcEiFh93vI78JLVP0wj1De6Nb4dIdkfShV924vkE=;
 b=Esyz7hKBaYXUOKWVm/lLuTOjuf7rnFheMNysEZKSvse3QyEIKogmjFnRMItTyVS4XJ
 rmukSv9ecdQc0YpQV/C9oJzvxPCDCmY0DRwjsi9r7Z0HCsj7I1xCCXgoy65L+DG5ocm5
 BG7vIdSsxkG30Sqm8V0hlYWs9RlsSAkbMtcmIkaoI/8CynmqrXHdu17AWS0uTr8L9m4v
 BnvPe462b4e5E/28sIfc2eWKTTD7GCS04Bpp8UHVzpLhmX/sMxcNMyMRlh8B8nUCXuBN
 5e9q9C5Ajz+9stLPwiu3WQM1X7yBN/wPZKzy0We3icMbvjNCmMM3H1HRSRpqQ6kfdrTa
 Qhaw==
X-Gm-Message-State: AOAM533L3GGAb8Kx2NrJKB+jjgSlF3dcE+giXmwS+4HtNYuKrkT+w+sN
 eEdrwjdXs47FvhqtI1RKA1hCpGuh+ujjZF7l
X-Google-Smtp-Source: ABdhPJy7o0BUajhjlkdxwtWP6Kww5++PyZ2fPZrTQKKHR3fIyflNqY5Vb7X/1cfMV+WbZroPhmUJjA==
X-Received: by 2002:a62:864e:: with SMTP id x75mr6232072pfd.60.1599757480036; 
 Thu, 10 Sep 2020 10:04:40 -0700 (PDT)
Received: from [192.168.1.2] ([115.96.138.63])
 by smtp.gmail.com with ESMTPSA id b24sm2447457pjp.22.2020.09.10.10.04.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2020 10:04:39 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:34:20 +0530
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Message-ID: <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
In-Reply-To: <20200905103520.12626-3-ani@anisinha.ca>
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200905103520.12626-3-ani@anisinha.ca>
Subject: Re: [PATCH v1 2/3] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
X-Readdle-Message-ID: 448ada27-1a94-44ed-89fa-001a70213ad7@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f5a5ca2_327b23c6_17b9"
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f5a5ca2_327b23c6_17b9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sep 5, 2020, 16:05 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> This change adds a new unit test for the global flag
> 'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> bridges in i440fx. The flag can be used to turn off acpi based hotplug support
> for all the slots of the pci bus.
>
> Tested on the upstream qemu master branch on top of tag v5.1.0

Can someone please review this?
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
>
> ---
> tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index a2c0070306..e52a36e775 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -723,6 +723,20 @@ static void test_acpi_piix4_root_hotplug(void)
> free_test_data(&data);
> }
>
> +static void test_acpi_piix4_bridge_hotplug(void)
> +{
> + test_data data;
> +
> + memset(&data, 0, sizeof(data));
> + data.machine = MACHINE_PC;
> + data.variant = ".hpbridge";
> + data.required_struct_types = base_required_struct_types;
> + data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> + test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> + "-device pci-bridge,chassis_nr=1", &data);
> + free_test_data(&data);
> +}
> +
> static void test_acpi_q35_tcg(void)
> {
> test_data data;
> @@ -1117,6 +1131,7 @@ int main(int argc, char *argv[])
> qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> + qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
> --
> 2.17.1
>

--5f5a5ca2_327b23c6_17b9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Sep 5, 2020, 16:05 +0530, Ani Sinha &lt;ani=40an=
isinha.ca&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This change adds a new unit test=
 for the global flag</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>'acpi-pci-hotplug-with-bridge-su=
pport' which is available for cold plugged pci</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bridges in i440fx. The flag can =
be used to turn off acpi based hotplug support</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>for all the slots of the pci bus=
.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Tested on the upstream qemu mast=
er branch on top of tag v5.1.0</blockquote>
<div dir=3D=22auto=22><br />
Can someone please review this=3F&=23160;<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=
=40anisinha.ca&gt;</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>tests/qtest/bios-tables-test.c =7C=
 15 +++++++++++++++</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>1 file changed, 15 insertions(+)=
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/tests/qtest/bios-ta=
bles-test.c b/tests/qtest/bios-tables-test.c</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index a2c0070306..e52a36e775 100=
644</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/tests/qtest/bios-tables-te=
st.c</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/tests/qtest/bios-tables-te=
st.c</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -723,6 +723,20 =40=40 sta=
tic void test=5Facpi=5Fpiix4=5Froot=5Fhotplug(void)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>free=5Ftest=5Fdata(&amp;data);</=
blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+static void test=5Facpi=5Fpiix4=
=5Fbridge=5Fhotplug(void)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7B</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ test=5Fdata data;</blockquote>=

<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ memset(&amp;data, 0, sizeof(da=
ta));</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ data.machine =3D MACHINE=5FPC;=
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ data.variant =3D =22.hpbridge=22=
;</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ data.required=5Fstruct=5Ftypes=
 =3D base=5Frequired=5Fstruct=5Ftypes;</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ data.required=5Fstruct=5Ftypes=
=5Flen =3D ARRAY=5FSIZE(base=5Frequired=5Fstruct=5Ftypes);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ test=5Facpi=5Fone(=22-global P=
IIX4=5FPM.acpi-pci-hotplug-with-bridge-support=3Doff =22</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =22-device pci-bridge,chassis=5F=
nr=3D1=22, &amp;data);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ free=5Ftest=5Fdata(&amp;data);=
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7D</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void test=5Facpi=5Fq35=5F=
tcg(void)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>test=5Fdata data;</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -1117,6 +1131,7 =40=40 in=
t main(int argc, char *argv=5B=5D)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/piix4=
=22, test=5Facpi=5Fpiix4=5Ftcg);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/piix4=
/bridge=22, test=5Facpi=5Fpiix4=5Ftcg=5Fbridge);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/piix4=
/hotplug=22, test=5Facpi=5Fpiix4=5Froot=5Fhotplug);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ qtest=5Fadd=5Ffunc(=22acpi/pii=
x4/brhotplug=22, test=5Facpi=5Fpiix4=5Fbridge=5Fhotplug);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/q35=22=
, test=5Facpi=5Fq35=5Ftcg);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/q35/b=
ridge=22, test=5Facpi=5Fq35=5Ftcg=5Fbridge);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>qtest=5Fadd=5Ffunc(=22acpi/q35/m=
mio64=22, test=5Facpi=5Fq35=5Ftcg=5Fmmio64);</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2.17.1</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f5a5ca2_327b23c6_17b9--


