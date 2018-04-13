Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kf-0001Hi-51
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kd-0002Xz-4L
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:38164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f76kc-0002XX-Ut
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f76kb-0003om-SB
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D42EF2E80CB
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Apr 2018 21:41:03 -0000
From: Thomas Huth <1362635@bugs.launchpad.net>
Reply-To: Bug 1362635 <1362635@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140828141904.28233.58158.malonedeb@gac.canonical.com>
Message-Id: <152365566396.23899.9639815244312762190.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1362635] Re: bdrv_read co-routine re-entered
 recursively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing this ticket now, since it's not about upstream QEMU code.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1362635

Title:
  bdrv_read co-routine re-entered recursively

Status in QEMU:
  Invalid

Bug description:
  calling bdrv_read in a loop leads to the follwing situation:

  bs->drv->bdrv_aio_readv is called, and finally calls bdrv_co_io_em_comple=
te in other thread context.
  there is a possibility of calling bdrv_co_io_em_complete before calling q=
emu_coroutine_yield in bdrv_co_io_em. And qemu fails with "co-routine re-en=
tered recursively".

  static void bdrv_co_io_em_complete(void *opaque, int ret)
  {
      CoroutineIOCompletion *co =3D opaque;

      co->ret =3D ret;
      qemu_coroutine_enter(co->coroutine, NULL);
  }

  static int coroutine_fn bdrv_co_io_em(BlockDriverState *bs, int64_t secto=
r_num,
                                        int nb_sectors, QEMUIOVector *iov,
                                        bool is_write)
  {
      CoroutineIOCompletion co =3D {
          .coroutine =3D qemu_coroutine_self(),
      };
      BlockDriverAIOCB *acb;

      if (is_write) {
          acb =3D bs->drv->bdrv_aio_writev(bs, sector_num, iov, nb_sectors,
                                         bdrv_co_io_em_complete, &co);
      } else {
          acb =3D bs->drv->bdrv_aio_readv(bs, sector_num, iov, nb_sectors,
                                        bdrv_co_io_em_complete, &co);
      }

      trace_bdrv_co_io_em(bs, sector_num, nb_sectors, is_write, acb);
      if (!acb) {
          return -EIO;
      }
      qemu_coroutine_yield();

      return co.ret;
  }

  is it a bug, or may be I don't understand something?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1362635/+subscriptions
