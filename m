Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA27C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7849F20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC9Gr3Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7849F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6f6-0001cW-14
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg6b4-0004gI-Vp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:04:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg6b1-0005Xc-Mj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591103085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EXl0t22NJQipVdUc/QAaUU+ljAnCzfZ28ks/mzgoy4c=;
 b=YC9Gr3WoZd1F7YIuS99KM2HlcaLPRmnDgM3azJAF0p5297B8HdGrNnx8iXbhc8bctNM30I
 yAAoCiHSWQJYhCjM75vrmyUcIgrMd0OihANT+xYe6hKvEmaLzTv8dcfK3+bKfyKzeTs7Ac
 ou4aaIDMG+Nl0gfwuU5OzpxEqph1YLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-1W0IGln7MG2AK4SUhqYcXA-1; Tue, 02 Jun 2020 09:04:43 -0400
X-MC-Unique: 1W0IGln7MG2AK4SUhqYcXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125D6107ACCD;
 Tue,  2 Jun 2020 13:04:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5C9A78EF5;
 Tue,  2 Jun 2020 13:04:35 +0000 (UTC)
Date: Tue, 2 Jun 2020 15:04:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH] virtio-blk: Disable request queuing while switching
 contexts
Message-ID: <20200602130433.GH5940@linux.fritz.box>
References: <20200602081112.32426-1-slp@redhat.com>
 <20200602112314.GF5940@linux.fritz.box>
 <20200602121835.kfld5taju25p6njn@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200602121835.kfld5taju25p6njn@dritchie>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.06.2020 um 14:18 hat Sergio Lopez geschrieben:
