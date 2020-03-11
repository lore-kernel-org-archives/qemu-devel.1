Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B314C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677E1208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiKOS9dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677E1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByc6-0002BZ-KB
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jBybO-0001GB-II
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jBybN-0007U8-FU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jBybN-0007S8-As
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583922516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2S5VJ+RL4XJdcI53+rEm7DxRB2qefde3EfrftPQU/A=;
 b=iiKOS9dvnoIASTZaM2/dEKdA8lR4gbtYVhvAnBi9rUnYvfG5OoeJTZAGtTKvQMFYQf//w8
 aAOlosneWgFkCRG2yF1/8zpkvuUXcoCIDnDoA6Gb4N42nE7JKVSXitrntLK/2SwbsrnlD6
 cjaoZ1h403X9qDj1eUsetAV8riRdtsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ZSlL3y_kMsyqrcdLJLFG-Q-1; Wed, 11 Mar 2020 06:28:35 -0400
X-MC-Unique: ZSlL3y_kMsyqrcdLJLFG-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F21B21005509;
 Wed, 11 Mar 2020 10:28:33 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.119.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 326E160304;
 Wed, 11 Mar 2020 10:28:27 +0000 (UTC)
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
To: Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
 <20200310101108.3377b878@x1.home>
 <467b2253-a065-91c3-5b0c-4f03ee236d0c@redhat.com>
 <20200310193624.402fdb18@x1.home> <87ftefl673.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <126f7a20-bd78-fd9c-579f-91b850c99b4f@redhat.com>
Date: Wed, 11 Mar 2020 11:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87ftefl673.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mst@redhat.com, weifuqiang@huawei.com, qemu-devel@nongnu.org,
 arei.gonglei@huawei.com, huangzhichao@huawei.com, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 08:08, Markus Armbruster wrote:
> Alex Williamson <alex.williamson@redhat.com> writes:
> 
>> On Wed, 11 Mar 2020 00:14:31 +0100
>> Laszlo Ersek <lersek@redhat.com> wrote:
> [...]
>>> So from a memcpy() and range perspective, the patch looks OK. But
>>> there's still a wart I dislike: we should never perform pointer
>>> arithmetic on a (void*). I suggest casting (vdev->rom) to (uint8_t*) or
>>> (unsigned char*) first.
>>>
>>> Here's an excerpt from the ISO C99 standard:
>>>
>>> -v-
>>> 6.5.6 Additive operators
>>>
>>> Constraints
>>>
>>> 2 For addition, either both operands shall have arithmetic type, or one
>>>   operand shall be a pointer to an object type and the other shall have
>>>   integer type. [...]
>>> -^-
>>>
>>> A "pointer-to-void" is not a "pointer to an object type", because "void"
>>> is not an object type -- it is an incomplete type that cannot be completed:
>>>
>>> -v-
>>> 6.2.5 Types
>>>
>>> 1 [...] Types are partitioned into object types (types that fully
>>>   describe objects), function types (types that describe functions), and
>>>   incomplete types (types that describe objects but lack information
>>>   needed to determine their sizes).
>>>
>>> [...]
>>>
>>> 19 The void type comprises an empty set of values; it is an incomplete
>>>    type that cannot be completed.
>>> -^-
>>>
>>> For a different illustration, (vdev->rom + addr) is equivalent to
>>> &(vdev->rom[addr]) -- and we clearly can't have an "array of void".
>>>
>>> This anti-pattern (of doing pointer arithmetic on (void*)) likely comes
>>> from a guarantee that the standard does make, in the same "6.2.5 Types"
>>> section:
>>>
>>> -v-
>>> 27 A pointer to void shall have the same representation and alignment
>>>    requirements as a pointer to a character type. 39) [...]
>>>
>>> Footnote 39: The same representation and alignment requirements are
>>>              meant to imply interchangeability as arguments to
>>>              functions, return values from functions, and members of
>>>              unions.
>>> -^-
>>>
>>> It does not extend to the "+" operator.
>>
>> GNU C specifically allows arithmetic on pointers and defines the size
>> of a void as 1.  I'll comply, but this makes me want to stab myself in
>> the face :-\  Thanks,
> 
> We rely on GNU C extensions all over theplace.  Making the code uglier
> to avoid relying on this one here makes no sense to me.
> 

I agree, in fact. If GNU-isms are liberally used & tolerated in the QEMU
source, then there's no reason to diverge from that here. I steer clear
of GNU-isms as much as I can, regardless of codebase, but I *did* forget
that QEMU permits GNU-isms -- so there's no need for my pedantry here.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


