Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89488C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CDE20575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qes9oujh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CDE20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVTe-0005Ub-D9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVRT-0002dr-NG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVRS-00009v-9o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTVRR-0008TX-OO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588100328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwc433LAO/4q11ZASN0e6OXL4Y55czSQayFWtz8+uCc=;
 b=Qes9oujhja3CVPz0O+jli/Y4QISNTPjh19xrsvuaJI7a/6zhhTY6Cvb1x4JkymIeM7LMT+
 cfgrUg15BHHUrt2gOK+reqAd8elfdwRe/c5wnLZQwSNiRTeLU/GJczXdDsU4NB9KqaKSpQ
 IpgennjF1DeuYxumxB2pHIaRbkhLJd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-iZ7eRRD-Onu9sQ-NBBhz0A-1; Tue, 28 Apr 2020 14:58:43 -0400
X-MC-Unique: iZ7eRRD-Onu9sQ-NBBhz0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE92835B40;
 Tue, 28 Apr 2020 18:58:42 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B496B5D9E8;
 Tue, 28 Apr 2020 18:58:41 +0000 (UTC)
Subject: Re: [PATCH v7 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424125448.63318-5-kwolf@redhat.com>
 <6e1df4f4-366f-2612-fd18-ba916fd1a622@redhat.com>
 <20200428184514.GP5789@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <62530c3d-a0cb-fa83-957f-323d30fef913@redhat.com>
Date: Tue, 28 Apr 2020 13:58:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428184514.GP5789@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: vsementsov@virtuozzo.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 berto@igalia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 1:45 PM, Kevin Wolf wrote:
> Am 28.04.2020 um 18:28 hat Eric Blake geschrieben:
>> On 4/24/20 7:54 AM, Kevin Wolf wrote:
>>> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
>>> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
>>> undo any previous preallocation, but just adds the zero flag to all
>>> relevant L2 entries. If an external data file is in use, a write_zeroes
>>> request to the data file is made instead.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    block/qcow2-cluster.c |  2 +-
>>>    block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
>>>    2 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>
>>> +++ b/block/qcow2.c
>>> @@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>>        bs->supported_zero_flags = header.version >= 3 ?
>>>                                   BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK : 0;
>>> +    bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
>>
>> Is this really what we want for encrypted files, or would it be better as:
>>
>>      if (bs->encrypted) {
>>          bs->supported_truncate_flags = 0;
>>      } else {
>>          bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
>>      }
>>
>> At the qcow2 level, we can guarantee a read of 0 even for an encrypted
>> image, but is that really what we want?  Is setting the qcow2 zero flag on
>> the cluster done at the decrypted level (at which point we may be leaking
>> information about guest contents via anyone that can read the qcow2
>> metadata) or at the encrypted level (at which point it's useless
>> information, because knowing the underlying file reads as zero still
>> decrypts into garbage)?
> 
> The zero flag means that the guest reads zeros, even with encrypted
> files. I'm not sure if it's worse than exposing the information which
> clusters are allocated and which are unallocated, which we have always
> been doing and which is hard to avoid without encrypting all the
> metadata, too. But it does reveal some information.
> 
> If we think that exposing zero flags is worse than exposing the
> allocation status, I would still not use your solution above. In that
> case, the full fix would be returning -ENOTSUP from
> .bdrv_co_pwrite_zeroes() to cover all other callers, too.

Indeed, it also makes me wonder if we should support 
truncate(BDRV_REQ_ZERO_WRITE|BDRV_REQ_NO_FALLBACK), to differentiate 
whether a truncation request is aiming more to be fast (NO_FALLBACK set, 
fail immediately with -ENOTSUP on encryption) or complete (NO_FALLBACK 
clear, go ahead and write guest-visible zeroes, which populates the 
format layer).  In other words, maybe we want a knob that the user can 
set on encrypted volumes on whether to allow zero flags in the qcow2 image.

> 
> If we think that allocation status and zero flags are of comparable
> importance, then we need to fix either both or nothing. Hiding all of
> this information probably means encrypting at least the L2 tables and
> potentially all of the metadata apart from the header. This would
> obviously require an incompatible feature flag (and some effort to
> implement it).

Indeed, my question is broad enough that it does not hold up _this_ 
series, so much as providing food for thought on what else we may need 
to add for encrypted qcow2 images as a future series, to make it easier 
to adjust the slider between the extremes of performance vs. minimal 
data leaks when using encryption.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


