Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD55C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310E220658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDEflm6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9iX-0001Ip-B1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jE9fH-0005VW-Ag
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jE9fG-00050l-1K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:41:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jE9fF-0004vk-Q9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98oGeyXVWtl7gfBE+Fz5XwqdtRJ4boDODVDfUVs//kc=;
 b=WDEflm6d9M1wdQlR3NbABQ+Be17os8SaeLOLelHZa4w8t+PLjOQ7cYoqyJi8M0C/4RxprS
 2tUwS3mglJAk+WnYzjDn+4Cs46EjmSO7VXH8/90ULAARYg3p3JnwBMSixhq5/M/lxGbl1b
 IOS2G/XaJUtG6mrpm9++eNVrIQsw4oE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-eyGusJfYPMCUPSXSmi7USg-1; Tue, 17 Mar 2020 06:41:35 -0400
X-MC-Unique: eyGusJfYPMCUPSXSmi7USg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF43800D5F;
 Tue, 17 Mar 2020 10:41:34 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6747E31B;
 Tue, 17 Mar 2020 10:41:29 +0000 (UTC)
Date: Tue, 17 Mar 2020 11:41:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 07/15] s390x: protvirt: Move STSI data over SIDAD
Message-ID: <20200317114118.2e33d32f.cohuck@redhat.com>
In-Reply-To: <eb5e64f6-69a0-424f-ef4b-36f999fdbca8@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-8-frankja@linux.ibm.com>
 <5936071e-36d7-b456-5106-d377eab15785@de.ibm.com>
 <4f99c8bc-932d-2d38-a4dd-71ef54399af6@linux.ibm.com>
 <20200317112850.70daa19c.cohuck@redhat.com>
 <eb5e64f6-69a0-424f-ef4b-36f999fdbca8@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/eqG/SYldIbZPXgjG/9Wdt.F";
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/eqG/SYldIbZPXgjG/9Wdt.F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2020 11:32:03 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/17/20 11:28 AM, Cornelia Huck wrote:
> > On Thu, 12 Mar 2020 12:20:25 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> On 3/12/20 11:42 AM, Christian Borntraeger wrote: =20
> >>>
> >>>
> >>> On 11.03.20 14:21, Janosch Frank wrote:   =20
> >>>> For protected guests, we need to put the STSI emulation results into
> >>>> the SIDA, so SIE will write them into the guest at the next entry.
> >>>>
> >>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  target/s390x/kvm.c | 11 +++++++++--
> >>>>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >>>> index cdcd538b4f7fb318..8085d5030e7c6454 100644
> >>>> --- a/target/s390x/kvm.c
> >>>> +++ b/target/s390x/kvm.c
> >>>> @@ -50,6 +50,7 @@
> >>>>  #include "exec/memattrs.h"
> >>>>  #include "hw/s390x/s390-virtio-ccw.h"
> >>>>  #include "hw/s390x/s390-virtio-hcall.h"
> >>>> +#include "hw/s390x/pv.h"
> >>>> =20
> >>>>  #ifndef DEBUG_KVM
> >>>>  #define DEBUG_KVM  0
> >>>> @@ -1800,7 +1801,9 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __=
u64 addr, uint8_t ar)
> >>>>      SysIB_322 sysib;
> >>>>      int del;
> >>>> =20
> >>>> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib)=
)) {
> >>>> +    if (s390_is_pv()) {
> >>>> +        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));   =20
> >>>
> >>> Not strictly necessary, but do we also want to do an early exit if th=
e pv case fails?
> >>>    =20
> >>
> >> I'd rather do an early exit for the SIDA read/write ioctl itself =20
> >=20
> > Early exit in what respect? Abort? =20
>=20
> Yes, abort
> If a write fails we most likely will not succeed on the continuation
> check and if a read fails we will error out somewhere in qemu anyway

Ok, so this will go into the previous patch, I guess?

--Sig_/eqG/SYldIbZPXgjG/9Wdt.F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5wqU4ACgkQ3s9rk8bw
L68vAA//RMXYVsk6o51+YzZe5BJ7TVNQaz8mIgL/fPdGQYmmBKi/smiplu+Edt+y
XeutH6ezFaa1FlJtXX3/ow6BRn2+a2TZXVsGEiW+w/PHijEL8MYPvxJMzu38mPFF
Q3ZsxrStk0B5M4jyD7e7ssjsckTIurzvk4QeUXaoBOPM1G+qbEs9aWQLyhOLttXM
UYmES7xBfeXsh6I4D29bY1FdhyHnIl607rFcgWOoWFOCc09a6y5e4wQmbTPT76I3
PkLN23UYdT9XVu1+uE8CH9vhIqHr2Jma4vMzDedz/Zoi/x9T0Df6fHFGGei7p/qV
HdfLDW/jTCNeh4iHSTKxnSGqQpaQtiMhQd0RYtoA6rb8wJOElemonXYSpmdWIaB0
znKVfiiffLL03vsVYCI9Evy3nN0ohFw8llHiZvEGclnFZt05sC5t66AAHang/yte
jq5Cj87ficegl97poQrHdzKzQfuSQ7zYC3s9JQHDYoIsRMoM6/Tz/rJRfTj74D0L
6UJIny3io+fkQHIKVzKoI1xSdi/A10rBnXpVb6S//YBDjTOnqhfytJMahGSVok62
gam77i9Vch/8+2ROVuFWdOvz4hvogy57VyPyKrwSLqkSfBqWhK9fkrq81D/QXFV7
8k9nMDZaEcNDan3dSgsFYhKY4A8LOer4P3DCimceDeSDgprw6cs=
=tDTS
-----END PGP SIGNATURE-----

--Sig_/eqG/SYldIbZPXgjG/9Wdt.F--


