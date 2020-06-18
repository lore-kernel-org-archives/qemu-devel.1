Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB10720888
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHmPJUNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB10720888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvrP-0003zX-5Y
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlvqf-0002fS-MM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:49:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlvqe-0005KK-75
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592491738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wa9ofjsgBTB46nJUGptcVFKHtsfILsSf/2QWeSMefAo=;
 b=XHmPJUNZYMH3KMbllKlGRMGrFIGqLWq/Ix+8ScfgRl/bJPwtCPwn6xqq9OEegvMB3vWrBp
 1degMqmQBxoGQ65dTImNHC3JRW/3x0mtsguZxo6bEi+ax4CX+rBz5iMuTGcinK2To3JJPP
 /nsqfDlgXa8nHGBCWpHNOfY1dexbxL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-mIX2__G2N4OHNRbmZNaYLw-1; Thu, 18 Jun 2020 10:48:49 -0400
X-MC-Unique: mIX2__G2N4OHNRbmZNaYLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F49619241BE;
 Thu, 18 Jun 2020 14:47:55 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F06A25BAC4;
 Thu, 18 Jun 2020 14:47:36 +0000 (UTC)
Subject: Re: [PATCH v3 08/17] block/io: support int64_t bytes in
 bdrv_aligned_preadv()
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-9-vsementsov@virtuozzo.com>
 <9143ff10-cba2-bcc2-c48c-eac73446b159@redhat.com>
 <w51lfkktpaz.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7f16039b-d361-8645-7805-100c1ef5314a@redhat.com>
Date: Thu, 18 Jun 2020 09:47:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w51lfkktpaz.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 9:35 AM, Alberto Garcia wrote:
> On Fri 22 May 2020 05:14:36 PM CEST, Eric Blake wrote:
>>>    static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>>> -    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
>>> +    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
>>>        int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
>   [...]
>>>        BlockDriverState *bs = child->bs;
>>>        int64_t total_bytes, max_bytes;
>>>        int ret = 0;
>>> -    uint64_t bytes_remaining = bytes;
>>> +    int64_t bytes_remaining = bytes;
>>>        int max_transfer;
>>>    
>>>        assert(is_power_of_2(align));
>>> +    assert(offset >= 0 && bytes >= 0);
>>
>> Use within the function:
>>
>> the new assertion added here does not check for whether offset+bytes is
>> positive; I would suggest we strengthen it to instead be:
>> assert(offset >= 0 && (uint64_t) bytes <= INT64_MAX - offset);
> 
> But here you would be making 'bytes' unsigned without asserting that
> it's not negative.

'offset >= 0' proves that offset is nonnegative.  'INT64_MAX - offset' 
is still a signed integer, and is also necessarily non-negative (the 
maximum positive integer minus any other positive integer cannot go 
negative).  We then coerce that into an unsigned comparison, which means 
if bytes was negative, the coercion will result in something larger than 
(unsigned)INT64_MAX, and the overall assert() will fail.  Thus, as 
written, the assertion works just fine at proving both bytes and offset 
were non-negative, and that bytes+offset did not overflow a signed integer.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


