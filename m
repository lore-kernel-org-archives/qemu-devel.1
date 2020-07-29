Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B24207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJDETA2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B24207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0n7J-00065q-Ge
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0n61-0005X8-Ui
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:30:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0n5y-0001zu-Dd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596033013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIDkxltvDEgv5aPG58kveP5LTo4gYeFZX+YY/uQFJnI=;
 b=cJDETA2LUM28FWk1FSJ+uT3WU0oX6vvMBVh0KMd1rIDr7tQ9d79VsF+Mndnla9awCSk/hi
 8idBzffmgx8R04CgOTfVQ46GyIh8Z1ytNk8iPLYQlReLXD2DKTo3BQh9WZdzs7VPCcZseG
 sfIFhRm8xQbBIXYzj4eNFbxdwGedGG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Z5C3pzp8MgyyUeZSBrMc-A-1; Wed, 29 Jul 2020 10:29:58 -0400
X-MC-Unique: Z5C3pzp8MgyyUeZSBrMc-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974AF106B242;
 Wed, 29 Jul 2020 14:29:57 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E88D5DA73;
 Wed, 29 Jul 2020 14:29:54 +0000 (UTC)
Date: Wed, 29 Jul 2020 15:29:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200729142953.GE52286@stefanha-x1.localdomain>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728153219.GC21660@stefanha-x1.localdomain>
 <c5b15243-200b-fa17-27b5-1b27dbddbe6d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c5b15243-200b-fa17-27b5-1b27dbddbe6d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
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
 "mpatel@redhat.com" <mpatel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 Roman Mohr <rmohr@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 03:15:25PM -0400, Daniel Walsh wrote:
> On 7/28/20 11:32, Stefan Hajnoczi wrote:
> > On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> >> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> >> misono.tomohiro@fujitsu.com> wrote:
> >>
> >>>> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print=
 an
> >>> error
> >> "Just" pointing docker to a different seccomp.json file is something w=
hich
> >> k8s users/admin in many cases can't do.
> > There is a Moby PR to change the default seccomp.json file here but it'=
s
> > unclear if it will be merged:
> > https://github.com/moby/moby/pull/41244
> >
> > Stefan
>=20
> Why not try Podman?

Absolutely, Podman allows unshare(2) in its default seccomp policy so it
does not have this problem.

I think Roman's point was mainly about the upstream user experience
where Docker is common.

Stefan

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hh+AACgkQnKSrs4Gr
c8j8nQgAp70hD2BPLqDLm5JIwSXUuitCFEM/4u7WRCIu4k+IHcAdopIHEolwkQ3p
p05v4mTk69BwTNbFfKwzX2o8yXu/sjT96BqZqDtcJIoGH4vZd5l1yiqefGD8VvQM
qvTqOw8P3oXeY/H4WsluTbsQfL6aKuWjuBdSReOoTrUqfXnvH+Y2N3Y+yPIuFWeF
7Fnak1afGTeShhTWyDCLgomu1fwgdVSLZUt56bJ7ARaBkgr0YRsykdXUP4c1KkUO
93LoEW1Vwoxm/J+yziECd02oruuu9SM1M5CY/FOGxS7kBiebs683tI3Cq2zfBE4c
a3Yff6jYM4fFFN62MpB95KJ2JFenmg==
=eINk
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--