> On Tue, Jun 02, 2020 at 01:23:14PM +0200, Kevin Wolf wrote:
> > Am 02.06.2020 um 10:11 hat Sergio Lopez geschrieben:
> > > Disable request queuing while switching contexts on
> > > virtio_blk_data_plane_[start|stop](), preventing requests from gettin=
g
> > > queued on the wrong context.
> > >
> > > Placing requests on the wrong context may lead to them being wrongly
> > > accessed in parallel from different threads, potentially leading to
> > > multiple issues.
> > >
> > > For example, stopping and resuming a VM multiple times while the gues=
t
> > > is generating I/O on a virtio_blk device can trigger a crash with a
> > > stack tracing looking like this one:
> > >
> > > <------>
> > >  Thread 2 (Thread 0x7ff736765700 (LWP 1062503)):
> > >  #0  0x00005567a13b99d6 in iov_memset
> > >      (iov=3D0x6563617073206f4e, iov_cnt=3D1717922848, offset=3D516096=
, fillc=3D0, bytes=3D7018105756081554803)
> > >      at util/iov.c:69
> > >  #1  0x00005567a13bab73 in qemu_iovec_memset
> > >      (qiov=3D0x7ff73ec99748, offset=3D516096, fillc=3D0, bytes=3D7018=
105756081554803) at util/iov.c:530
> > >  #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=3D0x7=
ff6512ee6c0) at block/linux-aio.c:86
> > >  #3  0x00005567a12f42ff in qemu_laio_process_completions (s=3D0x7ff71=
82e8420) at block/linux-aio.c:217
> > >  #4  0x00005567a12f480d in ioq_submit (s=3D0x7ff7182e8420) at block/l=
inux-aio.c:323
> > >  #5  0x00005567a12f43d9 in qemu_laio_process_completions_and_submit (=
s=3D0x7ff7182e8420)
> > >      at block/linux-aio.c:236
> > >  #6  0x00005567a12f44c2 in qemu_laio_poll_cb (opaque=3D0x7ff7182e8430=
) at block/linux-aio.c:267
> > >  #7  0x00005567a13aed83 in run_poll_handlers_once (ctx=3D0x5567a2b58c=
70, timeout=3D0x7ff7367645f8)
> > >      at util/aio-posix.c:520
> > >  #8  0x00005567a13aee9f in run_poll_handlers (ctx=3D0x5567a2b58c70, m=
ax_ns=3D16000, timeout=3D0x7ff7367645f8)
> > >      at util/aio-posix.c:562
> > >  #9  0x00005567a13aefde in try_poll_mode (ctx=3D0x5567a2b58c70, timeo=
ut=3D0x7ff7367645f8)
> > >      at util/aio-posix.c:597
> > >  #10 0x00005567a13af115 in aio_poll (ctx=3D0x5567a2b58c70, blocking=
=3Dtrue) at util/aio-posix.c:639
> > >  #11 0x00005567a109acca in iothread_run (opaque=3D0x5567a2b29760) at =
iothread.c:75
> > >  #12 0x00005567a13b2790 in qemu_thread_start (args=3D0x5567a2b694c0) =
at util/qemu-thread-posix.c:519
> > >  #13 0x00007ff73eedf2de in start_thread () at /lib64/libpthread.so.0
> > >  #14 0x00007ff73ec10e83 in clone () at /lib64/libc.so.6
> > >
> > >  Thread 1 (Thread 0x7ff743986f00 (LWP 1062500)):
> > >  #0  0x00005567a13b99d6 in iov_memset
> > >      (iov=3D0x6563617073206f4e, iov_cnt=3D1717922848, offset=3D516096=
, fillc=3D0, bytes=3D7018105756081554803)
> > >      at util/iov.c:69
> > >  #1  0x00005567a13bab73 in qemu_iovec_memset
> > >      (qiov=3D0x7ff73ec99748, offset=3D516096, fillc=3D0, bytes=3D7018=
105756081554803) at util/iov.c:530
> > >  #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=3D0x7=
ff6512ee6c0) at block/linux-aio.c:86
> > >  #3  0x00005567a12f42ff in qemu_laio_process_completions (s=3D0x7ff71=
82e8420) at block/linux-aio.c:217
> > >  #4  0x00005567a12f480d in ioq_submit (s=3D0x7ff7182e8420) at block/l=
inux-aio.c:323
> > >  #5  0x00005567a12f4a2f in laio_do_submit (fd=3D19, laiocb=3D0x7ff5f4=
ff9ae0, offset=3D472363008, type=3D2)
> > >      at block/linux-aio.c:375
> > >  #6  0x00005567a12f4af2 in laio_co_submit
> > >      (bs=3D0x5567a2b8c460, s=3D0x7ff7182e8420, fd=3D19, offset=3D4723=
63008, qiov=3D0x7ff5f4ff9ca0, type=3D2)
> > >      at block/linux-aio.c:394
> > >  #7  0x00005567a12f1803 in raw_co_prw
> > >      (bs=3D0x5567a2b8c460, offset=3D472363008, bytes=3D20480, qiov=3D=
0x7ff5f4ff9ca0, type=3D2)
> > >      at block/file-posix.c:1892
> > >  #8  0x00005567a12f1941 in raw_co_pwritev
> > >      (bs=3D0x5567a2b8c460, offset=3D472363008, bytes=3D20480, qiov=3D=
0x7ff5f4ff9ca0, flags=3D0)
> > >      at block/file-posix.c:1925
> > >  #9  0x00005567a12fe3e1 in bdrv_driver_pwritev
> > >      (bs=3D0x5567a2b8c460, offset=3D472363008, bytes=3D20480, qiov=3D=
0x7ff5f4ff9ca0, qiov_offset=3D0, flags=3D0)
> > >      at block/io.c:1183
> > >  #10 0x00005567a1300340 in bdrv_aligned_pwritev
> > >      (child=3D0x5567a2b5b070, req=3D0x7ff5f4ff9db0, offset=3D47236300=
8, bytes=3D20480, align=3D512, qiov=3D0x7ff72c0425b8, qiov_offset=3D0, flag=
s=3D0) at block/io.c:1980
> > >  #11 0x00005567a1300b29 in bdrv_co_pwritev_part
> > >      (child=3D0x5567a2b5b070, offset=3D472363008, bytes=3D20480, qiov=
=3D0x7ff72c0425b8, qiov_offset=3D0, flags=3D0)
> > >      at block/io.c:2137
> > >  #12 0x00005567a12baba1 in qcow2_co_pwritev_task
> > >      (bs=3D0x5567a2b92740, file_cluster_offset=3D472317952, offset=3D=
487305216, bytes=3D20480, qiov=3D0x7ff72c0425b8, qiov_offset=3D0, l2meta=3D=
0x0) at block/qcow2.c:2444
> > >  #13 0x00005567a12bacdb in qcow2_co_pwritev_task_entry (task=3D0x5567=
a2b48540) at block/qcow2.c:2475
> > >  #14 0x00005567a13167d8 in aio_task_co (opaque=3D0x5567a2b48540) at b=
lock/aio_task.c:45
> > >  #15 0x00005567a13cf00c in coroutine_trampoline (i0=3D738245600, i1=
=3D32759) at util/coroutine-ucontext.c:115
> > >  #16 0x00007ff73eb622e0 in __start_context () at /lib64/libc.so.6
> > >  #17 0x00007ff6626f1350 in  ()
> > >  #18 0x0000000000000000 in  ()
> > > <------>
> > >
> > > This is also known to cause crashes with this message (assertion
> > > failed):
> > >
> > >  aio_co_schedule: Co-routine was already scheduled in 'aio_co_schedul=
e'
> > >
> > > RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1812765
> > > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > > ---
> > >  hw/block/dataplane/virtio-blk.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/vir=
tio-blk.c
> > > index 1b52e8159c..f1c7ba69c0 100644
> > > --- a/hw/block/dataplane/virtio-blk.c
> > > +++ b/hw/block/dataplane/virtio-blk.c
> > > @@ -214,12 +214,17 @@ int virtio_blk_data_plane_start(VirtIODevice *v=
dev)
> > >      vblk->dataplane_started =3D true;
> > >      trace_virtio_blk_data_plane_start(s);
> > >
> > > +    /* Prevent requests from getting queued on the old context */
> > > +    blk_set_disable_request_queuing(s->conf->conf.blk, true);
> > > +
> > >      r =3D blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err)=
;
> > >      if (r < 0) {
> > >          error_report_err(local_err);
> > >          goto fail_guest_notifiers;
> > >      }
> > >
> > > +    blk_set_disable_request_queuing(s->conf->conf.blk, false);
> > > +
> >
> > Why are we even getting new requests that could possibly be queued? Thi=
s
> > is in virtio_blk_data_plane_start/stop(), so clearly the device should
> > be idle and the virtio queues shouldn't be processed at all at the same
> > time?
>=20
> Requests are processed and queued by virtio_blk_dma_restart_bh(),
> which is a BH registered by virtio_blk_dma_restart_cb(), which in turn
> is a callback for VM state change events registered with
> qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s).
>=20
> This is the back trace of a request being queued this way:
>=20
> (gdb) bt
> #0  0x000055cd35ce7490 in virtio_blk_submit_multireq (blk=3D0x55cd38cd24d=
0, mrb=3D0x7ffd25b365c0)
>     at /root/src/qemu/hw/block/virtio-blk.c:448
> #1  0x000055cd35ce7d5f in virtio_blk_handle_request (req=3D0x7f5a4c022c80=
, mrb=3D0x7ffd25b365c0)
>     at /root/src/qemu/hw/block/virtio-blk.c:686
> #2  0x000055cd35ce8602 in virtio_blk_dma_restart_bh (opaque=3D0x55cd38ccf=
4c0)
>     at /root/src/qemu/hw/block/virtio-blk.c:836
> #3  0x000055cd360dc4f5 in aio_bh_call (bh=3D0x55cd3880b300) at /root/src/=
qemu/util/async.c:164
> #4  0x000055cd360dc4f5 in aio_bh_poll (ctx=3Dctx@entry=3D0x55cd3780bff0) =
at /root/src/qemu/util/async.c:164
> #5  0x000055cd360dfd29 in aio_poll (ctx=3Dctx@entry=3D0x55cd3780bff0, blo=
cking=3Dblocking@entry=3Dtrue)
>     at /root/src/qemu/util/aio-posix.c:650
> #6  0x000055cd3603a645 in bdrv_do_drained_begin
>     (poll=3Dtrue, ignore_bds_parents=3Dfalse, parent=3D0x0, recursive=3Df=
alse, bs=3D0x55cd3788d550)
>     at /root/src/qemu/block/io.c:429
> #7  0x000055cd3603a645 in bdrv_do_drained_begin
>     (bs=3D0x55cd3788d550, recursive=3D<optimized out>, parent=3D0x0, igno=
re_bds_parents=3D<optimized out>, poll=3D<optimized out>) at /root/src/qemu=
/block/io.c:395
> #8  0x000055cd35fde969 in bdrv_set_aio_context_ignore
>     (bs=3Dbs@entry=3D0x55cd3788d550, new_context=3Dnew_context@entry=3D0x=
55cd37810e40, ignore=3Dignore@entry=3D0x7ffd25b36890) at /root/src/qemu/blo=
ck.c:6309
> #9  0x000055cd35fdef33 in bdrv_child_try_set_aio_context
>     (bs=3Dbs@entry=3D0x55cd3788d550, ctx=3D0x55cd37810e40, ignore_child=
=3D<optimized out>, errp=3D<optimized out>)
>     at /root/src/qemu/block.c:6431
> #10 0x000055cd3602919b in blk_do_set_aio_context
>     (blk=3D0x55cd38cd24d0, new_context=3D0x55cd37810e40, update_root_node=
=3D<optimized out>, errp=3D<optimized out>) at /root/src/qemu/block/block-b=
ackend.c:2016
> #11 0x000055cd35cef54f in virtio_blk_data_plane_start (vdev=3D<optimized =
out>)
>     at /root/src/qemu/hw/block/dataplane/virtio-blk.c:220

