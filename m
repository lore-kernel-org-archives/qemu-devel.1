Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267BDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A55206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCENh8Iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A55206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RbX-0001JX-5n
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0Raj-0000fB-Pe
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:32:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0Rah-0003Jn-2P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595950349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKRGGmG/omP8cr/ZFm2gHGXVnNS4MSHhCI608YM67Qw=;
 b=NCENh8IvdXk0yq7MHxuKxCBfxIct2G2PGZkQUvYJ2VqfEox8d1DRpWkkczLPpEOXsMmlHH
 o4E29ZXNHt82x9RPainJi5QVW1yWXN6Dg4eMwwdeKpZOGMEqGJys3PecTCnZ6qyj37cIso
 w7lLI1FuzKtAJhEwY/STT4s7STyrb8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Knf0lPrZPjGLW1Dqwvdyvw-1; Tue, 28 Jul 2020 11:32:25 -0400
X-MC-Unique: Knf0lPrZPjGLW1Dqwvdyvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D4A88015F4;
 Tue, 28 Jul 2020 15:32:24 +0000 (UTC)
Received: from localhost (ovpn-115-19.ams2.redhat.com [10.36.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0E641001281;
 Tue, 28 Jul 2020 15:32:20 +0000 (UTC)
Date: Tue, 28 Jul 2020 16:32:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Mohr <rmohr@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200728153219.GC21660@stefanha-x1.localdomain>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> misono.tomohiro@fujitsu.com> wrote:
>=20
> > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print =
an
> > error
> > >
> > > An assertion failure is raised during request processing if
> > > unshare(CLONE_FS) fails. Implement a probe at startup so the problem =
can
> > > be detected right away.
> > >
> > > Unfortunately Docker/Moby does not include unshare in the seccomp.jso=
n
> > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > > include unshare (e.g. podman is unaffected):
> > >
> > https://raw.githubusercontent.com/seccomp/containers-golang/master/secc=
omp.json
> > >
> > > Use "docker run --security-opt seccomp=3Dpath/to/seccomp.json ..." if=
 the
> > > default seccomp.json is missing unshare.
> >
> > Hi, sorry for a bit late.
> >
> > unshare() was added to fix xattr problem:
> >
> > https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad49166=
3cfcc#
> > In theory we don't need to call unshare if xattr is disabled, but it is
> > hard to get to know
> > if xattr is enabled or disabled in fv_queue_worker(), right?
> >
> >
> In kubevirt we want to run virtiofsd in containers. We would already not
> have xattr support for e.g. overlayfs in the VM after this patch series (=
an
> acceptable con at least for us right now).
> If we can get rid of the unshare (and potentially of needing root) that
> would be great. We always assume that everything which we run in containe=
rs
> should work for cri-o and docker.

Root is required to access files with any uid/gid.

Dave Gilbert is working on xattr support without CAP_SYS_ADMIN. He may
be able to find a way to drop unshare (at least in containers).

> "Just" pointing docker to a different seccomp.json file is something whic=
h
> k8s users/admin in many cases can't do.

There is a Moby PR to change the default seccomp.json file here but it's
unclear if it will be merged:
https://github.com/moby/moby/pull/41244

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8gRQMACgkQnKSrs4Gr
c8gFewf+N/01Xy2AeoJ+M2D/I7CvBDsqtoktTXivzhkqUYVQV1APtrrvRl3VJm3f
/9s0A+uFATHccykvXHorARbYZzp6xj4ELnSWwkrHyVfqN8+gVCFJmEpumddusRFP
t7sG03AyDmWtXQmWNEtNqDNsKzp377P7Vb4TBaUd5f5KsjskmrvSs9SV/f3NBi0k
yQC/4wUmB5kcaNWMvC6ReCUQ8WUJU6VPwebiOPAdVJdQq5jG/UIY24uiPoqPyvz/
XFVbt1IbNxoYp6TwzUOfdcSu2CX4I20E+fmRbBvZFtgwWwKWWOlDOdcGPCtLtEK1
HSqcs8Jln8pC6/5Zff+FT6SqhNSFBg==
=06TQ
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--


