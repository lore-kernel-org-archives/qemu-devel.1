Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F4C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8478B20637
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df+Ji0Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8478B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4k7a-0005UF-Nb
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4k6s-0004Vx-PV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4k6r-00054j-NL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:35:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4k6r-00053y-J8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582198513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vInPSb0E28anbWFW9CYHdjoOs+aV2xFdbT/VWE+wstI=;
 b=Df+Ji0Z1BUGXRyuX/VmRbgaPPG2njmBhsoi5SbkYweJgNzyQNuDlGtETEYpQSMKXgfa4BS
 kn2KABJAamVkOjYhtR4l7C156zQjPj4dUbAtk4DqACht+m2cK9CFA7nW3rvpwMsJBVCLmr
 +QuGIMb2LJKqHuG6TOhWdgXDk+CyFZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-aWcVqFkCNuesIU4a1yyqNw-1; Thu, 20 Feb 2020 06:35:09 -0500
X-MC-Unique: aWcVqFkCNuesIU4a1yyqNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3FEC107ACC5;
 Thu, 20 Feb 2020 11:35:07 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6981387B11;
 Thu, 20 Feb 2020 11:35:01 +0000 (UTC)
Date: Thu, 20 Feb 2020 12:34:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 16/17] s390x: protvirt: Handle SIGP store status
 correctly
Message-ID: <20200220123449.5f8a6011.cohuck@redhat.com>
In-Reply-To: <cf0c8c3c-06d9-cc49-886e-c54281759dff@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-17-frankja@linux.ibm.com>
 <20200220120244.2ea06cec.cohuck@redhat.com>
 <cf0c8c3c-06d9-cc49-886e-c54281759dff@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/dKDB.S6ynSEyph+n+rOTjvu";
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

--Sig_/dKDB.S6ynSEyph+n+rOTjvu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2020 12:30:28 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/20/20 12:02 PM, Cornelia Huck wrote:
> > On Fri, 14 Feb 2020 10:16:35 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Status storing is not done by QEMU anymore, but is handled by SIE.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  target/s390x/helper.c | 4 ++++
> >>  target/s390x/sigp.c   | 1 +
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> >> index a3a49164e4..3800c4b395 100644
> >> --- a/target/s390x/helper.c
> >> +++ b/target/s390x/helper.c
> >> @@ -246,6 +246,10 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, =
bool store_arch)
> >>      hwaddr len =3D sizeof(*sa);
> >>      int i;
> >> =20
> >> +    if (cpu->env.pv) {
> >> +        return 0;
> >> +    }
> >> +
> >>      sa =3D cpu_physical_memory_map(addr, &len, 1);
> >>      if (!sa) {
> >>          return -EFAULT;
> >> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> >> index c604f17710..da0cfb97de 100644
> >> --- a/target/s390x/sigp.c
> >> +++ b/target/s390x/sigp.c
> >> @@ -497,6 +497,7 @@ void do_stop_interrupt(CPUS390XState *env)
> >>      if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) =3D=3D 0) {
> >>          qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> >>      }
> >> +    /* Storing will occur on next SIE entry for fmt 4 */ =20
> >=20
> > What's fmt 4? =20
>=20
> PVMs are using a FMT 4 SCB instead of the normal format 2 one.
>=20
> So I guess this should read:
> /* Storing will occur on next SIE entry for protected VMs */

Better :)

>=20
> >  =20
> >>      if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS) {
> >>          s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
> >>      } =20
> >=20
> >  =20
>=20
>=20


--Sig_/dKDB.S6ynSEyph+n+rOTjvu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5ObtkACgkQ3s9rk8bw
L68CTg/9ELlIfeFAN39zg9BRtchdtGAwtV/DN7t036MZnIXJJ+poqDChEZfyuVmp
dGuu1HgePaNLA25mbM2INWcJFa+unognpMOkSIaxk/8p/JI2iRaqH7oGsJhqrCo3
GXCksYnlPg5LefaweKdxy55fYXenz5j2ku8KuTxl6wsAoTq/ZptkiFkmRgKv4+dI
SLMjfXpGRqQHGUEEMysY0EAGYSUlFl1FQhkV4SW/0Lt62uWyjl5eR8BsSPgiZh7M
JvG8J/Ns3mP4xAVd6er74KpyarGp81OvKuVUsmXxDnH3hUFjNOGfxHIWhRdbMTFD
o87hMxytYljbjridivWGnLtlKNSCeV589Q533hv0s7C/KoLyhOES1Pzjb2A1ekj+
jP8sDpDiJBhfzGmhjBfOcNw6WgiZtu/4kyKGKyC+mFSVhgqgYWQ46FMcZvFwFVKE
XF8YpHk1Sq4ne2Lg38w6IMqFQB8na6x/LxoDmxplJo9XwluGOtq5TCsgcuHF39+Y
QEOQVkwsNalHZ5FHbj3rYYGaZjVL/LG2+TJYswQSerMthvUleDEUz90IqEfkKCIU
ILA+q0he1v0EUX+dwH0v2gqMDJSExkwTSWN7H89Vs/zzdmzmG0R9gqcHuQ0O+GAb
W0FT5ggev3d1vz+syv8GdHQSeH1J0dnhcb9yyzLDQRf/GgadqV0=
=gnq4
-----END PGP SIGNATURE-----

--Sig_/dKDB.S6ynSEyph+n+rOTjvu--


