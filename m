Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A02C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 17:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09B020768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q+/n+RqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09B020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMEn6-00064s-Qz
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 13:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMEmG-0005Yn-RU
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 13:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMEmF-0000fw-Rq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 13:46:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMEmF-0000dJ-7a; Wed, 08 Apr 2020 13:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=qVvbnbArWEfrCCqGkA3oqEew/asQmaUTi/byeGxZGnM=; 
 b=Q+/n+RqI+ZQGAT3w9ymjuIUoAOkoIiHwrxtoJB07Hxa1W1YfDRuJfOr6IpqpJVYjh9PWfg6iqiwlBBuaWhC9QQ2DJ9XmNJokJTPt4VBBxFK418wWl/zyd+Uy00djZgGtm/kTMc3+GgpXoYPYWMNhw7TjU4zZRpYXEnfgoGJUEaYp+sqQ20bwcoJe5nv8pY80TIoLxifbEWLHYTg1KJbAD0fQY6EL4BMQxegiaIPmk+GoGsAp8xxSwwYTcF+2ySO8HkbPSr5kvKck6wL5BPL0jQHEjZBaNZ/S2gvqRp3pzi5ZxnEz1Sn2RNy2YQs2Nb9Dny2U7XofLPTJsiJhuPFGVQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMEmC-00064m-6V; Wed, 08 Apr 2020 19:46:12 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMEmB-00069s-T7; Wed, 08 Apr 2020 19:46:11 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/30] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
In-Reply-To: <d2b34b1c-4b4b-f363-3bbc-7c3999cf79a2@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <fe21a93340427771899c47569c47063b849b54e6.1584468723.git.berto@igalia.com>
 <d2b34b1c-4b4b-f363-3bbc-7c3999cf79a2@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 08 Apr 2020 19:46:11 +0200
Message-ID: <w51tv1tuazg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 08 Apr 2020 01:23:42 PM CEST, Max Reitz wrote:
>> +        switch (type) {
>> +        case QCOW2_CLUSTER_COMPRESSED:
>> +            return QCOW2_SUBCLUSTER_COMPRESSED;
>
> Why did you drop the check that l2_bitmap == 0 here?

We don't generally check that reserved bits are 0. It would for example
allow us to add a new compatible feature in the future using those bits.

Berto

