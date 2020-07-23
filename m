Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB3EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A5D206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRg2RiwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A5D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaQU-0006VI-E9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaLO-0008Ps-Ab
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:29:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaLL-0003Pp-SX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHEES92NECN0dH1hpVq1NC2OiJmv3OoiVcTLFJXns0c=;
 b=VRg2RiwRVHI2AUycnfyikF23I/bEDvBOqDIEwtmaWvmaLVnCceejFsw7uY/ommkZXNprOB
 mZuPZCj7dxLrFvbc0EMacbj58D21H7G6efjNIpuP8uu62oYwGx9M0FVGwGM9WZnV4VYuZH
 lC9i5xH8gXepCW0T3/D4B0P9BJWsQ9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-pv7tjdbxOdaFz6aQFfIsIg-1; Thu, 23 Jul 2020 08:28:56 -0400
X-MC-Unique: pv7tjdbxOdaFz6aQFfIsIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447B3185BE06
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:28:55 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEBED19D81;
 Thu, 23 Jul 2020 12:28:51 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:28:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200723122850.GI186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722175820.GL2660@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200722175820.GL2660@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com, qemu-devel@nongnu.org,
 vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 06:58:20PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
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
>=20
> OK, I'm guessing the behaviour of what happens if the host adds another
> mount afterwards might be different?

Running inside a container with -o chroot:
 - The container has its own mount namespace and it is therefore not
   affected, modulo shared subtrees (see mount(8)).

Running outside a container with -o chroot:
 - Path traversal can only reach mounts that are made within the shared
   directory tree. Technically other mounts are still there but it is
   not possible to reach them via file system paths.

> > 2. Pid namespace. This should be fine because virtiofsd is the only
> >    process running in the container.
>=20
> Is it ? Isn't the qemu and any other vhost-user processes also in the
> same container?

No. QEMU, virtiofsd, and other vhost-user processes should run in their
own containers. Application container images are typically designed to
run a single program per container. It's technically possible to launch
multiple programs but that is considered bad practice for application
containers.

Kubernetes:
Containers in a pod do not share a single pid namespace by default.
Pods do share a single network namespace so they can communicate via
UNIX domain sockets.

> > 3. Network namespace. This should be fine because seccomp already
> >    rejects the connect(2) syscall, but an additional layer of security
> >    is lost. Container runtime-specific network security policies can be
> >    used drop network traffic (except for the vhost-user UNIX domain
> >    socket).
>=20
> Should this be tied to the same flag - this feels different from the
> chroot specific problem.

Good point. Daniel Berrange has suggested another command-line syntax
that makes sandbox configuration more modular. I'll try to implement
something like that.

Stefan

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZgoIACgkQnKSrs4Gr
c8h1zwf+OetM+DquK6ixEWTGmiV9CQJ/x8PVDkAON2pb35cjoFNFks6bK90wheCl
ajGM2zlXhyLK64HEqhDhlmK+2gVBzpJeMNpRwAPFIkZeRKNxW9xYmH0bxLVxJtTf
3PslPVM10L/o3S5NLB/j0lVRL5EdR9nOtL1+FEPhGlNC9Y6MNhM3sUWHPtDQr+CB
dEq7WD6HauBwi8esX3S6Izut2AieqVKgI3NoecZ8NPmCftEj3LLkXHhy0Z+R/SHV
E6hG/LZGv5ka6p+B4C86PCqEof7lNepm4xPUrCptByEQsPM/zigzwq0TuodclevP
OC7Qts4qjuFt7y1Ts5gsIcsTk9YSgw==
=o4bu
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--


