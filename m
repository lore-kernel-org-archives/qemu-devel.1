Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2411F207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOCz6o3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2411F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2kU-0008Qf-KC
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kG2jf-0007y8-Na
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:14:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kG2jd-0006R0-Gb
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599668052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlnIjF7L86V5+9wZ1OH/H8lj8QgoBZCQnyX6nouVO6U=;
 b=QOCz6o3zuMdO5bm70gcaJGofRPsNYbl8yqAI5xL/IUX8l1pKjCaZowbtnDe59v+MnAvrwA
 zauF8KQ32MO5y0nXA2YpsX32WaDTQicRlItwNTY93+evVn3gbJTBunHr8cE/eYIit8DoiW
 3cVqMcI9XEy6CWY/tl0B3vfRWLaPUTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-KXxyPWnzMFWGjrpPAbWKzQ-1; Wed, 09 Sep 2020 12:14:09 -0400
X-MC-Unique: KXxyPWnzMFWGjrpPAbWKzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6171800466;
 Wed,  9 Sep 2020 16:14:08 +0000 (UTC)
Received: from localhost (ovpn-112-103.ams2.redhat.com [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B07C5C1C2;
 Wed,  9 Sep 2020 16:14:07 +0000 (UTC)
Date: Wed, 9 Sep 2020 17:13:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH v4 1/2] logging: Fixes memory leak in test-logging.c
Message-ID: <20200909161351.GB61449@stefanha-x1.localdomain>
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-2-luoyonggang@gmail.com>
 <20200909083001.GD12090@stefanha-x1.localdomain>
 <CAE2XoE_AOYve+0uxRp4ki8nHERbvvTLVvJnzC-Oh7HFHDkr0xA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_AOYve+0uxRp4ki8nHERbvvTLVvJnzC-Oh7HFHDkr0xA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 04:35:26PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yongg=
ang Luo) wrote:
> On Wed, Sep 9, 2020 at 4:30 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>=20
> > On Tue, Sep 08, 2020 at 11:10:51PM +0800, Yonggang Luo wrote:
> > > g_dir_make_tmp Returns the actual name used. This string should be
> > > freed with g_free() when not needed any longer and is is in the GLib
> > > file name encoding. In case of errors, NULL is returned and error wil=
l
> > > be set. Use g_autofree to free it properly
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  tests/test-logging.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/test-logging.c b/tests/test-logging.c
> > > index 8a1161de1d..957f6c08cd 100644
> > > --- a/tests/test-logging.c
> > > +++ b/tests/test-logging.c
> > > @@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
> > >
> > >  int main(int argc, char **argv)
> > >  {
> > > -    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-logging.XXXXXX", N=
ULL);
> > > +    g_autofree gchar *tmp_path =3D
> > g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
> > >      int rc;
> > >
> > >      g_test_init(&argc, &argv, NULL);
> >
> > I don't see the memory leak. There is a g_free(tmp_path) at the bottom
> > of main().
> >
> > Did I miss something?
> >
> Oh, gocha, this issue fixed by someone else. So when I rebasing, somethin=
g
> are lost.
>  I am intent replace the free with  g_autofree , should I update it? this
> is not a fix anymore, just
> a improve

If you want. It's not essential in this function since there aren't
return statements where memory leaks often occur, but since you're
already working on the code, it's still an improvement to use
g_autofree.

Stefan

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9Y/z8ACgkQnKSrs4Gr
c8iCPQgAp23ejgNO7qUhwT9wz585rQo9q32wQhqrKYKlz2xwPOibgS4qJok6wymN
+v3yFGNfC2SEyfbZFHgzMfvhXpLBnioBKqvS4yu2S3w5ME3yhbYh/U51ZSPEP+fV
6/NuQdiFr6612UPfOaDWG289lPj/UsB7D7o6ndnGoWf2rdME4CZHz1RqWXeNr/BG
iGM2jVYwSff5a5Q6PsNACtlt9WWksI8rCZLB9xPFkBwg70m5IMaWw4+AoRR6otS8
PeYkAKmzDyfeJf9yzMbikLVuxDOnotM6MXhFaUwL/OD7oJYeFsCRmCqHTxTiGIG7
ekQialjeOLGFvwvdmnADX1A2twq2jg==
=tend
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--


