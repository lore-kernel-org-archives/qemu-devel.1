Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVKAk-0007ZV-VS
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVKAg-00044b-02
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:44:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gVKAf-000446-O3
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:44:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0A113138BBA
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 17:44:12 +0000 (UTC)
Date: Fri, 7 Dec 2018 12:44:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181207124358-mutt-send-email-mst@kernel.org>
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181207170400.5129-5-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/nvram/fw_cfg: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Dec 07, 2018 at 06:03:58PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Well why not.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/nvram/fw_cfg.c     | 5 +++++
>  hw/nvram/trace-events | 5 +++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 3cb726ff68..582653f07e 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -627,6 +627,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s=
, uint16_t key,
> =20
>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t =
len)
>  {
> +    trace_fw_cfg_add_bytes(key, len);
>      fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, tru=
e);
>  }
> =20
> @@ -634,6 +635,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key,=
 const char *value)
>  {
>      size_t sz =3D strlen(value) + 1;
> =20
> +    trace_fw_cfg_add_string(key, value);
>      fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
>  }
> =20
> @@ -643,6 +645,7 @@ void fw_cfg_add_i16(FWCfgState *s, uint16_t key, ui=
nt16_t value)
> =20
>      copy =3D g_malloc(sizeof(value));
>      *copy =3D cpu_to_le16(value);
> +    trace_fw_cfg_add_i16(key, value);
>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>  }
> =20
> @@ -662,6 +665,7 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, ui=
nt32_t value)
> =20
>      copy =3D g_malloc(sizeof(value));
>      *copy =3D cpu_to_le32(value);
> +    trace_fw_cfg_add_i32(key, value);
>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>  }
> =20
> @@ -671,6 +675,7 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, ui=
nt64_t value)
> =20
>      copy =3D g_malloc(sizeof(value));
>      *copy =3D cpu_to_le64(value);
> +    trace_fw_cfg_add_i64(key, value);
>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>  }
> =20
> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
> index 6b55ba7a09..0ee0f8d04a 100644
> --- a/hw/nvram/trace-events
> +++ b/hw/nvram/trace-events
> @@ -7,4 +7,9 @@ nvram_write(uint32_t addr, uint32_t old, uint32_t val) =
"write addr %d: 0x%02x ->
>  # hw/nvram/fw_cfg.c
>  fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d =3D %d"
>  fw_cfg_read(void *s, uint64_t ret) "%p =3D 0x%"PRIx64
> +fw_cfg_add_bytes(uint16_t key, size_t len) "key 0x%04" PRIx16 " (%zu b=
ytes)"
>  fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %=
s (%zd bytes)"
> +fw_cfg_add_string(uint16_t key, const char *value) "key 0x%04" PRIx16 =
", value '%s'"
> +fw_cfg_add_i16(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", val=
ue 0x%" PRIx32
> +fw_cfg_add_i32(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", val=
ue 0x%" PRIx32
> +fw_cfg_add_i64(uint16_t key, uint64_t value) "key 0x%04" PRIx16 ", val=
ue 0x%" PRIx64
> --=20
> 2.17.2
