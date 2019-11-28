Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB178C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B739B21774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkoXyy2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739B21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQEB-0000Bv-Pb
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaQ6I-0005aG-RF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaQ65-00081r-JR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:09:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaQ65-0007pf-Cu
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574971742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bNl6agWHIgwCJ6Hb0jGAA40xKpKz9cUfHQxbNXaQq7k=;
 b=VkoXyy2BfYBwxYj0PSnGLmGtnTBK2vcjkYa0aBx66DtaGPWf7UaRpwYKIuvG+2NXDufVSl
 +x+13YCk4nidsWOCObVQ4IkI2MooPLSvIFLGys+CKlLiix0YKpOwFC4AYTsdIFUpT5Wlsp
 gCfNDuvSxUwaZyLOzdizYwXaNB+TNaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-UUojAlNSOuK1sZB-2J-Wew-1; Thu, 28 Nov 2019 15:08:59 -0500
X-MC-Unique: UUojAlNSOuK1sZB-2J-Wew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0634B1883521;
 Thu, 28 Nov 2019 20:08:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DBEE5D6D0;
 Thu, 28 Nov 2019 20:08:52 +0000 (UTC)
Subject: Re: [PATCH 14/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-15-frankja@linux.ibm.com>
 <db581b32-2b84-683c-0e7e-b6ee908eb701@redhat.com>
 <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <28289bed-0dab-53f6-ed78-8c36498b1b5e@redhat.com>
Date: Thu, 28 Nov 2019 21:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FjuCAAuNR6rsTEln09rnE72ME0c4I53kB"
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FjuCAAuNR6rsTEln09rnE72ME0c4I53kB
Content-Type: multipart/mixed; boundary="F2chkxQt4qB7f2N6lmeGhgq3qD98Kpqh3";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, pmorel@linux.ibm.com
Message-ID: <28289bed-0dab-53f6-ed78-8c36498b1b5e@redhat.com>
Subject: Re: [PATCH 14/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-15-frankja@linux.ibm.com>
 <db581b32-2b84-683c-0e7e-b6ee908eb701@redhat.com>
 <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>
In-Reply-To: <be2aece1-8879-d3d3-81ff-7bbbb8052548@linux.ibm.com>

--F2chkxQt4qB7f2N6lmeGhgq3qD98Kpqh3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/11/2019 17.10, Janosch Frank wrote:
> On 11/28/19 4:28 PM, Thomas Huth wrote:
>> On 20/11/2019 12.43, Janosch Frank wrote:
>>> IO instruction data is routed through SIDAD for protected guests, so
>>> adresses do not need to be checked, as this is kernel memory.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  target/s390x/ioinst.c | 46 +++++++++++++++++++++++++++----------------
>>>  1 file changed, 29 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>>> index c437a1d8c6..d3bd422ddd 100644
>>> --- a/target/s390x/ioinst.c
>>> +++ b/target/s390x/ioinst.c
>>> @@ -110,11 +110,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t re=
g1, uint32_t ipb, uintptr_t ra)
>>>      int cssid, ssid, schid, m;
>>>      SubchDev *sch;
>>>      SCHIB schib;
>>> -    uint64_t addr;
>>> +    uint64_t addr =3D 0;
>>>      CPUS390XState *env =3D &cpu->env;
>>> -    uint8_t ar;
>>> +    uint8_t ar =3D 0;
>>> =20
>>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    if (!env->pv) {
>>> +        addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    }
>>>      if (addr & 3) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return;
>>> @@ -167,11 +169,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t re=
g1, uint32_t ipb, uintptr_t ra)
>>>      int cssid, ssid, schid, m;
>>>      SubchDev *sch;
>>>      ORB orig_orb, orb;
>>> -    uint64_t addr;
>>> +    uint64_t addr =3D 0;
>>>      CPUS390XState *env =3D &cpu->env;
>>> -    uint8_t ar;
>>> +    uint8_t ar =3D 0;
>>> =20
>>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    if (!env->pv) {
>>> +        addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    }
>>>      if (addr & 3) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return;
>>> @@ -198,12 +202,14 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t re=
g1, uint32_t ipb, uintptr_t ra)
>>>  void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
>>>  {
>>>      CRW crw;
>>> -    uint64_t addr;
>>> +    uint64_t addr =3D 0;
>>>      int cc;
>>>      CPUS390XState *env =3D &cpu->env;
>>> -    uint8_t ar;
>>> +    uint8_t ar =3D 0;
>>> =20
>>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    if (!env->pv) {
>>> +        addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    }
>>>      if (addr & 3) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return;
>>> @@ -228,13 +234,15 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t r=
eg1, uint32_t ipb,
>>>  {
>>>      int cssid, ssid, schid, m;
>>>      SubchDev *sch;
>>> -    uint64_t addr;
>>> +    uint64_t addr =3D 0;
>>>      int cc;
>>>      SCHIB schib;
>>>      CPUS390XState *env =3D &cpu->env;
>>> -    uint8_t ar;
>>> +    uint8_t ar =3D 0;
>>> =20
>>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    if (!env->pv) {
>>> +        addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    }
>>>      if (addr & 3) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return;
>>> @@ -294,16 +302,18 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg=
1, uint32_t ipb, uintptr_t ra)
>>>      int cssid, ssid, schid, m;
>>>      SubchDev *sch;
>>>      IRB irb;
>>> -    uint64_t addr;
>>> +    uint64_t addr =3D 0;
>>>      int cc, irb_len;
>>> -    uint8_t ar;
>>> +    uint8_t ar =3D 0;
>>> =20
>>>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid))=
 {
>>>          s390_program_interrupt(env, PGM_OPERAND, ra);
>>>          return -EIO;
>>>      }
>>>      trace_ioinst_sch_id("tsch", cssid, ssid, schid);
>>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    if (!env->pv) {
>>> +        addr =3D decode_basedisp_s(env, ipb, &ar);
>>> +    }
>>>      if (addr & 3) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return -EIO;
>>
>> Would it make sense to hide all these changes in decode_basedisp_s()
>> instead? ... so that decode_basedisp_s() returns 0 if env->pv =3D=3D tru=
e ?
>> ... or are there still cases where we need real values from
>> decode_basedisp_s() in case of env->pv=3D=3Dtrue?
>=20
> I'd like to keep decode_basedisp_s() as is, but how about a static
> function in ioinst.c called something like get_address_from_regs()?
>=20
> It'll call decode_basedisp_s() or return 0.

