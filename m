Received: from eggs.gnu.org ([2001:4830:134:3::10]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caEOp-0002kf-Kv
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caEOm-0005nn-55
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:26:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:44545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caEOl-0005nj-Uk
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:26:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caEOi-0005fj-T0
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 04:25:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 12F342E8192
	for <qemu-devel@nongnu.org>; Sun,  5 Feb 2017 04:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Feb 2017 04:18:15 -0000
From: Launchpad Bug Tracker <1646610@bugs.launchpad.net>
Reply-To: Bug 1646610 <1646610@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161201202504.25700.658.malonedeb@wampee.canonical.com>
Message-Id: <20170205041815.20738.30432.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1646610] Re: "Assertion `!r->req.sg' failed."
 during live migration with VirtIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1646610

Title:
  "Assertion `!r->req.sg' failed." during live migration with VirtIO

Status in QEMU:
  Expired

Bug description:
  We've hit this issue twice so far, but don't have an obvious repro
  yet. It's pretty rare for us to hit it but I'm still trying so I can
  get a core and backtrace. The guest was Windows running a constant
  workload. We were using VirtIO SCSI drivers in both cases.

  In both cases we hit the assert here:

  hw/scsi/scsi-generic.c:

  static void scsi_generic_save_request(QEMUFile *f, SCSIRequest *req)
  {
      SCSIGenericReq *r =3D DO_UPCAST(SCSIGenericReq, req, req);

      qemu_put_sbe32s(f, &r->buflen);
      if (r->buflen && r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
  ***     assert(!r->req.sg);
          qemu_put_buffer(f, r->buf, r->req.cmd.xfer);
      }
  }

  From code inspection, it seems that this will always happen if
  scsi_req_enqueue_internal in hw/scsi/scsi-bus.c is ever invoked.

  static void scsi_req_enqueue_internal(SCSIRequest *req)
  {
      assert(!req->enqueued);
      scsi_req_ref(req);
      if (req->bus->info->get_sg_list) {
          req->sg =3D req->bus->info->get_sg_list(req);
      } else {
          req->sg =3D NULL;
      }
      req->enqueued =3D true;
      QTAILQ_INSERT_TAIL(&req->dev->requests, req, next);
  }

  req->bus->info->get_sg_list will return &req->qsgl for a virtio-scsi
  bus since it's a method stored on the SCSIBusInfo struct. I didn't see
  anything that would clear the req->sg if scsi_req_enqueue_internal is
  called at least once.

  I think this can only happen if scsi_dma_restart_bh in hw/scsi/scsi-
  bus.c is called. The only other location I see
  scsi_req_enqueue_internal is on the load side for the destination of a
  migration.

  static void scsi_dma_restart_bh(void *opaque)
  {
      SCSIDevice *s =3D opaque;
      SCSIRequest *req, *next;

      qemu_bh_delete(s->bh);
      s->bh =3D NULL;

      QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
          scsi_req_ref(req);
          if (req->retry) {
              req->retry =3D false;
              switch (req->cmd.mode) {
              case SCSI_XFER_FROM_DEV:
              case SCSI_XFER_TO_DEV:
                  scsi_req_continue(req);
                  break;
              case SCSI_XFER_NONE:
                  scsi_req_dequeue(req);
                  scsi_req_enqueue(req); // *** this calls scsi_req_enqueue=
_internal
                  break;
              }
          }
          scsi_req_unref(req);
      }
  }

  Finally when put_scsi_requests is called for migration, it seems like
  it will call both virtio_scsi_save_request (from
  bus->info->save_request) and scsi_generic_save_request (from
  req->ops->save_request) and trigger the assert.

  I searched for a bit, but didn't find anyone else reporting this. Has
  anyone else seen this? It seems to me like that assert should check
  that the sg list is empty instead of checking that it exists. Is this
  an appropriate assessment? Assuming I find a repro, I'll try to test
  this solution.

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1646610/+subscriptions
