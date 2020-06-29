Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E03C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063C325584
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOVGDl9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063C325584
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwJT-0007Y8-8t
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwF2-0003Iy-GC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:02:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwEy-00006d-PM
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgnWzIplglTMmsrRpF0Pu+Pu7Lafz3+3ZP18OW9i2RE=;
 b=QOVGDl9S9phzhKfysPqBqnQL6Vs8tKuKpLYq2jo8GnbOrziyeKK6CCn9DiOlH4CtTcJjDC
 HKwsR06S2xlFHyL6OmZ3gA+ZlrwFjlyI6xG2LhY+ZsVq0+xMo1YtWLbU7DC4k21MLlSnsP
 lNdnbeMQ7n9Xjh+9BshpLr6qP6bDARU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-RKFfgpavOuG-qceDpXWrlA-1; Mon, 29 Jun 2020 12:02:11 -0400
X-MC-Unique: RKFfgpavOuG-qceDpXWrlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2DA18015FD;
 Mon, 29 Jun 2020 16:02:10 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9017B70915;
 Mon, 29 Jun 2020 16:02:04 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
To: Stefan Hajnoczi <stefanha@gmail.com>, Lin Ma <LMa@suse.com>
References: <AM6PR04MB578290CA80CC6000756C4C0EC5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
 <20200629103948.GF31392@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <556bd179-71b5-cbe7-1d8b-eff20e70a7c0@redhat.com>
Date: Mon, 29 Jun 2020 11:02:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629103948.GF31392@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 5:39 AM, Stefan Hajnoczi wrote:

>>> SCSI defines 3 values and QEMU can represent all of them:
>>>
>>> 0 - mapped or unknown
>>> 1 - deallocated
>>> 2 - anchored
>>>
>>> See the BDRV_BLOCK_* constants in include/block/block.h. The
>>> is_deallocated boolean is not enough to represent this state, but the
>>> bdrv_block_status() return value can be used instead.
>>
>> I don't know which one in BDRV_BLOCK_* can be used to represent 'anchored'.
>> It seems that I need to use BDRV_BLOCK_* combination to recognized 'anchored',
>>
>> I'd like to use these combinations to analyze the bdrv_block_status() return value:
>> 'deallocated': BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ZERO
>> 'anchored':    BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | ! BDRV_BLOCK_ZERO | ! BDRV_BLOCK_DATA
>> Am I right?
> 
> My understanding is that the SCSI status are mapped to QEMU block status
> as follows:
> 
> allocated: BDRV_BLOCK_DATA | !BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID

I haven't read the scsi code, but as written, I would assume that any 
portion of the block status with this result has the following properties:
- reading sees guest-visible data; we cannot guarantee whether it is all 
zero, and the data reserves actual space

> anchored: BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID

- reading sees all zeros, but the disk has reserved actual space such 
that future writes will not run out of space

> deallocated: !BDRV_BLOCK_DATA

- reading does not see data; future writes will have to reserve space. 
I would expect this option might also have '| BDRV_BLOCK_ZERO' depending 
on whether this particular scsi device guarantees that reads of an 
unallocated portion see all zeros instead of unspecified garbage.

> 
> I have CCed Eric Blake, who is familiar with block status.

Adding Vladimir in CC as well, as he has pending patches that try to 
clear up the use of BDRV_BLOCK_* constants with regards to two different 
queries:
- allocation implies that data comes from this layer of a backing chain, 
rather than deferring to a backing image
- allocation implies that storage is reserved (that is, not sparse)

It sounds like we are trying to represent the second question for scsi 
(namely, the same question that gets answered by lseek(SEEK_HOLE) for 
POSIX files), and not the first (namely, the question answered for qcow2 
images).


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