Ugh. Thanks, I see now what's going on.

We were relying on blk_set_aio_context() to complete the requests, and
since BlockBackend queues the requests instead of completing them during
drained_begin, we end up executing the requests after drained_end in the
main loop context, but the block nodes have meanwhile moved to the
iothread context.

Of course, this was already a bad hack before, witnessed by the FIXME
comment in virtio_blk_dma_restart_cb().

> I'm not familiar with the code, but I guess we need this BH to ensure
> we process the virtqueue after resuming.

The BH was introduced in commit 213189ab65d. The commit message has a
very detailed problem description, but to summarise, if I understand
correctly, the main purpose is that we don't end up stopping the VM due
to an I/O error while we are only in the middle of sending VM state
handlers events that the VM is about to be continued.

> We could perhaps schedule the BH in a different way, or add a flag to
> VirtIOBlock so virtio_blk_data_plane_[start|stop] would instruct
> virtio_blk_dma_restart_bh() to avoid processing the virtqueue,
> rescheduling itself instead. How does this would look to you?

Yes, I think if dataplane is enabled, we should really run the restarted
requests in the iothread. virtio_blk_dma_restart_cb() is called too
early, before the dataplane is running, so I guess we need some way to
tell the dataplane that it should run the request restarting logic of
virtio_blk_dma_restart_bh() after it has started (no additional BH
needed there). Your flag sounds like the obvious way to get this.

