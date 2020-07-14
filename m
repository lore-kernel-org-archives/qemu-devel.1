Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E982CC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3B6217D8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmfTigDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B6217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHpv-0001Qw-Vs
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHpO-00010d-0x
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:06:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHpL-00061A-8u
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594721178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nwp3CHjiPsabev5UzB4dLZ6VFjUeZaaYLUBNzy6Z5g=;
 b=SmfTigDXgjH5RM1T78lcTGbUOQ2zMs2BRXF4ilaeOJ1tWg4xHKJOLUc67PpQ10TScdVPVG
 6KlyGZH45dx1Y94CfkCccaRy9+4lWjLeJC5kQzR5qHlWrqGecPFd8BTVrIvHT3r127/pTe
 UvT14spqfQpDVyVqWsZBqyGJyxPAib8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-cgu4bmCyOW2yX076MqTg8g-1; Tue, 14 Jul 2020 06:06:16 -0400
X-MC-Unique: cgu4bmCyOW2yX076MqTg8g-1
Received: by mail-wm1-f69.google.com with SMTP id u68so3181720wmu.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5nwp3CHjiPsabev5UzB4dLZ6VFjUeZaaYLUBNzy6Z5g=;
 b=ofnIWmvgfF6FwtSvsqcWBRJ1yq1f35H3sR9GWqboDEzj5Fr9rdOCo4HWAyR1bnpA9O
 k40bOSaB55fNl9s2Fr6e37orfcze8V2RX13ERFnMJWxHzlrs52vxEWoKN7LoYLOCkWho
 Bj+iOJdk5xuwEOHSDqV5nxt81Nje6Gh/7XjH6/I7SYyjpTon3QkfrypBgJmOkYjNpxZd
 LxP6xyO5AmVEphuf6LGbYOC1kRS3ZbGZnmrn+3KoRZFF1T6nog/U3W8wKTwXQCoorihv
 ClTvr6GDYwkncX/+HLTpSW/P/MZq3JUsIUxprhI6Npcw0uLzWPv7k4cDuyuU9gcqV4Ho
 /l7Q==
X-Gm-Message-State: AOAM5311xQoGCeCvsaPzYu++zqT3HibAxbO5c8ZmvGndFH0knstPLTt2
 E9unmx99i9BkOBb65OTe5OS+n1y09SrpUb+cpGwF5rUV5HvcxshPU56v7v223skBqZV+3tmlWs8
 hP3Xu1MGc7c4vvPI=
X-Received: by 2002:a7b:c746:: with SMTP id w6mr3612536wmk.171.1594721175135; 
 Tue, 14 Jul 2020 03:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSLb4CTQn63+qM2ojEflnxDlUtMx3kqo6FxawOZPJGLVX3XSshuzb3lsM4whj0yJEnin4P6w==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr3612505wmk.171.1594721174771; 
 Tue, 14 Jul 2020 03:06:14 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id w12sm30172400wrm.79.2020.07.14.03.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 03:06:13 -0700 (PDT)
Date: Tue, 14 Jul 2020 06:06:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH for-5.1] acpi-pm-tmr: allow 2-byte reads
Message-ID: <20200714055749-mutt-send-email-mst@kernel.org>
References: <20200714095518.16241-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <20200714095518.16241-1-mjt@msgid.tls.msk.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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
Cc: Simon John <git@the-jedi.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 12:55:18PM +0300, Michael Tokarev wrote:
> As found in LP#964247, MacOS Catalina performs 2-byte reads
> on the acpi timer address space while the spec says it should
> be 4-byte. Allow 2-byte reads.
> 
> Reported-By: Simon John <git@the-jedi.co.uk>
> Signed-Off-By: Michael Tokarev <mjt@tls.msk.ru>

After some thought, I think I'll do a 1-byte one the way
Simon proposed. Just go back to behave the way it did.
Will apply yours on top - Simon - could you try and send a
tested-by tag please?


> ---
>  hw/acpi/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> I'm applying this to debian qemu package, need the fix
> faster in order to release security updates for other
> branches.
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 45cbed49ab..9be38aa2ac 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -530,7 +530,9 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_tmr_ops = {
>      .read = acpi_pm_tmr_read,
>      .write = acpi_pm_tmr_write,
> -    .valid.min_access_size = 4,
> +    .impl.min_access_size = 4,
> +     /* at least MacOS Catalina reads 2 bytes and fails if it doesn't work */
> +    .valid.min_access_size = 2,
>      .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> 2.20.1


