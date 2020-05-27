Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2FF20899
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJHUf0Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2FF20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdw6G-0000b7-T3
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdw5j-00005D-LK
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:27:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdw5i-0005Qd-GL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590586049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBlHYRr+2Dh8pEH404jcIq99PLQqY8QrTlAXqVTDhS8=;
 b=RJHUf0Y39xZrlTlXLqy8w19FlcJHJ5A/HApu7mNlYploDq2cjfX7hqJQh6aEXH1kPxdFYj
 UbjZAA+fclv3phdZB34eGx0COpHH+LkOjIuOvHRiy/BVeS9st7+rOBP51ek86xD8xdy5Gp
 9BratT4AhnixYiiu666JNbbEFp0hZl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-zVGhS5a3MQCqtzRdiYPJ-Q-1; Wed, 27 May 2020 09:27:25 -0400
X-MC-Unique: zVGhS5a3MQCqtzRdiYPJ-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB3B460;
 Wed, 27 May 2020 13:27:23 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0427A60C84;
 Wed, 27 May 2020 13:27:21 +0000 (UTC)
Subject: Re: [PATCH v7 14/32] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <961e6f3e3af13a25c666859b391b7ed147873d8b.1590429901.git.berto@igalia.com>
 <c423bd22-cfd3-48c6-1129-eb784017cb8a@redhat.com>
 <w51k10xk8nf.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ddd2085b-e8bb-932b-fbb4-5fbed6064132@redhat.com>
Date: Wed, 27 May 2020 08:27:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51k10xk8nf.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 4:51 AM, Alberto Garcia wrote:
> On Tue 26 May 2020 10:32:08 PM CEST, Eric Blake wrote:
>>> +/* The subcluster X [0..31] is allocated */
>>> +#define QCOW_OFLAG_SUB_ALLOC(X)   (1ULL << (X))
>>> +/* The subcluster X [0..31] reads as zeroes */
>>> +#define QCOW_OFLAG_SUB_ZERO(X)    (QCOW_OFLAG_SUB_ALLOC(X) << 32)
>>> +/* Subclusters [X, Y) (0 <= X <= Y <= 32) are allocated */
>>
>> As you are now using a half-open range, should this be:
>>    (0 <= X < Y <= 32)
> 
> I changed the macros because I wanted to allow cases where X == Y.
> 
> The reason is the new qcow2_get_subcluster_range_type() function:
> 
>      case QCOW2_SUBCLUSTER_NORMAL:
>          val = l2_bitmap | QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
>          return cto32(val) - sc_from;
> 
> If sc_from is 0 then the result of the macro is also 0, and 'val' equals
> the lower 32 bits (allocation status bits) of the L2 bitmap, as
> expected.
> 
>>> +#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
>>> +    (QCOW_OFLAG_SUB_ALLOC(Y) - QCOW_OFLAG_SUB_ALLOC(X))
>>
>> with <= instead of <, then it is impossible to distinguish between
>> QCOW_OFLAG_SUB_ALLOC_RANGE(0,0) and QCOW_OFLAG_SUB_ALLOC_RANGE(31,31)
>> which both resolve to 0.
> 
> Exactly, there is no difference and there should not be.

Okay, then with that explanation, I agree that the comment is correct as 
written.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


