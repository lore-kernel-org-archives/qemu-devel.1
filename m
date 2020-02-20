Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F5920659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F5920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4kK6-0001p2-G1
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4kJX-0001NL-6a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4kJV-0002fC-Rb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:48:18 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47328)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j4kJV-0002dE-FY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:48:17 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6F9ECC0101;
 Thu, 20 Feb 2020 14:48:14 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Vladimir Sementsov-Ogievskiy'" <vsementsov@virtuozzo.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <003701d5e7d4$90bcc130$b2364390$@ru>
 <ea13d572-4840-3e88-bc7f-d7c4351cc345@virtuozzo.com>
In-Reply-To: <ea13d572-4840-3e88-bc7f-d7c4351cc345@virtuozzo.com>
Subject: RE: Race condition in overlayed qcow2?
Date: Thu, 20 Feb 2020 14:48:17 +0300
Message-ID: <003b01d5e7e3$a466a340$ed33e9c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXn4KaJuZHxzQWTSM+9bXEI7rlI7wAAsFYg
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
> 20.02.2020 13:00, Pavel Dovgalyuk wrote:
> >> From: Vladimir Sementsov-Ogievskiy =
[mailto:vsementsov@virtuozzo.com]
> >> 20.02.2020 11:31, dovgaluk wrote:
> >>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-19 19:07:
> >>>> 19.02.2020 17:32, dovgaluk wrote:
> >>>>> I encountered a problem with record/replay of QEMU execution and =
figured out the
> >> following, when
> >>>>> QEMU is started with one virtual disk connected to the qcow2 =
image with applied
> 'snapshot'
> >> option.
> >>>>>
> >>>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: =
introduce parallel
> >> subrequest handling in read and write"
> >>>>> introduces some kind of race condition, which causes difference =
in the data read from
> the
> >> disk.
> >>>>>
> >>>>> I detected this by adding the following code, which logs IO =
operation checksum. And this
> >> checksum may be different in different runs of the same recorded =
execution.
> >>>>>
> >>>>> logging in blk_aio_complete function:
> >>>>>           qemu_log("%"PRId64": blk_aio_complete\n", =
replay_get_current_icount());
> >>>>>           QEMUIOVector *qiov =3D acb->rwco.iobuf;
> >>>>>           if (qiov && qiov->iov) {
> >>>>>               size_t i, j;
> >>>>>               uint64_t sum =3D 0;
> >>>>>               int count =3D 0;
> >>>>>               for (i =3D 0 ; i < qiov->niov ; ++i) {
> >>>>>                   for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) =
{
> >>>>>                       sum +=3D =
((uint8_t*)qiov->iov[i].iov_base)[j];
> >>>>>                       ++count;
> >>>>>                   }
> >>>>>               }
> >>>>>               qemu_log("--- iobuf offset %"PRIx64" len %x sum: =
%"PRIx64"\n", acb-
> >>> rwco.offset, count, sum);
> >>>>>           }
> >>>>>
> >>>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
> >>>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, =
cur_bytes, qiov,
> qiov_offset);
> >>>>>
> >>>>> That change fixed a bug, but I have no idea what to debug next =
to figure out the exact
> >> reason of the failure.
> >>>>>
> >>>>> Do you have any ideas or hints?
> >>>>>
> >>>>
> >>>> Hi!
> >>>>
> >>>> Hmm, do mean that read from the disk may return wrong data? It =
would
> >>>> be very bad of course :(
> >>>> Could you provide a reproducer, so that I can look at it and =
debug?
> >>>
> >>> It is just a winxp-32 image. I record the execution and replay it =
with the following
> command
> >> lines:
> >>>
> >>> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin =
-m 512M -drive
> >> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive
> driver=3Dblkreplay,if=3Dnone,image=3Ddevice-
> >> 34-file,id=3Ddevice-34-driver -device =
ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -
> net
> >> none
> >>>
> >>> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin =
-m 512M -drive
> >> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive
> driver=3Dblkreplay,if=3Dnone,image=3Ddevice-
> >> 34-file,id=3Ddevice-34-driver -device =
ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -
> net
> >> none
> >>>
> >>> Replay stalls at some moment due to the non-determinism of the =
execution (probably caused
> by
> >> the wrong data read).
> >>
> >> Hmm.. I tried it  (with x86_64 qemu and centos image). I waited for =
some time for a first
> >> command, than Ctrl+C it. After it replay.bin was 4M. Than started =
the second command. It
> >> works, not failing, not finishing. Is it bad? What is expected =
behavior and what is wrong?
> >
> > The second command should finish. There is no replay introspection =
yet (in master), but you
> can
> > stop qemu with gdb and inspect replay_state.current_icount field. It =
should increase with
> every
> > virtual CPU instruction execution. If that counter has stopped, it =
means that replay hangs.
>=20
> It hangs for me even with QCOW2_MAX_WORKERS =3D 1..


There could be some other bugs in record/replay.
To be sure try winxp on i386.

Pavel Dovgalyuk


