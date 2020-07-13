Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59CE206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSWc3FlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59CE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwQO-0007sn-6k
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juwPj-0007Sx-VW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:14:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juwPh-00070t-7h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594638863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yJxjN2eK2C/RtbAhcih8fYRhZsxSSIJoRDR+ygJPZ0=;
 b=NSWc3FlGhOCZWOP+VRgBD7CnaAO7913+r6qXgLfoaq+0GveRGDeF0TzfDLOvI9IJmCKj7h
 f3j4ihXPW1UrQlr92kXI4urFxtWzLLLNfZeY3Vb/p/xCFLfaKjZlN6OQ2qDK3a0Zm65c16
 c4HN5A3zLAhVkiWICZomaCvJvjqe7kw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-3Y341XyLNpGUJwd3ZcNP8w-1; Mon, 13 Jul 2020 07:14:19 -0400
X-MC-Unique: 3Y341XyLNpGUJwd3ZcNP8w-1
Received: by mail-wr1-f72.google.com with SMTP id s16so17393131wrv.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NpTWVJsF5mPjoZtLMQOdwBipVAebIZ+sY13ywG6j7qo=;
 b=MzP5oQczP3OcjqVbSTv1ridQTV1Yf/uZjNB1AA18bokS4JMR7zPYQWrxwWsyUtMMZZ
 sMLjQZDaXe9T+bEUucUlJDW7udY6U5xbvrM8DG2NO7QW/r/pdh9apIecvC5Mc+C1kJm9
 V8AQIs5ROegEj3EIYo2G6S+rCrdmQpwciR2VTpXpUNRScpnC0fVqdBpIE7eVjW9TmoWV
 AXkbU11kBoTh/+MZ75Ce2aSVQqkyj/YCH14XXq0l/Oqbz6CaVL59Z3KDg2nt4AfxMP2Y
 XJoeMpb9xogNNIVUrxQvkxg4zW8MKqdGrANFK/TFYnXO8edpa1ZNhr5rOZyUO2jpIELN
 CUMg==
X-Gm-Message-State: AOAM5334TFrlPqJrJY9jHu+Tn943gIqbMXVm94hSAzEf++WnWAkv4arQ
 jBvf62zBnHMahhYd18ZdOwa5m/mpM3OYzI4gO7yizAwj7pIIzq0QbBkt9J9QnvcT6AHe4Y/GLi/
 PPx+99PqVGJIawRw=
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr75810962wrr.23.1594638858096; 
 Mon, 13 Jul 2020 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziHGKYA1ttybZawIhwKv+312YiNjlLRoLmelUapdedOMMaSKiSnCJcZruRvIVUi63dj4EFuw==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr75810946wrr.23.1594638857829; 
 Mon, 13 Jul 2020 04:14:17 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id d201sm21441221wmd.34.2020.07.13.04.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 04:14:17 -0700 (PDT)
Date: Mon, 13 Jul 2020 07:14:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200713070946-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: imammedo@redhat.com, Simon John <github@the-jedi.co.uk>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 10:20:12AM +0300, Michael Tokarev wrote:
> 12.07.2020 15:00, Simon John wrote:
> > macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> > 
> > acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
> > 
> > Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
> 
> Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Thu Nov 22 12:12:30 2012 +0100
> Subject: apci: switch timer to memory api
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> because this is the commit which put min_access_size = 4 in there
> (5d971f9e672507210e7 is just a messenger, actual error were here
> earlier but it went unnoticed).
> 
> While min_access_size=4 was most likely an error, I wonder why
> we use 1 now, while the subject says it needs 2? What real min
> size is here for ACPI PM timer?
> 
> /mjt


Well the ACPI spec 1.0b says

4.7.3.3 Power Management Timer (PM_TMR)

...

This register is accessed as 32 bits.

and this text is still there in 6.2.


So it's probably worth it to cite this in the commit log
and explain it's a spec violation.
I think it's better to be restrictive and only allow the
minimal variation from spec - in this case I guess this means 2 byte
reads.

In any case pls do include an explanation for why you picked
one over the other.

> 
> > Signed-off-by: Simon John <git@the-jedi.co.uk>
> > ---
> >  hw/acpi/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > index f6d9ec4f13..05ff29b9d7 100644
> > --- a/hw/acpi/core.c
> > +++ b/hw/acpi/core.c
> > @@ -527,7 +527,7 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
> >  static const MemoryRegionOps acpi_pm_tmr_ops = {
> >      .read = acpi_pm_tmr_read,
> >      .write = acpi_pm_tmr_write,
> > -    .valid.min_access_size = 4,
> > +    .valid.min_access_size = 1,
> >      .valid.max_access_size = 4,
> >      .endianness = DEVICE_LITTLE_ENDIAN,
> >  };


