Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47231C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B10F2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbe3mPTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B10F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRI3u-0006Ia-3J
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRI1B-0003Ve-CM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRI1A-0004So-M0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:14:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRI1A-0004IV-76
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587572071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO7RMM3PauNN+PRJAliJJqxjVKn2lt92tzsxUz6ovVM=;
 b=Hbe3mPTrO0Sr++gNBw7c6dzHBuchKmGi9uq/ivfOzphhc/z/EzFr/frQwwDOfTAuktOrH1
 Mq1gtMEa8ZaIkz7K0TIubIlyHSXedsXXGxU90XDIdlVZzVRatROpDkJZDzTEscwP3V1Lw/
 8phdaXr7hLlJsO8RM1HgGXdGIv9DxBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-RJ_z4rgwPE-mqoi-GOh1nA-1; Wed, 22 Apr 2020 12:14:26 -0400
X-MC-Unique: RJ_z4rgwPE-mqoi-GOh1nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2A8100CC89;
 Wed, 22 Apr 2020 16:14:25 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E37160610;
 Wed, 22 Apr 2020 16:14:12 +0000 (UTC)
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
 <84c6ca49-aef3-adf4-2efe-68357dd20ce8@redhat.com>
 <20200422155835.GC7155@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <20d12788-2d62-12a4-0949-f29594054026@redhat.com>
Date: Wed, 22 Apr 2020 11:14:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422155835.GC7155@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 10:58 AM, Kevin Wolf wrote:

>>> @@ -4214,6 +4215,35 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>            g_assert_not_reached();
>>>        }
>>> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
>>> +        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
>>> +        uint64_t zero_end = QEMU_ALIGN_UP(offset, s->cluster_size);
>>
>> This rounds up beyond the new size...
>>
>>> +
>>> +        /* Use zero clusters as much as we can */
>>> +        ret = qcow2_cluster_zeroize(bs, zero_start, zero_end - zero_start, 0);
>>
>> and then requests that the extra be zeroed.  Does that always work, even
>> when it results in pdrv_co_pwrite_zeroes beyond the end of s->data_file?
> 
> You mean the data_file_is_raw() path in qcow2_cluster_zeroize()? It's
> currently not a code path that is run because we only set
> BDRV_REQ_ZERO_WRITE for truncate if the image has a backing file, and
> data_file_is_raw() doesn't work with backing files.

Good point.

> 
> But hypothetically, if someone called truncate with BDRV_REQ_ZERO_WRITE
> for such a file, I think it would fail.
> 
>> If so,
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> otherwise, you may have to treat the tail specially, the same way you
>> treated an unaligned head.
> 
> Actually, do I even need to round the tail?
> 
>      /* Caller must pass aligned values, except at image end */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
>             end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
> 
> So qcow2_cluster_zeroize() seems to accept the unaligned tail. It would
> still set the zero flag for the partial last cluster and for the
> external data file, bdrv_co_pwrite_zeroes() would have the correct size.

Then I'm in favor of NOT rounding the tail.  That's an easy enough 
change and we've now justified that it does what we want, so R-b stands 
with that one-line tweak.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


