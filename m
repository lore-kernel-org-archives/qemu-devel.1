Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA3EC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1128207D3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwpeoU2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1128207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKdQ-0005Bn-Sa
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKcj-0004M5-Sv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 13:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKci-0001q1-Dc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 13:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600451799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swcf2kXSfR3tUVIu5BivtZePY7QB2qcACObw0jLGrS8=;
 b=WwpeoU2Mxty3/1xzahEI+C3Vk/FuHrBNtECD9JbvqUxqKvipD7fYPFU06Ya2da2PZAy60+
 nXbbgRMCocfbbkJLGM/94tTAMc5rUcks0Iq2bO5ZgTKI4/K4BNujwA6iN4DT5/B259FCDs
 uZhIqXTnx3blmRx0aggLLMUY5Tw/mqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-KH70pgrTPBOF_ep3ScQIFw-1; Fri, 18 Sep 2020 13:56:37 -0400
X-MC-Unique: KH70pgrTPBOF_ep3ScQIFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16C58800050;
 Fri, 18 Sep 2020 17:56:36 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A68FA3782;
 Fri, 18 Sep 2020 17:56:32 +0000 (UTC)
Date: Fri, 18 Sep 2020 13:56:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 4/7] block: move logical block size check function to
 a common utility function
Message-ID: <20200918175631.GB7594@habkost.net>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-5-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-5-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 04:09:09PM +0800, Coiby Xu wrote:
> Move the constants from hw/core/qdev-properties.c to
> util/block-helpers.h so that knowledge of the min/max values is
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


