Received: from eggs.gnu.org ([2001:4830:134:3::10]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gP8Kc-0006M6-Ab
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gP8KX-0003kf-4k
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:52:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55108
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gP8KW-0003ja-UI
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:52:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAKFoCtC137855
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 10:52:48 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nvm923cm5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 10:52:47 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 20 Nov 2018 15:52:47 -0000
References: <20181120072239.512-1-ppandit@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 20 Nov 2018 10:52:41 -0500
MIME-Version: 1.0
In-Reply-To: <20181120072239.512-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <ea6eb292-53d6-9bf0-98b9-8b53c44e77c8@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cheng Feng <PSIRT@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 11/20/18 2:22 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While performing mmio device r/w operations, guest could set 'addr'
> parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=3D5
> after setting new 'locty' via 'tpm_tis_new_active_locality'.
> Add check to avoid OOB access.

Do you have test code that can set the memory to such a locality or is=20
this purely hypothetical at the moment?

We are registering this MMIO area:

 =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_m=
emory_ops,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s, "tpm-tis-mmio",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 TPM_TIS_NUM_LOCALITIES <<=20
TPM_TIS_LOCALITY_SHIFT);

#define TPM_TIS_NUM_LOCALITIES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5

#define TPM_TIS_LOCALITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12

--> 5 << 12 =3D 0x5000, thus we get memory locations [0 .. 0x4fff]


We have the following code to get from an address to the locality:

static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
{
 =C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0=
x7);
}

With this we would get localities of [0x0 .. 0x4] following the memory=20
locations [0 .. 0x4fff] above.


 =C2=A0=C2=A0=C2=A0 Stefan


>
> Reported-by: Cheng Feng <PSIRT@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/tpm/tpm_tis.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> Update: add assert() calls
>    -> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00912.ht=
ml
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 12f5c9a759..d6bf3ceb26 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -293,6 +293,7 @@ static void tpm_tis_request_completed(TPMIf *ti, in=
t ret)
>       uint8_t locty =3D s->cmd.locty;
>       uint8_t l;
>
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
>       if (s->cmd.selftest_done) {
>           for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>               s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> @@ -401,6 +402,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
>       uint32_t avail;
>       uint8_t v;
>
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
>       if (tpm_backend_had_startup_error(s->be_driver)) {
>           return 0;
>       }
> @@ -523,6 +525,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
>       uint16_t len;
>       uint32_t mask =3D (size =3D=3D 1) ? 0xff : ((size =3D=3D 2) ? 0xf=
fff : ~0);
>
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
>       trace_tpm_tis_mmio_write(size, addr, val);
>
>       if (locty =3D=3D 4) {
> @@ -642,7 +645,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
>               }
>           }
>
> -        if (set_new_locty) {
> +        if (set_new_locty && TPM_TIS_IS_VALID_LOCTY(active_locty)) {
>               tpm_tis_new_active_locality(s, active_locty);
>           }
>
