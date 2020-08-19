Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C412207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqeVZkpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C412207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8RL3-00057t-O3
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8RIU-0001mZ-Io
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:50:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8RIR-0003f9-2S
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597855841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgQmhbSQkMcHpuEo6kHD+MxqWynRjsofqKF/7Gb9J9k=;
 b=fqeVZkpk7/QqZzvM+r3s14Xo2m71oVgmYWu2qbJSpwusmjrqN4j7BLZnamKwhaTcaQr+eh
 JK433WnzajoE4CeohQKzEvs7r2uxil5zhc57Vo3LrbaibOq1n06SaN2LmHayaQUJUl5SgQ
 UXNJ6gtonevZi0myoJXNDgOIj73ITcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-MUjOMyUiMf-NMy5CmCec6w-1; Wed, 19 Aug 2020 12:50:40 -0400
X-MC-Unique: MUjOMyUiMf-NMy5CmCec6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD3B81007460;
 Wed, 19 Aug 2020 16:50:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E3D756B6;
 Wed, 19 Aug 2020 16:50:37 +0000 (UTC)
Date: Wed, 19 Aug 2020 18:50:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 33/47] mirror: Deal with filters
Message-ID: <20200819165036.GH10272@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-34-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-34-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> This includes some permission limiting (for example, we only need to
> take the RESIZE permission for active commits where the base is smaller
> than the top).
> 
> Use this opportunity to rename qmp_drive_mirror()'s "source" BDS to
> "target_backing_bs", because that is what it really refers to.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> @@ -1682,6 +1721,7 @@ static BlockJob *mirror_start_job(
>      s->zero_target = zero_target;
>      s->copy_mode = copy_mode;
>      s->base = base;
> +    s->base_overlay = bdrv_find_overlay(bs, base);
>      s->granularity = granularity;
>      s->buf_size = ROUND_UP(buf_size, granularity);
>      s->unmap = unmap;

Is this valid without freezing the links between base_overlay and base?

Actually, I guess we should freeze everything between bs and base (for
base != NULL) and it's a preexisting problem that just happens to affect
this code, too.

Or maybe freezing everything is too much. We only want to make sure that
no non-filter is inserted between base and base_overlay and that base
(and now base_overlay) always stay in the backing chain of bs. But what
options apart from freezing do we have to achieve this?

Why is using base_overlay even better than using base? Assuming there is
a good reason, maybe the commit message could spell it out.

Kevin


