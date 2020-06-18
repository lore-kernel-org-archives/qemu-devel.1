Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EC7208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP1r61v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EC7208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0uR-0007fg-W1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0tX-0007Di-0d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:12:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0tV-0001UV-6H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592511134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7mzCPrxi0qhZSsnwATnLQThTmUXOxqjCZOy8xps5/w=;
 b=cP1r61v3I+GRoTGYbhtQuA0L18E6ZftYLul/AqEWt5VEu7YQnVzuWpFkBLc1/fcnq+0MNl
 fhFHSWaaACQiZC+lQ7NKsOIIUsCVJDZ3q3+WN3hmPZnROng6+rZKGrXyy6B/erjxnPZtsy
 8VmRuORmudODwu6Z088AlcG+boAoJcY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-X5PR9FvgNQWpKajIZmsFDw-1; Thu, 18 Jun 2020 16:12:12 -0400
X-MC-Unique: X5PR9FvgNQWpKajIZmsFDw-1
Received: by mail-wr1-f70.google.com with SMTP id b14so2939951wrp.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8nReIp/L/gbgwGe8czOjHjnqwXghAM4mM9FC2eAftRo=;
 b=YcphcYxM7q5E4orF0X135k27DkPa+LhJCzscDBZr/++raeRk5PriNAJlipjVPcNhDR
 p+yxF6oHKY0YVrz3pf1OumfgAbPPvBbPTeUKdXa/HbJBoYTe/yhYVYwecHcgymAtG41R
 JJapyfyBkT2x10dY+foAG5h8zXEy7hiUPLFMYMSbMzPrDQbvynJlX1dO8CphG+2Xn+IM
 sJ8H+FTSA0iBPxg4rdiHLbvHCmGSX9dg7AsXGp+LDt7K8YHTlp5HNJDDlQ3e5EVvyZJo
 4apcKGn5CXYTVa4ikQFDq/PkdoO//pcbduCk2ucM4Yyjtz/Ll3zR1YLVNN6WRgl0/9Wd
 qlcw==
X-Gm-Message-State: AOAM530KTlGmS0bdivPVujk9NpiGcZsaTlpEuPN75J2S1VXeWV4Tx36p
 4VqfXbY2TwkGsgZS3Q3EwHISB8HnUQFyqX87XluBEJGi4rt9+yy3r5Y0dQoYZu423LBu6TbC8Ny
 qFnx1TDfdJ6fPtXE=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr201608wrq.420.1592511131519;
 Thu, 18 Jun 2020 13:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo9aYmkB7ydsAWi4OgscsHhmBRiPzQUJI71f926KZHQGRJ18x2drTjc75yvXx+MHvKGyA24A==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr201590wrq.420.1592511131269;
 Thu, 18 Jun 2020 13:12:11 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id z12sm5247077wrg.9.2020.06.18.13.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:12:10 -0700 (PDT)
Date: Thu, 18 Jun 2020 16:12:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 5/8] acpi: Enable TPM IRQ
Message-ID: <20200618161045-mutt-send-email-mst@kernel.org>
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
 <6b3b7b49-02e6-9d2d-91ad-65a5ea6d2244@redhat.com>
 <0069a66e-474e-21b9-84ce-36a552cc7b98@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <0069a66e-474e-21b9-84ce-36a552cc7b98@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 07:59:51AM -0400, Stefan Berger wrote:
> On 6/17/20 4:22 AM, Auger Eric wrote:
> > Hi Stefan,
> > 
> > On 6/16/20 10:57 PM, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
> > > Windows. Query for the TPM's irq number and enable the TPM IRQ unless
> > > TPM_IRQ_DISABLED is returned.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   hw/i386/acpi-build.c  | 11 +++++------
> > >   include/hw/acpi/tpm.h |  2 +-
> > >   2 files changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 900f786d08..bb9a7f8497 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >               build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > >               if (TPM_IS_TIS_ISA(tpm)) {
> > > +                int8_t irq = tpm_get_irqnum(tpm);
> > >                   if (misc->tpm_version == TPM_VERSION_2_0) {
> > >                       dev = aml_device("TPM");
> > >                       aml_append(dev, aml_name_decl("_HID",
> > > @@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >                   crs = aml_resource_template();
> > >                   aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> > >                              TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > > -                /*
> > > -                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> > > -                    Rewrite to take IRQ from TPM device model and
> > > -                    fix default IRQ value there to use some unused IRQ
> > > -                 */
> > > -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> > > +
> > > +                if (irq != TPM_IRQ_DISABLED) {
> > Out of curiosity what is the goal to expose the irq num as a property
> > settable by the end-user if only 13 is known to work in all cases. At
> > least shouldn't we warn the end-user in case he attempts to change the
> > default value?
> 
> For Windows only IRQ 13 works (and I am not sure whether this has always
> been like this), Linux accepts several other ones. As for exposing it to the
> end-user, I may have taken this from soundblaster (sb16.c), which also
> exposes it. If someone plays around with the irq numbers I would say they
> must have some more Pc knowledge than  just trying random numbers.
> 
> 
>    Stefan

So is this useful to anyone? If no I'd say drop it.
I'm guessing sb16 has it since it is useful for running extremely old OSes which might
have weird quirks for a specific hardware.


