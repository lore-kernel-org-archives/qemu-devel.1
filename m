Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF96C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0F720737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2niYQnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0F720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jywk0-000691-F2
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jywjE-0005jB-6B
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jywjB-0000PU-TU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595593384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhUBwRcRyGbFmU6cgwcLfwLsU3FtjUsJb5WmzqrnQNg=;
 b=F2niYQnhxgjZcJFCD0l8b9XL497uFvt8U6NO5b/eSyDI+kCDmwxa1eHTAKmKHHqQWb4fpr
 7ZgIae435xItW3jj38XzG8nsDpnbyGVc1pTVY6RBppLfsAY2BJvRm5sXllnKUQDkoPZ3Gw
 8zLBYvEYpmaVNvrMgoDzTDhCalTfC5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-7fZrvcthO6GqmKXfpdsajg-1; Fri, 24 Jul 2020 08:23:00 -0400
X-MC-Unique: 7fZrvcthO6GqmKXfpdsajg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCFE1801A03
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 12:22:59 +0000 (UTC)
Received: from localhost (ovpn-114-111.ams2.redhat.com [10.36.114.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5F6D70105;
 Fri, 24 Jul 2020 12:22:53 +0000 (UTC)
Date: Fri, 24 Jul 2020 13:22:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200724122252.GA333683@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722190318.GM2660@work-vm>
 <20200723123229.GK186372@stefanha-x1.localdomain>
 <20200723175538.GW2621@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200723175538.GW2621@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
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

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 06:55:38PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Wed, Jul 22, 2020 at 08:03:18PM +0100, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > +    /*
> > > > +     * Make the shared directory the file system root so that FUSE=
_OPEN
> > > > +     * (lo_open()) cannot escape the shared directory by opening a=
 symlink.
> > > > +     *
> > > > +     * It's still possible to escape the chroot via lo->proc_self_=
fd but that
> > > > +     * requires gaining control of the process first.
> > > > +     */
> > > > +    if (chroot(lo->source) !=3D 0) {
> > > > +        fuse_log(FUSE_LOG_ERR, "chroot(\"%s\"): %m\n", lo->source)=
;
> > > > +        exit(1);
> > > > +    }
> > >=20
> > > I'm seeing suggestions that you should drop CAP_SYS_CHROOT after
> > > chroot'ing to stop an old escape (where you create another jail insid=
e
> > > the jail and the kernel then lets you walk outside of the old one).
> >=20
> > That's already the case:
> >=20
> > 1. setup_seccomp() blocks further chroot(2) calls.
> > 2. setup_capabilities() drops CAP_SYS_CHROOT.
>=20
> Ah yes; could you add a comment if you respin; it's not obvious that
> the capability to chroot allows you to break out of an existing chroot
> you're in.

Sure.

Stefan

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8a0pwACgkQnKSrs4Gr
c8gtjAf+N3a6aSnhKxco1M3LCLZ/NcE9w+b0cAGpoxUawTBFfxYCHoT569DSsB5M
qBhQsAw6JWm6FvmnsSlrND2m6bIvARP5k3OOZzwyv7jrfCkoWG/q53ULaWCtYsOr
NFrGoqrDKicuwZa8YwJOERT+yJv/wIpWPJ585UIU8F5NtQ4LirYz2W71YfxkU519
czYfiAoY42QJSmrCjEi18SJCfD6gS7cbY5yOKAWq2y5zK8mGJe2j91WXa4N/DssH
79C2XlmEWpAvQUbXBsO5oYpuxNzRgWBiNruP5PkltPtOtIHOV0nbTnbOvR8aHj9N
vNUXY8FWOmZTE4VXa2zvuOCphT6gWg==
=3N0O
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


