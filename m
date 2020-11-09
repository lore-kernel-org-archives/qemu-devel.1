Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D23C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A035E206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwN7N0v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A035E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Ok-00069D-Dm
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc8ML-000384-Qy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc8MI-0004om-Tl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWpk81ZLEkIXSKVBy9o/PuJL/3kSjDw6HfzyDivt6is=;
 b=RwN7N0v/3pIyXCI8JWD0zAIqr9Qv0iuxTNiDfx2Bx3xcxxcwSlGzNrhF6oWMxvLVDAOkN2
 EN8NKmAPUrGBg18DhUurkg0v5558JNZXyMMoaSwFpvkwjKnZ3iyPB69BeFoBPQHSF28FMh
 YV+RlxuVRRaXVb/rACSLTs24YygZPQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-SsPMPft4M5SlFNCZ4dg6Dg-1; Mon, 09 Nov 2020 09:41:19 -0500
X-MC-Unique: SsPMPft4M5SlFNCZ4dg6Dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12B21074646;
 Mon,  9 Nov 2020 14:41:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F6CD5B4CD;
 Mon,  9 Nov 2020 14:41:14 +0000 (UTC)
Subject: Re: [PATCH v2 0/7] block: permission update fix & refactor
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cdf7dea8-67d1-b0e1-b8f0-8e6333f586c7@redhat.com>
Date: Mon, 9 Nov 2020 15:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106124241.16950-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, berto@igalia.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.11.20 13:42, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> These series supersedes "Fix nested permission update" and includes one
> more fix (patch 01) and more improvements.
> 
> I think patch 01 is good to have in 5.2, 02 is probably OK for 5.2 and
> the others are OK for next release. Still all may be taken to 5.2, up to
> block maintainers.
> 
> Actually the series is a first part of my work announced in
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08386.html
> to bring correct order to permission update (topological sort),
> update permission only on updated graph (and rollback graph changes),
> get rid of .active fields in block jobs.
> 
> Supersedes: <20201031123502.4558-1-vsementsov@virtuozzo.com>
> 
> v2: all new except for 03:, which uses suggestions by Albert and more
> strict version of bdrv_replace_node.

Thanks, I took 1 through 3 to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

and 4 through 7 to my block-next branch (squashing in the fix for 4, and 
fixing up the resulting conflict in 7):

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


