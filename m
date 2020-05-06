Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF915C38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5E720714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T5q5KixL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5E720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWH9E-0000IB-S7
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWH8O-00089I-Gw; Wed, 06 May 2020 06:18:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWH8M-0002UA-Gk; Wed, 06 May 2020 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=9wSzxJkvdDSJn6IJnpcTITLLzX2qt2AQP7+/sbEr1Es=; 
 b=T5q5KixLnFnvBQu6Mn3huGzZ5L74USpXNXvGp+tpzrpB6iuz1tXhExnWPKRxKUrJfXkVJFTaaBwL5hu+ySRBL+hc4TWclGFuOJhq3V09DPV4mJY7OQ9WURMSq8G+GTmQn3UEXyGX0f7re02+O3MI9ZkPXs5Or1ijjTbFto6VesRFSPwRMSkpQaj/jQv3mSUA88hi0QedtGQWwp0/bazElMvPvebZ0Qgjkkq3GaaGsof0TpUTuQWOGYBy7IbwGZY+Zse6fGYtNEdZMgLvR1dmoxgEOYq/g9Fgh56IeKuY/Z8Lk0nJaPMS9w/e9HqnwdWHY+v3qfI031d3BVVUI43TGQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWH8G-0008HM-OG; Wed, 06 May 2020 12:18:28 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWH8G-0000v1-FN; Wed, 06 May 2020 12:18:28 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 11/31] qcow2: Add offset_into_subcluster() and
 size_to_subclusters()
In-Reply-To: <1697e9b7-c895-4f92-bb69-d43ff9bd4c44@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <bf2f5e0e41d5c51cde60cd457fd6d69d0f6ab030.1588699789.git.berto@igalia.com>
 <1697e9b7-c895-4f92-bb69-d43ff9bd4c44@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 06 May 2020 12:18:28 +0200
Message-ID: <w51k11p9xjf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 06:18:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 May 2020 09:42:08 PM CEST, Eric Blake wrote:
> On 5/5/20 12:38 PM, Alberto Garcia wrote:
>> Like offset_into_cluster() and size_to_clusters(), but for
>> subclusters.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   block/qcow2.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> 
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index e68febb15b..8b1ed1cbcf 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -537,11 +537,21 @@ static inline int64_t offset_into_cluster(BDRVQcow2State *s, int64_t offset)
>>       return offset & (s->cluster_size - 1);
>>   }
>>   
>> +static inline int64_t offset_into_subcluster(BDRVQcow2State *s, int64_t offset)
>> +{
>> +    return offset & (s->subcluster_size - 1);
>> +}
>> +
>>   static inline uint64_t size_to_clusters(BDRVQcow2State *s, uint64_t size)
>>   {
>>       return (size + (s->cluster_size - 1)) >> s->cluster_bits;
>>   }
>
> Pre-existing, but this could use DIV_ROUND_UP.

Yeah but it would be nicer to have a version of the macro optimized for
powers of two.

Berto

