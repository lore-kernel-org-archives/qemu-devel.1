Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADCEC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607F123600
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnKL6Wt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607F123600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLDyY-0003ub-FZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDx6-0003Gi-Ls
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDx4-00005C-NM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600902809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIx//qx3Bizex3Q7K6bz8SxGjjzvHjWFeU9EfojuCHg=;
 b=SnKL6Wt5bbGUPupleDQxAiuO9ATKd1wqL3Jq0xyT1XJbMiavs4nbPJhLENwZODqhRSXKfl
 wJR0Jg9Q7L9jtB3aMxCINIV797ECoboFlO3q7U80JZjn/bwuSRmhqIPVF9qkNHpLBYaRXX
 KlR7h5HVCSeEEO6JtSXb91Sh556FIKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-i4LM55HxPP-oV9Xqjd1MxQ-1; Wed, 23 Sep 2020 19:13:26 -0400
X-MC-Unique: i4LM55HxPP-oV9Xqjd1MxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E29425CE;
 Wed, 23 Sep 2020 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B675C1C7;
 Wed, 23 Sep 2020 23:13:24 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:13:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200923231322.GA296416@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
 <20200923230846.GX191229@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200923230846.GX191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 07:08:50PM -0400, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:47PM -0400, John Snow wrote:
> > The edge case is that if the name is '', this expression returns a
> > string instead of a bool, which violates our declared type.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/gen.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > index 9898d513ae..cb2b2655c3 100644
> > --- a/scripts/qapi/gen.py
> > +++ b/scripts/qapi/gen.py
> > @@ -251,7 +251,7 @@ def __init__(self, prefix, what, user_blurb, builti=
n_blurb, pydoc):
> > =20
> >      @staticmethod
> >      def _is_user_module(name):
> > -        return name and not name.startswith('./')
> > +        return name is not None and not name.startswith('./')
>=20
> Another possibility here that handles the empty string situation and
> will never return anything but a bool:
>=20
>   return all([name, not name.startswith('./')])
>

Never mind me... I noticed that this actually gets called with None.

- Cleber.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r1pIACgkQZX6NM6Xy
CfMi3A//dWf9abCqareaGYgBEsJTpxBi/jsH9M9UrJZOOg5OJw5zq9hPwe++cdzX
/buNDCcHeVrrCsv/LntQ3ZIaYdQUzNXa22scqIfgqp4TPLDPOwO4lxdak6wRiTUS
9LK2IUAqdz47p+90Nmfsciw0ni12PC0fnBKYjT0D9YsDL5XqdcVC/iCB/PuXMqVR
YDVARvfbDr/aoIOX85WuWbCidNbeiF8aZ+hZsGcU6kwtuxtag7xaHCO3sIrOPJVz
PavliEBtNPMgWuA27GS6RdRoiTVn0HPE8MKuHpo5PwM5E2yCN3GZkypVIKC6MmiV
K0PJjd4fq87Vj2DRJTtdpMQ+8KHloWPtVy798ap5nIGbGXclCxry5+E/b3IJVfIt
YZQeCeHufemuFA9eAEKLWalLucGMq3mun8n0OYYrEdlpo9zf991sZ26osD59XUFd
WKcogv98EXC0jKnyWiRJQ546r8iNjhbjF1saiKEtF1AfV0nbmehhHBzk+WEkzj2t
zAUauFzUMoKpy82XEaLEubpXKYtWhMaJ3WdlcZaMxOD0L/06kzGylbBsBfX5or7h
+k9UyCOL/bTUo1VmDkCGV3K1FxqR2JWBhOv8YslNjQkQ2Tv7dbSFRxo1JYSB1zSG
m2Z4rJUfhoflAgGzXQcRBTF9tmEwOg92B4k/NKc1xUAGUcl65xE=
=QdbH
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


