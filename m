Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4054921771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG1866re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4054921771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPNf-00013n-6D
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaMwH-0001jv-Vr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaMvx-000778-N1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:46:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaMvu-0006nc-NT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574959579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7Zyor4f+SnOoIGq937UVRKBknDfuK/yutmUID31h3k=;
 b=RG1866re+HojnIJqKNXlPYsIHNMctbKCco2gucqooBx/fkZF+1Cgk8pRHvybicuA6zaI1W
 2CGYVeo5bTvhKRiv/bOr12DjaCksasOms9yzL0sYHshBVqeX/qL1J+b3G5H4XIU88E/04m
 ZQUHHroKJjTQcQec2PIePz3mH5ZjnYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-QGmmLYneM6eiL5jCIKSH0w-1; Thu, 28 Nov 2019 11:46:16 -0500
X-MC-Unique: QGmmLYneM6eiL5jCIKSH0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7554A107ACC5;
 Thu, 28 Nov 2019 16:46:14 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7279600CA;
 Thu, 28 Nov 2019 16:46:09 +0000 (UTC)
Date: Thu, 28 Nov 2019 17:45:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 08/15] s390x: protvirt: KVM intercept changes
Message-ID: <20191128174557.2e421e94.cohuck@redhat.com>
In-Reply-To: <da848181-41a3-0738-84f8-258046965671@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-9-frankja@linux.ibm.com>
 <d081f111-857c-048b-c753-3cc021304102@redhat.com>
 <da848181-41a3-0738-84f8-258046965671@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/2f+4qa5JN6ldMWPdpHobzcs";
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

--Sig_/2f+4qa5JN6ldMWPdpHobzcs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2019 17:38:19 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/21/19 4:11 PM, Thomas Huth wrote:
> > On 20/11/2019 12.43, Janosch Frank wrote: =20
> >> Secure guests no longer intercept with code 4 for an instruction
> >> interception. Instead they have codes 104 and 108 for secure
> >> instruction interception and secure instruction notification
> >> respectively.
> >>
> >> The 104 mirrors the 4, but the 108 is a notification, that something
> >> happened and the hypervisor might need to adjust its tracking data to
> >> that fact. An example for that is the set prefix notification
> >> interception, where KVM only reads the new prefix, but does not update
> >> the prefix in the state description.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  target/s390x/kvm.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index 418154ccfe..58251c0229 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -115,6 +115,8 @@
> >>  #define ICPT_CPU_STOP                   0x28
> >>  #define ICPT_OPEREXC                    0x2c
> >>  #define ICPT_IO                         0x40
> >> +#define ICPT_PV_INSTR                   0x68
> >> +#define ICPT_PV_INSTR_NOT               0x6c
> >> =20
> >>  #define NR_LOCAL_IRQS 32
> >>  /*
> >> @@ -151,6 +153,7 @@ static int cap_s390_irq;
> >>  static int cap_ri;
> >>  static int cap_gs;
> >>  static int cap_hpage_1m;
> >> +static int cap_protvirt;
> >> =20
> >>  static int active_cmma;
> >> =20
> >> @@ -336,6 +339,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
> >>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
> >>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
> >> +    cap_protvirt =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
> >> =20
> >>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
> >>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> >> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
> >>              (long)cs->kvm_run->psw_addr);
> >>      switch (icpt_code) {
> >>          case ICPT_INSTRUCTION:
> >> +        case ICPT_PV_INSTR:
> >> +        case ICPT_PV_INSTR_NOT:
> >>              r =3D handle_instruction(cpu, run); =20
> >=20
> > Even if this works by default, my gut feeling tells me that it would be
> > safer and cleaner to have a separate handler for this...
> > Otherwise we might get surprising results if future machine generations
> > intercept/notify for more or different instructions, I guess?
> >=20
> > However, it's just a gut feeling ... I really don't have much experienc=
e
> > with this PV stuff yet ... what do the others here think?
> >=20
> >  Thomas =20
>=20
>=20
> Adding a handle_instruction_pv doesn't hurt me too much.
> The default case can then do an error_report() and exit(1);
>=20
> PV was designed in a way that we can re-use as much code as possible, so
> I tried using the normal instruction handlers and only change as little
> as possible in the instructions themselves.

I think we could argue that handling 4 and 104 in the same function
makes sense; but the 108 notification should really be separate, I
think. From what I've seen, the expectation of what the hypervisor
needs to do is just something else in this case ("hey, I did something;
just to let you know").

Is the set of instructions you get a 104 for always supposed to be a
subset of the instructions you get a 4 for? I'd expect it to be so.

--Sig_/2f+4qa5JN6ldMWPdpHobzcs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3f+cYACgkQ3s9rk8bw
L69xqQ//Su8xJ7klpJMmBc/Y378NiwOiiq3Nutjg48MGgoXAsWUaKBYqABkt26m/
waBInOH6v8R53cj7UvJNVjzq9OtYiOaiEVW1lGJgy6VUvjkLBewsC24zKiEPWdEp
xWEYkstrF496hFPgW0riIHoHQrZGEbfvRH1Qc1pbzv91dBUU7Rhz6Cl5bIpQbtd2
AHkAkt4QMH7AmAbPYX/nBfjqbteH1DyzpX8Qz7SdCbN1aka8VPs2FcdqGR6KFQhh
xGjgUqFWzp7GS/UL8s8+utBqdKW3Jjow/ye0MbOgBl6PPDVegBqUYkphLq8oVBX8
dhFKwetrQdh11x0HspQq4PLJwt3Jhj6z25zsRKTaLhWrXmjfRgrM/U4/lJV53lae
RUZ9SSte9Opnjo+4LMoH1parGmKjrD20It/JKd+M18PR0MDORA4PFGn6Sq3pW6DN
3KUrwHckq+BZm9TMQGiqY4afpq0DWDujBj6LNzuuprmp42nDlleR+33ow5z3VQiL
p+3e0ujT/X7soKLaoQa5jBLdqoaAbj1oenCWi6H0MfC83MXyM1i1weOnlv+wN27e
J2GUwukIyYAZrTGyZKpnS6Oy2xEJeIW2mJAGGhRJhqi08WzHm4nxnoMpPHXkp7Mv
4kW8Z714SXSgzMpPnkJpSALs5j7RN71lyEnlFiFiNHQDG6Snv2M=
=0Bmj
-----END PGP SIGNATURE-----

--Sig_/2f+4qa5JN6ldMWPdpHobzcs--


