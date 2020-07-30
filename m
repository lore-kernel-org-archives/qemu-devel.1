Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1051C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C81A20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL5L/mHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81A20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BCp-0000GB-T7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1B9a-0004Ga-D8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:11:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1B9U-0000AN-VQ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LsHJBTEaKzlKHvGL1D+u6E/99h7vm8La4lCjYKoomPI=;
 b=VL5L/mHnvOLntyi24k6FtFciUZd0wT87XX2YVpMsKAOQhiRaj222nOEECaqmvI4js5AwgB
 xbd+162oUvpCaY3GgBN9ivLI48xsOiYWdlaAC9nNIweF2E7n+zY1fW01qwWQzV5QFEgS31
 NzTNS1Fzt4kBC/GsmU4VpvQk2ruuP4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-rG4Y9WbiPm-aga9v9zqlLw-1; Thu, 30 Jul 2020 12:11:20 -0400
X-MC-Unique: rG4Y9WbiPm-aga9v9zqlLw-1
Received: by mail-wm1-f70.google.com with SMTP id h6so1477502wml.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LsHJBTEaKzlKHvGL1D+u6E/99h7vm8La4lCjYKoomPI=;
 b=iqUjfC24ZFK66ELzfKpO8RXeuyZhgiNwhRRTth8WLt6i31dlb2FQ2uKFCVEN4g0V6Z
 AMMXUDZMByoRD/BF5sU90/HImAlhy1iOxDKtNOpbIjOSSLSFiT2sNJT7rKTQ4eEtOQez
 oK+Jm0C8hV1pQSidO/3M0cpHkx96z6T3FfuSMz3iDpCHzhyzvEQr3tuJPrM6HHfUenn1
 PLf/Or8n0a6CpoI9h1Vfl9gpwYj+ahmiL5bf5oWuv2GumaXUuh/g+z0sST9YZCBzPARQ
 KqiNzebzQFFZ7QGnjNbb3qQ2nXVpRwo2ZL4tzzPPA0a4/Dt0AmA+ZZUlyVUeUffRrgpN
 LbTg==
X-Gm-Message-State: AOAM5318ZYQ+1UjP4CK53LOSvBbN0ZZEkSoA2VAxNo9YkzGj0iIQfUo3
 5eYPqk0XJvdvw0Ol8wif1nSgHZQZaoHpNKR5TBpYm5d+y9+LkWLP6B/h03Fw2Sj/m69AVkVRjkL
 PV8G+4u/hr8nqGQ0=
X-Received: by 2002:a1c:9cd4:: with SMTP id
 f203mr14646158wme.155.1596125479369; 
 Thu, 30 Jul 2020 09:11:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV0ItGIAToxBdVDGaZhl3LIsKhLWaX9QvMlJqRECAM45UjRm6D8ju39t/xNkfzZV8kSSvUuA==
X-Received: by 2002:a1c:9cd4:: with SMTP id
 f203mr14646131wme.155.1596125479109; 
 Thu, 30 Jul 2020 09:11:19 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id v1sm9240377wro.83.2020.07.30.09.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 09:11:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] i386/acpi: fix inconsistent QEMU/OVMF device paths
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200730155755.188845-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <e1759ee7-b167-d69e-99f9-e824e9e3e0b8@redhat.com>
Date: Thu, 30 Jul 2020 18:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730155755.188845-1-mst@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vit9696 <vit9696@protonmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 5:58 PM, Michael S. Tsirkin wrote:
> macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
> while OVMF firmware gets them via an internal channel through QEMU.
> Due to a bug in QEMU ACPI currently UEFI firmware and ACPI have
> different values, and this makes the underlying operating system
> unable to report its boot option.
> 
> The particular node in question is the primary PciRoot (PCI0 in ACPI),
> which for some reason gets assigned 1 in ACPI UID and 0 in the
> DevicePath. This is due to the _UID assigned to it by build_dsdt in
> hw/i386/acpi-build.c Which does not correspond to the primary PCI
> identifier given by pcibus_num in hw/pci/pci.c
> 
> Reference with the device paths, OVMF startup logs, and ACPI table
> dumps (SysReport):
> https://github.com/acidanthera/bugtracker/issues/1050
> 
> In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
> the paragraph,
> 
>     Root PCI bridges will use the plug and play ID of PNP0A03, This will
>     be stored in the ACPI Device Path _HID field, or in the Expanded
>     ACPI Device Path _CID field to match the ACPI name space. The _UID
>     in the ACPI Device Path structure must match the _UID in the ACPI
>     name space.
> 
> (See especially the last sentence.)
> 
> Considering *extra* root bridges / root buses (with bus number > 0),
> QEMU's ACPI generator actually does the right thing; since QEMU commit
> c96d9286a6d7 ("i386/acpi-build: more traditional _UID and _HID for PXB
> root buses", 2015-06-11).
> 
> However, the _UID values for root bridge zero (on both i440fx and q35)
> have always been "wrong" (from UEFI perspective), going back in QEMU to
> commit 74523b850189 ("i386: add ACPI table files from seabios",
> 2013-10-14).
> 
> Even in SeaBIOS, these _UID values have always been 1; see commit
> a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008-03-08) for
> i440fx, and commit ecbe3fd61511 ("seabios: q35: add dsdt", 2012-12-01)
> for q35.
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: vit9696 <vit9696@protonmail.com>

Vitaly uses his full name on EDK2 mailing list, so I don't think he'll
have a problem to use it in QEMU too:
Tested-by: Vitaly Cheptsov <vit9696@protonmail.com>

From:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line
"Please use your real name to sign a patch (not an alias or acronym)."

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..7a5a8b3521 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1497,7 +1497,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          dev = aml_device("PCI0");
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1512,7 +1512,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
> 


