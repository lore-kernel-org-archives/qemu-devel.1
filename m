Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2887FC433EA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54B7206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAu+J9q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54B7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaQB-0006CL-5y
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaP6-0004Vf-CY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:32:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaP4-0004NZ-P0
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvN8M+tJjfimie1VPyOcfMod4sSBXeqisQGAakSHFUg=;
 b=KAu+J9q+wXsH5ZpmDypuKdx710EvZn7rYQiO9LHxdJu0IYMEvV2rGQ1KXitAGPna4ZvOH4
 1EvllFcmjuq8PErVSD//4VRKkZ+Pd/nXgCREsmDGfYcXcQwM7fHUByIFRov+bKrdJG1xJL
 pY+upp1m6ABrXdqGewAOLwMUFGt8qZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-p01ZCY7FN7GvCQMx8zKGtw-1; Thu, 23 Jul 2020 08:32:47 -0400
X-MC-Unique: p01ZCY7FN7GvCQMx8zKGtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC4280BCBA
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:32:45 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 210546A500;
 Thu, 23 Jul 2020 12:32:30 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:32:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200723123229.GK186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722190318.GM2660@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200722190318.GM2660@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
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

--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 08:03:18PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > +    /*
> > +     * Make the shared directory the file system root so that FUSE_OPE=
N
> > +     * (lo_open()) cannot escape the shared directory by opening a sym=
link.
> > +     *
> > +     * It's still possible to escape the chroot via lo->proc_self_fd b=
ut that
> > +     * requires gaining control of the process first.
> > +     */
> > +    if (chroot(lo->source) !=3D 0) {
> > +        fuse_log(FUSE_LOG_ERR, "chroot(\"%s\"): %m\n", lo->source);
> > +        exit(1);
> > +    }
>=20
> I'm seeing suggestions that you should drop CAP_SYS_CHROOT after
> chroot'ing to stop an old escape (where you create another jail inside
> the jail and the kernel then lets you walk outside of the old one).

That's already the case:

1. setup_seccomp() blocks further chroot(2) calls.
2. setup_capabilities() drops CAP_SYS_CHROOT.

Stefan

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Zg10ACgkQnKSrs4Gr
c8h4HQf/RUS35yKPn0YuL0Blj7IStwftED6MWxJTsn76LYo4pnAtm1LLqWgDBuHo
qzpHnQhP7LEka+NA83+Vqmfz2qXtsYbj6itgLA73h/15b2pMWCkKg9U2yM0iztJp
pg4zDLUrt54i9NFTdRTsj+CHGFHdgspf+8ipMLhsiybtph3skBQtk3EvRUyVMJhR
2LxS5pRUCbr9uS5l/QLv9VAjcsCgEW98p2HG4uCJo6tY0li9iFY63Q5to3HL3rCy
EGMkFSOk/KYMcIoJQqSIO7getjtLVJuVqBxocKeYz2k7acpnE7UOODn9AVwWyfgn
FecaTHoPhmvjwaKwjUaQbmnbXs/fOQ==
=Yuf1
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--


