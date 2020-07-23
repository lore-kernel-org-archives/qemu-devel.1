Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF03D2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcQDcY3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF03D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaB8-0003A7-1J
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaA2-0002UU-Nc
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:17:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaA1-0001s1-0l
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595506636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFydj0YKd+Gwb1rBB5Qpmv5fZqKSUe4SIMKeKsZ/Jc4=;
 b=DcQDcY3DvMd9rab2l7UfQZxcuq1gWLha/fb8yvvprWMAv1iRQ5uygn5pqmonPMsV8/ilHP
 8dS8u1GqkWNHaK1AFuTv33qurlctJ7xIww5G6p7Y30SQjv2ufIg0B2+lasFI3lfORgiSBL
 6vqVhRV8GrPhm4UmKy6LUBzvykfMuZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-V9M-Z_SUN8yIjViHl-boBg-1; Thu, 23 Jul 2020 08:17:14 -0400
X-MC-Unique: V9M-Z_SUN8yIjViHl-boBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39FA019057A0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:17:13 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A86E5D9E2;
 Thu, 23 Jul 2020 12:17:09 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:17:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200723121708.GH186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722165811.GT2324845@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722165811.GT2324845@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 05:58:11PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 22, 2020 at 02:02:05PM +0100, Stefan Hajnoczi wrote:
> > virtiofsd cannot run in an unprivileged container because CAP_SYS_ADMIN
> > is required to create namespaces.
> >=20
> > Introduce a weaker sandbox that is sufficient in container environments
> > because the container runtime already sets up namespaces. Use chroot to
> > restrict path traversal to the shared directory.
> >=20
> > virtiofsd loses the following:
> >=20
> > 1. Mount namespace. The process chroots to the shared directory but
> >    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
> >    syscalls.
> >=20
> > 2. Pid namespace. This should be fine because virtiofsd is the only
> >    process running in the container.
> >=20
> > 3. Network namespace. This should be fine because seccomp already
> >    rejects the connect(2) syscall, but an additional layer of security
> >    is lost. Container runtime-specific network security policies can be
> >    used drop network traffic (except for the vhost-user UNIX domain
> >    socket).
>=20
> IIUC this relies on the fact that the container will still have=20
> CAP_SYS_CHROOT IOW, we still don't have a solution for running
> virtiofsd as an unprivileged user.

Yes, this still requires root in the container.

Stefan

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Zf8QACgkQnKSrs4Gr
c8iLbwgAviC1NQgA4Vm+Xio7KYEn44ZsEpL2SFhZD27BjsmxEv+YFMlYL/8fAXiR
h1ApQwFKEcy8wQ+iVYVLYnJDJm+DTBMEH8vWI+NiPYNN01MhXZzvtNd31LWXJyOg
9sSfS5GZqFNFk0ybcmDfh/ENjDHRbf+vdmJe9c5VpXEzJDa8i37aSz3AlqXiZv1h
vAvB+etU8uC2cJkxPFUlAlyWMXkGM6rxQ6TecVbLMGj7RJICaJVzI/MH42MPwguL
HsPPzHT3Q5F56X457aJO6oevjHYsfCy7Olmu2m9r/I2sCqB5EjO1DwyCYo3CjbuU
3Uk0+8jqh5lJx0K08vtWPoXK+NBL4A==
=x66X
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--


