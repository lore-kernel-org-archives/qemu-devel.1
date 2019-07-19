Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DEC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD3D21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJlt8p5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD3D21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPUt-00032W-CB
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoPUh-0002dG-Kp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoPUg-0000c0-4H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:48:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hoPUf-0000bW-TA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:48:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so31675940wru.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PCgqpbzniK+IUw4onmPYXAXx5csOHxlHy8i4kswyd6Q=;
 b=YJlt8p5Ou5rg2KMmdG8rHgBZjhBzWl8RxA/0xgIiUG25SP7oWoZ/h0MsRQ/0YUtvvN
 +PHbiVWWzgHbnhFfGZKZbPLzbxebWlDxRoAoO30S0JsDtJznMuI11cti48WWEHfs4LU9
 HUV01HI/nZUf9qKrQghCvodjLdIPexzo8Fjsn5fnQ7wvSpgSeL1BIgL5ecPcNFWXanrT
 7rI10W38cI9VaxYHgeQq83HpRiARixkvJR4sqntn/FKgX/Omne2IP+iW+rrB5D2HZJWa
 wmf+dJ/j1X06M7mU/Dli3p+8tAfcks5L+qZv7U7/InbYw5nmg6RPr6hAhLiVeZ0LJOFK
 Dgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PCgqpbzniK+IUw4onmPYXAXx5csOHxlHy8i4kswyd6Q=;
 b=G76uBdRpZ4HVd2Myqtfr2f2s6wbFpYSK6cT5SK8wnIW0EOrfpbsVEBzxUDJ/6NVP8B
 WZFV1dxVM9DGY52bd/pBI5NYDckAQlBCiatUDsKUCqnnogXb5XbFl2lqWt09Nbjc9lY4
 lIHuZx34cJmhceXmgcFcfTMFL953+Ts+IKTB8MlyjYaBw6bUtp51FHcxvGduoLT6a7bP
 ycDUQZohthLmK96Vq8q1E13L7aO5ZcpjFm6zT7tPbx/SwThCA8U+ehTADHxXRAuUCO2M
 Pjf5irtFGvGEFkPYnX/UcjSeg1m3yJeLBaFWpdfvpQOIyJpsdd05kw/DunhPr31ANvmn
 ELPg==
X-Gm-Message-State: APjAAAUZC62nJTM+1dwPgoAAEF1n9TRyMdJwfwHxKXyg71lG9OzmUZjl
 tuwDbp4qWV0o5ygRFE34Mec=
X-Google-Smtp-Source: APXvYqzauQH5b1BHiQ5EWT3b4j9f1z9WWwCHgojelr4Slqzq6Hn0dnhHHGlUbr9XVH8J8PF8kj8fIg==
X-Received: by 2002:adf:f851:: with SMTP id d17mr55659088wrq.77.1563529680959; 
 Fri, 19 Jul 2019 02:48:00 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u186sm47011294wmu.26.2019.07.19.02.47.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 02:48:00 -0700 (PDT)
Date: Fri, 19 Jul 2019 10:47:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1836855 <1836855@bugs.launchpad.net>
Message-ID: <20190719094758.GD18585@stefanha-x1.localdomain>
References: <156335163555.1137.2433837611161042870.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <156335163555.1137.2433837611161042870.malonedeb@gac.canonical.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Bug 1836855] [NEW] virtio_scsi_ctx_check failed
 when detach virtio_scsi disk
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 08:20:35AM -0000, =E8=B4=9E=E8=B4=B5=E6=9D=8E wrote:
> Public bug reported:
>=20
> I found a problem  that virtio_scsi_ctx_check  failed when detaching
> virtio_scsi disk.  The  bt is below:
>=20
> (gdb) bt
> #0  0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
> #1  0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
> #2  0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.6
> #3  0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
> #4  0x00000000004eb9a8 in virtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d790,=
 s=3D<optimized out>, s=3D<optimized out>)
>     at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:243
> #5  0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare (s=3Ds@entry=
=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
>     at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:553
> #6  0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0, vq=3D=
0xd283410)
>     at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:588
> #7  0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D0x0, =
vq=3D0xffffae7a6f98)
>     at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi-dataplane.c:57
> #8  0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at util/aio-posi=
x.c:323
> #9  0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue) at =
util/aio-posix.c:472
> #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread.c=
:49
> #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at util/qe=
mu-thread-posix.c:495
> #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at u=
vp/hotpatch/qemu_hotpatch_helper.c:579
> #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
> #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6
>=20
> assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx)  failed.
>=20
> I think this patch
> (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3a0=
c7f1097412f44bfd9eff0b)
> introduce this problem.
>=20
> commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b  move blockbackend back
> to main AioContext on unplug. It set the AioContext of
>=20
> SCSIDevice  to the main AioContex, but s->ctx is still the iothread
> AioContext.  Is this a bug?

The backtrace shows that virtqueue processing is happening in the
IOThread.  This is expected so now the question is why the
BlockBackend's AioContext is the main AioContext.

Can you share steps for reproducing this bug?

Thanks!

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1836855
>=20
> Title:
>   virtio_scsi_ctx_check failed when detach virtio_scsi disk
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   I found a problem  that virtio_scsi_ctx_check  failed when detaching
>   virtio_scsi disk.  The  bt is below:
>=20
>   (gdb) bt
>   #0  0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
>   #1  0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
>   #2  0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.6
>   #3  0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
>   #4  0x00000000004eb9a8 in virtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d79=
0, s=3D<optimized out>, s=3D<optimized out>)
>       at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:243
>   #5  0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare (s=3Ds@ent=
ry=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
>       at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:553
>   #6  0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0, vq=
=3D0xd283410)
>       at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:588
>   #7  0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D0x0=
, vq=3D0xffffae7a6f98)
>       at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi-dataplane.c:=
57
>   #8  0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at util/aio-po=
six.c:323
>   #9  0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue) a=
t util/aio-posix.c:472
>   #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread=
=2Ec:49
>   #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at util/=
qemu-thread-posix.c:495
>   #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at=
 uvp/hotpatch/qemu_hotpatch_helper.c:579
>   #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
>   #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6
>=20
>   assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx)  failed.
>=20
>   I think this patch
>   (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3=
a0c7f1097412f44bfd9eff0b)
>   introduce this problem.
>=20
>   commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b  move blockbackend
>   back to main AioContext on unplug. It set the AioContext of
>=20
>   SCSIDevice  to the main AioContex, but s->ctx is still the iothread
>   AioContext.  Is this a bug?
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1836855/+subscriptions
>=20

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0xkc4ACgkQnKSrs4Gr
c8gu2wf8DunTdcy2tJeAbClFutsM4V1UtXDC2NyFPymItiKAV787JoXixpmL6hi2
aykdvVvn9QMY6oPub+F5mL1H11t3ux/3g9RJTqy6dJvFGhquy+se/73pcv9qk1n/
rUcyH0LPozI45rUGJwdG2KXE9PjRbob3Qj3Z9lNnmn0Gr5mSzV+bluErxVRHWJZu
CZCcko0h89iYjAmNxczbIa9C45FMw8fjZzuNucItbUcIzLjZKxTtanwV7liJDEK+
NBY0mkRiEFEKz6OWaxaKeFexKQScudSaxyMX9AoiZB+PTwTMcRtHskLu0vl+2I60
9G5dgJLRtYYSFp+UQ7t4TTIoh2WIvg==
=OpLQ
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

