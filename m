Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716AC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497042078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkkxQTpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497042078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOX6-00077u-EZ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDOWV-0006VH-Vu
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDOWT-00082F-7w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599036819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4LUzdmKJauUmEbRNA6jnGkgs2IhSTpJQ0udtQo+e8vo=;
 b=YkkxQTpMU3jvH5oIzyB8QgSF1jzaZZCo6ngjzv14uWR7QvsR+iqGXqxVqA4CYOU501PHMA
 ayMCqbzItMtlmZx4WXu4S4Nl5lcPQiWeTHBL12HqVi8rZiGr2pZz/KmL+fkx2eUCKm+8sa
 ihVHvS2hKIL1CrKcalex/kMSwVaj9pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-HzMxnmG8OW2HFHGEvpt32Q-1; Wed, 02 Sep 2020 04:53:37 -0400
X-MC-Unique: HzMxnmG8OW2HFHGEvpt32Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16F51074644;
 Wed,  2 Sep 2020 08:53:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-85.ams2.redhat.com [10.36.113.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B40A5D9CD;
 Wed,  2 Sep 2020 08:53:34 +0000 (UTC)
Date: Wed, 2 Sep 2020 10:53:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v8 29/43] mirror: Deal with filters
Message-ID: <20200902085333.GA5765@linux.fritz.box>
References: <20200901143424.884735-1-mreitz@redhat.com>
 <20200901143424.884735-30-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901143424.884735-30-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.09.2020 um 16:34 hat Max Reitz geschrieben:
> This includes some permission limiting (for example, we only need to
> take the RESIZE permission for active commits where the base is smaller
> than the top).
> 
> base_overlay is introduced so we can query bdrv_is_allocated_above() on
> it - we cannot do that with base itself, because a filter's block_status
> is the same as its child node, so if there are filters on base,
> bdrv_is_allocated_above() on base would return information including
> base.
> 
> Use this opportunity to rename qmp_drive_mirror()'s "source" BDS to
> "target_backing_bs", because that is what it really refers to.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I see that you decided not to fix the missing freeze of the backing
chain on the source side. I'm willing to view this as a pre-existing
issue that shouldn't stop this series, but are you going to send a
separate patch for it?

Kevin


