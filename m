Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50598C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E166208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsM3K0n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E166208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvUL-0006Af-Ab
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBvTi-0005Xr-CH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBvTh-0002zy-AN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:08:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBvTh-0002zu-6P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583910508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9368dyM5HaeqtOch05Zmbcpy1rqScEOaBOvr0mRwwAQ=;
 b=RsM3K0n+daBQqpgBNRsqqtylaNZ18k7ebodfBKE/YOGAHEG0P+87vI27MW78DdZeSwJy1A
 BrOfKrXLXr+VEXOgGQ86iy5RQA0KwOchJLAy1f8k+Awr+Jj1im9TZlw6qzUrRwCzkkYF8W
 sJFW4GmHMaqwFz8cl6u5x/2RvA4BX0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-udjxVVM7Nwe0uwHSCtChFg-1; Wed, 11 Mar 2020 03:08:25 -0400
X-MC-Unique: udjxVVM7Nwe0uwHSCtChFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD134800D50;
 Wed, 11 Mar 2020 07:08:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB40A8F365;
 Wed, 11 Mar 2020 07:08:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A54811386A6; Wed, 11 Mar 2020 08:08:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
 <20200310101108.3377b878@x1.home>
 <467b2253-a065-91c3-5b0c-4f03ee236d0c@redhat.com>
 <20200310193624.402fdb18@x1.home>
Date: Wed, 11 Mar 2020 08:08:16 +0100
In-Reply-To: <20200310193624.402fdb18@x1.home> (Alex Williamson's message of
 "Tue, 10 Mar 2020 19:36:24 -0600")
Message-ID: <87ftefl673.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Williamson <alex.williamson@redhat.com> writes:

> On Wed, 11 Mar 2020 00:14:31 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
[...]
>> So from a memcpy() and range perspective, the patch looks OK. But
>> there's still a wart I dislike: we should never perform pointer
>> arithmetic on a (void*). I suggest casting (vdev->rom) to (uint8_t*) or
>> (unsigned char*) first.
>>=20
>> Here's an excerpt from the ISO C99 standard:
>>=20
>> -v-
>> 6.5.6 Additive operators
>>=20
>> Constraints
>>=20
>> 2 For addition, either both operands shall have arithmetic type, or one
>>   operand shall be a pointer to an object type and the other shall have
>>   integer type. [...]
>> -^-
>>=20
>> A "pointer-to-void" is not a "pointer to an object type", because "void"
>> is not an object type -- it is an incomplete type that cannot be complet=
ed:
>>=20
>> -v-
>> 6.2.5 Types
>>=20
>> 1 [...] Types are partitioned into object types (types that fully
>>   describe objects), function types (types that describe functions), and
>>   incomplete types (types that describe objects but lack information
>>   needed to determine their sizes).
>>=20
>> [...]
>>=20
>> 19 The void type comprises an empty set of values; it is an incomplete
>>    type that cannot be completed.
>> -^-
>>=20
>> For a different illustration, (vdev->rom + addr) is equivalent to
>> &(vdev->rom[addr]) -- and we clearly can't have an "array of void".
>>=20
>> This anti-pattern (of doing pointer arithmetic on (void*)) likely comes
>> from a guarantee that the standard does make, in the same "6.2.5 Types"
>> section:
>>=20
>> -v-
>> 27 A pointer to void shall have the same representation and alignment
>>    requirements as a pointer to a character type. 39) [...]
>>=20
>> Footnote 39: The same representation and alignment requirements are
>>              meant to imply interchangeability as arguments to
>>              functions, return values from functions, and members of
>>              unions.
>> -^-
>>=20
>> It does not extend to the "+" operator.
>
> GNU C specifically allows arithmetic on pointers and defines the size
> of a void as 1.  I'll comply, but this makes me want to stab myself in
> the face :-\  Thanks,

We rely on GNU C extensions all over theplace.  Making the code uglier
to avoid relying on this one here makes no sense to me.


