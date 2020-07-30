Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67776C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369552072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM7QsSN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369552072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ELx-0003vC-8t
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1EL3-0002wk-2t
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:35:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1EKx-0004aF-9D
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596137730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmhrzzrFt+9+00z9tkBH1hFVeZ+/CoxQ4GyyKANXxGo=;
 b=GM7QsSN4gBxt4jwfnNXfgbbsrokTvRO3UpT6bSK0PGQwi/+jKisg0ewX5Z5J/4wod4sOzU
 Abc0Yia2UOnj771zyeq/qw08xE67lIhltRny2zHaoBfrDeADEJfFRRFSujaps4Yp7Dy+9s
 iuIr5ODgGHdSx5jcIomUQ/ZarGHNdn4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-__xh28DHM06ACeiGiBfOsw-1; Thu, 30 Jul 2020 15:35:25 -0400
X-MC-Unique: __xh28DHM06ACeiGiBfOsw-1
Received: by mail-wm1-f72.google.com with SMTP id c124so1562863wme.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 12:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=umqcSAY0ovyYX/6slBaErJJ00LVM8u2MgN0tR/LIpvA=;
 b=D2QT6g4gIS/IGNu2aFaOknn04f7esCaGWo8ozUtFke8JZGzIFlubJqbb0NjSe9RsjU
 dLSziPyPtTrclVx+0UVQjgeb+Ys9tPKXWENL2E8sYuO/z2oQyyd3Q8fK2nJ61hjy3YLQ
 7jcDK7OGhTHIFL5V77zroxVzdlN2K5qUH163zTSiszpOeLn7KFEYpjtOtpzsNfQuqfCi
 4iKdH1QmvanoHjywDOxuJ9hvWCcAPltDE+w3aLkhzN5G/+XiFBoamyVgJoYy32F4p04h
 fdfGksQxWbdtm+kYpsfSjaSzRXa+M0E0Ye4ZGbCB9FZTDB9BwTSfAyt/+VPlW9k8S/Vl
 pnGA==
X-Gm-Message-State: AOAM530xfipVgAhWVYT4pFdeArvu//6f6v8lRFxN0ClOsDauN7y+QpGg
 yNhWDvL3fGs8ll6zza+8L5ceW2XmS7hMAS+M1SjlDjBWHT+jGO4hUgmwUVg7/bAma3B7Wpq3gv3
 bDJmWOTr+2AOI4ng=
X-Received: by 2002:a7b:c057:: with SMTP id u23mr583678wmc.167.1596137724449; 
 Thu, 30 Jul 2020 12:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxovEHSvPWzklzkn5zjj0APWmAbcet0a+iv5EUm1znB2HHYX/Omz8b3Ih77/qqloSlz9DqVig==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr583662wmc.167.1596137724196; 
 Thu, 30 Jul 2020 12:35:24 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id a10sm11106762wro.35.2020.07.30.12.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 12:35:23 -0700 (PDT)
Date: Thu, 30 Jul 2020 15:35:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] i386/acpi: fix inconsistent QEMU/OVMF device paths
Message-ID: <20200730153447-mutt-send-email-mst@kernel.org>
References: <20200730155755.188845-1-mst@redhat.com>
 <e1759ee7-b167-d69e-99f9-e824e9e3e0b8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e1759ee7-b167-d69e-99f9-e824e9e3e0b8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 vit9696 <vit9696@protonmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 06:11:17PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/30/20 5:58 PM, Michael S. Tsirkin wrote:
> > macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
> > while OVMF firmware gets them via an internal channel through QEMU.
> > Due to a bug in QEMU ACPI currently UEFI firmware and ACPI have
> > different values, and this makes the underlying operating system
> > unable to report its boot option.
> > 
> > The particular node in question is the primary PciRoot (PCI0 in ACPI),
> > which for some reason gets assigned 1 in ACPI UID and 0 in the
> > DevicePath. This is due to the _UID assigned to it by build_dsdt in
> > hw/i386/acpi-build.c Which does not correspond to the primary PCI
> > identifier given by pcibus_num in hw/pci/pci.c
> > 
> > Reference with the device paths, OVMF startup logs, and ACPI table
> > dumps (SysReport):
> > https://github.com/acidanthera/bugtracker/issues/1050
> > 
> > In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
> > the paragraph,
> > 
> >     Root PCI bridges will use the plug and play ID of PNP0A03, This will
> >     be stored in the ACPI Device Path _HID field, or in the Expanded
> >     ACPI Device Path _CID field to match the ACPI name space. The _UID
> >     in the ACPI Device Path structure must match the _UID in the ACPI
> >     name space.
> > 
> > (See especially the last sentence.)
> > 
> > Considering *extra* root bridges / root buses (with bus number > 0),
> > QEMU's ACPI generator actually does the right thing; since QEMU commit
> > c96d9286a6d7 ("i386/acpi-build: more traditional _UID and _HID for PXB
> > root buses", 2015-06-11).
> > 
> > However, the _UID values for root bridge zero (on both i440fx and q35)
> > have always been "wrong" (from UEFI perspective), going back in QEMU to
> > commit 74523b850189 ("i386: add ACPI table files from seabios",
> > 2013-10-14).
> > 
> > Even in SeaBIOS, these _UID values have always been 1; see commit
> > a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008-03-08) for
> > i440fx, and commit ecbe3fd61511 ("seabios: q35: add dsdt", 2012-12-01)
> > for q35.
> > 
> > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > Tested-by: vit9696 <vit9696@protonmail.com>
> 
> Vitaly uses his full name on EDK2 mailing list, so I don't think he'll
> have a problem to use it in QEMU too:
> Tested-by: Vitaly Cheptsov <vit9696@protonmail.com>
> 
> From:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line
> "Please use your real name to sign a patch (not an alias or acronym)."

Right. Tested-by is different though, I don't think we have
a problem with anonymous testing.

Anyway, updated.

> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/i386/acpi-build.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..7a5a8b3521 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1497,7 +1497,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          dev = aml_device("PCI0");
> >          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> >  
> > @@ -1512,7 +1512,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >          aml_append(dev, build_q35_osc_method());
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> > 


