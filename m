Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED3C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5DB20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP+kSRw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5DB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxmF6-0001to-1n
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxmEM-0001VA-Vq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:58:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxmEK-0008RJ-7i
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595314702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xaBu+S49jBgdFm0ASLjFmwp1MClrH5h2BZbHQx1LR6I=;
 b=WP+kSRw8v2ZGCtM+possqLR6YeoqT4noVqqXEZ3U5+cWdSdNMgu9vsrwmdwRLRlvlaa1fe
 X1KSJjmE9lnOt7I+xb2/W80tFZ10YacBRJTeHMjyZ1CYQdyJkTRw9KWRs1raAGZPPaH0Id
 FCEEckeOaFfeomEnM9P7mML5vu2vtlw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-98ExJ_SrNEaQ9XKpujaRKg-1; Tue, 21 Jul 2020 02:58:17 -0400
X-MC-Unique: 98ExJ_SrNEaQ9XKpujaRKg-1
Received: by mail-wr1-f70.google.com with SMTP id i10so12713827wrn.21
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 23:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xaBu+S49jBgdFm0ASLjFmwp1MClrH5h2BZbHQx1LR6I=;
 b=TKPzInNMthGAcd39VwdCFOJWmtWh0c4gvpDtbUqtulPCuYf9zNDzg9E72OsmyDzHft
 0qejOOPNvHhFtT4km0Qw1edWQFw8ubZ+hCTaw/aX2n3En93iH0jx9r3XC/Ulf3Uv60Xz
 6tAN+xnLsrcE7aNpCZ2IVDxswiVAhBiXDZ1qm7feEOumvSi3qPzhz3xQQpUFgIXdJ5yx
 n0MWC+VJon19LpZ8uMNxmeG6If38AIEhxjpTc3xJoPDB0g6qqkkz7sxQn7jI5FfDRlj7
 5PpI3KMlFG0nj0eCyEkd8BBs9cDGi5RA+eeIhLAfRT9ocIja2lKJmYSPKVC2KHRHoqXT
 sHgQ==
X-Gm-Message-State: AOAM532sMqetasLhRDTnmISi2iqxiuY9wtV40PVCenyv1LmFxvv/MpVe
 XFMCA++ss5RhvKxLWlaoNjbS7qt01F7LEVaDYVtCbNa4UKfXSVpVG/GOI9L/hm8nregRAbY82MP
 lm3oo7Y9AFE6pfZ8=
X-Received: by 2002:adf:f984:: with SMTP id f4mr24874296wrr.221.1595314695808; 
 Mon, 20 Jul 2020 23:58:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi4BfXafYXvq2yH8TLAZANF07s8caXGL5LMivPW5GjuuQB/8lr0voddu4vY/bXDDRQ4g/WvQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr24874273wrr.221.1595314695506; 
 Mon, 20 Jul 2020 23:58:15 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id q3sm2127067wmq.22.2020.07.20.23.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 23:58:14 -0700 (PDT)
Date: Tue, 21 Jul 2020 02:58:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: OVMF and PCI0 UID
Message-ID: <20200721025745-mutt-send-email-mst@kernel.org>
References: <56E4DCD4-DBA1-4A41-8568-1CBBB37ED320@protonmail.com>
 <829eba8a-d9a7-a335-6b85-91e64462e64b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <829eba8a-d9a7-a335-6b85-91e64462e64b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
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
Cc: Igor Mammedov <imammedo@redhat.com>, mhaeuser@posteo.de,
 vit9696 <vit9696@protonmail.com>, qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 11:25:58PM +0200, Laszlo Ersek wrote:
> Hi Vitaly,
> 
> adding Igor, Michael, Marcel, and qemu-devel.
> 
> On 07/20/20 11:06, vit9696 wrote:
> > Hello,
> >
> > I discovered an issue with inconsistent QEMU/OVMF device paths, and
> > while I am unsure whether directing this e-mail is appropriate to you,
> > I believe that you likely have the contacts you could forward this
> > e-mail to.
> >
> > macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
> > while OVMF firmware gets them via an internal channel through QEMU.
> > Due to a bug in QEMU (or OVMF) currently UEFI firmware and ACPI have
> > different values, and this makes the underlying operating system
> > unable to report its boot option.
> >
> > The particular node in question is the primary PciRoot (PCI0 in ACPI),
> > which for some reason gets assigned 1 in ACPI UID and 0 in the
> > DevicePath. To me this looks like a bug here:
> > https://github.com/qemu/qemu/blob/8f06f22/hw/i386/acpi-build.c#L1511-L1515
> > Which does not correspond to the primary PCI identifier here:
> > https://github.com/qemu/qemu/blob/5a79d10/hw/pci/pci.c#L160-L162
> >
> > Reference with the device paths, OVMF startup logs, and ACPI table
> > dumps (SysReport):
> > https://github.com/acidanthera/bugtracker/issues/1050
> >
> > Would you be able to forward this to the right people or perhaps keep
> > an eye on the issue itself?
> 
> I think you are right.
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
> Does the following patch work for you? (I can see you proposed the same
> in
> <https://github.com/acidanthera/bugtracker/issues/1050#issuecomment-660734139>)
> 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a35..7a5a8b3521b0 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1496,9 +1496,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          sb_scope = aml_scope("_SB");
> >          dev = aml_device("PCI0");
> >          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> >
> >          build_hpet_aml(dsdt);
> > @@ -1511,9 +1511,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          dev = aml_device("PCI0");
> >          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >          aml_append(dev, build_q35_osc_method());
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> 
> If it does, I suggest submitting the above patch to qemu-devel, and/or
> filing a bug for upstream QEMU at <https://bugs.launchpad.net/qemu/>.

Or even just reporting whether the above helps you, we can
take it from there.

> (Note: I didn't even compile the above change.)
> 
> Thanks
> Laszlo


