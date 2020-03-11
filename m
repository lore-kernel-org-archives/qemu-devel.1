Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B95DC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6117420727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvB2/skF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6117420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzx1-0007KQ-I8
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBzwR-0006tQ-6L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBzwP-00027Y-N4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:54:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBzwP-000277-Jf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583927665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPr97CQr4JWiwPy6mmbExeNtkfVK7bLZjjhRnS+2AgE=;
 b=YvB2/skF/8Arvc5u4B3PxP5/U1x2vZg+yoy8b4smaIrYZe4ooI0cZK516sQfZlHF1FK/ZR
 vedFPJnCemQxdhKc02GQr1H8IurIXSoV/OV295SZ0IiGdn58U5TgMfrEOQdJyltg/3Xnrk
 efr2/se9aGE8ac9knXp7oGhTmf5hUCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-bVh_HDYTMVycRKBo3_uJbA-1; Wed, 11 Mar 2020 07:54:23 -0400
X-MC-Unique: bVh_HDYTMVycRKBo3_uJbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5DB107B118;
 Wed, 11 Mar 2020 11:54:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06DE88F37F;
 Wed, 11 Mar 2020 11:54:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D06211386A6; Wed, 11 Mar 2020 12:54:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
 <20200310101108.3377b878@x1.home>
 <467b2253-a065-91c3-5b0c-4f03ee236d0c@redhat.com>
 <20200310193624.402fdb18@x1.home>
 <30f4a52f-a572-8643-1801-95c9fd2cd8a8@redhat.com>
Date: Wed, 11 Mar 2020 12:54:13 +0100
In-Reply-To: <30f4a52f-a572-8643-1801-95c9fd2cd8a8@redhat.com> (Laszlo Ersek's
 message of "Wed, 11 Mar 2020 11:26:38 +0100")
Message-ID: <87o8t3ds4a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: mst@redhat.com, weifuqiang@huawei.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/11/20 02:36, Alex Williamson wrote:
>> On Wed, 11 Mar 2020 00:14:31 +0100
>> Laszlo Ersek <lersek@redhat.com> wrote:
>>=20
>>> On 03/10/20 17:11, Alex Williamson wrote:
>>>
>>>> commit 2088fc1e1f426b98e9ca4d7bcdbe53d886a18c37
>>>> Author: Alex Williamson <alex.williamson@redhat.com>
>>>> Date:   Tue Mar 10 10:04:36 2020 -0600
>>>>
>>>>     vfio/pci: Use defined memcpy() behavior
>>>>    =20
>>>>     vfio_rom_read() relies on memcpy() doing the logically correct thi=
ng,
>>>>     ie. safely copying zero bytes from a NULL pointer when rom_size is
>>>>     zero, rather than the spec definition, which is undefined when the
>>>>     source or target pointers are NULL.  Resolve this by wrapping the
>>>>     call in the condition expressed previously by the ternary.
>>>>    =20
>>>>     Additionally, we still use @val to fill data based on the provided
>>>>     @size regardless of mempcy(), so we should initialize @val rather
>>>>     than @data.
>>>>    =20
>>>>     Reported-by: Longpeng <longpeng2@huawei.com>
>>>>     Reported-by: Laszlo Ersek <lersek@redhat.com>
>>>>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 5e75a95129ac..b0799cdc28ad 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -859,16 +859,17 @@ static uint64_t vfio_rom_read(void *opaque, hwad=
dr addr, unsigned size)
>>>>          uint16_t word;
>>>>          uint32_t dword;
>>>>          uint64_t qword;
>>>> -    } val;
>>>> -    uint64_t data =3D 0;
>>>> +    } val =3D { 0 };
>>>> +    uint64_t data;
>>>> =20
>>>>      /* Load the ROM lazily when the guest tries to read it */
>>>>      if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
>>>>          vfio_pci_load_rom(vdev);
>>>>      }
>>>> =20
>>>> -    memcpy(&val, vdev->rom + addr,
>>>> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr)=
 : 0);
>>>> +    if (addr < vdev->rom_size) {
>>>> +        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - add=
r));
>>>> +    }
>>>> =20
>>>>      switch (size) {
>>>>      case 1: =20
>>>
>>> Regarding the pre-patch code:
>>>
>>> My understanding is that the memcpy() could be reached with a
>>> guest-originated "addr" even if "vdev->rom" was NULL. If that's the
>>> case, then the pre-patch code invokes undefined behavior regardless of
>>> memcpy(), because it performs pointer arithmetic on a null pointer (not
>>> to mention that the type of that pointer is (void *)....)
>>>
>>> Regarding the proposed change:
>>>
>>> (addr < vdev->rom_size) requires that "vdev->rom_size" be positive. In
>>> that case, I assume that
>>>
>>> - "vdev->rom" is not NULL, and
>>> -  MIN(size, vdev->rom_size - addr) bytes are "in range" for the object
>>> allocated at "vdev->rom".
>>>
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
>>> A "pointer-to-void" is not a "pointer to an object type", because "void=
"
>>> is not an object type -- it is an incomplete type that cannot be comple=
ted:
>>>
>>> -v-
>>> 6.2.5 Types
>>>
>>> 1 [...] Types are partitioned into object types (types that fully
>>>   describe objects), function types (types that describe functions), an=
d
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
>>=20
>> GNU C specifically allows arithmetic on pointers and defines the size
>> of a void as 1.  I'll comply, but this makes me want to stab myself in
>> the face :-\  Thanks,
>
> Sorry, I didn't want to annoy you. :)
>
> In fact I was about to mention, "I really don't understand why compilers
> don't yell upon seeing pointer-to-void arithmetic", but I got distracted
> and forgot about that thought. In retrospect, that may have been for the
> best! :)

You're looking for

'-Wpointer-arith'
     Warn about anything that depends on the "size of" a function type
     or of 'void'.  GNU C assigns these types a size of 1, for
     convenience in calculations with 'void *' pointers and pointers to
     functions.  In C++, warn also when an arithmetic operation involves
     'NULL'.  This warning is also enabled by '-Wpedantic'.


