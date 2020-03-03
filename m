Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB00C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E695D20863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E695D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j96ie-0003qr-1Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j96hy-0003MZ-3O
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j96hw-0003Bz-Io
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:31:33 -0500
Received: from mail.ispras.ru ([83.149.199.45]:32916)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j96hw-0003B6-6A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:31:32 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id 7B770C0110;
 Tue,  3 Mar 2020 15:31:29 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 03 Mar 2020 15:31:29 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] icount: make dma reads deterministic
In-Reply-To: <20200302161903.GF4965@linux.fritz.box>
References: <158315399043.847.4021939910752786131.stgit@pasha-Precision-3630-Tower>
 <20200302161903.GF4965@linux.fritz.box>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <a6067910aa1bb4eb512c50292734b566@ispras.ru>
X-Sender: dovgaluk@ispras.ru
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, jsnow@redhat.com,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-03-02 19:19:
> Am 02.03.2020 um 13:59 hat Pavel Dovgalyuk geschrieben:
>> Windows guest sometimes makes DMA requests with overlapping
>> target addresses. This leads to the following structure of iov for
>> the block driver:
>>=20
>> addr size1
>> addr size2
>> addr size3
>>=20
>> It means that three adjacent disk blocks should be read into the same
>> memory buffer. Windows does not expects anything from these bytes
>> (should it be data from the first block, or the last one, or some=20
>> mix),
>> but uses them somehow. It leads to non-determinism of the guest=20
>> execution,
>> because block driver does not preserve any order of reading.
>>=20
>> This situation was discusses in the mailing list at least twice:
>> https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
>> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html
>>=20
>> This patch makes such disk reads deterministic in icount mode.
>> It skips SG parts that were already affected by prior reads
>> within the same request. Parts that are non identical, but are just
>> overlapped, are trimmed.
>>=20
>> Examples for different SG part sequences:
>>=20
>> 1)
>> A1 1000
>> A1 1000
>> ->
>> A1 1000
>>=20
>> 2)
>> A1 1000
>> A2 1000
>> A1 1000
>> A3 1000
>> ->
>> Two requests with different offsets, because second A1/1000 should be=20
>> skipped.
>> A1 1000
>> A2 1000
>> --
>> A3 1000
>=20
> How is the "--" line represented in the code?
>=20
>> 3)
>> A1 800
>> A2 1000
>> A1 1000
>> ->
>> First 800 bytes of third SG are skipped.
>> A1 800
>> A2 1000
>> --
>> A1+800 800
>>=20
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>  dma-helpers.c |   57=20
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 53 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/dma-helpers.c b/dma-helpers.c
>> index e8a26e81e1..d71512f707 100644
>> --- a/dma-helpers.c
>> +++ b/dma-helpers.c
>> @@ -13,6 +13,7 @@
>>  #include "trace-root.h"
>>  #include "qemu/thread.h"
>>  #include "qemu/main-loop.h"
>> +#include "sysemu/cpus.h"
>>=20
>>  /* #define DEBUG_IOMMU */
>>=20
>> @@ -139,17 +140,65 @@ static void dma_blk_cb(void *opaque, int ret)
>>      dma_blk_unmap(dbs);
>>=20
>>      while (dbs->sg_cur_index < dbs->sg->nsg) {
>> +        bool skip =3D false;
>>          cur_addr =3D dbs->sg->sg[dbs->sg_cur_index].base +=20
>> dbs->sg_cur_byte;
>>          cur_len =3D dbs->sg->sg[dbs->sg_cur_index].len -=20
>> dbs->sg_cur_byte;
>> -        mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len,=20
>> dbs->dir);
>> -        if (!mem)
>> -            break;
>> -        qemu_iovec_add(&dbs->iov, mem, cur_len);
>> +
>> +        /*
>> +         * Make reads deterministic in icount mode.
>> +         * Windows sometimes issues disk read requests with
>> +         * overlapping SGs. It leads to non-determinism, because
>> +         * resulting buffer contents may be mixed from several
>> +         * sectors.
>> +         * This code crops SGs that were already read in this=20
>> request.
>> +         */
>=20
> Please make use of the full line length for the commit text, and add
> empty lines between paragraphs.

Ok

>=20
>> +        if (use_icount
>> +            && dbs->dir =3D=3D DMA_DIRECTION_FROM_DEVICE) {
>=20
> This fits in a single line.

Ok

>> +        }
>> +
>>          dbs->sg_cur_byte +=3D cur_len;
>>          if (dbs->sg_cur_byte =3D=3D dbs->sg->sg[dbs->sg_cur_index].le=
n) {
>>              dbs->sg_cur_byte =3D 0;
>>              ++dbs->sg_cur_index;
>>          }
>> +
>> +        /*
>> +         * All remaining SGs were skipped.
>> +         * This is not reschedule case, because we already
>> +         * performed the reads, and the last SGs were skipped.
>> +         */
>> +        if (dbs->sg_cur_index =3D=3D dbs->sg->nsg && dbs->iov.size =3D=
=3D 0)=20
>> {
>> +            dma_complete(dbs, ret);
>> +            return;
>> +        }
>>      }
>=20
> I think the concept of skipping SG list entries makes this patch
> relatively complex. Maybe one of these would work better:
>=20
> 1. Instead of skipping, add a temporary bounce buffer to the iovec.
>=20
> 2. Instead of skipping, just exit the loop and effectively split the
>    request in multiple parts (like you already do in one case). Then=20
> the
>    memory will still be written to twice, but deterministically so that
>    the later SG list entry always wins.
>=20
> I think 2. sounds quite attractive because you don't have to manage any
> additional state. You can even simplify the loop to use=20
> ranges_overlap()

Thanks for this idea. Please check the new version.
I didn't find how to check SG addresses without making the comparisons=20
too complex
and without storing extra data. Therefore I pass iov pointers directly=20
to ranges_overlap().


Pavel Dovgalyuk

