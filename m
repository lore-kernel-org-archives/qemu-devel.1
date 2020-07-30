Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3591C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1042083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAREMIFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1042083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EKU-0002QN-RM
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k1EJu-000200-Pd
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:34:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k1EJr-0004St-LW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596137662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/y3BKeLHo0U1uNMe7NCggNaRJa+AQj/SGenbibBYF8=;
 b=FAREMIFpMkQ92qXYjAjAV7x3o0j1G194jo0hxfcE2Oy+kCROjvfZL+J1lHPYQaJh2aSr0n
 mNWFaAHv6/EctoXLcCpc+MC8CUJjhZuSozZI2bAY98/YgJTO9ywfbVzGjJPTWH+HrhL98y
 gAltbVn6WW5w4u+bBAdkLlAtCwjHHCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-fUlssr-VPHqPoC51QQRdUA-1; Thu, 30 Jul 2020 15:34:18 -0400
X-MC-Unique: fUlssr-VPHqPoC51QQRdUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152F88015CE;
 Thu, 30 Jul 2020 19:34:17 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-173.ams2.redhat.com
 [10.36.114.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1671002393;
 Thu, 30 Jul 2020 19:34:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] i386/acpi: fix inconsistent QEMU/OVMF device paths
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200730155755.188845-1-mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <da31a188-aad7-e445-77b4-cb5b2d69c960@redhat.com>
Date: Thu, 30 Jul 2020 21:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200730155755.188845-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, vit9696 <vit9696@protonmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/30/20 17:58, Michael S. Tsirkin wrote:
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

with Phil's feedback included:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you very much for writing up the commit message on this patch,
Michael!

Laszlo


