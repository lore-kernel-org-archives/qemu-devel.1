Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B888C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435D3221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCjafKo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435D3221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIlQ-0000ZA-JJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIkf-00005Z-NS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:05:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIke-0005Wn-6X
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1QOMyOC6nvwzzu4f5q4WHKRShRedbQvsM+rPF9Ms6s=;
 b=iCjafKo8AJk4wO5ySZqxVhvijmy1Q86107JuQDpQ/ZuGZGhl3SsmsVbC9EYcIoz0lG+03m
 YkOX2TzUI8+kHvWqyGQCtA7JWEjW+M2qDlouAWRip+LHV9Bgai/bNjELbo8UOoZg6JptN7
 xosYrEnwAnfMujRUED/i4YrIRMloEY8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-qdIRZR_FMpWpoF3JT1nt6w-1; Tue, 14 Jul 2020 07:05:28 -0400
X-MC-Unique: qdIRZR_FMpWpoF3JT1nt6w-1
Received: by mail-wr1-f72.google.com with SMTP id 89so21168268wrr.15
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f1QOMyOC6nvwzzu4f5q4WHKRShRedbQvsM+rPF9Ms6s=;
 b=F4l9TvwiH/SI5BS6zK2aRDfsmsFbsQOMYiJg8yoD+h7Qo/zbqTBHkP1r1OLxrma+ix
 2IEbaK8IrxVDTOk4lFg1hR5ZCHfLvKNt2xjjB4QfNipzild57g7b4ATmd5VMihIsf+2I
 hinmOhoaybvLzMii7gkNaAXcY2mCZltkldGzlx5hVqZNSpJHB90512PoOIF4gs3d4TKj
 T08fvY991SNDEmjofDnweobsYxEGxUciW/cK7vCvmV3mu80exMj5hi/B6VkHrSpYoG7V
 /j9njX0i4h9FCeffD1iLtoiW4sBLAjK4rARCjhhw0nUpmvAM8zhQGu2qZUn5BudiH6Vj
 98sA==
X-Gm-Message-State: AOAM531bFTAb//qAonz5ieivycoechaKqIqTq1nO8uzv9/1Gfh9NC86c
 FXEsmIfrWjY1dI4mHXVXSq9hqpRzzBaMvrF2I8wtY3cVzaZMUykdhut6Q/I4+tK0pzPkilHaQ1K
 XxJ5JJoXt5Pvp5io=
X-Received: by 2002:adf:ff90:: with SMTP id j16mr4501673wrr.364.1594724726998; 
 Tue, 14 Jul 2020 04:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/skzhn9U1Tr28Gf2exSa2q6FZ6wJq5C2A1jdXo7VqcugIxPS7B+OJKBDnhlt7jjrKwoXtcg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr4501656wrr.364.1594724726823; 
 Tue, 14 Jul 2020 04:05:26 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id r28sm28106359wrr.20.2020.07.14.04.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 04:05:26 -0700 (PDT)
Date: Tue, 14 Jul 2020 07:05:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 for-5.1] acpi-pm-tmr: allow any small-size reads
Message-ID: <20200714070326-mutt-send-email-mst@kernel.org>
References: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Simon John <git@the-jedi.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 01:51:13PM +0300, Michael Tokarev wrote:
> As found in LP#1886318, MacOS Catalina performs 2-byte reads
> on the acpi timer address space while the spec says it should
> be 4-byte. Allow any small reads.
> 
> Reported-By: Simon John <git@the-jedi.co.uk>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


Do we need Simon to test this? Or did you already test
with MacOSX?



> ---
>  hw/acpi/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> v2: fixed bug#, use the right form of S-o-b, and allow up to 1 byte reads.
> 
> I'm applying this to debian qemu package, need the fix
> faster in order to release security updates for other
> branches.
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -530,7 +530,10 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_tmr_ops = {
>      .read = acpi_pm_tmr_read,
>      .write = acpi_pm_tmr_write,
> -    .valid.min_access_size = 4,
> +    .impl.min_access_size = 4,
> +     /* at least MacOS Catalina reads 2 bytes and fails if it doesn't work */
> +     /* allow 1-byte reads too */
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> 2.20.1


