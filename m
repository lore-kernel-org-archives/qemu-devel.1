Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kNv-0008DV-T3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kNs-0007Sv-P1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1kNs-0007Se-Jg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A2XaIq036336
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 22:35:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgjf97qsg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 22:35:00 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 22:35:00 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-2-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 22:34:56 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d03e9783-40ac-2330-18cc-c0b1139ba2e1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/42] tpm-tis: remove unused hw_access
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> This argument is always false, simplify the code.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>



> ---
>   hw/tpm/tpm_tis.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d5118e7f60..a9e9cbdeb2 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -615,9 +615,8 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
>    * Write a value to a register of the TIS interface
>    * See specs pages 33-63 for description of the registers
>    */
> -static void tpm_tis_mmio_write_intern(void *opaque, hwaddr addr,
> -                                      uint64_t val, unsigned size,
> -                                      bool hw_access)
> +static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
> +                               uint64_t val, unsigned size)
>   {
>       TPMState *s =3D opaque;
>       TPMTISEmuState *tis =3D &s->s.tis;
> @@ -631,7 +630,7 @@ static void tpm_tis_mmio_write_intern(void *opaque,=
 hwaddr addr,
>
>       DPRINTF("tpm_tis: write.%u(%08x) =3D %08x\n", size, (int)addr, (i=
nt)val);
>
> -    if (locty =3D=3D 4 && !hw_access) {
> +    if (locty =3D=3D 4) {
>           DPRINTF("tpm_tis: Access to locality 4 only allowed from hard=
ware\n");
>           return;
>       }
> @@ -942,12 +941,6 @@ static void tpm_tis_mmio_write_intern(void *opaque=
, hwaddr addr,
>       }
>   }
>
> -static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
> -                               uint64_t val, unsigned size)
> -{
> -    tpm_tis_mmio_write_intern(opaque, addr, val, size, false);
> -}
> -
>   static const MemoryRegionOps tpm_tis_memory_ops =3D {
>       .read =3D tpm_tis_mmio_read,
>       .write =3D tpm_tis_mmio_write,
