Received: from eggs.gnu.org ([209.51.188.92]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghz5k-0003s9-MN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghz5j-0003ls-RJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:51:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1ghz5j-0003lB-I6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:51:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BFnK9g117876
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:51:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pxuks8ujp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:51:25 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Fri, 11 Jan 2019 15:51:23 -0000
References: <20190111113657.66195-1-frankja@linux.ibm.com>
	<20190111113657.66195-2-frankja@linux.ibm.com>
	<2be2f28c-1c89-c985-7996-f30c25578446@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 11 Jan 2019 16:51:19 +0100
MIME-Version: 1.0
In-Reply-To: <2be2f28c-1c89-c985-7996-f30c25578446@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hYUPomZYC5XKFeZrPx4UFwLCs9zLwtGsx"
Message-Id: <df287522-75fd-30ff-f262-673958bdac7a@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x: Diag308 move common parameter
 checking into function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hYUPomZYC5XKFeZrPx4UFwLCs9zLwtGsx
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <df287522-75fd-30ff-f262-673958bdac7a@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390x: Diag308 move common parameter checking into
 function
References: <20190111113657.66195-1-frankja@linux.ibm.com>
 <20190111113657.66195-2-frankja@linux.ibm.com>
 <2be2f28c-1c89-c985-7996-f30c25578446@redhat.com>
In-Reply-To: <2be2f28c-1c89-c985-7996-f30c25578446@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.01.19 16:40, David Hildenbrand wrote:
> On 11.01.19 12:36, Janosch Frank wrote:
>> Let's make that switch statement a bit shorter.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/diag.c | 34 ++++++++++++++++++----------------
>>  1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index acb0f3d4af..cfd7222ddd 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -53,6 +53,22 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1=
, uint64_t r3)
>>  #define DIAG_308_RC_NO_CONF         0x0102
>>  #define DIAG_308_RC_INVALID         0x0402
>> =20
>> +static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>> +                              uintptr_t ra)
>> +{
>> +    if ((r1 & 1) || (addr & 0x0fffULL)) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra)=
;
>> +        return -EINVAL;
>> +    }
>> +    if (!address_space_access_valid(&address_space_memory, addr,
>> +                                    sizeof(IplParameterBlock), true,
>=20
> This is wrong, you would check for writing although you are only
> reading. (true vs. false)

Friday morning patches are the best patches :)
Let's drop that one for now, we'll touch it again, if we need to tinker
there.


--hYUPomZYC5XKFeZrPx4UFwLCs9zLwtGsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcOLt3AAoJEONU5rjiOLn4lq8QALyyrzUI0Sx/9ZMGHUKxF/LH
Gi3Pc3XWuX/Z+xQ6o71QUwojiX2vDnGruFtBBRqmGa7RIT1NAUkO6Qi0YTJgT5OA
ns9W8n20FbuuSair30eCxslxghK2lFxyc0uzjKxaMTG7FDJJ6qQOGZeOC1n07tci
7W9BH+basQGRrQIHdpjQaOpBKbTPBnd8jwag1R8xiyrJ6LhIvH7E3nAeRjkxgena
DvxrjzACSmksME9ITPsffRrfA08e4/zxM7QY/dCJuFBDxMs67Jjjc4TcokvP3akD
EJAE96xBkbInGUs14y35eYu9mpW3QbahaUQvvGWSYrzfofpbsA02ukxEneOzv461
jbddcAWsSwjSlQ9/CRD8UFrBLibxHOj3vWhCs+jlNSf06DVSAr5JeDMdhksgbc0N
mvgDfe5ecyiYgyYYgQE94+a3vFE+ton3Tu7vJJbMZfegdcucKO77+doM7u0bDYbQ
GzXK8vF/DGO06gWjQw3ghJ5aPK9xVQITSVZqbpsQhyPksPk1dmrZKa9KiksN53Ik
y39yNAj4fNkBlWFOI77hIt8Q1JuAD1lsBz+KFXOW/rtkZtr98yqbtZBZWDnfG94x
P53gVl/0nAd543jKO+w4JTtHqsOSp+AyHuZ/RVVaLtqZXJyZg+zGBYJCfl3yR1wY
8RpulPXIJKsKglaNXTyZ
=7rFW
-----END PGP SIGNATURE-----

--hYUPomZYC5XKFeZrPx4UFwLCs9zLwtGsx--
