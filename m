Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B05C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEB120888
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwwQRdgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEB120888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8R7m-0005ED-7o
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8R71-0004fQ-8u
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:38:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8R6y-0001xa-Kc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597855131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/CfPbqVwkBQNKsZsmfMjrcuU/QPk8UD5NZ/+SlLU2A=;
 b=RwwQRdgYJOsxY43RYdYv23MoXfzoeQ+bC8QX2iEPQINRdk7DAlSHWt7HqEt9+k0JQElBhK
 JwCuKRM1g76T7YsFM8/x01a31nz9226CZJR565UoyoBmw/VJ/WpuWQcY4uC0zZoDa9EVNN
 gy6LteGOjTXvtvqFkqjMhOLXt/NAz18=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-CLEfq4FfPdye5MGZaYyyrA-1; Wed, 19 Aug 2020 12:38:49 -0400
X-MC-Unique: CLEfq4FfPdye5MGZaYyyrA-1
Received: by mail-qt1-f200.google.com with SMTP id h10so17143232qtc.4
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7/CfPbqVwkBQNKsZsmfMjrcuU/QPk8UD5NZ/+SlLU2A=;
 b=Uq6qcBVy8RANsYUj9R9jGVhbwsuIQ/xi5yE+Xh2nX5q9g9fdZAcHE35w3d6R/xI+cz
 G1G3ra2GqxOsHVyWSeVwywJXnhD6HMfAfEdTlxnxnv/rSIaMx0IFeu5XYmlfjS1BZtqS
 L6EhCJq8FzFOK/f7l1cfktEUYn7F6JE44dWZj5V9b/pc5mX+bHcllWBEABJiuNdFiQ9s
 cMt4mV2BDKyQap+4P6C8/dTylSFkVilYCwe8/+HfZcbkRMvkAzlIpYfM0QChxvsKtkCJ
 a2EkVtx/K4yB7jDEy2Gr6Zez6GjEdq3ZvNi+9sWho8StxiZzG5x4KiBDNauqnf8Y297N
 BOJg==
X-Gm-Message-State: AOAM533fAIgXMdEpavxs7ytm9FgYiazH1RW5srVEbymDi7HqGEYmob9K
 b2BMtmMOPU+D5452S5n8tvfGzZRc00llP+oVuEUGphQvpjhpYZNyPL0Ng2qc6Re4IHcZUjNevaV
 nunf7ZkAIQG2WiEs=
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr23269638qkg.326.1597855129220; 
 Wed, 19 Aug 2020 09:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEco0mYHmo84nrtEEBT/fAa5nVZvACiG61Su8RdChtE+k1s4R8NE3USWcHlp2XAxlsIMV5RA==
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr23269614qkg.326.1597855128969; 
 Wed, 19 Aug 2020 09:38:48 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id 2sm24545280qki.46.2020.08.19.09.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:38:48 -0700 (PDT)
Date: Wed, 19 Aug 2020 12:38:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v4 1/2] memory: Rename memory_region_notify_one to
 memory_region_notify_one_iommu
Message-ID: <20200819163846.GA305409@xz-x1>
References: <20200818130151.31678-1-eperezma@redhat.com>
 <20200818130151.31678-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818130151.31678-2-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 03:01:50PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

It would be good if there's some commit message, though..

Also, I'd slightly prefer memory_region_notify_iommu_one rather than one_iommu,
but I'm fine with either.

-- 
Peter Xu


