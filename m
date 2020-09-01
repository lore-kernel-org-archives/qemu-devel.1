Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D98F206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaOrAzKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D98F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDYv-0000qe-JQ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDY2-0000Qx-8Z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:10:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDXz-0001JT-La
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598994629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DaypNNANIevQD4AzCg2EyiYu4Ha0XpTZGt1eASHuNM=;
 b=TaOrAzKEKtQt5amknnMK98rK9611N5K/29TrwXF3rnVQ6nR0JYYUbqYZ5rCRpsdmXI9KGC
 K/wd5zedbWFLZKnTi6i7uMeA/mnarKRNbjSmATDftKh1Zotr06Bmt2+lXGe3LpyV1sVUxK
 YAEc0s6ZXPt5SpLgXUHnm5m9H6A7PXU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-pBdtIUSbOGGEpJvG-fLHyg-1; Tue, 01 Sep 2020 17:05:50 -0400
X-MC-Unique: pBdtIUSbOGGEpJvG-fLHyg-1
Received: by mail-qt1-f198.google.com with SMTP id r22so2009543qtc.9
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6DaypNNANIevQD4AzCg2EyiYu4Ha0XpTZGt1eASHuNM=;
 b=WgtCMs6zO9T3oDpkAX17IQT3bAo27aYU8t9np10Kq9bLjsWClVGLAnJXvnrGE179A+
 gBKYWqIC9pTAlDqrB2981TD7qEY9bZ/SGzoSjVb+U+uu9SUt6e6swsRkdpTh/d9IEV2Z
 f5rza5UKVH5dUiP4Y7YjO/KjLTopMy/O1o9ixVQIP4u0axkpiwuigNdYbjfMjzIg96Cn
 M4usKhGXQdyrzeB95LQVAoPmTipdRNpy6jUkvI8pUXL5BqxkFywwh9tT0HARIPBvhHSw
 +iPw4ueGjh4jv4HJozTfwTTGMCv1jX8zbQjG2hzfCvUytx6tx7e3cTldawrI03+tQn1q
 7RFQ==
X-Gm-Message-State: AOAM531/G/4HnXEUWnY25Y/zTYfIDK6C9/sLaL4gr5RvIDJPFayyBFGs
 nI1xqhrPyZHpxBTE1sB8tpc5UabigNqceu+4edl+qwSN+vAaECu/0bhv0grm+TmFEVAlEjjhVpl
 1MoYN/8gpSpLiibg=
X-Received: by 2002:a37:a482:: with SMTP id n124mr3790052qke.339.1598994350031; 
 Tue, 01 Sep 2020 14:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJocgzSOrbc2llezi40sz6QYnCmz6e5ZIv6o9KnnyhaC1X1HGlwtiUfxBEXbkhAZc0nwljWA==
X-Received: by 2002:a37:a482:: with SMTP id n124mr3790034qke.339.1598994349826; 
 Tue, 01 Sep 2020 14:05:49 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id f7sm3014945qkj.32.2020.09.01.14.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 14:05:49 -0700 (PDT)
Date: Tue, 1 Sep 2020 17:05:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
Message-ID: <20200901210547.GG3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-6-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-6-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:26:08PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


