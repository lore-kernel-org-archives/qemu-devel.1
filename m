Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D29C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FF420768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUjuOUkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FF420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq8E-0007yF-Jq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnpxX-0005n0-Fv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:55:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnpxU-0004Hh-Sk
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592945754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sILYUEBXjY7nWGUA0nsJOCPILg9HWyYUE7clxAq8Dqs=;
 b=OUjuOUkdtmevOQEr1BfBP91wE8uBQCR5G8FcSOyOiHGIkTvTTNK4JQ70AJSCvYnzlYbTTt
 wArgkhztYEQYpjN3nJ1rU+bq5oysnKOiLXG9ohU5zDatA1vmUaRwMpNV1ylgmQ431g7g+t
 mnqZhzvryPq36x7oTLZ/0ZNaJktDES0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-gHt54RxbONqxbx_leugtww-1; Tue, 23 Jun 2020 16:55:53 -0400
X-MC-Unique: gHt54RxbONqxbx_leugtww-1
Received: by mail-wm1-f71.google.com with SMTP id r1so16424wmh.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sILYUEBXjY7nWGUA0nsJOCPILg9HWyYUE7clxAq8Dqs=;
 b=nq9jPxrlFbAZzIKIPysAxKSl+ms802O+mZS+jPKQJnk2/vdiU3/g6Y2I6bKHNfO8Rz
 JABSIrtvp/KZtpLCwwUyF2ZNywspOGAblDxJutjZgrwkQqWKeaMwLS12jkjapk24VLvg
 fvFqsQyplzqZVnBocLqsBo2WKvVola7WoTsNaUZIgOfvFUZxsGtfQyLZGWwvg4p9jccQ
 eZ3FJlp1KKI/uRPr2UfLJ69/PxhK9+N5PZHgDaZ6ACn/9lLKBAbQSJlLzw+J0g88f4fy
 b7E92vJtNZo0REa3klAIm2MVmqyKmKu8E7qPRxpcr73cxd8fhnqK0lMUK6SovCSrV4/u
 pxiw==
X-Gm-Message-State: AOAM530SOpbpV7niAPROQcmHiAV1VucXoYukx/H/HGgS3xPMLMP4Ah/R
 WCOuBkwFcvroa8o7cHjHD7BaDVgpyRjxbDyfwZPkirMCPq9rHdcAxf0F+tFrL8VLG9uNO43KeSd
 JicPh3D+ZqGczDAM=
X-Received: by 2002:adf:e545:: with SMTP id z5mr26353121wrm.89.1592945752118; 
 Tue, 23 Jun 2020 13:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybUqe+tzBqYDmbQd1i81sdb5BySBuYknfJ22s+slhpUANsPF/6sRrC1lkTqt+kK9z3JA//yw==
X-Received: by 2002:adf:e545:: with SMTP id z5mr26353104wrm.89.1592945751920; 
 Tue, 23 Jun 2020 13:55:51 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 t5sm12649927wrp.84.2020.06.23.13.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 13:55:51 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:55:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] libqos: pci-pc: use 32-bit write for EJ register
Message-ID: <20200623165527-mutt-send-email-mst@kernel.org>
References: <20200623161852.19477-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623161852.19477-1-pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 12:18:51PM -0400, Paolo Bonzini wrote:
> The memory region ops have min_access_size == 4 so obey it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I assume you are queueing this with the memory core change?

> ---
>  tests/qtest/libqos/pci-pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
> index 0bc591d1da..3bb2eb3ba8 100644
> --- a/tests/qtest/libqos/pci-pc.c
> +++ b/tests/qtest/libqos/pci-pc.c
> @@ -186,7 +186,7 @@ void qpci_unplug_acpi_device_test(QTestState *qts, const char *id, uint8_t slot)
>      g_assert(!qdict_haskey(response, "error"));
>      qobject_unref(response);
>  
> -    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
> +    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
>  
>      qtest_qmp_eventwait(qts, "DEVICE_DELETED");
>  }
> -- 
> 2.26.2