In fact, would it hurt to do this just unconditionally without a flag?
s->rq should be NULL when there is nothing to restart.

And then we can skip the same logic in virtio_blk_dma_restart_cb() if we
know that a dataplane is going to be started.

Kevin

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7WTmEACgkQfwmycsiP
L9bHzw/9EEMAYrLEOGVQsqoZN/nX5PeD3mRnhI0T6vhljgXZX+2WmtBwhISbDzGt
Mrk2XK2TR18rLeC8Owr7dUYyoSI4gBejaj6wRy5xkT+2qZh9YskDl0QH27LhHdzU
y5DNT9uf0VSKRPr10bHw1VMlgaBXDTZYGA8eLmZv1Bh8/+T3aJJFRCC+ThO4E5CT
q6xswPgAB+IETFjTrV4ZUTX8VXiC1KFrcktCVDqIpcFUXZufV59GITw4wpvOeFdX
yUs2H+OHN3zCO4DHUrCLtwLj1S7NV+cKn1HSQon6Z2uYPVkzMXbDHLf5CHVQWlV2
tvPMlfv/q12BJu34ERuaauHrtfeQOxM6ycCDfEPYSgwJkJxP/GFbmyIrCaDiJwUA
lm05C8w3oFzBY5l5qbB51S47Qxu24Li481QhHIMrzBbBWNmeQId0cbcmTZ60BrqK
bmQzPfKAhHo9LnLmWIEjWZDWJGtAY0UbZtIOkkeBJxUq8H2rf5GMAFMgbq3tvbXs
syh4eLmAf6tZ0Nvxdbn+XpuILu4aBTRQeVikDnyB8Gh4twkTvXpGyOvk6rySCL3W
UvOKrlRkRKGwfm2wk4CZYheg0lFCv75DeqzUDEEHaojAJ3tpSPCOGHQuMuBslUHT
KaDvNHeemi/hnUuNWr75UgM1gq+Xxg619Qm0/gEcxFDQXfGv3is=
=EjV8
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


