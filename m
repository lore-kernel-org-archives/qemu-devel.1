Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5008C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3342073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ex1XNthg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3342073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlwl-0003eB-RU
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnlw0-00037H-64
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:38:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnlvx-0000Bz-S0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592930284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhi0PS7n1ZRCPP2piOnp56xx3hnijdA9/z/AatAiLUk=;
 b=Ex1XNthgiXT9EC4R2f2QPOJRtcOocr9chStj84cg2OTk2AWf96nclLGtJ4n1WiFf8VPSsi
 KdSqd6c5LPDVIDuougZyKH/eYIwEJezPdhIQDF0KfgVR++YTmKPIPSFTPXHUqxeGYitJV4
 a9uvylqtKC/Nu7f4udy+uZ6zw/iKVhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-gUJhKWFkN5KGGh43RKDJvA-1; Tue, 23 Jun 2020 12:37:56 -0400
X-MC-Unique: gUJhKWFkN5KGGh43RKDJvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D348018AB;
 Tue, 23 Jun 2020 16:37:53 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 919DA11CC00;
 Tue, 23 Jun 2020 16:37:43 +0000 (UTC)
Subject: Re: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-6-vsementsov@virtuozzo.com>
 <w513686o0gq.fsf@maestria.local.igalia.com>
 <7b5f7192-9a03-da06-1583-039b671c1e81@redhat.com>
 <58dd9502-9356-3fa1-e37d-b9ce8b646b3b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <11646943-c9ee-04cb-3648-323740536291@redhat.com>
Date: Tue, 23 Jun 2020 11:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <58dd9502-9356-3fa1-e37d-b9ce8b646b3b@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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

On 6/23/20 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.05.2020 21:34, Eric Blake wrote:
>> On 5/11/20 12:17 PM, Alberto Garcia wrote:
>>> On Thu 30 Apr 2020 01:10:21 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>>      compute 'int tail' via % 'int alignment' - safe
>>>
>>>      tail = (offset + bytes) % alignment;
>>>
>>> both are int64_t, no chance of overflow here?
>>
>> Good question - I know several places check that offset+bytes does not 
>> overflow, but did not specifically audit if this one does.  Adding an 
>> assert() in this function may be easier than trying to prove all 
>> callers pass in safe values.
>>
> 
> Hm, it's preexisting, as int64_t + int may overflow as well. Strange, 
> but I don't see overflow check neither in blk_check_byte_request nor in 
> bdrv_check_byte_request. Only discard, which recently dropped call of 
> bdrv_check_byte_request() has this check.

In fact, iotest 197 (see commit 461743390) is an instance of testing for 
a bug where we overflowed INT_MAX due to rounding up to cluster size, 
even with a transaction request smaller than limits.

> 
> I can add a patch for overflow check in blk_check_byte_request and 
> bdrv_check_byte_request.. But what about alignment? There may be 
> requests, for which bytes + offset doesn't overflow, but do overflow 
> after aligning up. Refactor bdrv_pad_request() to return an error if we 
> can't pad request due to overflow?

The only cases where int64_t + int can overflow due to rounding up for 
alignment are when the file size is extremely close to 2^63 bytes 
already.  The easiest fix is to reject opening a file that reports a 
size that would overflow when rounded up to alignment (that is, if size 
 > INT64_MAX - alignment, we should refuse to proceed).  Such images 
will never occur for actual disk images (because that is really a LOT of 
storage), but are possible over things like NBD (in fact, nbdkit has 
intentionally made it easy to provoke boundary testing near 2^63 bytes, 
and is already aware that anything larger than 2^63-512 is problematic 
in qemu).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


