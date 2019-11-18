Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681CDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F8D20748
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib98Jpgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F8D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWh0A-0005XP-C7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 08:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iWgyC-0004Z7-V1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iWgyA-0007Fn-Nu
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:21:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iWgyA-0007F4-0b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574083289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDt0kz5uoG+Wvoc+FOMxPI8N9nsBIvdXSRfwD1DTFEU=;
 b=Ib98JpgkVDE6To+FetRlGAWJ7GETiSEew4WyadIeJq6rHnhgaqVnmqeZpF/NyMzCGE0JHb
 D0UFZ5oGAv9ka2qwK6QoWKzkA6w2w+MRsBHfwY6g0dPlnW7pSY935PAx9NWarPDKgXqY/u
 CKzCWVTLUI+cnp/E+j25xP9GRhWl/JE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-LnQFtjI7MT25Zt7nGCEG2g-1; Mon, 18 Nov 2019 08:21:27 -0500
Received: by mail-qk1-f198.google.com with SMTP id 64so11466485qkm.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 05:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q9+IKFPWhISyaYV00Tog4e8K2FzhfF9OCbbQXzCjBFw=;
 b=Jp+MSUHEn3ZhTQEm6+gwe3N8fNHeuhAD5suL9JpaUnyADmETa8/S8t5er4lLDgCqCt
 zQkzvXMQHNsoKxUgIxcXZOa9amrHPDRjnIuBMvXNmKkV7/SVZXS0GZTf4qOkTf7iz8vc
 dEaWIcHuOhI+OiMRMu94lfnaPIY9FjSAvHEWUnRqNzzfjw3xZlBxkgaV+Rttygmi/pz5
 DaBaxcEN+bsBU1GtdhswIBnfgLtHU29mI3u6xF9ufrL7VL0COX86RG/VEGwluvcgQGBb
 w0lTofX1eYZjWnV5bl3BELrfiEwtjvWMNIsfoYwpRLn6TW9GqfAPjARSpxQL+71LvXBD
 9+FQ==
X-Gm-Message-State: APjAAAW/gh8CvvW11DfRNazcoX+LJ94w3sZNmWQdY8fEm9ltPStufaM2
 caJ9lRo1vscn++uHg81wwxJziFR4civ2cNDTEBXLGWNeGAwZX3WTHCF/U1KSZlZAC3mfviDdb0P
 Ey8Hh1WWcJb4ujhc=
X-Received: by 2002:ac8:13ca:: with SMTP id i10mr25764988qtj.214.1574083287505; 
 Mon, 18 Nov 2019 05:21:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg2fO6T3H3YLS5WBC+X8LieZNM8Tgl3Rc4RrZGwUyU1/5RAkrJEWaL4BfmLzoP5T+X12Q76A==
X-Received: by 2002:ac8:13ca:: with SMTP id i10mr25764951qtj.214.1574083287214; 
 Mon, 18 Nov 2019 05:21:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id a2sm8410998qkl.71.2019.11.18.05.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 05:21:26 -0800 (PST)
Date: Mon, 18 Nov 2019 08:21:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
Message-ID: <20191118082036-mutt-send-email-mst@kernel.org>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-4-zhengxiang9@huawei.com>
 <20191115103801.547fc84d@redhat.com>
 <cf5e5aa4-2283-6cf9-70d0-278d167e3a13@huawei.com>
 <87758ec2-c242-71c3-51f8-a5d348f8e7fd@huawei.com>
MIME-Version: 1.0
In-Reply-To: <87758ec2-c242-71c3-51f8-a5d348f8e7fd@huawei.com>
X-MC-Unique: LnQFtjI7MT25Zt7nGCEG2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 wanghaibin.wang@huawei.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org, james.morse@arm.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, xuwei5@huawei.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 09:18:01PM +0800, gengdongjiu wrote:
> On 2019/11/18 20:49, gengdongjiu wrote:
> >>> +     */
> >>> +    build_append_int_noprefix(table_data, source_id, 2);
> >>> +    /* Related Source Id */
> >>> +    build_append_int_noprefix(table_data, 0xffff, 2);
> >>> +    /* Flags */
> >>> +    build_append_int_noprefix(table_data, 0, 1);
> >>> +    /* Enabled */
> >>> +    build_append_int_noprefix(table_data, 1, 1);
> >>> +
> >>> +    /* Number of Records To Pre-allocate */
> >>> +    build_append_int_noprefix(table_data, 1, 4);
> >>> +    /* Max Sections Per Record */
> >>> +    build_append_int_noprefix(table_data, 1, 4);
> >>> +    /* Max Raw Data Length */
> >>> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LEN=
GTH, 4);
> >>> +
> >>> +    /* Error Status Address */
> >>> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> >>> +                     4 /* QWord access */, 0);
> >>> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> >>> +        ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id)=
,
> >> it's fine only if GHESv2 is the only entries in HEST, but once
> >> other types are added this macro will silently fall apart and
> >> cause table corruption.
>    why  silently fall?
>    I think the acpi_ghes.c only support GHESv2 type, not support other ty=
pe.
>=20
> >>
> >> Instead of offset from hest_start, I suggest to use offset relative
> >> to GAS structure, here is an idea>>
> >> #define GAS_ADDR_OFFSET 4
> >>
> >>     off =3D table->len
> >>     build_append_gas()
> >>     bios_linker_loader_add_pointer(...,
> >>         off + GAS_ADDR_OFFSET, ...
>=20
> If use offset relative to GAS structure, the code does not easily extend =
to support more Generic Hardware Error Source.
> if use offset relative to hest_start, just use a loop, the code can suppo=
rt  more error source, for example:
> for (source_id =3D 0; i<n; source_id++)
> {
>    ......
>     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>         ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id),
>         sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
>         source_id * sizeof(uint64_t));
>   .......
> }
>=20
> My previous series patch support 2 error sources, but now only enable 'SE=
A' type Error Source

I'd try to merge this, worry about extending things later.
This is at v21 and the simpler you can keep things,
the faster it'll go in.


