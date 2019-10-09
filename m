Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4634620679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4634620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55457 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHgq-0007WC-HP
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIDv1-0000oH-2z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIDuz-0003fA-Pc
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIDuw-0003aJ-QV; Wed, 09 Oct 2019 11:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 845EB10C0518;
 Wed,  9 Oct 2019 15:30:20 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4E405D71C;
 Wed,  9 Oct 2019 15:30:19 +0000 (UTC)
Subject: Re: [PATCH] nbd: Don't let client send oversize strings
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190928041301.16296-1-eblake@redhat.com>
 <5e9da6ee2de81616cb1896da390515c53967077c.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e686bcf2-cd36-39b1-f786-4e442a18ee5e@redhat.com>
Date: Wed, 9 Oct 2019 10:30:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5e9da6ee2de81616cb1896da390515c53967077c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 09 Oct 2019 15:30:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/19 1:49 PM, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 23:13 -0500, Eric Blake wrote:
>> Qemu as server currently won't accept export names larger than 256
>> bytes, so most uses of qemu as client have no reason to get anywhere
>> near the NBD spec maximum of a 4k limit per string.  However, we
>> didn't actually have any code that prevented the client from violating
>> the protocol, which, while useful for testing corner-case server
>> reactions, is probably not ideal.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   include/block/nbd.h | 1 +
>>   nbd/client.c        | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>

>> +++ b/nbd/client.c
>> @@ -648,6 +648,10 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint32_t opt,
>>       if (query) {
>>           query_len = strlen(query);
>>           data_len += sizeof(query_len) + query_len;
>> +        if (query_len > NBD_MAX_STRING_SIZE) {
>> +            error_setg(errp, "x_dirty_bitmap query too long to send to server");
> Is there a way not to do this here? I don't know nbd well to be honest,
> and it looks like this code currently is only called for x_dirty_bitmap but
> there could be more cases in the future.

I could make this an assert, and fix the callers to pass in valid 
lengths (callers pass in either "base:allocation" which fits, or a 
user-supplied x_dirty_bitmap, so validating at the point that hack is 
assigned is reasoanble).

> 
> 
> nbd_negotiate_simple_meta_context which seems to be the caller of this, already mentions
> a 'hack' about this :-(
> 
> Of course if you think that this is not worth the time, you can leave this as is.
> 
> 
>> +            return -1;
>> +        }
>>       } else {
>>           assert(opt == NBD_OPT_LIST_META_CONTEXT);
>>       }
>> @@ -1010,6 +1014,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
>>       bool base_allocation = info->base_allocation;
>>
>>       assert(info->name);
>> +    if (strlen(info->name) > NBD_MAX_STRING_SIZE) {
>> +        error_setg(errp, "name too long to send to server");
> Maybe 'export name'?

Sure.

> 
> 
>> +        return -EINVAL;
>> +    }
>>       trace_nbd_receive_negotiate_name(info->name);
>>
>>       result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
> 
> Why not to do the export name check when info->name is set, that is in nbd_client_connect?

I'll spin up a v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

