Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ADAC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19312071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUv4pnWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19312071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBo64-0006PT-20
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jBo5H-0005X1-9v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jBo5F-000492-Mo
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:14:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jBo5F-0003zU-B0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583882084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jcfg5M3Im5/7BElIHp4Sfve98FyRc93y2WgtiPHPZGI=;
 b=HUv4pnWrMymyLsl4RPTQgAXMcHgIgJYwKgaQMzYh32QktWpE7SZrFFjML/2qXpN4INS0DN
 KVxGq2GhVGjdjqczbsW0gKCEezztRer2D7lGdvxjOAupaY3YZLU8WFm8MlPUBCwC2BIiSi
 P/wEXb2M7j+HIA1aT/knWhrAaowMJN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-uL-STIQDM7iaRypvbAi3EQ-1; Tue, 10 Mar 2020 19:14:40 -0400
X-MC-Unique: uL-STIQDM7iaRypvbAi3EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41FD0107ACC7;
 Tue, 10 Mar 2020 23:14:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE9F60BF4;
 Tue, 10 Mar 2020 23:14:31 +0000 (UTC)
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
To: Alex Williamson <alex.williamson@redhat.com>,
 "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
 <20200310101108.3377b878@x1.home>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <467b2253-a065-91c3-5b0c-4f03ee236d0c@redhat.com>
Date: Wed, 11 Mar 2020 00:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200310101108.3377b878@x1.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: weifuqiang@huawei.com, mst@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 arei.gonglei@huawei.com, huangzhichao@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 17:11, Alex Williamson wrote:

> commit 2088fc1e1f426b98e9ca4d7bcdbe53d886a18c37
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Tue Mar 10 10:04:36 2020 -0600
> 
>     vfio/pci: Use defined memcpy() behavior
>     
>     vfio_rom_read() relies on memcpy() doing the logically correct thing,
>     ie. safely copying zero bytes from a NULL pointer when rom_size is
>     zero, rather than the spec definition, which is undefined when the
>     source or target pointers are NULL.  Resolve this by wrapping the
>     call in the condition expressed previously by the ternary.
>     
>     Additionally, we still use @val to fill data based on the provided
>     @size regardless of mempcy(), so we should initialize @val rather
>     than @data.
>     
>     Reported-by: Longpeng <longpeng2@huawei.com>
>     Reported-by: Laszlo Ersek <lersek@redhat.com>
>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5e75a95129ac..b0799cdc28ad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -859,16 +859,17 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>          uint16_t word;
>          uint32_t dword;
>          uint64_t qword;
> -    } val;
> -    uint64_t data = 0;
> +    } val = { 0 };
> +    uint64_t data;
>  
>      /* Load the ROM lazily when the guest tries to read it */
>      if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
>          vfio_pci_load_rom(vdev);
>      }
>  
> -    memcpy(&val, vdev->rom + addr,
> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> +    if (addr < vdev->rom_size) {
> +        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - addr));
> +    }
>  
>      switch (size) {
>      case 1:

Regarding the pre-patch code:

My understanding is that the memcpy() could be reached with a
guest-originated "addr" even if "vdev->rom" was NULL. If that's the
case, then the pre-patch code invokes undefined behavior regardless of
memcpy(), because it performs pointer arithmetic on a null pointer (not
to mention that the type of that pointer is (void *)....)

Regarding the proposed change:

(addr < vdev->rom_size) requires that "vdev->rom_size" be positive. In
that case, I assume that

- "vdev->rom" is not NULL, and
-  MIN(size, vdev->rom_size - addr) bytes are "in range" for the object
allocated at "vdev->rom".

So from a memcpy() and range perspective, the patch looks OK. But
there's still a wart I dislike: we should never perform pointer
arithmetic on a (void*). I suggest casting (vdev->rom) to (uint8_t*) or
(unsigned char*) first.

Here's an excerpt from the ISO C99 standard:

-v-
6.5.6 Additive operators

Constraints

2 For addition, either both operands shall have arithmetic type, or one
  operand shall be a pointer to an object type and the other shall have
  integer type. [...]
-^-

A "pointer-to-void" is not a "pointer to an object type", because "void"
is not an object type -- it is an incomplete type that cannot be completed:

-v-
6.2.5 Types

1 [...] Types are partitioned into object types (types that fully
  describe objects), function types (types that describe functions), and
  incomplete types (types that describe objects but lack information
  needed to determine their sizes).

[...]

19 The void type comprises an empty set of values; it is an incomplete
   type that cannot be completed.
-^-

For a different illustration, (vdev->rom + addr) is equivalent to
&(vdev->rom[addr]) -- and we clearly can't have an "array of void".

This anti-pattern (of doing pointer arithmetic on (void*)) likely comes
from a guarantee that the standard does make, in the same "6.2.5 Types"
section:

-v-
27 A pointer to void shall have the same representation and alignment
   requirements as a pointer to a character type. 39) [...]

Footnote 39: The same representation and alignment requirements are
             meant to imply interchangeability as arguments to
             functions, return values from functions, and members of
             unions.
-^-

It does not extend to the "+" operator.

Thanks
Laszlo


