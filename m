Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A3FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7532080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8gp5GXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7532080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZhx-0002Q5-MB
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyZhA-0001ni-IC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:47:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyZh8-0004HG-OX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595504846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw+utQchIAaOyMZYkIyk21M/hJdTe+EMHO96H0dBMz8=;
 b=N8gp5GXb9UDWJJGyiCk+Nve3svbU4l3/InOlRHxxVNH6/0Zi58J/IEttpcsCJ6Wfa6T4na
 lfsS+gfsykJB1JRr9i5M8f5+STXhVLnbQAE2BC+lQPnQJ2Lxs2Mh0nr/WKVtbGVKVEnko+
 MtiL88ljo6NFt1CdM76fd76b6HyOc2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-oyfBWoJ-MdO13pv6TlV4Ow-1; Thu, 23 Jul 2020 07:47:20 -0400
X-MC-Unique: oyfBWoJ-MdO13pv6TlV4Ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 597CA8005B0;
 Thu, 23 Jul 2020 11:47:19 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2BC15F7D8;
 Thu, 23 Jul 2020 11:47:18 +0000 (UTC)
Subject: Re: [PATCH for-5.1] nbd: Fix large trim/zero requests
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200722212231.535072-1-eblake@redhat.com>
 <e7b8151d-b9d3-b5c5-9bc4-661a045d4ff9@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b72d8646-4ad5-be76-dca9-72bfb203d18f@redhat.com>
Date: Thu, 23 Jul 2020 06:47:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e7b8151d-b9d3-b5c5-9bc4-661a045d4ff9@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 2:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.07.2020 00:22, Eric Blake wrote:
>> Although qemu as NBD client limits requests to <2G, the NBD protocol
>> allows clients to send requests almost all the way up to 4G.  But
>> because our block layer is not yet 64-bit clean, we accidentally wrap
>> such requests into a negative size, and fail with EIO instead of
>> performing the intended operation.
>>

>> @@ -2378,8 +2378,17 @@ static coroutine_fn int 
>> nbd_handle_request(NBDClient *client,
>>           if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
>>               flags |= BDRV_REQ_NO_FALLBACK;
>>           }
>> -        ret = blk_pwrite_zeroes(exp->blk, request->from + 
>> exp->dev_offset,
>> -                                request->len, flags);
>> +        ret = 0;
>> +        /* FIXME simplify this when blk_pwrite_zeroes switches to 
>> 64-bit */
>> +        while (ret == 0 && request->len) {
>> +            int align = client->check_align ?: 1;
>> +            int len = MIN(request->len, 
>> QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
>> +                                                        align));
>> +            ret = blk_pwrite_zeroes(exp->blk, request->from + 
>> exp->dev_offset,
>> +                                    len, flags);
>> +            request->len -= len;
>> +            request->from += len;
>> +        }
>>           return nbd_send_generic_reply(client, request->handle, ret,
>>                                         "writing to file failed", errp);

It's easy enough to audit that blk_pwrite_zeroes returns 0 (and not 
arbitrary positive) on success.

>>
>> @@ -2393,8 +2402,17 @@ static coroutine_fn int 
>> nbd_handle_request(NBDClient *client,
>>                                         "flush failed", errp);
>>
>>       case NBD_CMD_TRIM:
>> -        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
>> -                              request->len);
>> +        ret = 0;
>> +        /* FIXME simplify this when blk_co_pdiscard switches to 
>> 64-bit */
>> +        while (ret == 0 && request->len) {
> 
> Did you check all the paths not to return positive ret on success? I'd 
> prefer to compare ret >= 0 for this temporary code to not care of it

And for blk_co_pdiscard, the audit is already right here in the patch: 
pre-patch, ret = blk_co_pdiscard, followed by...

> 
>> +            int align = client->check_align ?: 1;
>> +            int len = MIN(request->len, 
>> QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
>> +                                                        align));
>> +            ret = blk_co_pdiscard(exp->blk, request->from + 
>> exp->dev_offset,
>> +                                  len);
>> +            request->len -= len;
>> +            request->from += len;
> 
> Hmm.. Modifying the function parameter. Safe now, as 
> nbd_handle_request() call is the last usage of request in nbd_trip().
> 
>> +        }
>>           if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {

...a check for ret == 0.

>>               ret = blk_co_flush(exp->blk);
>>           }
>>
> 
> 

Yes, I can respin the patch to use >= 0 as the check for success in both 
functions, but it doesn't change the behavior.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


