Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE2FC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EA920857
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PZTwelTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EA920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREth-0006RB-7O
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jREt1-0005v0-D0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jREt0-0007jA-IS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:53:54 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jREsz-0007e9-N7; Wed, 22 Apr 2020 08:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Dyp1ZQqS31nj2oLnslS0eL8o2/rF04kBH66LWoARddQ=; 
 b=PZTwelTxl5ywfSARK1qHRwPKMaqUui38EkCzW3j3kLpiwOZ0zbxZGDTdh+fDQprfwCoW6pQTZiaU2ZmeQZ6oPRaw8kftv1+5AKhAdSP2qYaUYNoVGc8RkkRwpXiOViAp5lPE/PfN1pgbEUno30NhT0O5kwdYXHXhgwd+VUeVpDRH5JAZI9C64+AujxXzlTuReTamWqHzYjufnM8jTMixxGrrnHvE4ZGS4gxwNddBn80Oz7caL+oO8awlPTuRXRb0LOUsvmaDvaNmxOzgDEc6CkbejJc4VtfyWNo9o4/5sShcBn1PDBH7hP4EByHmZAnyWsfCGHjyRpuSQ+/N2bRxkw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jREsu-00037B-U5; Wed, 22 Apr 2020 14:53:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jREsu-00067I-Iz; Wed, 22 Apr 2020 14:53:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 19/30] qcow2: Add subcluster support to
 zero_in_l2_slice()
In-Reply-To: <047f52a9-72c5-785d-4c7b-f4bc9410bc80@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <f1d8c4bcf7c94e0cedbd96f1d7df9ea9905bddb3.1584468723.git.berto@igalia.com>
 <047f52a9-72c5-785d-4c7b-f4bc9410bc80@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 22 Apr 2020 14:53:48 +0200
Message-ID: <w51r1wfsmub.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 07:54:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 22 Apr 2020 01:06:42 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> @@ -1897,7 +1897,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>
> As I see, function is not prepared to handle unaligned offset. Worth
> add an assertion while being here?

The only caller already asserts that, and the length parameter is not
even the number of bytes but the number of clusters, so I don't think
it's so important in this case.

>>       for (i = 0; i < nb_clusters; i++) {
>> -        uint64_t old_offset;
>> +        uint64_t old_offset, l2_entry = 0;
>
> I'd rename s/old_offset/old_l2_entry

I think we can get rid of old_offset altogether. I'll think of a way to
restructure the logics along the lines that you suggest.

Thanks!

Berto

