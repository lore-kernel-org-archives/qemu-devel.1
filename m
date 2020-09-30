Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54894C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C3820789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI3LAN9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C3820789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYgq-0006Zc-Mw
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYfq-000635-8B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYfn-0003jF-Ko
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:45:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601459115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrn4u47m5bZToUUXDNtaaZ6vy7Orc+jYhkk7YzMDs0I=;
 b=AI3LAN9Gh8GvNuMvddCD6ljPxUnH6aHpH0ASG+xt14oo6mrNpLECBTQQswghzsj7hYSDkQ
 Ra1HL5x7nyvb9D2kgSdL7cTmF9/nHIDI9q1t2xtV86qYhmOkr2Yo2Rv6OmAucg8fGCjubK
 5rd2PBuo/x8vEkhHsw+lQu0k11VMJ+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506--FtUDdXgNPCJrgJQb7Ehdw-1; Wed, 30 Sep 2020 05:45:13 -0400
X-MC-Unique: -FtUDdXgNPCJrgJQb7Ehdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 038DE186840A;
 Wed, 30 Sep 2020 09:45:12 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60D1378831;
 Wed, 30 Sep 2020 09:45:08 +0000 (UTC)
Date: Wed, 30 Sep 2020 10:45:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 11/13] block/export: convert vhost-user-blk server to
 block export API
Message-ID: <20200930094508.GE201070@stefanha-x1.localdomain>
References: <20200924151549.913737-1-stefanha@redhat.com>
 <20200924151549.913737-12-stefanha@redhat.com>
 <87imbvj0it.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imbvj0it.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <coiby.xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 07:28:58AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > Use the new QAPI block exports API instead of defining our own QOM
> > objects.
> >
> > This is a large change because the lifecycle of VuBlockDev needs to
> > follow BlockExportDriver. QOM properties are replaced by QAPI options
> > objects.
> >
> > VuBlockDev is renamed VuBlkExport and contains a BlockExport field.
> > Several fields can be dropped since BlockExport already has equivalents=
.
> >
> > The file names and meson build integration will be adjusted in a future
> > patch. libvhost-user should probably be built as a static library that
> > is linked into QEMU instead of as a .c file that results in duplicate
> > compilation.
> >
> > The new command-line syntax is:
> >
> >   $ qemu-storage-daemon \
> >       --blockdev file,node-name=3Ddrive0,filename=3Dtest.img \
> >       --export vhost-user-blk,node-name=3Ddrive0,id=3Dexport0,unix-sock=
et=3D/tmp/vhost-user-blk.sock
> >
> > Note that unix-socket is optional because we may wish to accept chardev=
s
> > too in the future.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v2:
> >  * Replace str unix-socket with SocketAddress addr to match NBD and
> >    support file descriptor passing
> >  * Make addr mandatory [Markus]
> >  * Update vhost-user-blk-test.c to use --export syntax
> > ---
> >  qapi/block-export.json               |  21 +-
> >  block/export/vhost-user-blk-server.h |  23 +-
> >  block/export/export.c                |   8 +-
> >  block/export/vhost-user-blk-server.c | 452 +++++++--------------------
> >  tests/qtest/vhost-user-blk-test.c    |   2 +-
> >  util/vhost-user-server.c             |  10 +-
> >  block/export/meson.build             |   1 +
> >  block/meson.build                    |   1 -
> >  8 files changed, 158 insertions(+), 360 deletions(-)
> >
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index ace0d66e17..2e44625bb1 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -84,6 +84,21 @@
> >    'data': { '*name': 'str', '*description': 'str',
> >              '*bitmap': 'str' } }
> > =20
> > +##
> > +# @BlockExportOptionsVhostUserBlk:
> > +#
> > +# A vhost-user-blk block export.
> > +#
> > +# @addr: The vhost-user socket on which to listen. Both 'unix' and 'fd=
'
> > +#        SocketAddress types are supported. Passed fds must be UNIX do=
main
> > +#        sockets.
>=20
> "addr.type must be 'unix' or 'fd'" is not visible in introspection.
> Awkward.  Practical problem only if other addresses ever become
> available here.  Is that possible?

addr.type=3Dfd itself has the same problem, because it is a file
descriptor without type information. Therefore the QMP client cannot
introspect which types of file descriptors can be passed.

Two ideas:

1. Introduce per-address family fd types (SocketAddrFdTcpInet,
   SocketAddrFdTcpInet6, SocketAddrFdUnix, etc) to express specific
   address families in the QAPI schema.

   Then use per-command unions to express the address families supported
   by specific commands. For example,
   BlockExportOptionsVhostUserBlkSocketAddr would only allow
   SocketAddrUnix and SocketAddrFdUnix. That way new address families
   can be supported in the future and introspection reports.

2. Use a side-channel (query-features, I think we discussed something
   like this a while back) to report features that cannot be
   introspected.

I think the added complexity for achieving full introspection is not
worth it. It becomes harder to define new QAPI commands, increases the
chance of errors, and is more tedious to program for clients/servers.

Accepting any SocketAddr seems reasonable to me since vhost-user
requires an address family that has file descriptor passing. Very few
address families support this feature and we don't expect to add new
ones often.

Stefan

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90U6MACgkQnKSrs4Gr
c8g57ggAw/owdt5vuM0CCVc4DNk9Qyhw2r418NsWZGdoJQkXe/LjlTzKh4MG68s9
oHPTH0MLzK2iAI70wE8Uv0tJLXEOPjPktSOIJ+uHGbBUcjp2Xg6WqDqiD3l3HWgv
7N+9OdbY4Rd0+LVIWebhBCzD74p10SmVtIa4FGVDwSZWkqkIIc6Ul0y1tmQgoYfd
lpIrBn40KeMCIgz36nqxk0how6TJSQ88MvEwdvB2t66UqtXi5EEHFy9uhYo0W+Mz
NUHLphZthKBcki4bTcxnaKDUTZNxDRoqOD6sN+NjZV/aDoRzKtLcmy7ITT5HiLxt
09H393TNzrNsI60VA1y3l6+8JGaiKA==
=KIk1
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--


