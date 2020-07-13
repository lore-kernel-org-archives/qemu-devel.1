Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC99C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E26206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhG1SatG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E26206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxPh-0001Ij-ED
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juxP7-0000qL-AY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:17:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juxP5-0007IE-EU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594642670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPVtQmhx84k+s64EJGz4xvGNIb0Q5rOXRC5JGX7VKZI=;
 b=HhG1SatGR+RTYERhimuSSHXcHE38JTR6MpxXXH9VVEc7FTWHfS0brS+HWXbQLNVO3eqjix
 dJEXYAWnz7ivgE0Mjg4lXM0VA2rRIhpryxjR8Q+4A6HxVnGmm6Tq9FPz3GoWN0bKkOT5ad
 1wLf6t2NpIcCE1DkiCpamgK0pCiNUKk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-LehO3VfqPiaIYlZS668nvQ-1; Mon, 13 Jul 2020 08:17:46 -0400
X-MC-Unique: LehO3VfqPiaIYlZS668nvQ-1
Received: by mail-wr1-f72.google.com with SMTP id d11so17562713wrw.12
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ClaxM6wYSsPEgIDV2e2xtdvy0dyBlAGBJaPReTUt7LA=;
 b=JADvwc36zkI7MWM7gmuNeK0+OKjVsxFIkbO+cuBnSxNlsIf8qNpI8yNhA+fvUGi1Gu
 pL7Dccl7h+eOQT5rBD6wsdMWZmH0QY+taDCMrrnCgc/3n5dGE0xZ4pVnnO40eZrYa/y0
 DesiTI1ichki3mXqwN+7lX5097FhBYorR5HyIstGGUMzXXJF1Tds6Gzv7LlB89DxsJ99
 Zx2bU22e8HSn746KY4V8SjW95fbBLyYVtCygnTK+Ilzk95/zZoBx46f8tGlVYw4eMxpm
 Llw6JcWoesbOWiMwYY/0OGI/zljfedNnHLJ184dNbCIZ7ES/n7VPOk97bDn8b+yVHdVl
 M3mA==
X-Gm-Message-State: AOAM533Eo7ptjT8dzTlW+JxTjittwGdrNNUJJj9ewEG2h3lFPX43B2Ep
 kruw1LwNlx1RHFjTZ6q9DyUO4099Gh48uRHPcdm2GcclBfadWx123yaZ3iQUNcgJfybLHe3c5QB
 ZOixAMjZruwNN/g0=
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr17844570wmf.1.1594642665607; 
 Mon, 13 Jul 2020 05:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC9aRxwpsl9NYAYiF8YrZqBxcIQ1BcOLttIhWiFapajmP797YPSjOSNM17EUBOxw6gJO6cPg==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr17844544wmf.1.1594642665356; 
 Mon, 13 Jul 2020 05:17:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id u10sm21482037wml.29.2020.07.13.05.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 05:17:44 -0700 (PDT)
Date: Mon, 13 Jul 2020 08:17:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon John <git@the-jedi.co.uk>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200713081627-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
 <7662bc2c-d958-731a-0882-62c5ab47c7a4@the-jedi.co.uk>
MIME-Version: 1.0
In-Reply-To: <7662bc2c-d958-731a-0882-62c5ab47c7a4@the-jedi.co.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: imammedo@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 12:46:00PM +0100, Simon John wrote:
> I don't profess to understand most of this, I am just a user who found
> something didn't work and tracked down the cause with help from the people
> on the bugtracker.
> 
> the min=1 and max=4 was chosen as it seems to be set that way in most other
> places in the source, and 2 fits in that range.
> 
> so as macos seems to require 2 bytes but spec says 4 (32 bits) would it be
> better to set min=2 max=4, given that the original revert seems to be a
> security fix?
> 
> this works equally well:
> 
> static const MemoryRegionOps acpi_pm_tmr_ops = {
>     .read = acpi_pm_tmr_read,
>     .write = acpi_pm_tmr_write,
>     .valid.min_access_size = 2,
>     .valid.max_access_size = 4,
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
> 
> regards.
> 

Sounds good. And how about also adding:

      .impl.min_access_size = 4,

?

> 
> On 13/07/2020 12:14, Michael S. Tsirkin wrote:
> > On Mon, Jul 13, 2020 at 10:20:12AM +0300, Michael Tokarev wrote:
> > > 12.07.2020 15:00, Simon John wrote:
> > > > macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> > > > 
> > > > acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
> > > > 
> > > > Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> > > > Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
> > > 
> > > Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
> > > Author: Gerd Hoffmann <kraxel@redhat.com>
> > > Date:   Thu Nov 22 12:12:30 2012 +0100
> > > Subject: apci: switch timer to memory api
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > 
> > > because this is the commit which put min_access_size = 4 in there
> > > (5d971f9e672507210e7 is just a messenger, actual error were here
> > > earlier but it went unnoticed).
> > > 
> > > While min_access_size=4 was most likely an error, I wonder why
> > > we use 1 now, while the subject says it needs 2? What real min
> > > size is here for ACPI PM timer?
> > > 
> > > /mjt
> > 
> > 
> > Well the ACPI spec 1.0b says
> > 
> > 4.7.3.3 Power Management Timer (PM_TMR)
> > 
> > ...
> > 
> > This register is accessed as 32 bits.
> > 
> > and this text is still there in 6.2.
> > 
> > 
> > So it's probably worth it to cite this in the commit log
> > and explain it's a spec violation.
> > I think it's better to be restrictive and only allow the
> > minimal variation from spec - in this case I guess this means 2 byte
> > reads.
> > 
> > In any case pls do include an explanation for why you picked
> > one over the other.
> > 
> > > 
> > > > Signed-off-by: Simon John <git@the-jedi.co.uk>
> > > > ---
> > > > Â hw/acpi/core.c | 2 +-
> > > > Â 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > > index f6d9ec4f13..05ff29b9d7 100644
> > > > --- a/hw/acpi/core.c
> > > > +++ b/hw/acpi/core.c
> > > > @@ -527,7 +527,7 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
> > > > Â static const MemoryRegionOps acpi_pm_tmr_ops = {
> > > > Â Â Â Â  .read = acpi_pm_tmr_read,
> > > > Â Â Â Â  .write = acpi_pm_tmr_write,
> > > > -Â Â Â  .valid.min_access_size = 4,
> > > > +Â Â Â  .valid.min_access_size = 1,
> > > > Â Â Â Â  .valid.max_access_size = 4,
> > > > Â Â Â Â  .endianness = DEVICE_LITTLE_ENDIAN,
> > > > Â };
> > 
> 
> 
> -- 
> Simon John


