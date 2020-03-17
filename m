Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD1C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2AF20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQ1NMzUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2AF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFSX-0002gg-4k
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEFP3-00064s-Nf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEFP2-0005t7-3Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:49:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEFP1-0005lT-T3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584463755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TTlAhk/7drsqfeKyqvIFiaFPJtt8PqcGysqpb1xeLY=;
 b=cQ1NMzUr+4BWmEbmJgkBMx/FPArYRP1pqYJ0VZ/cQXBlNQoNyqNYtWkfshplx5ulnfMFOc
 s2fxn0ZE0NRoNFWOq4DdnL1whjsfcqIUrWbxMYvzXX6Wt8HrZaUAvBneD9kXMdWfKjJVkw
 zo5+DNwRQICU9duiE8ske+3z9Xr0vik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-2nfN7rXLPoOAbPPIV2UyUw-1; Tue, 17 Mar 2020 12:49:13 -0400
X-MC-Unique: 2nfN7rXLPoOAbPPIV2UyUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E6613F6;
 Tue, 17 Mar 2020 16:49:12 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDD95DA7C;
 Tue, 17 Mar 2020 16:49:07 +0000 (UTC)
Date: Tue, 17 Mar 2020 17:48:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 13/15] s390x: protvirt: Handle SIGP store status
 correctly
Message-ID: <20200317174856.456810a5.cohuck@redhat.com>
In-Reply-To: <d40bc40f-c217-f464-9f65-ea8899bbb899@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-14-frankja@linux.ibm.com>
 <b89dafb1-d931-906a-671d-caf71d795873@de.ibm.com>
 <d40bc40f-c217-f464-9f65-ea8899bbb899@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/R/2wqm8DRngjT4AqwRZO.No";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/R/2wqm8DRngjT4AqwRZO.No
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2020 17:13:10 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/12/20 4:51 PM, Christian Borntraeger wrote:
> > On 11.03.20 14:21, Janosch Frank wrote: =20
> >> For protected VMs status storing is not done by QEMU anymore.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com> =20
> >=20
> >  =20
> >> ---
> >>  target/s390x/helper.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> >> index ed726849114f2f35..5022df8812d406c9 100644
> >> --- a/target/s390x/helper.c
> >> +++ b/target/s390x/helper.c
> >> @@ -25,6 +25,7 @@
> >>  #include "qemu/timer.h"
> >>  #include "qemu/qemu-print.h"
> >>  #include "hw/s390x/ioinst.h"
> >> +#include "hw/s390x/pv.h"
> >>  #include "sysemu/hw_accel.h"
> >>  #include "sysemu/runstate.h"
> >>  #ifndef CONFIG_USER_ONLY
> >> @@ -246,6 +247,11 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, =
bool store_arch)
> >>      hwaddr len =3D sizeof(*sa);
> >>      int i;
> >> =20
> >> +    /* Storing will occur on next SIE entry for protected VMs */ =20
> >=20
> > Maybe ... next SIE entry of the sending CPU ....=20
> > ? =20
>=20
> Well that would be the current cpu, right?
> So:
> /* For PVMs storing will occur when this cpu enters SIE again */

With that comment tweak,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--Sig_/R/2wqm8DRngjT4AqwRZO.No
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5w/3gACgkQ3s9rk8bw
L6+XLA/+Nn+rtlyOM65n+AlXmzA8WSuBVBi0w/H8Ze+FCQGERC/U+FwFud+oIXjn
RfLsnOp8IZ/UFfmHpqiPH2Hz1iKR9ytWB17p6/RkPVl0UMGQYESwSO0mFcydvUIn
ROzuNyra6656+iQxL0Jj2up4ptO7aZXcmVk7HFt2bOAQAIgUA5fRtpIhceSzof4D
DC2DpgqNOI/Cf7TnEX2hPIpMfoer0QchH8/nRJA8+15r3PNP2sh3O68GbEW5ySTy
3w9Whz/ikSTqntKVWUEoYOo7SQMOSCaakk6dvYhHRsjtWto8dblH8OjknTuhKpJR
TkQTNJsEjeA2hr19LZdg5LKJgzg3UU48fAzB3ZYnyyjPbAJdNaYQERX3oTn6FnKa
YBpfIjrSweWeVtEn6Wa0e+2Yjlj3du/l5KAGF0NDSx0IQ7C+1Q5xAt4UDSRrrfBO
e72hA6EIAK23uCfc9NYuY6TQsBIpTBxnHdOW6DzE2iARHA9Fk7I4f7UnVGhEsZxC
lGGMvsCYfZfmH3YiG0j0NuUFYh7HmILyuJ7gXPESNSPfUm0kHe4NLVUclVpKoOvB
mD24ty/3631KPbIZ5ufLEDKf9E0H5bemKXUVw8H4VHSpVPLrnIlrYNfScISBgLZ9
egWZ4ATAxdtfU8ZW9W6jwyZA/WliuJIp7ytvtHoiCZEqt/Fxosw=
=p2K1
-----END PGP SIGNATURE-----

--Sig_/R/2wqm8DRngjT4AqwRZO.No--


