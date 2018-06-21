Received: from eggs.gnu.org ([2001:4830:134:3::10]:48214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVyQk-0002Hi-Qe
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVyQf-0002iq-Sg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:11:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44690
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fVyQf-0002iR-Nw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:11:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LC4I7n020029
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:11:09 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrb761mjb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:11:09 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 08:11:08 -0400
References: <20180621115530.11069-1-marcandre.lureau@redhat.com>
	<20180621115530.11069-2-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 08:11:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180621115530.11069-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <f500f7df-3eff-c9d6-2630-0c00f2360d6e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/21/2018 07:55 AM, Marc-Andr=C3=A9 Lureau wrote:
> The following patches implement the TPM Physical Presence Interface,
> and makes use of new memory region and fw_cfg entries. Enable it by
> default on >2.12 machine type.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/compat.h | 10 ++++++++++
>   hw/tpm/tpm_crb.c    |  3 +++
>   hw/tpm/tpm_tis.c    |  3 +++
>   3 files changed, 16 insertions(+)
>
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 563908b874..dac847548b 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,6 +2,16 @@
>   #define HW_COMPAT_H
>  =20
>   #define HW_COMPAT_2_12 \
> +    {\
> +        .driver   =3D "tpm-crb",\
> +        .property =3D "ppi",\
> +        .value    =3D "false",\
> +    },\
> +    {\
> +        .driver   =3D "tpm-tis",\
> +        .property =3D "ppi",\
> +        .value    =3D "false",\
> +    },\
>       {\
>           .driver   =3D "migration",\
>           .property =3D "decompress-error-check",\
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index a92dd50437..d5b0ac5920 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -41,6 +41,8 @@ typedef struct CRBState {
>       MemoryRegion cmdmem;
>  =20
>       size_t be_buffer_size;
> +
> +    bool ppi_enabled;
>   } CRBState;
>  =20
>   #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
> @@ -221,6 +223,7 @@ static const VMStateDescription vmstate_tpm_crb =3D=
 {
>  =20
>   static Property tpm_crb_properties[] =3D {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> +    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };

Wouldn't we have to bump up the version of teh VMStateDescription?

 =C2=A0=C2=A0 Stefan
>  =20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 12f5c9a759..d9ddf9b723 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -81,6 +81,8 @@ typedef struct TPMState {
>       TPMVersion be_tpm_version;
>  =20
>       size_t be_buffer_size;
> +
> +    bool ppi_enabled;
>   } TPMState;
>  =20
>   #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -950,6 +952,7 @@ static const VMStateDescription vmstate_tpm_tis =3D=
 {
>   static Property tpm_tis_properties[] =3D {
>       DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
