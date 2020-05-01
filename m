Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CBAC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 07:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD282071C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD282071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=physnet.uni-hamburg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUQ6t-0005Qz-KO
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 03:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mhohmann@physnet.uni-hamburg.de>) id 1jUQ6D-0004io-A4
 for qemu-devel@nongnu.org; Fri, 01 May 2020 03:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mhohmann@physnet.uni-hamburg.de>) id 1jUQ6C-00061G-Pz
 for qemu-devel@nongnu.org; Fri, 01 May 2020 03:28:41 -0400
Received: from mail.physnet.uni-hamburg.de ([134.100.106.230]:41092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mhohmann@physnet.uni-hamburg.de>)
 id 1jUQ6A-0005T0-0C; Fri, 01 May 2020 03:28:38 -0400
Received: from 227-98-191-90.dyn.estpak.ee ([90.191.98.227]
 helo=[192.168.1.129]) by mail.physnet.uni-hamburg.de with esmtpsa
 (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
 (envelope-from <mhohmann@physnet.uni-hamburg.de>)
 id 1jUQ5z-00013n-4b; Fri, 01 May 2020 09:28:28 +0200
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200430154606.6421-1-imammedo@redhat.com>
 <949872a1-1d5c-0e44-cab8-02d2e30202a7@redhat.com>
From: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
Autocrypt: addr=mhohmann@physnet.uni-hamburg.de; prefer-encrypt=mutual;
 keydata=
 mQENBEzzkJ0BCACoFEyKwRypWgc6Bbl/t5CRmCq+wnrLqGTji2iB9gHhP/dFisO3bdPjX2bT
 bZSG48rR7Q999M5NjCX7juQbAKQm5vv3NDBNqq35Q7nSALsEEazy1awbx56EBXPn/5VbH4JT
 c3sZiQR/MZY81WcWANPxZr3XWOl71netiVNzO5OBZSTxRV7dnB2meYBlhgD7dDzZTfJ8tpqu
 XlzlaZ+H2QDDt2TH0LYm6rhK2OXDqTCs09BiZi48Ev6YI/DC/RpLNGlVtACV1RB1i+GAKIZJ
 /E+E1A5wQTG+/wHblFq9PcFJKTJOQvMh3kV/4S4GuQbXoAMVn+6FGIF7mat4Oo+mNjchABEB
 AAG0ME1hbnVlbCBIb2htYW5uIDxtaG9obWFubkBwaHlzbmV0LnVuaS1oYW1idXJnLmRlPokB
 OAQTAQIAIgUCTPOQnQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ+9/1Gux6RLIN
 fgf+MHuA2VcJxo/xAvTjfrvmDFgTsepHFlWPKkEdEQY2FSG1dqhAHtEIlEJ0M/6Y0r5cSn+L
 E8yqW8OWP0aCsd0BTcp+h1t8lIZhx33ZGmOFDxLVcnIq/zyEloRbVZPG05yvKgmc3N3opaw4
 8WrdnQ7Q6+iQhY9v+S+BcRyJNDL6cWXZF2uLOvXDAq2Y1lihZSwBXvcQOgQ7nfgJYAveA140
 fqRmg5e7usL2xq1kaWDvRrxBk/D6kWqLBkvYQrxxflTfsbM4IJP4lmCIfyr0BxY0VOzjZ8Wu
 SYl9ETJcHSc4zR+s94PnDAlFsZbZHGoXK6YxD6SlyaisT00bqvZXmY8gHbkBDQRM85CdAQgA
 l90YtA7ak5BUEHw4WPY9AIpfP0IWSI3lQbudSdTcJ2GPx5fE01dd/W1V+7K7VBiDw7m1CjT7
 qnv5ZPFWIhGCBzxGhi/81NXhnEsHoElJEzea0XY64/7hf+CeM4rrx7CaXjByHDbVfFPQqUEZ
 yhZhxYChmpCi/5CAvs5sJKFNqTqF6AXFCNdam0iWu1pT2MVhl2RqYQq0rUNVDhlh/v/fPKsM
 tUqyfXbiXVaG9zcozC7AS6U+0jly9oMsGrz9eCE6uDc3YceTnhUqRvuBzj3wB6hFNXj82T/+
 4r60s9zAc2VMi3F0jKBr0+7b+5JOjeraPlvNB0ftCfnFNDGeC0pZAQARAQABiQEfBBgBAgAJ
 BQJM85CdAhsMAAoJEPvf9RrsekSyMAMH/2gVwokA0EEeF00AO6K9uTukidAflrXYFS+KLKC2
 oa8uAb2Or6y2OOZeaLmYhbOdRapFCElqjGSMYlBHPFmu10KDUYzNuaVmSULw84e0KzNPCeJG
 zOF4bGvLY9bv4cp2tMeUNDIvQHsmZ0PE+O9i9cVtuITEjsXxa/62SE1TSnLg3QUUZEvTIIKN
 ZEoxKIHrxiLVsa5Rd21YDVyShLjK4sa4Tc0PUPpe5yWkET6hVBIw2g15hAO8+qkShbRYg9CH
 pZQlUIv2wMJqzXV4UaHYzRJcgZZ0YEvNHE/Vstl7GLHk/QtaCxqva6novYYXWK/rMGrK19gw
 3dYtCkCgf6rLwTE=
Organization: University of Tartu
Message-ID: <dfa7be0a-ded6-4526-9041-d04a699acfd0@physnet.uni-hamburg.de>
Date: Fri, 1 May 2020 10:28:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <949872a1-1d5c-0e44-cab8-02d2e30202a7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wJjZ1bGKfA4EEJRdunlbuRfBkh0BiOcuC"
Received-SPF: none client-ip=134.100.106.230;
 envelope-from=mhohmann@physnet.uni-hamburg.de;
 helo=mail.physnet.uni-hamburg.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:28:28
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Received-From: 134.100.106.230
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wJjZ1bGKfA4EEJRdunlbuRfBkh0BiOcuC
Content-Type: multipart/mixed; boundary="QSTfVxnx1TY7zSZbwdE6wqxeVtPHp1EuO"

--QSTfVxnx1TY7zSZbwdE6wqxeVtPHp1EuO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks! I applied the patch, and now it works also inside the docker cont=
ainer, for all architectures (i386, x86_64, arm, aarch64) for which I hav=
e test cases at hand.

Indeed, since the container is configured by a public cloud service, ther=
e is no possibility to change any security settings. Disabling mbind unle=
ss explicitly requested seems to be the best way to go here.

On 30.04.20 19:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Typo "empty" in patch subject.
>=20
> On 4/30/20 5:46 PM, Igor Mammedov wrote:
>> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
>> The backend however calls mbind() which is typically NOP
>> in case of default policy/absent host-nodes bitmap.
>> However when runing in container with black-listed mbind()
>> syscall, QEMU fails to start with error
>> =C2=A0 "cannot bind memory to host NUMA nodes: Operation not permitted=
"
>> even when user hasn't provided host-nodes to pin to explictly
>> (which is the case with -m option)
>>
>> To fix issue, call mbind() only in case when user has provided
>> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
>> That should allow to run QEMU in containers with black-listed
>> mbind() without memory pinning. If QEMU provided memory-pinning
>> is required user still has to white-list mbind() in container
>> configuration.
>>
>> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> CC: berrange@redhat.com
>> CC: ehabkost@redhat.com
>> CC: pbonzini@redhat.com
>> CC: mhohmann@physnet.uni-hamburg.de
>> CC: qemu-stable@nongnu.org
>> ---
>> =C2=A0 backends/hostmem.c | 6 ++++--
>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 327f9eebc3..0efd7b7bd6 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable=
 *uc, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(sizeof(b=
ackend->host_nodes) >=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned l=
ong));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(maxnode =
<=3D MAX_NODES);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mbind(ptr, sz, backend=
->policy,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxnode ? backend->host_nodes : NULL, m=
axnode + 1, flags)) {
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (maxnode &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb=
ind(ptr, sz, backend->policy, backend->host_nodes, maxnode + 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, errno,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cannot bind me=
mory to host NUMA nodes");
>>
>=20


--QSTfVxnx1TY7zSZbwdE6wqxeVtPHp1EuO--

--wJjZ1bGKfA4EEJRdunlbuRfBkh0BiOcuC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEGQ1wnDd/ca3CjRdj+9/1Gux6RLIFAl6rz5kACgkQ+9/1Gux6
RLJwfQgAprfTtTMCxTfwVd1WqThZFb6jXknn1Wp5eQWN0C+thxRLGUhzTGaOIs6f
GV8fuw2Tt1NqlWzAKAV+V5gIDH8y8mE06Je9woXOOq6VfOurMvMyq2sdEFJtdKIk
rMxf5YrU+BsShDRYP3GBl/NWHOo5fqLTcizeVsWW3pLYLs18O8UdzsGtVTxlypkb
2Jo2PCgq5r/4Keo2olF5H0WqArQ9m7ivPqkF4UxveDdZinagkWta395LJYtKbk+m
ngpVGmuJsdnJ9J+pptQ+2CFZiflpcevX5k8UufClVqkbA4iC6lW+e6fbGrSLAcoG
B4q0ls5s+D0T5T6PTlBVz/oboo40og==
=HlMq
-----END PGP SIGNATURE-----

--wJjZ1bGKfA4EEJRdunlbuRfBkh0BiOcuC--

