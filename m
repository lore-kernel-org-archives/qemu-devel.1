Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8735C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6668520781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YQ4GLCpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6668520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfbP-0007m0-Hj
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jqfZ7-00030y-9A; Wed, 01 Jul 2020 12:26:29 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jqfZ3-00010J-AH; Wed, 01 Jul 2020 12:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=HVQcCvlJZVUxJGZT8wJUTkWih5ydhK9u2rICirn7H2A=; 
 b=YQ4GLCpp7lA/6u90W3qrb6rAi4QXVyRZhOxtVZq1tbD1KcLnry/WYww60K4GW1/OIMR54+RqIN3355RhImEqJ3Ob8shuiqjo8J/ohIhnhP6ZUH3GLHrjGFLev3DIwZcAri36fZcrt0I0V7679woC6ll3/ABPachxreB9BwHZ56i3wpu5lZdItD4uJE+1a3hV8qhvxx1yIZAK+2cnSIoQvOeYgi3W8CqYr/dD5v/MP1uxam+UbKahna0WOOBwGHEdfg9NKy02gbRjI6KA8iyKIN3uTB4n3Mnxwpxgavi3LeHQWrDvRDb3oiXIrLPaUARDwJAd+dlTFfrWCgMuKbTpcQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jqfYf-0000le-KB; Wed, 01 Jul 2020 18:26:01 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jqfYf-0005PC-7j; Wed, 01 Jul 2020 18:26:01 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 14/34] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
In-Reply-To: <fae77394-92fd-d170-0ae6-051c0a024d04@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <6ee75696d3eaed56b46e91fe242fdfab51feb066.1593342067.git.berto@igalia.com>
 <fae77394-92fd-d170-0ae6-051c0a024d04@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 01 Jul 2020 18:26:01 +0200
Message-ID: <w51mu4jurqe.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:26:02
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

On Wed 01 Jul 2020 02:52:14 PM CEST, Max Reitz wrote:
>>      if (l2_entry & QCOW_OFLAG_COMPRESSED) {
>>          return QCOW2_CLUSTER_COMPRESSED;
>> -    } else if (l2_entry & QCOW_OFLAG_ZERO) {
>> +    } else if ((l2_entry & QCOW_OFLAG_ZERO) && !has_subclusters(s)) {
>
> OK, so now qcow2_get_cluster_type() reports zero clusters to be normal
> or unallocated clusters when there are subclusters.  Seems weird to
> me, because zero clusters are invalid clusters then.

I'm actually hesitant about this.

In extended L2 entries QCOW_OFLAG_ZERO does not have any meaning so
technically it doesn't need to be checked any more than the other
reserved bits (1 to 8).

The reason why we would want to check it is, of course, because that bit
does have a meaning in regular L2 entries.

But that bit is ignored in images with subclusters so the only reason
why we would check it is to report corruption, not because we need to
know its value.

It's true that we do check it in v2 images, although in that case the
entries are otherwise identical and there is a way to convert between
both types.

> I preferred just reporting them as zero clusters and letting the
> caller deal with it, because it does mean an error in the image and so
> it should be reported.

Another alternative would be to add QCOW2_CLUSTER_INVALID and we could
even include there other cases like unaligned offsets and things like
that. But that would also affect the code that repairs corrupted images.

Berto

