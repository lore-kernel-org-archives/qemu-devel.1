Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D829F2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1EHMZ+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1A9v-0001MW-7g
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1A9L-0000ue-4m
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:07:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1A9J-0004VI-HH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596121632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCeHeWqfsG12YPXespgYCdePkJ9ozj/yzc+sFWvi7To=;
 b=I1EHMZ+jklXCWUDRysKVxKmUd6n7DmV5utwjwYNTMChg7UWW/akcuxUiYCnpIeymw06nZd
 6gKAS5l+qHzwFGqykPbaAROkKmuyDY6+n1FUBsyhmMUJjPcPGg5YKRKriYqkFMwTFOTOWN
 saGEdedRtaJs+s3gQV/sRsBFnpnlSWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-le5njwLqNhuRWwsirhs71w-1; Thu, 30 Jul 2020 11:07:08 -0400
X-MC-Unique: le5njwLqNhuRWwsirhs71w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2223B107B7EF;
 Thu, 30 Jul 2020 15:07:07 +0000 (UTC)
Received: from gondolin (ovpn-112-203.ams2.redhat.com [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7A65F7D8;
 Thu, 30 Jul 2020 15:06:58 +0000 (UTC)
Date: Thu, 30 Jul 2020 17:06:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390x/s390-virtio-ccw: fix off-by-one in
 loadparm getter
Message-ID: <20200730170656.263a94fa.cohuck@redhat.com>
In-Reply-To: <20200730130156.35063-1-pasic@linux.ibm.com>
References: <20200730130156.35063-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 15:01:56 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> As pointed out by Peter, g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1)
> reads one past of the end of ms->loadparm, so g_memdup() can not be used
> here.
> 
> Let's use g_strndup instead!
> 
> Fixes: d664548328 ("s390x/s390-virtio-ccw: fix loadparm property getter")
> Fixes: Coverity CID 1431058
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Thanks, queued to s390-fixes.


