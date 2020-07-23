Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B18C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D633206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuqxDtnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D633206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydIn-0005PO-KQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jydHH-0004VG-Es
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:36:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jydHF-00038l-PV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595518615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iLWiDOIXMyWQf5B+S9B5zIYhz/tN7ErzT7y846Y0HcY=;
 b=CuqxDtnO+BHMwQVwMKn/ONfnd9WqQ/hY1rIDCcNgxoxCuPeO31LjXC4iH5lWp/f8iiddDj
 ihR0NkfijjsN3D/D5WvDVlzOn8wAc0HJURcDpfAJ+cWrEUxnTesp/Jz9TlmLyq4awXemwg
 lv+Lq3suTSPefyelT4RJelMpjUk3MpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-oye9fbXcN0i8dLsZx8aIpg-1; Thu, 23 Jul 2020 11:36:53 -0400
X-MC-Unique: oye9fbXcN0i8dLsZx8aIpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5618180046D
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 15:36:52 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09C347849A;
 Thu, 23 Jul 2020 15:36:48 +0000 (UTC)
Date: Thu, 23 Jul 2020 16:36:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 2/3] virtiofsd: add
 container-friendly -o chroot sandboxing option
Message-ID: <20200723153647.GB300121@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722175820.GL2660@work-vm>
 <20200723122850.GI186372@stefanha-x1.localdomain>
 <20200723134733.GA5885@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723134733.GA5885@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vromanso@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 09:47:33AM -0400, Vivek Goyal wrote:
> On Thu, Jul 23, 2020 at 01:28:50PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 22, 2020 at 06:58:20PM +0100, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > virtiofsd cannot run in an unprivileged container because CAP_SYS_A=
DMIN
> > > > is required to create namespaces.
> > > >=20
> > > > Introduce a weaker sandbox that is sufficient in container environm=
ents
> > > > because the container runtime already sets up namespaces. Use chroo=
t to
> > > > restrict path traversal to the shared directory.
> > > >=20
> > > > virtiofsd loses the following:
> > > >=20
> > > > 1. Mount namespace. The process chroots to the shared directory but
> > > >    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
> > > >    syscalls.
> > >=20
> > > OK, I'm guessing the behaviour of what happens if the host adds anoth=
er
> > > mount afterwards might be different?
> >=20
> > Running inside a container with -o chroot:
> >  - The container has its own mount namespace and it is therefore not
> >    affected, modulo shared subtrees (see mount(8)).
>=20
> How does virtiofsd inside container gets the directory it wants to
> export to guest? I am assuming that its probably a volume mount
> inside container. If yes, volume mounts can set propagation
> properties say "slave" and that means mounts done later will
> propagate inside container in that volume (and hopefully be
> visible inside guest once submount patches are upstream).

Yes, the shared directory is a volume mount and propagation works as
expected:

  $ docker run -v path/to/shared-dir:/shared-dir:slave \
=09       -v /tmp/socket-dir:/var/run \
=09       virtiofsd

When I mount things in path/to/shared-dir on the host they appear in
/shared-dir inside the guest. When I omit the "slave" option (the
default is "private") then the mount does not propagate.

The following Dockerfile was used:

  $ cp ~/src/qemu/virtiofsd . # copy the executable
  $ cat >Dockerfile
  FROM fedora:32
  COPY --chown=3D0:0 virtiofsd /usr/bin/virtiofsd
  RUN dnf update -qy && dnf install -qy libseccomp liburing zlib glib2 nett=
le gnutls libcap-ng
  VOLUME ["/shared-dir", "/var/run"]
  CMD ["/usr/bin/virtiofsd", "--socket-path=3D/var/run/virtiofsd.sock", "-o=
", "source=3D/shared-dir", "-o", "cache=3Dauto", "-o", "no_posix_lock", "-o=
", "xattr", "-o", "chroot"]

Stefan

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Zro8ACgkQnKSrs4Gr
c8iWkggAtGpbfo1cQOxcG92FgjYSVkpMbpQGp+Mlmr1zpPbb/3jfk9KnX8ONeV5M
YqCPm0tkPdX0Ufjkzano+Q3X1udYRCk3AShn7CfwhrkcWixQzzdk0QzO24pJDOjX
tL1msD+tMuljJf4X6lqAxFnTVWegUPcGGtRH4kk+ebNoPwccWdO6f1P9y50Q5ChB
POu4IFzY92ykUhJSB1EkyUKiQiqa467jU8twOkhaHjcw2ydGAs4Q6LAWSCgB0z+S
QWgBhS/4VcMxipfOQC3kj1Zlhlax6Jp8QnokO95MHyIATVk0FS93K8o/g6CkbzNb
TMoVWMMIHn1F4oMmVvpoF6JvWO0CfQ==
=paOA
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--


