Received: from eggs.gnu.org ([209.51.188.92]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtbsD-0006o7-Ek
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtbs9-0005Pw-3V
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:29:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtbs7-0005Jn-2O
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:29:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CHPDRw143525
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:29:19 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm0x5nc3x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:29:18 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 12 Feb 2019 17:29:17 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-2-git-send-email-liam.merwick@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 12 Feb 2019 12:29:15 -0500
MIME-Version: 1.0
In-Reply-To: <1549897385-10091-2-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <a0baaa1e-9fbb-83aa-37ff-3ff3fc6bd015@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] tpm_tis: assert valid addr passed
 to tpm_tis_locality_from_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 2/11/19 10:03 AM, Liam Merwick wrote:
> Defensive check to prevent future caller passing incorrect address
> or catch if the MMIO address parameters were not all changed together.
>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>
> I've been running static analysis tools on QEMU and one reports this ch=
eck.
> While it's just theoretically correct (impossible to hit with current c=
ode),
> fixing this helps minimise noise and find other issues using those stat=
ic
> analyzers as well as defending against the addition of future bugs.
>
>   hw/tpm/tpm_tis.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 61a130beef35..860c2ace7d99 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -100,6 +100,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
>  =20
>   static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
>   {
> +    assert(addr < TPM_TIS_ADDR_SIZE);
>       return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
>   }
>  =20

If we want to add a check then we should check the value of the locality=20
that's being derived from the address here since that one serves as an=20
index into the array. However, we shouldn't need it with the way we=20
register the amount of MMIO memory derived from the number of localities=20
and the way we then derive the locality from the address.

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 61a130beef..797f107246 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -100,7 +100,10 @@ static uint64_t tpm_tis_mmio_read(void *opaque,=20
hwaddr addr,

 =C2=A0static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
 =C2=A0{
-=C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0=
x7);
+=C2=A0=C2=A0=C2=A0 uint8_t locty =3D (uint8_t)(addr >> TPM_TIS_LOCALITY_=
SHIFT);
+=C2=A0=C2=A0=C2=A0 fprintf(stderr, "addr=3D%08lx locty=3D%u\n", addr, lo=
cty);
+=C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(locty));
+=C2=A0=C2=A0=C2=A0 return locty;
 =C2=A0}

 =C2=A0static void tpm_tis_show_buffer(const unsigned char *buffer,
