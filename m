Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C6B206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzLiaQNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C6B206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyd1Z-0008PL-JB
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyd0Z-0007PK-D9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:19:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyd0X-0008DK-H0
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595517580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJAf3dN/BRQiyWef3mpedNBfYA6a6XwXsMqfE+vH7Ko=;
 b=XzLiaQNfD1F/AH5yM4HA2T4MuMo+5etx4BqrrEahC0CjuK0d51dwLuiT0WqDqGCfE5mo82
 wKulrF+/VTDAa/qf9BNHMLcqa089+btEQTXNlEK3UgEeM1Ap1qrjN46OrWbfb2DTK/dzkk
 QpIkySy5iikRbpKoLuLIcLMy6yVcxHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-QOOml1lPOO2zIv-0VtmxPg-1; Thu, 23 Jul 2020 11:19:34 -0400
X-MC-Unique: QOOml1lPOO2zIv-0VtmxPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A7A1C746C
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 15:19:33 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7290F5BAD5;
 Thu, 23 Jul 2020 15:19:30 +0000 (UTC)
Date: Thu, 23 Jul 2020 16:19:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 3/3] virtiofsd: probe
 unshare(CLONE_FS) and print an error
Message-ID: <20200723151929.GA300121@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-4-stefanha@redhat.com>
 <20200722170328.GU2324845@redhat.com>
 <20200723124611.GL186372@stefanha-x1.localdomain>
 <20200723125035.GH2615312@redhat.com>
 <20200723135603.GB5885@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723135603.GB5885@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 09:56:03AM -0400, Vivek Goyal wrote:
> On Thu, Jul 23, 2020 at 01:50:35PM +0100, Daniel P. Berrang=E9 wrote:
> > On Thu, Jul 23, 2020 at 01:46:11PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Jul 22, 2020 at 06:03:28PM +0100, Daniel P. Berrang=E9 wrote:
> > > > On Wed, Jul 22, 2020 at 02:02:06PM +0100, Stefan Hajnoczi wrote:
> > > > > An assertion failure is raised during request processing if
> > > > > unshare(CLONE_FS) fails. Implement a probe at startup so the prob=
lem can
> > > > > be detected right away.
> > > > >=20
> > > > > Unfortunately Docker/Moby does not include unshare in the seccomp=
.json
> > > > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists alwa=
ys
> > > > > include unshare (e.g. podman is unaffected):
> > > > > https://raw.githubusercontent.com/seccomp/containers-golang/maste=
r/seccomp.json
> > > > >=20
> > > > > Use "docker run --security-opt seccomp=3Dpath/to/seccomp.json ...=
" if the
> > > > > default seccomp.json is missing unshare.
> > > > >=20
> > > > > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > >  tools/virtiofsd/fuse_virtio.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse=
_virtio.c
> > > > > index 3b6d16a041..ebeb352514 100644
> > > > > --- a/tools/virtiofsd/fuse_virtio.c
> > > > > +++ b/tools/virtiofsd/fuse_virtio.c
> > > > > @@ -949,6 +949,19 @@ int virtio_session_mount(struct fuse_session=
 *se)
> > > > >  {
> > > > >      int ret;
> > > > > =20
> > > > > +    /*
> > > > > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will=
 need it. It's
> > > > > +     * an unprivileged system call but some Docker/Moby versions=
 are known to
> > > > > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > > > > +     */
> > > > > +    ret =3D unshare(CLONE_FS);
> > > > > +    if (ret =3D=3D -1 && errno =3D=3D EPERM) {
> > > > > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EP=
ERM. If "
> > > > > +                "running in a container please check that the co=
ntainer "
> > > > > +                "runtime seccomp policy allows unshare.\n");
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > >=20
> > > > This describes the unshare() call as a "probe" and a "test", but th=
at's
> > > > misleading IMHO. A "probe" / "test" implies that after it has compl=
eted,
> > > > there's no lingering side-effect, which isn't the case here.
> > > >=20
> > > > This is actively changing the process' namespace environment in the
> > > > success case, and not putting it back how it was originally.
> > > >=20
> > > > May be this is in fact OK, but if so I think the commit message and
> > > > comment should explain/justify what its fine to have this lingering
> > > > side-effect.
> > > >=20
> > > > If we want to avoid the side-effect then we need to fork() and run
> > > > unshare() in the child, and use a check of exit status of the child
> > > > to determine the result.
> > >=20
> > > Thanks for pointing this out. I'll add a comment explaining that
> > > virtiofsd is single-threaded at this point. No other threads share th=
e
> > > file system attributes so the call has no observable side-effects.
> >=20
> > Also, if we do an unshare() here, do we still need the unshare() later
> > on in the code ?
>=20
> I think so. That unshare() later is to isolate one thread from other.

Yes. Each thread that calls unshare(CLONE_FS) gets its own current
working directory and other file system attributes.

The purpose of the call is to allow worker threads to change current
working directory without affecting each other.

Stefan

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZqoEACgkQnKSrs4Gr
c8gWGwf+JXFC/fVRr0GYRmrh2uGeGA4U1u2SxYwL9sZysPsGWbqQ1tw6+mu8fzNv
stSqtgMA+7FZJERxdL551DWiEloK1mSKpp8pb5RVBxEW6HZrVwsKAw3F89bkJrhk
tiCxlkTvlhd+D3eIoO4/lYoYHj5HRP0hO67yB7LGicSqpfED/3AbTGJSYBgIb7Mu
7lgKFy1cyA1p7TrLtbpFOixoUS4kTRlmETa5mUuRU9SqHjvNKlQugJMrMNcNiDrK
lXpy1tv/gmpRShFFlW5LoePDV/z9UEj4L8QHauuxy+yFF2Rf8WyGqzL0OCN9YuWi
2Nrzj7F7AgF5m/Qd1T2/PhBi5yTyrw==
=IHJ0
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


