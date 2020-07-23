Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8705207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2dND43w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8705207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyafH-00023V-UV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyada-0008HZ-GV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:47:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyadY-0006bz-Lt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAJes/WZNEl7/oJ6OaTWOdOIJYof7BenrgGwnwlbclE=;
 b=L2dND43w/oYvHYh3ogM+UDy94kvifFyKuueI5gQXd/To3ljHKAHDDs8Vo1Yzfkej9HLK0o
 eCW7zeq5A95tRiFmeBhYZrea0xKw7QhHnZFxBkibS/iGzMAOXDU1iNzYUGPlcR6Mk/qCRf
 +zkjLcpQAfsoo2ic8IxHYvRT/RiufaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-Zw2N8nCeOVG-D-J1SKBImg-1; Thu, 23 Jul 2020 08:47:44 -0400
X-MC-Unique: Zw2N8nCeOVG-D-J1SKBImg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A891109D67E;
 Thu, 23 Jul 2020 12:46:16 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51B760CC0;
 Thu, 23 Jul 2020 12:46:12 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:46:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH for-5.1 3/3] virtiofsd: probe unshare(CLONE_FS) and print
 an error
Message-ID: <20200723124611.GL186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-4-stefanha@redhat.com>
 <20200722170328.GU2324845@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722170328.GU2324845@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vromanso@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 qemu-devel@nongnu.org, virtio-fs@redhat.com, rmohr@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 06:03:28PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 22, 2020 at 02:02:06PM +0100, Stefan Hajnoczi wrote:
> > An assertion failure is raised during request processing if
> > unshare(CLONE_FS) fails. Implement a probe at startup so the problem ca=
n
> > be detected right away.
> >=20
> > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > include unshare (e.g. podman is unaffected):
> > https://raw.githubusercontent.com/seccomp/containers-golang/master/secc=
omp.json
> >=20
> > Use "docker run --security-opt seccomp=3Dpath/to/seccomp.json ..." if t=
he
> > default seccomp.json is missing unshare.
> >=20
> > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virti=
o.c
> > index 3b6d16a041..ebeb352514 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -949,6 +949,19 @@ int virtio_session_mount(struct fuse_session *se)
> >  {
> >      int ret;
> > =20
> > +    /*
> > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need =
it. It's
> > +     * an unprivileged system call but some Docker/Moby versions are k=
nown to
> > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > +     */
> > +    ret =3D unshare(CLONE_FS);
> > +    if (ret =3D=3D -1 && errno =3D=3D EPERM) {
> > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. I=
f "
> > +                "running in a container please check that the containe=
r "
> > +                "runtime seccomp policy allows unshare.\n");
> > +        return -1;
> > +    }
> > +
>=20
> This describes the unshare() call as a "probe" and a "test", but that's
> misleading IMHO. A "probe" / "test" implies that after it has completed,
> there's no lingering side-effect, which isn't the case here.
>=20
> This is actively changing the process' namespace environment in the
> success case, and not putting it back how it was originally.
>=20
> May be this is in fact OK, but if so I think the commit message and
> comment should explain/justify what its fine to have this lingering
> side-effect.
>=20
> If we want to avoid the side-effect then we need to fork() and run
> unshare() in the child, and use a check of exit status of the child
> to determine the result.

Thanks for pointing this out. I'll add a comment explaining that
virtiofsd is single-threaded at this point. No other threads share the
file system attributes so the call has no observable side-effects.

Stefan

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZhpMACgkQnKSrs4Gr
c8ik/AgApNN9mJAnOFGeULLn8Vr3WIe2F0EAxh9D/+qiyAP/RBuxnkuwG9p8uRxV
JoD4IPn5v9b745/h3du76rot+UVXzfVDvEtRPWncf90N5fTmI7QUI2SSUL3M3hI4
AlH6L4wEjmgN1ccezx14rFqdt/aNcFDQnVDXzfMCiktHkzxSvcuz4QMcHNxKn7wI
SWDUWDVtjH/uiBW9IA32oOrurVMV9xnWO9ciVWepnrM8xHObhRzZ9CU6crsbQaFk
+pnmqLhDMA/ies5rKPhTAw6DWQ5ERRc6RCSPDbtjj7iogtNc5tDXOYtKIDYO2Tz3
2S/BvjZfNtRfU8nqdOYX00zxOtcHew==
=bxzm
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--