Sounds fine for me, too!

 Thomas


--F2chkxQt4qB7f2N6lmeGhgq3qD98Kpqh3--

--FjuCAAuNR6rsTEln09rnE72ME0c4I53kB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl3gKVIACgkQLtnXdP5w
LbXPDA//QJKI4gKqKwtWPfydUmqgKA5AcW/kDALcnyq30opNuOKvD9UByH6IDunr
2qijR7+iEE3oXUO96ZiHAOKpt2oZ0Z9L4u+Q3Ycm3UPnPGYyELjOY/FmEvmIX66M
at3Rrb6ySb2d2OjWyyD9yDgrmB7863BdZpmL6zqu4nnFzQrvK3DpIP9RWA8v5x+L
dA8ru81BBIXvWspKoHDGv9M1oQSwYrs6u1oC21hHUycMNqZLqAzhN2phbZowWgf0
DTrqK44WrM9uywbxxZ1YYdgG4gHvWQjXb1BXhMnURjHjmyqOa/a5LHbpdRlEdDov
pw1mGOvZRZidKMJgwqIzVeXwE2ooIhOEkAA5+GWS8WI4TcrdEjy2VMy/Q4JBix1k
VK6XuGC5RSXShtx7VXwB5PPbM43Z/+zMk7fqf8n+rV178y+HOyQln6mGlz9vAGoZ
9suYCoe+MEx2ufOyjTYNRTI7Qi3SNNhrxuTGHIsfTR2oSxHfOya+mWOpMlYMfFiL
B839PkreVngSVacEy8HgCwG61vj7nID7d1JgM/+MeGxN6t+s/ONg3M4RnmPoBhah
wlthhFSpTBfnHkIAUkYxj5v7UMw8wNff4RZGi4w1fmaSOa2oF5QP3Pi4bRWW8v5T
ez73IA/qsVe+vEHoxMtl480CdyO3f+MnuWqooThuiM95KzRzhak=
=yUhl
-----END PGP SIGNATURE-----

--FjuCAAuNR6rsTEln09rnE72ME0c4I53kB--


