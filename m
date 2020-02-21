Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B3EC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03B24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j57XU-0002kW-Q9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j57Wf-00028m-5P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j57Wd-0001Nc-RI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:35:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44534)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j57Wd-0001Hw-EI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:35:23 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3682EC0101;
 Fri, 21 Feb 2020 15:35:21 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 21 Feb 2020 15:35:21 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Race condition in overlayed qcow2?
In-Reply-To: <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 13=
:09:
> 21.02.2020 12:49, dovgaluk wrote:
>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-20=
 12:36:
>>>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>>>=20
>>>>>=20
>>>>> That is strange. I could think, that it was caused by the bugs in
>>>>> deterministic CPU execution, but the first difference in logs
>>>>> occur in READ operation (I dump read/write buffers in=20
>>>>> blk_aio_complete).
>>>>>=20
>>>>=20
>>>> Aha, yes, looks strange.
>>>>=20
>>>> Then next steps:
>>>>=20
>>>> 1. Does problem hit into the same offset every time?
>>>> 2. Do we write to this region before this strange read?
>>>>=20
>>>> 2.1. If yes, we need to check that we read what we write.. You say=20
>>>> you dump buffers
>>>> in blk_aio_complete... I think it would be more reliable to dump at=20
>>>> start of
>>>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify=
=20
>>>> its buffers
>>>> during operation which would be strange but possible.
>>>>=20
>>>> 2.2 If not, hmm...
>>>>=20
>>>>=20
>>>=20
>>> Another idea to check: use blkverify
>>=20
>> I added logging of file descriptor and discovered that different=20
>> results are obtained
>> when reading from the backing file.
>> And even more - replay runs of the same recording produce different=20
>> results.
>> Logs show that there is a preadv race, but I can't figure out the=20
>> source of the failure.
>>=20
>> Log1:
>> preadv c 30467e00
>> preadv c 30960000
>> --- sum =3D a2e1e
>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
>> --- sum =3D 10cdee
>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=20
>> ee00
>>=20
>> Log2:
>> preadv c 30467e00
>> --- sum =3D a2e1e
>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
>> preadv c 30960000
>> --- sum =3D f094f
>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=20
>> ee00
>>=20
>>=20
>> Checksum calculation was added to preadv in file-posix.c
>>=20
>=20
> So, preadv in file-posix.c returns different results for the same
> offset, for file which is always opened in RO mode? Sounds impossible
> :)

True.
Maybe my logging is wrong?

static ssize_t
qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
{
     ssize_t res =3D preadv(fd, iov, nr_iov, offset);
     qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_t)offset);
     int i;
     uint32_t sum =3D 0;
     int cnt =3D 0;
     for (i =3D 0 ; i < nr_iov ; ++i) {
         int j;
         for (j =3D 0 ; j < (int)iov[i].iov_len ; ++j)
         {
             sum +=3D ((uint8_t*)iov[i].iov_base)[j];
             ++cnt;
         }
     }
     qemu_log("size: %x sum: %x\n", cnt, sum);
     assert(cnt =3D=3D res);
     return res;
}

This code prints preadv checksum.
But when I calculate the same with the standalone program, then it gives=20
me another values of the checksums for the same offsets:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/uio.h>

unsigned char buf[0x100000];

int main(int argc, char **argv)
{
   if (argc < 4) return 1;
   int f =3D open(argv[1], O_RDONLY);
   unsigned int cnt;
   unsigned int offs;
   sscanf(argv[2], "%x", &offs);
   sscanf(argv[3], "%x", &cnt);
   printf("file: %s offset: %x size: %x\n", argv[1], offs, cnt);
   struct iovec iov =3D {buf, (size_t)cnt};
   size_t sz =3D preadv(f, &iov, 1, offs);
   printf("read %x\n", (int)sz);
   int i;
   unsigned int sum =3D 0;
   for (i =3D 0 ; i < cnt ; ++i)
     sum +=3D buf[i];
   printf("sum =3D %x\n", sum);
}



Pavel Dovgalyuk

