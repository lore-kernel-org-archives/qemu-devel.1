Received: from eggs.gnu.org ([209.51.188.92]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gugXr-0003JU-MG
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gugXq-0004zl-RZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gugXq-0004iq-LT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:40:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78D8EC7964
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 16:40:51 +0000 (UTC)
Date: Fri, 15 Feb 2019 17:40:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190215174019.6fab4f3f@Igors-MacBook-Pro.local>
In-Reply-To: <20190215153600.1770727-1-berrange@redhat.com>
References: <20190215153600.1770727-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/smbios: fix offset of type 3 sku field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 15 Feb 2019 15:36:00 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> The type 3 SMBIOS structure[1] ends with fields
>=20
>   ...
>   0x14  - contained element count
>   0x15  - contained element record length
>   0x16  - sku number
>=20
> The smbios_type_3 struct missed the contained element record
> length field, causing sku number to be reported at the wrong
> offset.
>=20
> [1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_=
3.1.1.pdf
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/smbios/smbios.c           | 1 +
>  include/hw/firmware/smbios.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 818be8a838..47be9071fa 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -563,6 +563,7 @@ static void smbios_build_type_3_table(void)
>      t->height =3D 0;
>      t->number_of_power_cords =3D 0;
>      t->contained_element_count =3D 0;
> +    t->contained_element_record_length =3D 0;
>      SMBIOS_TABLE_SET_STR(3, sku_number_str, type3.sku);
> =20
>      SMBIOS_BUILD_TABLE_POST;
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index eeb5a4d7b6..6fef32a3c9 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -162,6 +162,7 @@ struct smbios_type_3 {
>      uint8_t height;
>      uint8_t number_of_power_cords;
>      uint8_t contained_element_count;
> +    uint8_t contained_element_record_length;
>      uint8_t sku_number_str;
>      /* contained elements follow */
>  } QEMU_PACKED;
