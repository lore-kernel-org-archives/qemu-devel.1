Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AD420723
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZBSzRfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AD420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5P3-00027d-W7
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT5Nr-0001Jc-Lj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT5Nm-00009e-Dq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602776492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPxtBuHlqNyWCKxhUQYfGvkpauJtaSJEq7HxeTZHi/M=;
 b=PZBSzRfHWfDQv2FtagnWaXvyQe7UdezPFfX6YBQaYKabye4ANh1wDPsAFFRds2S1KK7yCd
 VD9sx7jdiAPFOzppz0zR17o2RMDUw/oj2/gCW0eEzgPDKPSA16B1X593FCg+//6uC7uyAs
 RzlC7b/aLR2CTZh9Js8250nNKoA5g7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-vvQ8a8XTNbiCJeqgcDsVFw-1; Thu, 15 Oct 2020 11:41:29 -0400
X-MC-Unique: vvQ8a8XTNbiCJeqgcDsVFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6AE980364C;
 Thu, 15 Oct 2020 15:41:28 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8962455764;
 Thu, 15 Oct 2020 15:41:24 +0000 (UTC)
Date: Thu, 15 Oct 2020 17:41:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 02/20] fuse: Allow exporting BDSs via FUSE
Message-ID: <20201015154123.GK4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-3-mreitz@redhat.com>
 <20201015085703.GB4610@merkur.fritz.box>
 <2db9dbfe-137a-4cdc-08ab-aaa1aed26423@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2db9dbfe-137a-4cdc-08ab-aaa1aed26423@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.10.2020 um 16:46 hat Max Reitz geschrieben:
> On 15.10.20 10:57, Kevin Wolf wrote:
> > Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
> >> block-export-add type=3Dfuse allows mounting block graph nodes via FUS=
E on
> >> some existing regular file.  That file should then appears like a raw
> >> disk image, and accesses to it result in accesses to the exported BDS.
> >>
> >> Right now, we only implement the necessary block export functions to s=
et
> >> it up and shut it down.  We do not implement any access functions, so
> >> accessing the mount point only results in errors.  This will be
> >> addressed by a followup patch.
> >>
> >> We keep a hash table of exported mount points, because we want to be
> >> able to detect when users try to use a mount point twice.  This is
> >> because we invoke stat() to check whether the given mount point is a
> >> regular file, but if that file is served by ourselves (because it is
> >> already used as a mount point), then this stat() would have to be serv=
ed
> >> by ourselves, too, which is impossible to do while we (as the caller)
> >> are waiting for it to settle.  Therefore, keep track of mount point
> >> paths to at least catch the most obvious instances of that problem.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>

> >> +/**
> >> + * Callback to be invoked when the FUSE session FD can be read from.
> >> + * (This is basically the FUSE event loop.)
> >> + */
> >> +static void read_from_fuse_export(void *opaque)
> >> +{
> >> +    FuseExport *exp =3D opaque;
> >> +    int ret;
> >> +
> >> +    blk_exp_ref(&exp->common);
> >> +
> >> +    ret =3D fuse_session_receive_buf(exp->fuse_session, &exp->fuse_bu=
f);
> >=20
> > The fuse_session_loop() implementation seems to imply that we should
> > retry on EINTR.
>=20
> OK.  I see you=E2=80=99re digging into libfuse already. :)

Well, I have to review against something, and the documentation tends to
be terse...

> >> +    if (ret < 0) {
> >> +        goto out;
> >> +    }
> >> +
> >> +    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
> >> +
> >> +out:
> >> +    blk_exp_unref(&exp->common);
> >> +}
> >> +
> >> +static void fuse_export_shutdown(BlockExport *blk_exp)
> >> +{
> >> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> >> +
> >> +    if (exp->fuse_session) {
> >> +        fuse_session_exit(exp->fuse_session);
> >> +
> >> +        if (exp->mounted) {
> >> +            fuse_session_unmount(exp->fuse_session);
> >> +            exp->mounted =3D false;
> >> +        }
> >> +
> >> +        if (exp->fd_handler_set_up) {
> >> +            aio_set_fd_handler(exp->common.ctx,
> >> +                               fuse_session_fd(exp->fuse_session), tr=
ue,
> >> +                               NULL, NULL, NULL, NULL);
> >> +            exp->fd_handler_set_up =3D false;
> >> +        }
> >> +
> >> +        fuse_session_destroy(exp->fuse_session);
> >> +        exp->fuse_session =3D NULL;
> >=20
> > What happens if a request is still in flight?
> >=20
> > Oh, can't happen because the driver is fully synchronous after this
> > series. Fair enough, making it asynchronous can come on top of it.
>=20
> (I had multiple approaches of handling parallel requests, but none made
> a substantial performance difference, which is why I left the driver in
> the most simple form for this first proposal.)

I think the more relevant part is that we'd block the guest or anything
else running in the main loop while doing I/O.

Not a problem if you spawn a new qemu-storage-daemon just for this FUSE
export, but if you want to have multiple exports, or export from the
system emulator, you probably don't want to have synchronous operations.

Kevin

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl+IbaIACgkQfwmycsiP
L9b3Wg//c/3xzjBx3fytK7EQnGbo36NT36GvjcmDeodeL9X4QYHqwj/QZD2VPNiP
ZM6HTTofhctO79qmLgC+9ndpD9Y7zqV4r1SYzAcigRubG2SIPWs6/VBI7H/9HEGc
/cug8OWmFkRnKHbxTMpIIxI4LsjU3oqBwalzAo/K8Ebed+e3E8NY72jdc3hSGjqc
01/yxnmN7bDuVFeZn9tCM64Oiib+i4JNSebAaR2B0Lb4k0dAJnRpOhnw474ejiZH
ub1TQO2NBncrtEa0ybTR2dPcqrQK6LcGi5Y/oPWfnYIH8BGxq7MgtFxqXMOShyvJ
H2Vd7vxM06vTr27hvGJCvx97hY4zSfSvBYbXd7bBOfDQaFhQMsPbSOBXoOc6o5W7
Xx0I3xJtN9PGX2soOe7X5T6rlUe5fmkd8SBi0/35YvgRoFaSxqTsFxnn7Ky/LQEY
smxAGYfhvlRs5hJXS688iAoFxejEahy1R3RWPZlS6InZMyMijOabZl+fVkHg9Ug5
DrpJoM6FIJCM2Rus5BnMd7Nc25TvdtsqVJeGKHgYZUVuTWqKq0s4wr2UkTNbOIYE
4v5suw6QLd+OFkY3+dkkZUi/zyKZPSd8pF7wTI6rsddFuMV7W9pxhsnvQqb6zIdj
h4C2HwOXh53inztx89+CdqVXQ+nmUvl2qZCvm4dFsYwtSBJTMIY=
=56Yj
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


