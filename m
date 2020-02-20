Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8558C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A166624654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A166624654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ie3-00031U-R7
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4id9-0002Xo-Du
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4id3-0002Zr-US
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:00:27 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60586)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4id3-0002XQ-Hm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:00:21 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 13971C0101;
 Thu, 20 Feb 2020 13:00:19 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Vladimir Sementsov-Ogievskiy'" <vsementsov@virtuozzo.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
In-Reply-To: <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
Subject: RE: Race condition in overlayed qcow2?
Date: Thu, 20 Feb 2020 13:00:21 +0300
Message-ID: <003701d5e7d4$90bcc130$b2364390$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXnzOnZzP2FR0GjSVSMa/tr7Qq8fQABo6kg
Content-Language: ru
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

> From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
> 20.02.2020 11:31, dovgaluk wrote:
> > Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-19 19:07:
> >> 19.02.2020 17:32, dovgaluk wrote:
> >>> I encountered a problem with record/replay of QEMU execution and =
figured out the
> following, when
> >>> QEMU is started with one virtual disk connected to the qcow2 image =
with applied 'snapshot'
> option.
> >>>
> >>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: =
introduce parallel
> subrequest handling in read and write"
> >>> introduces some kind of race condition, which causes difference in =
the data read from the
> disk.
> >>>
> >>> I detected this by adding the following code, which logs IO =
operation checksum. And this
> checksum may be different in different runs of the same recorded =
execution.
> >>>
> >>> logging in blk_aio_complete function:
> >>>          qemu_log("%"PRId64": blk_aio_complete\n", =
replay_get_current_icount());
> >>>          QEMUIOVector *qiov =3D acb->rwco.iobuf;
> >>>          if (qiov && qiov->iov) {
> >>>              size_t i, j;
> >>>              uint64_t sum =3D 0;
> >>>              int count =3D 0;
> >>>              for (i =3D 0 ; i < qiov->niov ; ++i) {
> >>>                  for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) {
> >>>                      sum +=3D =
((uint8_t*)qiov->iov[i].iov_base)[j];
> >>>                      ++count;
> >>>                  }
> >>>              }
> >>>              qemu_log("--- iobuf offset %"PRIx64" len %x sum: =
%"PRIx64"\n", acb-
> >rwco.offset, count, sum);
> >>>          }
> >>>
> >>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
> >>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, =
cur_bytes, qiov, qiov_offset);
> >>>
> >>> That change fixed a bug, but I have no idea what to debug next to =
figure out the exact
> reason of the failure.
> >>>
> >>> Do you have any ideas or hints?
> >>>
> >>
> >> Hi!
> >>
> >> Hmm, do mean that read from the disk may return wrong data? It =
would
> >> be very bad of course :(
> >> Could you provide a reproducer, so that I can look at it and debug?
> >
> > It is just a winxp-32 image. I record the execution and replay it =
with the following command
> lines:
> >
> > qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin =
-m 512M -drive
> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive =
driver=3Dblkreplay,if=3Dnone,image=3Ddevice-
> 34-file,id=3Ddevice-34-driver -device =
ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net
> none
> >
> > qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin =
-m 512M -drive
> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive =
driver=3Dblkreplay,if=3Dnone,image=3Ddevice-
> 34-file,id=3Ddevice-34-driver -device =
ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net
> none
> >
> > Replay stalls at some moment due to the non-determinism of the =
execution (probably caused by
> the wrong data read).
>=20
> Hmm.. I tried it  (with x86_64 qemu and centos image). I waited for =
some time for a first
> command, than Ctrl+C it. After it replay.bin was 4M. Than started the =
second command. It
> works, not failing, not finishing. Is it bad? What is expected =
behavior and what is wrong?

The second command should finish. There is no replay introspection yet =
(in master), but you can
stop qemu with gdb and inspect replay_state.current_icount field. It =
should increase with every
virtual CPU instruction execution. If that counter has stopped, it means =
that replay hangs.

> >> What is exactly the case? May be you have other parallel aio
> >> operations to the same region?
> >
> > As far as I understand, all aio operations, initiated by IDE =
controller, are performed one-
> by-one.
> > I don't see anything else in the logs.
> >
> >> Ideas to experiment:
> >>
> >> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
> >
> > 1 or 2 are ok, and 4 or 8 lead to the failures.
> >
> >> 2. understand what is the case in code: is it read from one or =
several
> >> clusters, is it aligned,
> >> what is the type of clusters, is encryption in use, compression?
> >
> > There is no encryption and I thinks compression is not enabled too.
> > Clusters are read from the temporary overlay:
> >
> > blk_aio_prwv
> > blk_aio_read_entry
> > bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 =
len: 1e00
> > bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len: =
1c200
> > bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: =
1e000
> > bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: =
1e000
> > bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: =
1e000
> >
> >
> >> 3. understand what kind of data corruption. What we read instead of
> >> correct data? Just garbage, or may be zeroes, or what..
> >
> > Most bytes are the same, but some are different:
> >
> > < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
> > < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
> > < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
> > < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
> > < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
> > ---
> >> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
> >> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
> >> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
> >> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
> >> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
> >
> > That is strange. I could think, that it was caused by the bugs in
> > deterministic CPU execution, but the first difference in logs
> > occur in READ operation (I dump read/write buffers in =
blk_aio_complete).
> >
>=20
> Aha, yes, looks strange.
>=20
> Then next steps:
>=20
> 1. Does problem hit into the same offset every time?

Yes, almost the same offset, almost the same phase of the execution.

> 2. Do we write to this region before this strange read?

No.

> 2.1. If yes, we need to check that we read what we write.. You say you =
dump buffers
> in blk_aio_complete... I think it would be more reliable to dump at =
start of
> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify =
its buffers
> during operation which would be strange but possible.

I dumped every write in file-posix.c handle_aiocb_rw_linear and =
qemu_pwritev
and found no difference in executions.

> 2.2 If not, hmm...

Exactly.

Pavel Dovgalyuk


