Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A15C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276B21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGzO0MhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276B21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOHr-0001xs-2x
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaMVe-0001Fp-IN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaMVM-0007Fk-O0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:18:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaMVL-0007DI-Eo
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574957934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuoeCvQxPY2zi6GOIRuPI1p5MgGz09ELKDH59B2pOMQ=;
 b=FGzO0MhUYdSK+CgGa6A20rOkhbRfksMc63Cy0pk7dyd+1wac9HnM79R6GPJdPevy2oMv2J
 IIebUjwkv38SGkXzmgiUuqRtvJBR2coN5fs/XuBEDcyRK9yWcy3A0obiWTXG3rK0qUPNpH
 Wvk5UJ9hH0gzBLzrzKFkAIOohrqfc2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-T-FGe5s-MYyakSyHbZj-bQ-1; Thu, 28 Nov 2019 11:18:52 -0500
X-MC-Unique: T-FGe5s-MYyakSyHbZj-bQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5560A18C841A;
 Thu, 28 Nov 2019 16:18:51 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6FF5C1B2;
 Thu, 28 Nov 2019 16:18:46 +0000 (UTC)
Date: Thu, 28 Nov 2019 17:18:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 14/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
Message-ID: <20191128171832.191f2636.cohuck@redhat.com>
In-Reply-To: <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-15-frankja@linux.ibm.com>
 <db581b32-2b84-683c-0e7e-b6ee908eb701@redhat.com>
 <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/LZphlgqIj6YWahpLPlxClG2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/LZphlgqIj6YWahpLPlxClG2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2019 17:10:38 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/28/19 4:28 PM, Thomas Huth wrote:

> > Would it make sense to hide all these changes in decode_basedisp_s()
> > instead? ... so that decode_basedisp_s() returns 0 if env->pv =3D=3D tr=
ue ?
> > ... or are there still cases where we need real values from
> > decode_basedisp_s() in case of env->pv=3D=3Dtrue? =20
>=20
> I'd like to keep decode_basedisp_s() as is, but how about a static
> function in ioinst.c called something like get_address_from_regs()?
>=20
> It'll call decode_basedisp_s() or return 0.

We could do something like that; but do we ever get there for other
instruction formats as well? It feels a bit odd to single out this one.

--Sig_/LZphlgqIj6YWahpLPlxClG2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3f81gACgkQ3s9rk8bw
L6/N6w/+I1Zi0qQtBep1W1Goik+TdmFew+kOx34q7yY03YfbBdfBRLeWxsZ0r7O/
yCMbbTHZQBBgXru6uB7aaKH0/g+e+nNfNO+dw5GNYj/cZ1NxT+AlYCqA+sBS4/gg
Cr2QuDv8N8s5NxEVCNnhR3ZcGxiZc4Hmg3NunkV4kqhvmEms4ZHaZu6E4yImKeOK
AXbrhT1CPwfwCk2giS66EyN3sT3YMhue/qh7+yBLr/BERH872BvMRQkQpE2CNpTv
L1Q7bCinL4HZ/N+RTnK9NZtgrLbdUDCw6/qrLUMSCCchMeUY9GpLRFCxDJXNhIDl
Y5OdMtsnHz/+vW60dg1Z8DRp2rlBPKn8OK1P5MS9EZ/JivjMVRFX/WyPVjMgmpjy
cUd1aWB1ZbeK/q/lqmpBFP+5LYkk7OhkUIK64ED9bolGk9z3V6yu4QFz8d+CvDvD
8xrhspOR7Oa9h+ZU0hEirp0hnwdW+5ykA+R28fPbShLDwn1wcG9ZO9So6lxQxopM
9WD8wvcFE3IeWZ4xpC5q0KvY6AtjCnQieMm4mTCCaJA4pZvG4l7UTDxHojNcbXqC
bDYTlZNylkVWdG4CWvUy+o2ValsDe1xT0WqipBva6d4j4Q3Fk44gGwBCIGWK1vI0
ix89lZrLR1B196Zyq25GnLFij7aDbzpyfEBeNp1hUrmSKr+6TZM=
=URKD
-----END PGP SIGNATURE-----

--Sig_/LZphlgqIj6YWahpLPlxClG2--


