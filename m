Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286F3206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD4nXzWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286F3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYlA-0000Jr-CX
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42730 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQYkM-0008Gt-Lx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:54:11 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQYkM-0004zw-BJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:54:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21499
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQYkL-0004v3-Qy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8VYH79oipZhKGruaeFhIL40GGcCXwcxdYwECT7PSo4=;
 b=BD4nXzWJiIWQmsiivM2vo+boCMiXZMrRhQPgt4XbRGmfGWAxEmjVAL2Uzt90LBHxeFKrf4
 OInwxAofNsnk7JhU/YGuB/i+j7Bd6Zi1waaeBGIQl4NP2Jv8+sToJ+AX6q6rpJUCtCBOT/
 GB48p4PKClproVaQKDkM1pXG5RHHNAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-rMFED9B3MSqq9xhmfSBiXw-1; Mon, 20 Apr 2020 11:54:03 -0400
X-MC-Unique: rMFED9B3MSqq9xhmfSBiXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF25685EE70;
 Mon, 20 Apr 2020 15:54:01 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AEE960C99;
 Mon, 20 Apr 2020 15:53:57 +0000 (UTC)
Subject: Re: [PATCH v4 5/9] raw-format: Support BDRV_REQ_ZERO_WRITE for
 truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-6-kwolf@redhat.com>
 <b30bde4c-1ac1-f7cf-0c1f-1e8f52c4c821@redhat.com>
 <20200420153217.GA29316@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7d313fb3-d2c4-54f8-fc03-4d471ee084fc@redhat.com>
Date: Mon, 20 Apr 2020 10:53:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420153217.GA29316@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Kevin Wolf wrote:

>>> @@ -445,6 +445,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>>>        bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
>>>            ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>>                bs->file->bs->supported_zero_flags);
>>> +    bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
>>
>> Shouldn't this be:
>>
>> bs->supported_truncate_flags = (bs->file->bs->supported_truncate_flags &
>>                                  BDRV_REQ_ZERO_WRITE);
>>
>> rather than unconditionally advertising something that the underlying layer
>> may lack?
> 
> Maybe that makes more sense, yes.

If nothing else, it is more consistent with what we are doing for 
supported_zero_flags.  I also argue that having a reference to the 
passthrough is easier to grep for, if we ever add new flags in the 
future.  That is, while keeping passthrough as opt-in rather than blind 
copying or blind assignment is slightly more code, it is easier to maintain.

> 
> I think in practice it wouldn't make a difference because the nested
> bdrv_co_truncate() would still fail rather than silently ignoring the
> flag. It would behave the same as filter drivers, which also recursively
> call bdrv_co_truncate() without checking the flag first (which is, of
> course, because I don't want to modify each filter driver).

Probably true, but consistency and ease of maintenance are better than 
proving action at a distance :)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


