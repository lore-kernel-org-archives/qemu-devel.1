Received: from eggs.gnu.org ([2001:4830:134:3::10]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT1ds-0003e5-6K
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT1dp-0007x9-4b
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:00:36 -0400
References: <20180613081819.147178-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec5d62ca-4096-470a-74f5-a6679c09cc6d@redhat.com>
Date: Wed, 13 Jun 2018 11:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180613081819.147178-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodels: add z14 Model ZR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 10:18, Christian Borntraeger wrote:
> introduce the new z14 Model ZR1 cpu model. Mostly identical to z14, onl=
y
> the cpu type differs (3906 vs. 3907)
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index e10035aaa8..cfdbccf46d 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] =3D {
>      CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"=
),
>      CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"=
),
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
> +    CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Mod=
el ZR1 GA1"),
>  };
> =20
>  #define QEMU_MAX_CPU_TYPE 0x2827
>=20

This is the first time that we have two different EC variants (different
CPU type) with the same HW gen and GA level .

Are they really completely equal (esp. the IBC value? that is used for
model detection) apart from the CPU type?

check_unavailable_features()/arch_query_cpu_model_comparison() will
treat both models as equal (meaning one can run on the other).

arch_query_cpu_model_baseline() might produce a z14ZR1-base when
baselining e.g. a z14 and a z14ZR1 (don't think this is a problem), as
s390_find_cpu_def() will always try to walk as far as possible in the
cpu model definition table.

--=20

Thanks,

David / dhildenb
