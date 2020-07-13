Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F251A20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUDe+XPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F251A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwGH-0003IP-7m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juwDt-0000jA-SH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:02:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1juwDr-00053l-R9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594638130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRF8uZm4rnD0AkZpdkMnnDf26Vaep2LDxP4/uTxLlRw=;
 b=dUDe+XPuN6oLbijKlZPHzokVu6uuorYx6LGXDTaGipSBdzIRhPK50loeyxVbDIZvUVlauf
 a6nm1qJ0UPWMg6w0j5eSR+8tJ5LE3SvayXo8S7a6XyBtPBvcxr3XvBITrgCFRTviV6Bc8S
 FNyaYMcXYWb6pgaq+GHtvGD3hYdVL24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-tZpQ-BzjPKCpXpilbHkSjw-1; Mon, 13 Jul 2020 07:02:02 -0400
X-MC-Unique: tZpQ-BzjPKCpXpilbHkSjw-1
Received: by mail-wm1-f70.google.com with SMTP id 65so18311087wmd.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 04:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fRF8uZm4rnD0AkZpdkMnnDf26Vaep2LDxP4/uTxLlRw=;
 b=P+YhOAYZk7WhxdyBB04Rf0VLqbHT8E+8jgkHaAg+VB2A0jejlaOfuSZv4zCfn4N+oE
 MOtAAax121tkF7HRiNEowQtIo2+WZnT0KEh3qdFbf+prf9KhhPNzTPTf9zgMoepRJIth
 knHtwiAJapcyrxBSuxHusj8Q4RrFMtUhPuUcU0513Y8UEdp7NCUHzhZAtkCBiqXPifeh
 2kNnrnFxQ6cCD7ypDN4ya60E7YWhMVq+U1wleogUBBwBU96kui5Grm39BZ/5GZUTTKtc
 aWWHVO3lw7TfvQIN7Z1P5uMH7/cVRRj34wzR/IaqGoyCoof0Cb5kHWUxXR6KGdlfif+B
 4QsQ==
X-Gm-Message-State: AOAM533bgUKKheiiXY2JWDBFnxwoas2qRoHzhvi6w6VMGs0VHYvkUlWr
 yMEx0cTiNv+jgVasr0ylwCwPDdz2nTncOEk1WgEFgwJ/Plepl7JOaljkY93zR7YHjn/kf3rFV7p
 NirN9lP5emDxmbWc=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr52972666wra.150.1594638121626; 
 Mon, 13 Jul 2020 04:02:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7gbXXJkTRPARQXe+EchFs+oZM71HNgqGxcQiO0uYXIA3eHn3bl4ZSSlkSUbO8ZckwIRGqHQ==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr52972645wra.150.1594638121416; 
 Mon, 13 Jul 2020 04:02:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id 78sm15826868wma.31.2020.07.13.04.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 04:02:00 -0700 (PDT)
Date: Mon, 13 Jul 2020 07:01:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200713070038-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <33bd2c28-8671-a552-61b2-08f5cd1c082d@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <33bd2c28-8671-a552-61b2-08f5cd1c082d@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

On Mon, Jul 13, 2020 at 10:43:19AM +0300, Michael Tokarev wrote:
> 13.07.2020 10:20, Michael Tokarev пишет:
> > 12.07.2020 15:00, Simon John wrote:
> >> macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> >>
> >> acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
> >>
> >> Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> >> Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
> > 
> > Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
> > Author: Gerd Hoffmann <kraxel@redhat.com>
> > Date:   Thu Nov 22 12:12:30 2012 +0100
> > Subject: apci: switch timer to memory api
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > because this is the commit which put min_access_size = 4 in there
> > (5d971f9e672507210e7 is just a messenger, actual error were here
> > earlier but it went unnoticed).
> > 
> > While min_access_size=4 was most likely an error, I wonder why
> > we use 1 now, while the subject says it needs 2? What real min
> > size is here for ACPI PM timer?
> 
> Actually it is more twisted than that. We can't just change the size,
> we must update the corresponding code too.
> 
> 
> static uint64_t acpi_pm_tmr_read(void *opaque, hwaddr addr, unsigned width)
> {
>     return acpi_pm_tmr_get(opaque);
> }
> 
> note the actual read function does not even know neither the requested
> address nor the requested width, it assumes the min/max constraints
> are enforced and the read goes to all 4 bytes. If this pm timer can
> be read byte-by-byte, we should return the right byte of the value,
> not always the whole value.
> 
> /mjt


I think that specifying .impl.min_access_size is a way to do that easily
without major code changes.

-- 
MST


