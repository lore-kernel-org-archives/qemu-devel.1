Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56206C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D446320672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNtM96uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D446320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFzs-0004nK-Rn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqFzF-00049F-K4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:07:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqFzD-0001VX-W1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593522462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0f6V9xQGN8eu8iczLMQGi83G3SFTPuv4hNZNh6TtEbg=;
 b=GNtM96uO0BwatI+TJaRTmg7M7CYGwbggC1QE52frusRvbu76w+6iBwxEEP1GlkFTCAjVW9
 SJ8kfoJbEpNJkutEGuZhaTffycPhyisie978x96CEMUaWPq307ZaelDFtQKjpqA75+d1wU
 T+9w/NUHOytws9wlespfYSHMt9cpLco=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-OlWFI9xUPEuKAnZGSGcTMQ-1; Tue, 30 Jun 2020 09:07:40 -0400
X-MC-Unique: OlWFI9xUPEuKAnZGSGcTMQ-1
Received: by mail-wr1-f72.google.com with SMTP id o25so18654623wro.16
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 06:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0f6V9xQGN8eu8iczLMQGi83G3SFTPuv4hNZNh6TtEbg=;
 b=geRkElM2QeGLG0EFioHBVC1cRD5ge//UaE2QaCOthitOD0OcwBBIf8aOg/vGXPPxSC
 Mal2TiHF5g3mn28byBC41xiXkQpAkv+sTU/96l65g0yYjXWiZrw5NxNYB1/IPt11WAqF
 VlpD5jWPDTDYfJPLM1pxeKdg/5CiT3Snd8cpxqlxfickyK5GQvYpfxUlLyZe+XnU/2TQ
 KYmtUuc+XKnkdMm/LvOr4pvmja/v0RYjm8elbMFAFVwuO6/w9L+D/ASPf+jbUAZKYJGs
 3SZOfd/agR5K8VSMIwt+1u7ZOE3c5z4edXJ3UXWo4JgMZC+Wn+VP6guzK5jCYI2Rk9tL
 NmYQ==
X-Gm-Message-State: AOAM531Do98EwwsaZNZr/ZtY4OuLcQXg6dXG3wuR/Ov2ZU1v2iQhqMux
 wkgnD6nJKGrYIDLMrrz7f/dOS/0yJbtbSynUUWnYtPb1a3rL8BjDUxD0ZrJ6RCI1QOx6xkabFLD
 cNVuzPceeGH2mQxI=
X-Received: by 2002:adf:ff90:: with SMTP id j16mr3517380wrr.364.1593522458504; 
 Tue, 30 Jun 2020 06:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDDcu4T/AipyuWwPmJ4buScKdzkruZN9F+uoJAuOE1UpwL+mUl56hVEQOcBzb9VtRptdy6uw==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr3517358wrr.364.1593522458200; 
 Tue, 30 Jun 2020 06:07:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u84sm3460857wmg.7.2020.06.30.06.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:07:36 -0700 (PDT)
Date: Tue, 30 Jun 2020 09:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200630090717-mutt-send-email-mst@kernel.org>
References: <20200623145506.439100-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623145506.439100-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 10:57:02AM -0400, Michael S. Tsirkin wrote:
> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> since that change makes unit tests much slower for all developers, while it's not
> a robust way to fix migration tests. Migration tests need to find
> a more robust way to discover a reasonable bandwidth without slowing
> things down for everyone.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

What's the conclusion here? Should I merge this?


> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index dc3490c9fa..21ea5ba1d2 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
>  
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> -- 
> MST


