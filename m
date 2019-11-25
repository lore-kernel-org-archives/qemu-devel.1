Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B87EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6F520674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZZgBtDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6F520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGft-0004wE-MB
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iZGWB-0003I6-9X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iZGW9-0006UH-Or
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:43:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iZGW8-0006U5-TE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1n3bB/7PAoMMfHzuT1CLjIeTcc8jnuTeicqn0kWkfQY=;
 b=PZZgBtDK85ngqjmVuF1sVXeu/wbn0mlzFUZA1pENqZuF1KcJlHBzBChn3YO6Xf8+FdhY+H
 6aWTUdmPc6sM9JmuncfpDxIl0StE6IohuqM7ipVQIDuoBzFYYKgirXAd26gBucIg12BF0Z
 XpmYbU14bM1UlkPgefIAzCWt4UU12O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-XfgLtMwLMt2kbEwKJ9xsgA-1; Mon, 25 Nov 2019 10:43:08 -0500
X-MC-Unique: XfgLtMwLMt2kbEwKJ9xsgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0643FA0892;
 Mon, 25 Nov 2019 15:43:07 +0000 (UTC)
Received: from gondolin (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B61D5C1D4;
 Mon, 25 Nov 2019 15:43:02 +0000 (UTC)
Date: Mon, 25 Nov 2019 16:42:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] s390x: Move clear reset
Message-ID: <20191125164249.08b00a90.cohuck@redhat.com>
In-Reply-To: <dff1140c-f773-da51-ecdd-6ad6d46c94d8@linux.ibm.com>
References: <20191125090348.27010-1-frankja@linux.ibm.com>
 <20191125090348.27010-5-frankja@linux.ibm.com>
 <20191125143714.1c7c5937.cohuck@redhat.com>
 <dff1140c-f773-da51-ecdd-6ad6d46c94d8@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/iirsXXnwIcD=HhMlJMMK/TJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/iirsXXnwIcD=HhMlJMMK/TJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2019 14:49:54 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/25/19 2:37 PM, Cornelia Huck wrote:
> > On Mon, 25 Nov 2019 04:03:47 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Let's also move the clear reset function into the reset handler.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  target/s390x/cpu-qom.h |  1 +
> >>  target/s390x/cpu.c     | 58 +++++++++++++----------------------------=
-
> >>  2 files changed, 18 insertions(+), 41 deletions(-)
> >> =20
> >  =20
> >> @@ -453,6 +424,11 @@ static Property s390x_cpu_properties[] =3D {
> >>      DEFINE_PROP_END_OF_LIST()
> >>  };
> >> =20
> >> +static void s390_cpu_reset_clear(CPUState *s)
> >> +{
> >> +    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
> >> +}
> >> +
> >>  static void s390_cpu_class_init(ObjectClass *oc, void *data)
> >>  {
> >>      S390CPUClass *scc =3D S390_CPU_CLASS(oc);
> >> @@ -469,7 +445,7 @@ static void s390_cpu_class_init(ObjectClass *oc, v=
oid *data)
> >>      scc->load_normal =3D s390_cpu_load_normal;
> >>  #endif
> >>      scc->reset =3D s390_cpu_reset;
> >> -    cc->reset =3D s390_cpu_full_reset;
> >> +    cc->reset =3D s390_cpu_reset_clear;
> >>      cc->class_by_name =3D s390_cpu_class_by_name,
> >>      cc->has_work =3D s390_cpu_has_work;
> >>  #ifdef CONFIG_TCG =20
> >=20
> > One thing I liked about the previous naming is that it is more obvious
> > that the clear reset is actually the full reset of a cpu. Not sure if
> > keeping that is better than matching the function name to the name of
> > the reset being performed. Opinions?
> >  =20
>=20
> Are you only worrying for this particular wrapper or in general?
> I'd be happy to rename the wrapper to s390_cpu_reset_full()

Yes, I was thinking about this wrapper only, but don't feel too
strongly.

--Sig_/iirsXXnwIcD=HhMlJMMK/TJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3b9nkACgkQ3s9rk8bw
L695hBAAsxs2XEqogW/TjjfBXEOy3QRxmIEsl+E2IePgD+8tuWf7cvD/cz+u5Br9
ct/+PUHd1BdrhHuoBJGcD/+3PSw8h4q0C7QsGAdRWYS6OBBW4EGQrO86tHxvedcf
41B4demtM4+evp+umSENb45osIJdD8LDWjybKMYjbYb47gJZgyLSSiwTLaNd/IEN
ZwTsqM4Q2bHzoNzpNmUGQt8mN0AmW0Q3UceP29WU7qFcgACRM02NbJLUYmQLLuYe
ADMlC6rE/0k2wyBUCo6LKvjsojgrOY5Db3CiqZS4u/wu2forHcqm8NlMy+bzGaA7
b1u8ALrAEIVrmfRf+w1KXMxgx6VnBYYbbosltD89vwcf6EtY9ZOzoZ79FLw9kUyd
aXZVurSgtCD9yC+Xnu4spFuroU4Bc2lGbHErwot31XqX8jg1hCHRdPYJ+gLTU5qB
rddwSPN43HtcWq2euABTIB7ViVMEsWq+wMUupg1mhNkFtBTsjeLTAjDZQhX+PZac
/vCl9gZaIna11cpkXCqE75VwQBa05TV59Z1P9p4hJe8MAknIH9ZXmFMfq0GrGPYj
ckC45jCf1v56VD3ynRb4x+9nI8WxAeRLekeV2vc1igz/iFZb1S51dK6DERXH7ewB
fKVE35dFBCiWVzFPw4/ZAaW8dlY4618EKyrNCmLRwyFWd6+l0oU=
=WM8m
-----END PGP SIGNATURE-----

--Sig_/iirsXXnwIcD=HhMlJMMK/TJ--


