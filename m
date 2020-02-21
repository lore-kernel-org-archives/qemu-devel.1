Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82586C35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5888E206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5888E206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54yG-0003Jq-JP
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j54wf-0001HD-9h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j54wd-0002Zm-Na
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:50:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:48104)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j54wd-0002WE-BF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:50:03 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8ADF3C0101;
 Fri, 21 Feb 2020 12:49:59 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 21 Feb 2020 12:49:59 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Race condition in overlayed qcow2?
In-Reply-To: <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
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

Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-20 12=
:36:
> 20.02.2020 12:05, Vladimir Sementsov-Ogievskiy wrote:
>> 20.02.2020 11:31, dovgaluk wrote:
>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-1=
9 19:07:
>>>> 19.02.2020 17:32, dovgaluk wrote:
>>>>> I encountered a problem with record/replay of QEMU execution and=20
>>>>> figured out the following, when
>>>>> QEMU is started with one virtual disk connected to the qcow2 image=20
>>>>> with applied 'snapshot' option.
>>>>>=20
>>>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2:=20
>>>>> introduce parallel subrequest handling in read and write"
>>>>> introduces some kind of race condition, which causes difference in=20
>>>>> the data read from the disk.
>>>>>=20
>>>>> I detected this by adding the following code, which logs IO=20
>>>>> operation checksum. And this checksum may be different in different=
=20
>>>>> runs of the same recorded execution.
>>>>>=20
>>>>> logging in blk_aio_complete function:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("%"PRId64=
": blk_aio_complete\n",=20
>>>>> replay_get_current_icount());
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov=
 =3D acb->rwco.iobuf;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qiov && qiov->=
iov) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t i, j;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t sum =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int count =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D 0 ; i < qiov->niov ; ++i) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j=
) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=3D ((uint8_t*)q=
iov->iov[i].iov_base)[j];
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 qemu_log("--- iobuf offset %"PRIx64" len %x sum:=20
>>>>> %"PRIx64"\n", acb->rwco.offset, count, sum);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>=20
>>>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
>>>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset,=20
>>>>> cur_bytes, qiov, qiov_offset);
>>>>>=20
>>>>> That change fixed a bug, but I have no idea what to debug next to=20
>>>>> figure out the exact reason of the failure.
>>>>>=20
>>>>> Do you have any ideas or hints?
>>>>>=20
>>>>=20
>>>> Hi!
>>>>=20
>>>> Hmm, do mean that read from the disk may return wrong data? It would
>>>> be very bad of course :(
>>>> Could you provide a reproducer, so that I can look at it and debug?
>>>=20
>>> It is just a winxp-32 image. I record the execution and replay it=20
>>> with the following command lines:
>>>=20
>>> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -m=
 512M=20
>>> -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive=20
>>> driver=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-dr=
iver=20
>>> -device ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -n=
et=20
>>> none
>>>=20
>>> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -m=
 512M=20
>>> -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive=20
>>> driver=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-dr=
iver=20
>>> -device ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -n=
et=20
>>> none
>>>=20
>>> Replay stalls at some moment due to the non-determinism of the=20
>>> execution (probably caused by the wrong data read).
>>=20
>> Hmm.. I tried it=C2=A0 (with x86_64 qemu and centos image). I waited f=
or=20
>> some time for a first command, than Ctrl+C it. After it replay.bin was=
=20
>> 4M. Than started the second command. It works, not failing, not=20
>> finishing. Is it bad? What is expected behavior and what is wrong?
>>=20
>>>=20
>>>> What is exactly the case? May be you have other parallel aio
>>>> operations to the same region?
>>>=20
>>> As far as I understand, all aio operations, initiated by IDE=20
>>> controller, are performed one-by-one.
>>> I don't see anything else in the logs.
>>>=20
>>>> Ideas to experiment:
>>>>=20
>>>> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
>>>=20
>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>=20
>>>> 2. understand what is the case in code: is it read from one or=20
>>>> several
>>>> clusters, is it aligned,
>>>> what is the type of clusters, is encryption in use, compression?
>>>=20
>>> There is no encryption and I thinks compression is not enabled too.
>>> Clusters are read from the temporary overlay:
>>>=20
>>> blk_aio_prwv
>>> blk_aio_read_entry
>>> bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 len:=
=20
>>> 1e00
>>> bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len:=20
>>> 1c200
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len:=20
>>> 1e000
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len:=20
>>> 1e000
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len:=20
>>> 1e000
>>>=20
>>>=20
>>>> 3. understand what kind of data corruption. What we read instead of
>>>> correct data? Just garbage, or may be zeroes, or what..
>>>=20
>>> Most bytes are the same, but some are different:
>>>=20
>>> < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
>>> < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
>>> < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
>>> < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
>>> < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>> ---
>>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
>>>> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
>>>> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
>>>> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
>>>> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>>=20
>>> That is strange. I could think, that it was caused by the bugs in
>>> deterministic CPU execution, but the first difference in logs
>>> occur in READ operation (I dump read/write buffers in=20
>>> blk_aio_complete).
>>>=20
>>=20
>> Aha, yes, looks strange.
>>=20
>> Then next steps:
>>=20
>> 1. Does problem hit into the same offset every time?
>> 2. Do we write to this region before this strange read?
>>=20
>> 2.1. If yes, we need to check that we read what we write.. You say you=
=20
>> dump buffers
>> in blk_aio_complete... I think it would be more reliable to dump at=20
>> start of
>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify=20
>> its buffers
>> during operation which would be strange but possible.
>>=20
>> 2.2 If not, hmm...
>>=20
>>=20
>=20
> Another idea to check: use blkverify

I added logging of file descriptor and discovered that different results=20
are obtained
when reading from the backing file.
And even more - replay runs of the same recording produce different=20
results.
Logs show that there is a preadv race, but I can't figure out the source=20
of the failure.

Log1:
preadv c 30467e00
preadv c 30960000
--- sum =3D a2e1e
bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
--- sum =3D 10cdee
bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=20
ee00

Log2:
preadv c 30467e00
--- sum =3D a2e1e
bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
preadv c 30960000
--- sum =3D f094f
bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=20
ee00


Checksum calculation was added to preadv in file-posix.c

Pavel Dovgalyuk

