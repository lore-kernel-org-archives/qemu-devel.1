Received: from eggs.gnu.org ([209.51.188.92]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gqics-0006Yq-9l
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gqicr-00089V-DZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:05:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gqicr-000834-1T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:05:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14Hwuoq019451
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 13:05:35 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qesjt242s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 13:05:35 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 4 Feb 2019 18:05:34 -0000
References: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 4 Feb 2019 13:05:30 -0500
MIME-Version: 1.0
In-Reply-To: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <3b98dc38-fe11-87fb-d846-4001f64c0b33@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm_tis: validate locality values don't
 overrun array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 1/30/19 9:45 AM, Liam Merwick wrote:
> Assert that various locality values don't exceed TPM_TIS_NUM_LOCALITIES
> by adding specific calls to assert(TPM_TIS_NUM_LOCALITIES(l)) in order
> to help static code analysis.
>
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   hw/tpm/tpm_tis.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index fd6bb9b59a96..2267bd8c346f 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -241,6 +241,9 @@ static void tpm_tis_abort(TPMState *s)
>   {
>       s->rw_offset =3D 0;
>  =20
> +    assert(TPM_TIS_IS_VALID_LOCTY(s->next_locty));

There are 2 callers of tpm_tis_abort: tpm_tis_prep_abort and=20
tpm_tis_request_completed. Both are checking s->next_locality already.=20
The former in line 270

 =C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(newlocty));

 =C2=A0=C2=A0=C2=A0 s->aborting_locty =3D locty; /* may also be TPM_TIS_N=
O_LOCALITY */
 =C2=A0=C2=A0=C2=A0 s->next_locty =3D newlocty;=C2=A0 /* locality after s=
uccessful abort */

and the latter in line 321:

 =C2=A0=C2=A0=C2=A0 if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tis_abort(s);
 =C2=A0=C2=A0=C2=A0 }

So this check would be redundant.


> +    assert(TPM_TIS_IS_VALID_LOCTY(s->aborting_locty));
> +

s->aborting_locty only serves as an index into the array in=20
tpm_tis_abort and only under the condition

 =C2=A0=C2=A0=C2=A0 if (s->aborting_locty =3D=3D s->next_locty) {

As state above s->next_locty has been tested for being a valid locality=20
already elsewhere and we don't need to test it another time. They way=20
the code accesses this variable we do not need this check, either.=20
Besides that there is this comment in the code in line 272, which would=20
make this assert wrong.


 =C2=A0=C2=A0=C2=A0 s->aborting_locty =3D locty; /* may also be TPM_TIS_N=
O_LOCALITY */





>       trace_tpm_tis_abort(s->next_locty);
>  =20
>       /*
> @@ -531,6 +534,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
>       uint16_t len;
>       uint32_t mask =3D (size =3D=3D 1) ? 0xff : ((size =3D=3D 2) ? 0xf=
fff : ~0);
>  =20
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
> +

We also do not need this check here since we are registering 0x5000=20
bytes of MMIO space, which gives us addresses [0x0..0x4fff], from which=20
we calculate the locality with a '>> 12':

static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
{
 =C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0=
x7);
}

this is where we register the MMIO memory:

 =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_m=
emory_ops,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s, "tpm-tis-mmio",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 TPM_TIS_NUM_LOCALITIES <<=20
TPM_TIS_LOCALITY_SHIFT);

The locality cannot be out-of-bounds.

 =C2=A0 Stefan


>       trace_tpm_tis_mmio_write(size, addr, val);
>  =20
>       if (locty =3D=3D 4) {
