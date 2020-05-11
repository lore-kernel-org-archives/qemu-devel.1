Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6077FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFC520836
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoF+nPEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFC520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYFjM-0003sQ-Ae
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 17:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jYFiW-0003Lw-RW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jYFiV-00061G-Fs
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589231521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BU3FEZ7eueZUvi2B9gCb6a6ZgqGmsW/r9yKr8z1X69Q=;
 b=MoF+nPEuiz3aulCYb+YAMtrTFtwLu5I3V5EqI19siCYMlvODTbu8Ajvx/ErCD8Kmz6lIr0
 fFkC9zsFsVPCsEQAFi3TBUs7tN/27vFVo5DKN/HdSNzMNV40fiRtW84kAOnI+g8KmfOH8D
 JBpoHN6ss8w2EuHZVn1bqQA1EmAz3Fc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-kTiQhyXXOZKTjDS3uiguSQ-1; Mon, 11 May 2020 17:11:59 -0400
X-MC-Unique: kTiQhyXXOZKTjDS3uiguSQ-1
Received: by mail-qt1-f199.google.com with SMTP id d35so11829591qtc.20
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 14:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BU3FEZ7eueZUvi2B9gCb6a6ZgqGmsW/r9yKr8z1X69Q=;
 b=NX0XQ2DMuj6WrBZbg1jk2pG7rcApZbLGCc/HzN4QudpvCS4zRFGAcA/lRR940+kbvV
 r/AnUJXjSC1SRR78JSrw8hJPLGo7y2Cs2T/u0ZniqUMhxNwdm56FgFvefKJgFzyvtG4H
 jFo2fGp87jHOpjL8+j1xD/EmtgIWYc0UvVfqgQaYw2s3+sZ8FZgRZcQzuG1GEp/uR9Lq
 cqk9v8IFoby5pdG6lf5d4/qYQLbi0Ww/5opEYiN8sdat0ePZcAn9L+jgDofSBuKm8CsV
 JDfrWESLQbP19jaqkJWhIfjsmo7fzrkVzj54JXamtVGS0uJuYvnBMiFyrNF7QRCQYp6E
 eQnw==
X-Gm-Message-State: AGi0PuYUXawHTWvBCFIj9Vu3E2A3nMvM8v2IWixH7gYWKDdWsFpTZzk0
 WjxNhuPAWjKfSytQ0cuFvPpD4MKUUROzy8hcEfbpdb6H1X01XpEzZc9ZCn3VwMUJQF4QHuGbC4T
 jDZxgRB7s3k8Uiq8=
X-Received: by 2002:ac8:6695:: with SMTP id d21mr18780366qtp.176.1589231519472; 
 Mon, 11 May 2020 14:11:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMooUqZ5/uNpM/8BWHmzYmuS81ATChj5wp5oxuyw8yy1+VQS8+iPnNq36BdJiMsoTH6mYg1g==
X-Received: by 2002:ac8:6695:: with SMTP id d21mr18780346qtp.176.1589231519208; 
 Mon, 11 May 2020 14:11:59 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id l2sm9315250qkd.57.2020.05.11.14.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 14:11:58 -0700 (PDT)
Date: Mon, 11 May 2020 17:11:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 3/5] virtio-iommu: Handle reserved regions in the
 translation process
Message-ID: <20200511211156.GM228260@xz-x1>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200508173057.32215-4-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 08, 2020 at 07:30:55PM +0200, Eric Auger wrote:
> When translating an address we need to check if it belongs to
> a reserved virtual address range. If it does, there are 2 cases:
> 
> - it belongs to a RESERVED region: the guest should neither use
>   this address in a MAP not instruct the end-point to DMA on
>   them. We report an error
> 
> - It belongs to an MSI region: we bypass the translation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


