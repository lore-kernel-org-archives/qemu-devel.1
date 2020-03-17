Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB2C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C520663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeF3PI2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Xg-0001Ne-4V
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jE9TE-0003O0-Gf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jE9TC-00047b-TO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jE9TC-000431-LU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584440949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrLU/2oKfFS7jSSW+98QZMDDPOalKw3bB3xVYxJoprQ=;
 b=CeF3PI2xvlFn1riq2PvnwCvwWMz8vyV+0QarjqBOUEv/Ua7Dc2BCvyDTyRQ31SL/xSdWRc
 QSCrlVI3zXlLieGLXgNIFjw9WtROLGh/FRcvSrOnU/Io37cKMkDupdXAx0S7GufA0hP1Gp
 mZoIuI6mGYu5u0a3V2EhuYEFbhfLuYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-wTMFJFGWOqWZaHGoLnt6Sw-1; Tue, 17 Mar 2020 06:29:07 -0400
X-MC-Unique: wTMFJFGWOqWZaHGoLnt6Sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1468E800D4E;
 Tue, 17 Mar 2020 10:29:06 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 335601001B07;
 Tue, 17 Mar 2020 10:29:02 +0000 (UTC)
Date: Tue, 17 Mar 2020 11:28:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 07/15] s390x: protvirt: Move STSI data over SIDAD
Message-ID: <20200317112850.70daa19c.cohuck@redhat.com>
In-Reply-To: <4f99c8bc-932d-2d38-a4dd-71ef54399af6@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-8-frankja@linux.ibm.com>
 <5936071e-36d7-b456-5106-d377eab15785@de.ibm.com>
 <4f99c8bc-932d-2d38-a4dd-71ef54399af6@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/V7weV+R62QnOVvXcheFEQe4";
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

--Sig_/V7weV+R62QnOVvXcheFEQe4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2020 12:20:25 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/12/20 11:42 AM, Christian Borntraeger wrote:
> >=20
> >=20
> > On 11.03.20 14:21, Janosch Frank wrote: =20
> >> For protected guests, we need to put the STSI emulation results into
> >> the SIDA, so SIE will write them into the guest at the next entry.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/kvm.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index cdcd538b4f7fb318..8085d5030e7c6454 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -50,6 +50,7 @@
> >>  #include "exec/memattrs.h"
> >>  #include "hw/s390x/s390-virtio-ccw.h"
> >>  #include "hw/s390x/s390-virtio-hcall.h"
> >> +#include "hw/s390x/pv.h"
> >> =20
> >>  #ifndef DEBUG_KVM
> >>  #define DEBUG_KVM  0
> >> @@ -1800,7 +1801,9 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u6=
4 addr, uint8_t ar)
> >>      SysIB_322 sysib;
> >>      int del;
> >> =20
> >> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib)))=
 {
> >> +    if (s390_is_pv()) {
> >> +        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib)); =20
> >=20
> > Not strictly necessary, but do we also want to do an early exit if the =
pv case fails?
> >  =20
>=20
> I'd rather do an early exit for the SIDA read/write ioctl itself

Early exit in what respect? Abort?

If not, checking the return code here and returning looks like
something we want.

--Sig_/V7weV+R62QnOVvXcheFEQe4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5wpmIACgkQ3s9rk8bw
L68ZVBAApwfpUO8/O754EB8vRFGkr95+L7EVjqeIE4rpvO7gSE+YYv2NMQx6dyTY
192GG9FmHx82uymD57xzjsbIt42OWnbw0FGu0pKxgKx7pmEMA8EAllxIlenaSNqb
3k+viPkdu45QSozJmj533JAIe+65ZVQRkKEg4Yx/2MGiooO29ouR+zLhp+q15otW
CgMwBUi5qdaPgul9wSwbrgITZ9ipOC4oXAh/Qnv378OdxqAC3NPr5oqMBNdD1xTw
WcvhNGOve/ehCnq3ycs9QlPITZZhUckaAi8NYPNEj7qy0eRYDkV4QpA6KjA8q3D1
JB1PfLY7Jtyvi+xd7k8EYR9qZsvLn1Rn8Pr685HpFryOAckAZEtMpyVVvMyERw6d
ZYH1on1zcCb9VM7oIy+MwezdbF1BnsGzUXDKwjTj8jeDrnI2BVpfPEFPn0rWI90m
SMUAef0j3WXcauk67A1Rn+G07ENI6yMld9GkSFe6+B1SmVds3JTTmhWQN0de53wH
jNYYFiSmYOoDBsSv3iP/914XHwMgftCbIN9WnvXcAxe0BaCuXxtr9W2FFoiJY1fa
Y1R1LdpSerII/hjk5ZN9K6Zz6X1oiR43wSFa3RQ1zHtBZEII/6oNv0cubOjszVJB
mBaj92XvG8jag4xl6cYnG2Jyc10No0FMpPpFP4lH1AIBCL/tYRU=
=GCzt
-----END PGP SIGNATURE-----

--Sig_/V7weV+R62QnOVvXcheFEQe4--


