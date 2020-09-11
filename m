Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB03C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D908F206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE5mkiHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D908F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkk9-0007QC-1r
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGkis-0006KF-SH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:12:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGkiq-0003iD-1H
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/O3HpFGsflqlcPJFwWArIXR8z/N4dFc3/HZf/RNbR8=;
 b=KE5mkiHdclr0PaSUTSGHyaBU0M6mg5HUSRM1mKyavwE7wX9CtoDzAruRYx13U7LU7c+Wzv
 /U3GvNlXCAN4DxK61+eEG6rVf/RNwjBiEDEmB1J6p8xAhUzZUyxgnIOf7ODNRJhAiHuXve
 G2Y/L36XrEqIMDnrD1O3WdJEYnhqVNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-IA2j_SnGPgmiFOleg72DoQ-1; Fri, 11 Sep 2020 11:12:13 -0400
X-MC-Unique: IA2j_SnGPgmiFOleg72DoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CACA8100670C;
 Fri, 11 Sep 2020 15:12:12 +0000 (UTC)
Received: from localhost (ovpn-113-177.ams2.redhat.com [10.36.113.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C533C89;
 Fri, 11 Sep 2020 15:12:09 +0000 (UTC)
Date: Fri, 11 Sep 2020 16:12:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 9/9] scsi/scsi_bus: fix races in REPORT LUNS
Message-ID: <20200911151208.GO94280@stefanha-x1.localdomain>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
 <20200831150124.206267-10-mlevitsk@redhat.com>
 <20200908152740.GF7154@stefanha-x1.localdomain>
 <b28a5a2bf78fdc563aa3b20d4cd264238545ef04.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b28a5a2bf78fdc563aa3b20d4cd264238545ef04.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xexMVKTdXPhpRiVT"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 11:20:24AM +0300, Maxim Levitsky wrote:
> On Tue, 2020-09-08 at 16:27 +0100, Stefan Hajnoczi wrote:
> > On Mon, Aug 31, 2020 at 06:01:24PM +0300, Maxim Levitsky wrote:
> > > @@ -460,46 +466,36 @@ static bool scsi_target_emulate_report_luns(SCS=
ITargetReq *r)
> > >      }
> > >      channel =3D r->req.dev->channel;
> > >      id =3D r->req.dev->id;
> > > -    found_lun0 =3D false;
> > > -    n =3D 0;
> > > =20
> > > -    rcu_read_lock();
> > > =20
> > > -    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> > > -        DeviceState *qdev =3D kid->child;
> > > -        SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> > > +    /* add size (will be updated later to correct value */
> > > +    g_byte_array_append(buf, tmp, 8);
> > > +    len +=3D 8;
> >=20
> > Can g_byte_array_size() be used instead of keeping a len local variable=
?
> Glib don't seem to have this function, I checked the docs.
> Its seems that they want to convert it to GBytes which is basically immut=
ible verion
> of GByteArray and it does have g_bytes_get_size.
> I decided that a local variable while ugly is still better that this.
>=20
>=20
> I haven't wrote much code that uses Glib, so I might have missed somethin=
g though.
> I had read this reference:
> https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html

Oops, you're right. GByteArray !=3D GBytes. The local variable makes sense.

Stefan

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bk8gACgkQnKSrs4Gr
c8h1vAgAvCF+frlhY6+1YCX92Bef3XdgjON2sen4vc0L2Suimiq1j/FMKw3WXzVq
AcXBlVEV3h6XBF5g4WfVyGK8jQiusZ7LG/GyULnal/SNpg+TpPUyYIzUb+j+qa4i
S/5dm0gAX5lSB7yvfjsrITVQFRYHrZGUjnqqKYsKWFQvNOIUoZHUrG1ZddNsGTHK
8Wh18qeCrC65mjxOfcSA4f2w6fOl3MG8PoevakrF7zY8SM6hI3YCdiJ/r4BIzIV9
qm6/uHropuVA2vSABZyq039I8FeyPs1IMI/yzXTylLUATgKzzvGXX6YBtw7lFD/V
0flurE3EBqsKTOZZWyhp9DPOxPe3Yg==
=Gh2Y
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--


