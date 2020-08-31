Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E74C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9547B207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZyZD6uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9547B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCp5L-0006Fh-OJ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 15:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kCp4k-0005kk-VS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:02:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kCp4i-0001tn-Ci
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598900558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPm5y8FW/fAvfz2uHk+ty8JVGwnDMrtC5j6mOnvNIXI=;
 b=CZyZD6uYXlGmK+XZaIM6AlTYomUBPnvlJqwRWlP4CLnkMI7akzi/b6/nKsrogGSVBAj0at
 /WPGgQauXAMQ/RuivcLr5A124t+iMCUBfsIn3HJtdwnQIsSIHiRordq0lhw0G+Q95AP6F2
 HsLVT/gEHrbgq7bdS1DSIsr16dcu5G0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-ZALOvUmxNsm2sekiGDmpvA-1; Mon, 31 Aug 2020 15:02:36 -0400
X-MC-Unique: ZALOvUmxNsm2sekiGDmpvA-1
Received: by mail-qk1-f197.google.com with SMTP id u23so4248898qku.17
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 12:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HPm5y8FW/fAvfz2uHk+ty8JVGwnDMrtC5j6mOnvNIXI=;
 b=LWtHSXQ678L8UFh/4IT+mNGGSMHS0VFQvcDepFSPtLmedIR9z+gtOrfsQ/Hp+sXb38
 bvt0aRq2V+2X109A2B6NAzBG2IsBspOuLKeRdEWevfQ2Tk3Y/2xO59PhN5tsGEm/wOcr
 9K3FYkQ9X/FkcJRo3ut1UNnJy22UJ1ard6UHT/wI0mzv25vOk3Drl+NmqjqFSw2u4n2j
 BI2cFLQsh4LdUOqxVeUIpF9LrxdLmIIqhXwGybQsc5JL9ahkMGHWSk7HmZ1Z7UuowAfs
 z0rpcmxQ1QWiqq1iejOiCr+COzTK8selno/O4znkgqFfgwbKQW/B4adbL9Q0UysM6F5S
 Oksw==
X-Gm-Message-State: AOAM530WNuTfnHXNeS5cK2dznPbi8PxkqORRUeG7K8vIW1yxgY56csoB
 VJtafvopsGocwwN/sD0gzRQFXMNULhBGLuc5yKtH1XayXkF7E5ld7i/0z9o4Jc913Wo5LqFeoJG
 8I5ZysnpBzvKJSRE=
X-Received: by 2002:a37:d95:: with SMTP id 143mr2958321qkn.224.1598900555893; 
 Mon, 31 Aug 2020 12:02:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIdSIl9C4/7PAALawvjCe9a7K1Pa6Fs2zCawYF1N+//9/ULgeN3fOABccR7EC241HXKAFVA==
X-Received: by 2002:a37:d95:: with SMTP id 143mr2958289qkn.224.1598900555652; 
 Mon, 31 Aug 2020 12:02:35 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id n15sm9882129qkk.28.2020.08.31.12.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 12:02:35 -0700 (PDT)
Date: Mon, 31 Aug 2020 15:02:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 46/74] x86-iommu: Rename QOM type macros
Message-ID: <20200831190233.GC121663@xz-x1>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-47-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200825192110.3528606-47-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 15:02:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 03:20:42PM -0400, Eduardo Habkost wrote:
> Some QOM macros were using a X86_IOMMU_DEVICE prefix, and others
> were using a X86_IOMMU prefix.  Rename all of them to use the
> same X86_IOMMU_DEVICE prefix.
> 
> This will make future conversion to OBJECT_DECLARE* easier.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


