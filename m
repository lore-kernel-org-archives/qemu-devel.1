Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPUdL-0003B3-P1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPUdI-0006UN-Fx
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:41:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gPUdI-0006Tg-7N
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:41:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALFYKmI047695
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:41:39 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nw88ex56b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:41:38 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 21 Nov 2018 15:41:38 -0000
References: <20181120072239.512-1-ppandit@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 21 Nov 2018 10:41:32 -0500
MIME-Version: 1.0
In-Reply-To: <20181120072239.512-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <5fcd30a0-f932-3f06-61a5-45ddc72ce606@linux.ibm.com>
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


This one I may take. However, the tpm_tis_tpm_send is called with a=20
valid locality (derived from the MMIO address) and passes the locality=20
number to the backend. The backends are reading the locality but don't=20
change it.


>       if (s->cmd.selftest_done) {
>           for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>               s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> @@ -401,6 +402,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
>       uint32_t avail;
>       uint8_t v;
>
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));


This check comes right after

 =C2=A0uint8_t locty =3D tpm_tis_locality_from_addr(addr);

which gives us a locty in range [0.. 4]. So I don't think a check here=20
is needed.


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


Same comment here.

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

It is possible that no locality is active by the current locality=20
relinquishing the ownership and we have to be able to set that.


>               tpm_tis_new_active_locality(s, active_locty);
>           }
>
