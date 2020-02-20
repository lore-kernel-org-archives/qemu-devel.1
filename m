Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD5C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C89208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp13LSjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C89208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4kCW-0007VI-Em
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4kBj-0006vN-Ip
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4kBh-0000gj-2H
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:40:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4kBf-0000dT-Kn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582198808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZqghI6VTnDayWziq1i1qFh+ovH15acB9NY3pwvnxxU=;
 b=Fp13LSjZknoUl4UoHh9wRqJ3pDV55qv86B+WzEP9q7j6XiCj6d/eIDMCMQqFw1UawvEx8/
 cCHNzMB4A+qk1914qWvmXV6IadHv/yZ31Zz7f5DgJR4V6QPmLR8qI4JUsl0Har76Yg+fEN
 E+JcZh29waAuHvBdxHVdY+vAmtIyMag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-iZ3XmRUXPE2jJhO-5fLBrg-1; Thu, 20 Feb 2020 06:40:01 -0500
X-MC-Unique: iZ3XmRUXPE2jJhO-5fLBrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973A6800EB4;
 Thu, 20 Feb 2020 11:40:00 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D32260BE1;
 Thu, 20 Feb 2020 11:39:56 +0000 (UTC)
Date: Thu, 20 Feb 2020 12:39:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 06/17] s390x: protvirt: Add migration blocker
Message-ID: <20200220123953.5b0272a4.cohuck@redhat.com>
In-Reply-To: <fbcacbf4-75d6-55f9-2ad3-6cd47b400fce@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-7-frankja@linux.ibm.com>
 <20200220114815.01634a4c.cohuck@redhat.com>
 <fbcacbf4-75d6-55f9-2ad3-6cd47b400fce@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/sQjOuS8R2bGfHEWXv5_Avg.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/sQjOuS8R2bGfHEWXv5_Avg.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2020 12:24:23 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/20/20 11:48 AM, Cornelia Huck wrote:
> > On Fri, 14 Feb 2020 10:16:25 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Migration is not yet supported.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 5fa4372083..d64724af91 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -42,6 +42,9 @@
> >>  #include "hw/s390x/tod.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "hw/s390x/pv.h"
> >> +#include "migration/blocker.h"
> >> +
> >> +static Error *pv_mig_blocker;
> >> =20
> >>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >>  {
> >> @@ -373,6 +376,7 @@ static void s390_machine_reset(MachineState *machi=
ne)
> >>      CPUState *cs, *t;
> >>      S390CPU *cpu;
> >>      S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
> >> +    static Error *local_err;
> >> =20
> >>      /* get the reset parameters, reset them once done */
> >>      s390_ipl_get_reset_request(&cs, &reset_type);
> >> @@ -422,6 +426,17 @@ static void s390_machine_reset(MachineState *mach=
ine)
> >>          }
> >>          run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
> >> =20
> >> +        if (!pv_mig_blocker) {
> >> +            error_setg(&pv_mig_blocker,
> >> +                       "protected VMs are currently not migrateable."=
);
> >> +        }
> >> +        migrate_add_blocker(pv_mig_blocker, &local_err); =20
> >=20
> > If I'm not lost in the context, that's during PV_RESET. I'm a bit
> > confused why you'd add the blocker here? =20
>=20
> Where would you want me to add it?
> It's here where we switch into secure mode and I need to block before
> switching and unblock if it fails.
>=20
> When having the blocker in diag.c, I'd have a hard time unblocking on a
> PV switch fail.
>=20
> >  =20
> >> +        if (local_err) {
> >> +            error_report_err(local_err);
> >> +            error_free(pv_mig_blocker);
> >> +            exit(1); =20
> >=20
> > Why the exit()? Can't you fail the call? =20
>=20
> Well, if that fails and we go protected, I wouldn't be protected agains
> migrations, right?

No, I meant not go protected, if that's possible.

>=20
> >  =20
> >> +        }
> >> +
> >>          if (s390_machine_pv_secure(ms)) {

Ok, I think what confuses me is this call: it reads as if you actually
tear down things if the machine is secure. Call it
s390_machine_pv_make_secure() to make sure it is actively doing
something and not checking a previously set value?

> >>              CPU_FOREACH(t) {
> >>                  s390_pv_vcpu_destroy(t);
> >> @@ -430,6 +445,7 @@ static void s390_machine_reset(MachineState *machi=
ne)
> >>              ms->pv =3D false;
> >> =20
> >>              s390_machine_inject_pv_error(cs);
> >> +            migrate_del_blocker(pv_mig_blocker);
> >>              s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> >>              return;
> >>          } =20
> >=20
> >  =20
>=20
>=20


--Sig_/sQjOuS8R2bGfHEWXv5_Avg.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5OcAkACgkQ3s9rk8bw
L69RUhAAlXxC3WtBgIZ7cm7dU4q+Pe1YxbjstWGsVBzAWCayy3GnhIEICCQjNUvB
D3SJkemV6SmQFTrxy8J3Ktkj8VlZOPaEcnt1PLiMvbKtj1d/duBECSXMBbRQ347J
j14X/hwVCR6SwkU+w8TOjgwHBxMgAg/QR2O4TnauoQ8egN7Wd5uB0xfJoPQeRgQv
T0z+0wx5PguuE56c10S/m9WFjLB8ynFM4GFmFidpikFpi5VnaLNE5DYrGYpsu8ZA
x3oH6Y8qIBNG+EG77BpvkRzJmZyD+C42Q2CksWXa2uPYauGRbL/pXxvuaVQ4B20g
Q5yv2pgrEjhNWQECUFdrB8Cza7utExzQGiSSnSTA6/kJn8k6PWvdv5dh52h/CC4j
b5Ei+9fFjSheiUBbdKVBRVLsYE8njYllU0Jep4bUV6GW05OS+LrtBPsZqRAkOOJS
ey5Kh8ME89VKCIkqIs5xkbLWuTV9Rw84Xyr9yk8rg1YYh11iWZxxKpbOW/8sHOgw
dp/t9YrRsgRZgC3ZIUp6Ixgste/ZQEZE0HiA3ukrlRFZJwK3plwVPGo9Ja0H4xMX
dz+dxUUxSWL86aiFoHPwWhfTcri1wo6onzAH20jYlpe/WQj+CsgCQMVBuWT+REfK
HyN6PnPjDXpUAJvvM6YU4sW6ERZPMieotQ2sWXJp8+KBNw0TvUM=
=UH4W
-----END PGP SIGNATURE-----

--Sig_/sQjOuS8R2bGfHEWXv5_Avg.--


