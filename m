Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD679C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964DA2075D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F7BD5fk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964DA2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr7tH-00031X-Mp
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 18:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7sa-0002PQ-4k; Thu, 02 Jul 2020 18:40:28 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:35216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7sX-00050O-Va; Thu, 02 Jul 2020 18:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=CfbFoR3PIPqMbvikH2ksfzazTShE37xTrU/k1qH1CUg=; 
 b=F7BD5fk8iAYmuEPzVV+mlketeCyJgdkPK1zluyRFoO+S3jY0NhL53RxW2mbxjg85Z/ETtv7XhzIVCe8xZvScRqPoVErH/LBB+MZ0wpVSHrtXvFaE0Vbaue+oHUEH+ms0jwweiycjCJEMoKkPGcU4blPFg0NqBO6PP9MNo2DVIfX/9wotSmVh6wuqnvt3JIO2TVXqI9HSpDY1AIuVPysIiH9+knX+FVZMr7RHHV0eJwI4mBFgvyhMjU0wxNhwBu2IF6+ovyDQQw0qpxnCbkA6SeClFqoAZCTAiwiP8wkYvzH1yfR9M1XOJQ6i21lnuiTEvlP6vx8RS7QyquJneoJDlA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jr7sS-000611-06; Fri, 03 Jul 2020 00:40:20 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jr7sR-00043g-Mk; Fri, 03 Jul 2020 00:40:19 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 28/34] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
In-Reply-To: <25384933-0ca3-3f50-c1af-4c92e8c88328@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <3c6140626c443f1eb443881eddcfb65b6107aff2.1593342067.git.berto@igalia.com>
 <25384933-0ca3-3f50-c1af-4c92e8c88328@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 00:40:19 +0200
Message-ID: <w514kqptub0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 18:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 02 Jul 2020 04:28:57 PM CEST, Max Reitz wrote:
>> +    /* For full clusters use zero_in_l2_slice() instead */
>> +    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
>> +    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
>
> Maybe we should also assert that @offset is aligned to the subcluster
> size.

It doesn't hurt but the only caller already guarantees that already ...

>> @@ -4367,12 +4367,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>          uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
>
> Can we instead align this to just subclusters?

I think so, good catch.

Berto

