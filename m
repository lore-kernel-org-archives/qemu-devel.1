Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A479C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B5F2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnEiBb1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B5F2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnIv-0004CR-0b
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXnHc-0003L0-Lx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXnHb-0001dn-Eo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:18:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXnHZ-0001dF-J0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574345883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sXBEDyWBDN1EcP1GJIlFktYZiZly7Rwb3dGQuB9LP0=;
 b=OnEiBb1T/gvTLfixjMt3xVZf2lH+t2eyf4A8a3JLzaRaPcUmoHx1r5xIGnvnjr/nWCp7XZ
 R2pGKx7lIkg/sBzYzssnW6xQYwsDq2yeeq061E2oJHJw5SK5fwqR4rwJ/m5h6aY4+G316X
 zpwJhcHNWUSj3wdCjGfFbQrcrWVu4sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-vVqrW763MXK7Vn_DRVM-hw-1; Thu, 21 Nov 2019 09:18:01 -0500
X-MC-Unique: vVqrW763MXK7Vn_DRVM-hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA73801E74;
 Thu, 21 Nov 2019 14:18:00 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 715A06CE76;
 Thu, 21 Nov 2019 14:17:52 +0000 (UTC)
Date: Thu, 21 Nov 2019 15:17:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 07/15] s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
Message-ID: <20191121151737.58f9b513.cohuck@redhat.com>
In-Reply-To: <2919845b-531d-8c79-fb16-36f67fa29789@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-8-frankja@linux.ibm.com>
 <20191121145001.5e7a182d.cohuck@redhat.com>
 <2919845b-531d-8c79-fb16-36f67fa29789@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/V3dz+E9FIC_0fwBTgAIPK1i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/V3dz+E9FIC_0fwBTgAIPK1i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2019 15:04:31 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/21/19 2:50 PM, Cornelia Huck wrote:
> > On Wed, 20 Nov 2019 06:43:26 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote: =20
>=20
> >  =20
> >>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
> >>          break;
> >>      case S390_RESET_LOAD_NORMAL: /* Subcode 1*/ =20
> >=20
> > missing blank before */ (introduced in a previous patch)
> >=20
> >  =20
> >> +        subsystem_reset();
> >> +        s390_pv_prepare_reset(env);
> >>          CPU_FOREACH(t) {
> >>              if (t =3D=3D cs) {
> >>                  continue;
> >>              }
> >>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
> >>          }
> >> -        subsystem_reset();
> >>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
> >>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
> >>          break;
> >>      case S390_RESET_EXTERNAL: =20
> >=20
> > Annotate this with the subcode as well? (in the patch introducing it) =
=20
>=20
> I think this has no diag 308 subcode and is triggered by qemu

-ENOCOFFE

But even more reason to annotate this with the fact that this is
triggered by QEMU :)

--Sig_/V3dz+E9FIC_0fwBTgAIPK1i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3WnIEACgkQ3s9rk8bw
L6+mnw/+OcTRhEMmU+KTrV8Q7yJzfhw6RfXa0z04AxEQK7JuABCqgbHra0nzXmBN
RnELkXs4RX1R9DPwJzo9D0Ad5PRlKSDtbwyiXMo2if7HUrFsvmEaoyiQdqD6+tYB
+WkCo1kDbYKKZzBZYxLZpir6J0zsCZZnKbLBnbOKGGoMyt/QX9+80oMIKJkNiZOf
Rs9+LnUZORT4mpR7h3CRfc7/6tCCFnjt6dYy4//jWApNHNan5Qlm7285Ug5BxErh
piDyNrXliCLsEtiJ1rbPlF6prFfL/r0YbY2WuoS0k5lRXfVPVbNCZkmMpf1hm83y
E9LQkFWa2aGxYtfaKaEcAddRDJ51suF7L5aE4Rk7rd2k1jMseNHExzFC+7BGM4gu
vHc9WulJlq8zCa2pjjIsJ+Vy12Lyac+EAOBjmgrGtcZkmn0OD6uuxUOWZOQTrSro
1nB8CZNmmSiLMwv9V6BI5XZG27Zf0owl12mYfiDTnNcOEC+CYdApQBW9z5Gr+ZQ8
1XF2Q/Fg84ADqlS8fA/3vvEHlBzaOM8mpwM9veYOKNg6XM7EOsWPbS/BsvMPrwQK
N+WtJFd/uxji8JeytvYLBJR/0ISu1D/oTphf8777IsNcPNjWUxkhRoCLxGT5B/uS
qCxekBfh1TS+9NyQgMukhgc/FZ3wmIg+tKHuPqQYJn4BUYUDqcE=
=PZot
-----END PGP SIGNATURE-----

--Sig_/V3dz+E9FIC_0fwBTgAIPK1i--


