Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E80C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3BF2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQo16P5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3BF2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3Nw-0001IC-Kq
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS3Mj-0000cn-TK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS3Mf-0002zI-Lv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:47:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49351
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS3Mf-0002s0-8O
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587754071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z5IQ9TwG74B+44pf0KetfGs9tKwqTSUFXB0YerezyA=;
 b=UQo16P5inoNTvRU9lKv25JWgMAV2YQvKdEiCTm2p8kXxBtOwDVvxyI3yqvLjHofW6uF9Oq
 /tGAfT91JL5UnuImOaVF8kKUX/m71kzn2M1Q+oC5ZBRz7KEgNTvJURWKOQfcjdV9ctEsqX
 4j4cdL5rHgWWymFblYSsjH8JU9Kw6mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404--Ct8WvtdN1OzwLUwGgEbSA-1; Fri, 24 Apr 2020 14:47:43 -0400
X-MC-Unique: -Ct8WvtdN1OzwLUwGgEbSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240941005510;
 Fri, 24 Apr 2020 18:47:42 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F36205C1D0;
 Fri, 24 Apr 2020 18:47:39 +0000 (UTC)
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <w51lfmkn4ws.fsf@maestria.local.igalia.com>
 <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
 <w51imhon30t.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cc3301dc-14e0-1b1c-fb97-4f4b8a520dfd@redhat.com>
Date: Fri, 24 Apr 2020 13:47:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51imhon30t.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 1:37 PM, Alberto Garcia wrote:
> On Fri 24 Apr 2020 08:25:45 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>> Reading the entire cluster will be interesting - you'll have to
>>>> decompress the entire memory, then overwrite the zeroed portions.
>>>
>>> I don't think so, qcow2_get_host_offset() would detect the number of
>>> contiguous subclusters of the same type at the given offset. In this
>>> case they would be _ZERO subclusters so there's no need to decompress
>>> anything, or even read it (it works the same with uncompressed
>>> clusters).
>>
>> But if at least one of subclusters to read is not _ZERO, you'll have
>> to decompress the whole cluster, and after decompression rewrite
>> zero-subclusters by zeroes, as Eric says.. Or I lost the thread:)
> 
> I don't see why you would need to rewrite anything... you do have to
> decompress the whole cluster, and the uncompressed cluster in memory
> would have stale data, but you never need to use that data for anything,
> let alone to return it to the guest.
> 
> Even if there's a COW, the new cluster would inherit the compressed
> cluster's bitmap so the zeroized subclusters still read as zeroes.
> 
> It's the same with normal clusters, 'write -P 0xff 0 64k' followed by
> 'write -z 16k 16k'. The host cluster on disk still reads as 0xff but the
> L2 entry indicates that part of it is just zeroes.

The point is this:  Consider 'write -P 0xff 0 64k', then 'write -z 16k 
16k', then 'read 0 64k'.  For normal clusters, we can just do a 
scatter-gather iov read of read 0-16k and 32-64k, plus a memset of 
16-32k.  But for compressed clusters, we have to read and decompress the 
entire 64k, AND also memset 16k-32k.  But if zeroing after reading is 
not that expensive, then the same technique for normal clusters is fine 
(instead of a scatter-gather read of 48k, just read the whole 64k 
cluster before doing the memset).  So the question at hand is not what 
happens in writing, but in reading, and whether we are penalizing reads 
from a compressed cluster or even from regular clusters, when reading 
from a cluster where subclusters have different status.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


