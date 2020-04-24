Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC1DC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB03E20774
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqSG9E2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB03E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS2Ou-0000m7-Ss
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 13:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS2O3-0008Nc-05
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS2O1-0005J9-OF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:45:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS2O1-0005H4-8v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587750311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mTrbPjCr9EATC4yIGlUG/AhG1AcBHC93jbADmsTDXE=;
 b=gqSG9E2dSSIRZnsaDHvCI/NesZWUBc7HOLsLmEc76w/bQs9x6rUGkcu6kq11jbrTVol2PG
 bcdEo4I6OAVfhBFStoAu2TNmhqmAxkU4o8PL71N1bgAtwHUzP1oouD7aYRUaF485TMGWSo
 VHuNiBtvOZgoS0WEul2QX+XnrEgznPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-i4_jQy2rOj-AzmvbTR5ldg-1; Fri, 24 Apr 2020 13:45:07 -0400
X-MC-Unique: i4_jQy2rOj-AzmvbTR5ldg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 223B48018A7;
 Fri, 24 Apr 2020 17:44:37 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D028B5D9CA;
 Fri, 24 Apr 2020 17:44:34 +0000 (UTC)
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
Date: Fri, 24 Apr 2020 12:44:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51o8rgn6j6.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 12:21 PM, Alberto Garcia wrote:
> On Fri 24 Apr 2020 07:11:08 PM CEST, Eric Blake <eblake@redhat.com> wrote:
>>> 'write -c 0 64k' followed by 'write -z 16k 16k' would not need to do any
>>> copy on write. The compressed data would remain untouched on disk but
>>> some of the subclusters would have the 'all zeroes' bit set, exactly
>>> like what happens with normal clusters.
>>
>> It's a special case that avoids COW for write zeroes, but not for
>> anything else. The moment you write any data (whether to the
>> zero-above-compressed or the regular compressed portion), the entire
>> cluster has to be rewritten.
> 
> That's right but you can still write zeroes without having to rewrite
> anything, and read back the zeroes without having to decompress the
> data.
> 
>> at the same time, I can see where you're coming from in stating that
>> if it makes management of extended L2 easier to allow zero subclusters
>> on top of a compressed cluster, then there's no reason to forbid it.
> 
> I'm not sure if it makes it easier. Some operations are definitely going
> to be easier but maybe we have to add and handle _ZERO_COMPRESSED in
> addition to _ZERO_PLAIN and _ZERO_ALLOC (the same for unallocated
> subclusters). Or maybe replace QCow2SubclusterType with something
> else. I need to evaluate that.

Reading the entire cluster will be interesting - you'll have to 
decompress the entire memory, then overwrite the zeroed portions.  The 
savings in reading occur only when your read is limited to just the 
subclusters that are zeroed.

But then again, even on a regular cluster, read has to pay attention to 
which subclusters are zeroed, so you already have the workhorse in read 
for detecting whether a normal read is sufficient or if you have to 
follow up with piecing together zeroed sections.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


