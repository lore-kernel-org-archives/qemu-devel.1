Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A1CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEEB20656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOZrrdmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEEB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZXn-0000aT-UA
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iQZW0-00088Q-KV
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iQZVx-00089t-U2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:11:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iQZVx-00085n-PN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572624664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7O80s9+2hxAFio1VB/6P/mPwrZ1Z6sjDn8YshcXlTZ8=;
 b=JOZrrdmKGEh+PnUtEUWGMyHwlJuXZV5+hzHVkzMo5wb/66Vzj96y4MxjMQELLbgBWaLbz/
 3nwUmz9IF86B8MUhkRQgbKE47QG5dJ2KOARLhfviOnUe8xCCjEIgj594abZjPrM7yThg0g
 GpAT9rgMXp9GVQHkbAFGEs5+F+5vZrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-5lquw0-6NL6nqhSv-qos6g-1; Fri, 01 Nov 2019 12:11:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C926107ACC0;
 Fri,  1 Nov 2019 16:10:59 +0000 (UTC)
Received: from [10.3.116.203] (ovpn-116-203.phx2.redhat.com [10.3.116.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 642AF166B8;
 Fri,  1 Nov 2019 16:10:55 +0000 (UTC)
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
To: "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
 <c8a31188-ff21-368e-12ca-0481a51c3136@openvz.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <686e8a67-06e9-d7f1-037b-cf730de23744@redhat.com>
Date: Fri, 1 Nov 2019 17:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c8a31188-ff21-368e-12ca-0481a51c3136@openvz.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5lquw0-6NL6nqhSv-qos6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/1/19 4:49 PM, Denis V. Lunev wrote:
> On 11/1/19 4:42 PM, John Snow wrote:
>> Hi, in one of my infamously unreadable and long status emails, I
>> mentioned possibly wanting to copy allocation data into bitmaps as a way
>> to enable users to create (external) snapshots from outside of the
>> libvirt/qemu context.
>>
>> (That is: to repair checkpoints in libvirt after a user extended the
>> backing chain themselves, you want to restore bitmap information for
>> that node. Conveniently, this information IS the allocation map, so we
>> can do this.)
>>
>> It came up at KVM Forum that we probably do want this, because oVirt
>> likes the idea of being able to manipulate these chains from outside of
>> libvirt/qemu.
>>
>> Denis suggested that instead of a new command, we can create a special
>> name -- maybe "#ALLOCATED" or something similar that can never be
>> allocated as a user-defined bitmap name -- as a special source for the
>> merge command.
>>
>> You'd issue a merge from "#ALLOCATED" to "myBitmap0" to copy the current
>> allocation data into "myBitmap0", for instance.
> original problem was a little bit incorrect. After some thoughts I found
> that this is NOT enough. We should also add zeroed clusters to the
> bitmap to merge! They do cover some data clusters from the original
> image.
>=20
> Thus we should either provide "ALLOCATED" bitmap for other purposes,
> and we should supply "CHANGED" which contains allocated AND
> explicitly zeroed clusters.

I'm also wondering if 'nbd-server-add' should add support to expose a=20
'qemu:allocation:XXX' meta context, in addition to the existing=20
'qemu:dirty-bitmap:XXX' contexts (would it just be a 0/1 bit for what is=20
allocated in block layer XXX, or would it be an integer depth 0,1,2,...=20
based on how deep in the chain a cluster is allocated, or?)

It may also be interesting to have a way to have 'nbd-server-add' force=20
EIO errors to reads from an area not covered by a bitmap (whether that=20
be the dirty bitmap or the #ALLOCATED bitmap), rather than falling back=20
to a read from the backing chain, to ensure that an NBD client using=20
such a backup image cannot read any more data than what the bitmap says=20
is available.

>=20
> Den
>> Some thoughts:
>>
>> - The only commands where this pseudo-bitmap makes sense is merge.
>> enable/disable/remove/clear/add don't make sense here.
>>
>> - This pseudo bitmap might make sense for backup, but it's not needed;
>> you can just merge into an empty/enabled bitmap and then use that.
>>
>> - Creating an allocation bitmap on-the-fly is probably not possible
>> directly in the merge command, because the disk status calls might take
>> too long...
>>
>> Hm, actually, I'm not sure how to solve that one. Merge would need to
>> become a job (or an async QMP command?) or we'd need to keep an
>> allocation bitmap object around and in-sync. I don't really want to do
>> either, so maybe I'm missing an obvious/better solution.
>>
>> Also, with regards to introspection, if we do create a special reserved
>> name like #ALLOCATED, we need to make sure that this is available and
>> obvious via the QAPI schema.

If nothing else, the recent addition of introspectible QMP features=20
should make this possible.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


