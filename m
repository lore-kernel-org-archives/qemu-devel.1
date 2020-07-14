Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885BA2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISr/eqEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885BA2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHGj-0008Ij-SW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHFu-0007YC-Iz
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:29:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHFs-0000io-O1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594718979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGpOACpsO5PLTNiwYMGgeO+lwdDjYKSnWF5KlZbRky8=;
 b=ISr/eqEBA8SyNTuUPdXVsW9aEbBDuGsPQjrOUW3u2pwu1gNLKwMWpThv5xFxE9t713Ed4l
 0gW2BWBY7Q/zG7sUIWnrPQWvUAYv3jrHqGM3+5Mm7xpQc60JIuHyhNTYKRxILpbFWZwbyK
 QhkPyfRXgL0+TZbZlddmIouI+WpChkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-2XiHyH4cNAu7T25WM4bWEg-1; Tue, 14 Jul 2020 05:29:36 -0400
X-MC-Unique: 2XiHyH4cNAu7T25WM4bWEg-1
Received: by mail-wm1-f70.google.com with SMTP id t18so3048044wmj.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=73BpJpKOrRYkd7U50kdJ32miKHDKk0fb0NT30VcSyOU=;
 b=espTZC2kBPYUI0ayPEzrFMct0VvvL+OVAmOd+8Uc5HIVRwbbiYgJMu1D1Hxzo4/2ic
 2S7HF7oBlrgG2GjKRmya3icQ96eQodOiwo82RUXaNrrM5CFQtxWK7/A7PTua/ZFYs4AE
 N6iE8/R3Wn+IEDSC8GmwA/ApaPs+fn4fuiJ+le9+vaLH1rOoJWdY5v86hlRdlLEzY39z
 JXkWTIGLoziPTAjAxW5yrNpSwwz7s2ye6637QrOJTqu0OqI3pIyTf4oygswuaRpcrxJR
 ZDCbdOq+gk3eHxe7HUWshvpXnk1ITR3XiAe57g0mWM2vb8fSM7+gZhEycO5RCBURuxt0
 kGUg==
X-Gm-Message-State: AOAM531xFa+IShSNzEsmP6V5BdcGbNThkQJi3hHYdiL8Q8HmLBuspyM3
 Mg8oqlR7cWjjwqzT1Y7zleE/AXEjodXCUQ2s9+GYFbFlX9mmad2H1qoVY53jYWu1YUr5oIjr5JR
 Apgko0f/mjQQNRf4=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr4011440wrs.365.1594718974879; 
 Tue, 14 Jul 2020 02:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzhQyYmmFdfjemZhE29TQvWvs04I65Pa5MihNnr/4AArb3JEDEAdFoSFbQnanjoDYzY4RBYw==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr4011421wrs.365.1594718974665; 
 Tue, 14 Jul 2020 02:29:34 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id b62sm3444186wmh.38.2020.07.14.02.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:29:33 -0700 (PDT)
Date: Tue, 14 Jul 2020 05:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200714052807-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

And looking at that:

-    case 0x08:
-        val = acpi_pm_tmr_get(&s->ar);
-        break;
     default:
         val = 0;
         break;

So what was going on is reads from 0x10 would just give you 0.
It looks like Mac OSX does not care much about the value it gets,
as long as it does not crash :).



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


