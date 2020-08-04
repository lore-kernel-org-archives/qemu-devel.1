Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9BFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3DB2070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QieeDLAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3DB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uJP-0000QX-Od
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uIq-0008QZ-Sg
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:36:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uIn-00028O-2Q
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596537371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bcyIf3xfGirLBu5KAuOouCIsAcyHrDOaTvNb9yEKQg=;
 b=QieeDLAuBr5YDnlU4Jj1X+5BmdpH9iOvZtwId3JCPRWUYuRvRbVfiCR5SNZ7q/1/+wAhyb
 6dU4dEQPMGiO15kpm2zFfVhi3UF1nRh/QqUjBWpLt8Rkpa/QHPumxgCScmro+1YmqNscqO
 7B/DR0DSLbEgHtTshWwAdfyhWyclmxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-BOf1QPVtNquhFz_1iq0WvQ-1; Tue, 04 Aug 2020 06:36:09 -0400
X-MC-Unique: BOf1QPVtNquhFz_1iq0WvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E6C1083E80
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 10:36:08 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E731E10013D0;
 Tue,  4 Aug 2020 10:36:04 +0000 (UTC)
Date: Tue, 4 Aug 2020 11:36:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 4/5] virtiofsd: Open lo->source while setting up root
 in sandbox=NONE mode
Message-ID: <20200804103603.GC1284284@stefanha-x1.localdomain>
References: <20200730194736.173994-1-vgoyal@redhat.com>
 <20200730194736.173994-5-vgoyal@redhat.com>
 <20200803095459.GD244853@stefanha-x1.localdomain>
 <20200803135715.GA233053@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803135715.GA233053@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2020 at 09:57:15AM -0400, Vivek Goyal wrote:
> On Mon, Aug 03, 2020 at 10:54:59AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jul 30, 2020 at 03:47:35PM -0400, Vivek Goyal wrote:
> > > In sandbox=3DNONE mode, lo->source points to the directory which is b=
eing
> > > exported. We have not done any chroot()/pivot_root(). So open lo->sou=
rce.
> > >=20
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > index 76ef891105..a6fa816b6c 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -3209,7 +3209,10 @@ static void setup_root(struct lo_data *lo, str=
uct lo_inode *root)
> > >      int fd, res;
> > >      struct stat stat;
> > > =20
> > > -    fd =3D open("/", O_PATH);
> > > +    if (lo->sandbox =3D=3D SANDBOX_NONE)
> > > +        fd =3D open(lo->source, O_PATH);
> > > +    else
> > > +        fd =3D open("/", O_PATH);
> >=20
> > Up until now virtiofsd has been able to assume that path traversal has
> > the shared directory as "/".
> >=20
> > Now this is no longer true and it is necessary to audit all syscalls
> > that take path arguments. They must ensure that:
> > 1. Path components are safe (no ".." or "/" allowed)
> > 2. Symlinks are not followed.
>=20
> This code does not change the path client is passing in and we are
> already doing the checks on passed in paths/names. So existing checks
> should work even for this case, isn't it?
>=20
> lo_lookup() {
>     if (strchr(name, '/')) {
>         fuse_reply_err(req, EINVAL);
>         return;
>     }
> }
>=20
> lo_do_lookup() {
>     /* Do not allow escaping root directory */
>     if (dir =3D=3D &lo->root && strcmp(name, "..") =3D=3D 0) {
>         name =3D ".";
>     }
> }

Yes, hopefully paths are already checked and syscalls do not follow
symlinks. However, we wouldn't have noticed if either of those were
missing since the pivot_root(2) ensured that path traversal stays within
the shared directory.

Now that a layer of protection has been removed it's necessary to check
again whether everything is really alright.

>=20
> >=20
> > Did you audit all syscalls made by passthrough_ll.c?
> >=20
> > virtiofsd still needs to restrict the client to the shared directory fo=
r
> > two reasons:
> > 1. The guest may not be trusted. An unprivileged sandbox=3Dnone mount c=
an
> >    be used with a malicious guest.
> > 2. If accidental escapes are possible then the guest could accidentally
> >    corrupt or delete files outside the shared directory.
>=20
> Even if escape is possible, its no different than a malicious user
> application running. Given sandbox=3Dnone can be used in case of
> unpriviliged mode, that means user app can only affect files owned by
> that user.

Users may run untrusted guests. Those guests should not gain access to
the user's files outside the shared directory.

> If doing chroot/pivot_root is must, then we need additional capabilities.

I think it's not a must, but just an extra layer of security. What I
don't know 100% is whether virtiofsd accidentally relies on that extra
layer of security today since it never ran without it :).

Stefan

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pOhMACgkQnKSrs4Gr
c8guwAf/VzWCrF8gU2TyirNenM6hAUUNehn9r0oFneTOWyiN+lGMUgznl1dZSLjE
7xOa968yo88CpK9ukzZTsa6qV28SWatInBGTa4jere1ju4gX9hvUpj8w+h9/Y0gq
gBlymLvn8ABGd4AcjCNsZPoNLsERJ35UUkMNyxPiLAiAEx93ujJvtkA1dq15DAUj
dZUEYyS0A1szZMH5HkDFOifcSQJjQ2LY3sqbBVYw8WhyYoCKVPS+v97LVzitXmCS
NksNIE5EDrSgmxfa43wZ57pCqtlZi2qsBrd+Gm35i4wzFU0pFEc6kcQpYXDJMOiO
b0qSr3S/KkcM478tnHbEMory1P3lMg==
=bD9h
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--


