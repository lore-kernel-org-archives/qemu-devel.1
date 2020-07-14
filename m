Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BBC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEED21897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKqpfL5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEED21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGV0-0000cK-Ge
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGTr-0007WX-Pv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGTp-0002Yj-PP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594716000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kd4iuf4IjSbHo0EgXv7qhcEtyWLyr+ddAYdcYHg+010=;
 b=LKqpfL5ah5a2BdXFCyOnNw1OuPzzIpAfcDP3Fe3H9bWDCXc+ooojWLm3Ad/H0UTn9ipHmJ
 XAXk8U819o3K+WOtMe22I3F0b1cIlNXMhUOGOBNVwSzxdlAZSl7BxkKoNxDLoUmUlLdpsr
 e74GIb53Mv9p7MKbxLhnEXyWfcH96dI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240--Y9RVrDFOiGJJVPmBSIVQg-1; Tue, 14 Jul 2020 04:39:58 -0400
X-MC-Unique: -Y9RVrDFOiGJJVPmBSIVQg-1
Received: by mail-wr1-f71.google.com with SMTP id c6so20720478wru.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 01:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kd4iuf4IjSbHo0EgXv7qhcEtyWLyr+ddAYdcYHg+010=;
 b=gq9ewePiICXYcOqCsCBYdpn9/t2YioVe/u6ik7NDT0YdH9IgSLa61sMqvyKfNZVap/
 QBKngx9+jNyD4r85tMBcXbi+APnSbGd4qw9PU9HA2JNmH4+sDS3dER4fg544+S12xKNX
 QT//HcYrbk1O+FXQbhQ/vFERkDFO30lactAJ8XbwiFJF/R+2owGbnVbGNlw1X5iP8O+m
 knNp5jFmhx2Hl15xyzYldZ+Fhg50BlXT+w+u+q6/QAqaJUt/mSxlfg7qZXy5GUz5wp1X
 Vn3AnvXbkkAJHqxgtMIdQANC7kTeOzgNzGwkebtSxluZpmpFtuJpGU/kmuxZRb0GQsX/
 pW+g==
X-Gm-Message-State: AOAM530QT69udDyV6kcmjyYZkmR7HQWasEslmmXxto5Nlb/wuY27KNGW
 lBIPo95R4miU+XHP8cRDAWQjrQVmsfWyBr7ny6r6bc/PhJftAmgjvWmXjCywPUpTvMMEZe/XlBs
 phRXLvwf1+TJJoaQ=
X-Received: by 2002:a5d:688d:: with SMTP id h13mr3737301wru.303.1594715997740; 
 Tue, 14 Jul 2020 01:39:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVeZzXD+xUni72PzBOxZPWt0vI4N8JB8h2ezYSQran3b53GtUd0czoU6JXjFz5r95U60pPHA==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr3737288wru.303.1594715997532; 
 Tue, 14 Jul 2020 01:39:57 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id r28sm27457519wrr.20.2020.07.14.01.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 01:39:56 -0700 (PDT)
Date: Tue, 14 Jul 2020 04:39:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH 4/5] hw/i386/acpi-build: Turn off support of PCIe
 native hot-plug and SHPC in _OSC
Message-ID: <20200714040118-mutt-send-email-mst@kernel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-5-jusual@redhat.com>
 <20200713165654.1f78af8f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200713165654.1f78af8f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 04:56:54PM +0200, Igor Mammedov wrote:
> On Thu,  9 Jul 2020 00:46:14 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > Other methods may be used if the system is capable of this and the _OSC bit
> > is set. Disable them explicitly to force ACPI PCI hot-plug use. The older
> > versions will still use PCIe native.

Do we need that later part btw?

> > 
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/i386/acpi-build.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 5c5ad88ad6..0e2891c3ea 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1599,6 +1599,7 @@ static Aml *build_q35_osc_method(AcpiPmInfo *pm)
> >      Aml *method;
> >      Aml *a_cwd1 = aml_name("CDW1");
> >      Aml *a_ctrl = aml_local(0);
> > +    unsigned osc_ctrl;
> >  
> >      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> >      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> > @@ -1612,9 +1613,12 @@ static Aml *build_q35_osc_method(AcpiPmInfo *pm)
> >  
> >      /*
> >       * Always allow native PME, AER (no dependencies)
> > -     * Allow SHPC (PCI bridges can have SHPC controller)
> > +     * Need to disable native and SHPC hot-plug to use acpihp
> > +     *
> > +     * PCI Firmware Specification, Revision 3.2

I don't think you have to add a reference as part of this patchset.
The spec in question documents _OSC so it's not a bad idea to
add it, but it's a bit more work, e.g. we generally try to list
the earliest spec that documents the given feature, since
So I suspect this is 3.0 actually.


> seems incomplete, were you going to point to a concrete chapter that requires this change?


It doesn't as such. A better description would be:

/ * Guests seem to generally prefer native hotplug control. As we want them to
  * use ACPI, don't enable it.
  */



> >       */
> > -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> > +    osc_ctrl = pm->pcihp_bridge_en ? 0x1C : 0x1F;
> Since you are touching this, how about converting this magic number to
> something more readable?
> i.e.
>             set_bit(ACPI_OSC_SHPC_EN,  osc_ctrl)
>           or
>             osc_ctrl |= BIT(SOME_FEATURE)
> 

... if there is such a macro. If not I suspect it's better as a comment:

	0x10 /* PCI Express Capability Structure control */ |
	0x80 /* PCI Express Advanced Error Reporting control */ |
	0x40 /* PCI Express Native Power Management Events control */



> > +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));
> >  
> >      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> >      /* Unknown revision */
> > @@ -1696,7 +1700,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> >          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > -        aml_append(dev, build_q35_osc_method());
> > +        aml_append(dev, build_q35_osc_method(pm));
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> >  
> > @@ -1771,7 +1775,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >              if (pci_bus_is_express(bus)) {
> >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> >                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> > -                aml_append(dev, build_q35_osc_method());
> > +                aml_append(dev, build_q35_osc_method(pm));
> >              } else {
> >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> >              }


