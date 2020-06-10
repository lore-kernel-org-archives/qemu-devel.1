Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132AD2072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIi9AH9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132AD2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3cH-0003Yp-Ot
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3bK-0002of-7n
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:29:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3bI-0005Vl-D2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591806555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAbKxMQGFPVu4UkAhaHkmv2rOxwrHX6xVrrdaAiD1d8=;
 b=OIi9AH9otIb/xP/mGX7igyLQ7ZzoFSARfN0v1dASr0xYgh/GSVGLXcwQANi8HOexKqm5VZ
 Sqzp7KVEtYyquKOy6LWR1vXehZGRvr1OKdEDBdp7SXKPhs3WStj/GuE4x3zRc2GoAS2wP0
 OXG+g1n25qJ1ivX5cx8e8OYa9QX+6jI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-uct5aVxKPD-O_F0rbFZsYw-1; Wed, 10 Jun 2020 12:29:11 -0400
X-MC-Unique: uct5aVxKPD-O_F0rbFZsYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58824100CD03;
 Wed, 10 Jun 2020 16:29:10 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4291C4;
 Wed, 10 Jun 2020 16:29:09 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: Call attention to truncation of long NBD
 exports
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200608182638.3256473-1-eblake@redhat.com>
 <20200608182638.3256473-3-eblake@redhat.com>
 <5430f8e5-8f28-d703-1b55-136e2296ec72@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8bce0710-648b-1862-688c-8cee1cab9c8b@redhat.com>
Date: Wed, 10 Jun 2020 11:29:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5430f8e5-8f28-d703-1b55-136e2296ec72@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> 08.06.2020 21:26, Eric Blake wrote:
>> Commit 93676c88 relaxed our NBD client code to request export names up
>> to the NBD protocol maximum of 4096 bytes without NUL terminator, even
>> though the block layer can't store anything longer than 4096 bytes
>> including NUL terminator for display to the user.  Since this means
>> there are some export names where we have to truncate things, we can
>> at least try to make the truncation a bit more obvious for the user.
>> Note that in spite of the truncated display name, we can still
>> communicate with an NBD server using such a long export name; this was
>> deemed nicer than refusing to even connect to such a server (since the
>> server may not be under our control, and since determining our actual
>> length limits gets tricky when nbd://host:port/export and
>> nbd+unix:///export?socket=/path are themselves variable-length
>> expansions beyond the export name but count towards the block layer
>> name length).
>>
>> Reported-by: Xueqiang Wei <xuwei@redhat.com>
>> Fixes: https://bugzilla.redhat.com/1843684
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
>> ---
>>   block.c     |  7 +++++--
>>   block/nbd.c | 21 +++++++++++++--------
>>   2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 8416376c9b71..6dbcb7e083ea 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6809,8 +6809,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>>           pstrcpy(bs->filename, sizeof(bs->filename), 
>> bs->exact_filename);
>>       } else {
>>           QString *json = 
>> qobject_to_json(QOBJECT(bs->full_open_options));
>> -        snprintf(bs->filename, sizeof(bs->filename), "json:%s",
>> -                 qstring_get_str(json));
>> +        if (snprintf(bs->filename, sizeof(bs->filename), "json:%s",
>> +                     qstring_get_str(json)) >= sizeof(bs->filename)) {
>> +            /* Give user a hint if we truncated things. */
>> +            strcpy(bs->filename + sizeof(bs->filename) - 4, "...");
>> +        }
> 
> Is  4096 really enough for json in normal cases?

By its very nature, a json string tends be longer than a counterpart URI 
string representing the same information (when such an explicit name 
exists) because of the extra characters burned in adding "key":value 
pairs wrapping the data that was compact in explicit form.  But 4k is 
still quite a lot, and the only cases I've seen where names don't fit in 
JSON form is where the user was explicitly trying to break things with 
corner-case testing, rather than what you get with day-to-day use.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


