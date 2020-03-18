Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EBC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD32920768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOCwCifN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUzi-0004CO-03
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEUz7-0003lJ-2B
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEUz5-0004j8-W4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:27:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEUz5-0004iQ-RU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584523651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7dV6GkzIQnvIYGcoARrvNTvWJJSNzYrr9iyXBu6J4M=;
 b=iOCwCifNiCo4Vg71qqXXQ66AEECkgSFHSps0txs7ev7tEAeVnN5NDw8uxlnUmfGorxepMN
 3PYMlmsbs13BufR6A44PzpCMJa78fPYyFUZ4aBvmf0cLE1Y+lsYG7LEOKiTOVrP9CLkeqW
 imdGWRPo+YDwgyiuH3Vo5O+A+ZsGFug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-JT6bAY4gNoeFFtHjwy4bSQ-1; Wed, 18 Mar 2020 05:27:29 -0400
X-MC-Unique: JT6bAY4gNoeFFtHjwy4bSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB34800D54;
 Wed, 18 Mar 2020 09:27:28 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 781367E33B;
 Wed, 18 Mar 2020 09:27:24 +0000 (UTC)
Date: Wed, 18 Mar 2020 10:27:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 15/15] s390x: Add unpack facility feature to GA1
Message-ID: <20200318102712.4bd4f254.cohuck@redhat.com>
In-Reply-To: <64ebd363-da9d-a98a-a50d-aa3994044015@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-16-frankja@linux.ibm.com>
 <20200317190605.36c5c73b.cohuck@redhat.com>
 <64ebd363-da9d-a98a-a50d-aa3994044015@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/3.E_ZJzqglXpD1qgBV.DQ.u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/3.E_ZJzqglXpD1qgBV.DQ.u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2020 09:44:08 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/17/20 7:06 PM, Cornelia Huck wrote:
> > On Wed, 11 Mar 2020 09:21:51 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:

> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index ff6027036ec2f14a..e11e895a3d9038bb 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -2403,6 +2403,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *=
model, Error **errp)
> >>          clear_bit(S390_FEAT_BPB, model->features);
> >>      }
> >> =20
> >> +    /* we do have the IPL enhancements */ =20
> >=20
> > I'm more confused by that comment than educated :) Not sure what 'IPL
> > enhancements' means in this context. =20
>=20
> /* We do have the protected virtualization ipl unpack facility */
> ?

Ah :)

What about

/*
 * If we have support for protected virtualization, indicate
 * the protected virtualization IPL unpack facility.
 */

?

>=20
> >  =20
> >> +    if (cap_protected) {
> >> +        set_bit(S390_FEAT_UNPACK, model->features);
> >> +    }
> >> +
> >>      /* We emulate a zPCI bus and AEN, therefore we don't need HW supp=
ort */
> >>      set_bit(S390_FEAT_ZPCI, model->features);
> >>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features); =
=20
> >  =20
>=20
>=20


--Sig_/3.E_ZJzqglXpD1qgBV.DQ.u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5x6XAACgkQ3s9rk8bw
L6+Jzw//VC0Iw2iA5gE2zGGkKMDJ4emwYghduSnCc49ckokfunzXfrnu0qVxpqiT
/DK36ky017qS1s3eubuTbC8OkbkFtRK+7cxrY2fLE1bnPMxhnvoss24J9hnLal70
zNmpPkttM8axX1wN8XUFPLTbYnQuUN9kni5B1QJf3yNmdU98zEke/QXk0cRgN9MC
MhmA6yzhQrQZezTJfALKekEMEP52x/8sl5GT9GlLIeZJo58uoNl2CVbxYK+JEeFt
AGHQnv4IOYUAoMKuanTJ2tjOveKd/9GutrfMgtyragK15berphUIfEOeDUOHciJU
HTjjfdMgvr0/fc8FCW5C6uNnHblVR/tvyBR/+m2uQ1chHpqomRSATsBn1xhbniWP
kO73lT0RAfed09GcZ0s60Q52I6+/fGbmEgUG2kARmRHk+tfiMtOFm7ufobpz6B8m
Cns+qWF1MVqdLQOspPy/S89EJFQ8EKOIp0rv/bAPlTe0NeqZD/ZN5o/vMOSMt7Ws
niXBoWncdYsN4+1TaMfA6tWx8P2j7KZFP1ZcBNPprXmFSLRMSHI3vm0kQcF2nHRO
GqTBzWqrPzfxdQGebYDinHy/KBHwqPuzkXWanIc4VyBwZ84iu8LiXNX8dYKEpLiR
eVRsIAOFt1/2rGABI9tc7KXnrq0cfv0Nk7I9sgMNrkzya4Be1Gk=
=ZMjk
-----END PGP SIGNATURE-----

--Sig_/3.E_ZJzqglXpD1qgBV.DQ.u--


