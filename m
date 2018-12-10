Received: from eggs.gnu.org ([2001:4830:134:3::10]:40909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWP60-0003x8-GO
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWP5x-0007qX-Ap
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gWP5w-0007q7-Vc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:11:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8771C0587D1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:11:47 +0000 (UTC)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-7-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <22bb9367-f39a-c13b-8b0d-22c622a59433@redhat.com>
Date: Mon, 10 Dec 2018 18:11:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181207170400.5129-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/nvram/fw_cfg: Add
 fw_cfg_add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 12/07/18 18:04, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a function to read the full content of file on the host, and add
> a new 'file' name item to the fw_cfg device.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
>  include/hw/nvram/fw_cfg.h | 22 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 50525ec1dd..f3232fcb16 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -842,6 +842,28 @@ void fw_cfg_add_file(FWCfgState *s,  const char *f=
ilename,
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len,=
 true);
>  }
> =20
> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
> +                                const char *host_path, size_t *len)
> +{
> +    GError *gerr =3D NULL;
> +    gchar *ptr =3D NULL;
> +    gsize contents_len =3D 0;
> +
> +
> +    if (g_file_get_contents(host_path, &ptr, &contents_len, &gerr)) {
> +        fw_cfg_add_file(s, filename, ptr, contents_len);

Can you rename "ptr" to "data" or "contents"?

> +    } else {
> +        error_report("failed to read file %s, %s", host_path, gerr->me=
ssage);

OK... most functions in this file that populate fw_cfg and can fail
(from external data) still use error_report() + a NULL retval, so this
looks consistent.

> +        g_error_free(gerr);
> +        return NULL;
> +    }
> +    if (len) {
> +        *len =3D contents_len;
> +    }
> +
> +    return ptr;
> +}
> +
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>                          void *data, size_t len)
>  {
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 28630b2f26..8de8d63433 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -166,6 +166,28 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, u=
int64_t value);
>  void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
>                       size_t len);
> =20
> +/**
> + * fw_cfg_add_file_from_host:
> + * @s: fw_cfg device being modified
> + * @filename: name of new fw_cfg file item
> + * @host_path: path of the host file to read the data from
> + * @len: pointer to hold the length of the host file (optional)
> + *
> + * Read the content of a host file as a raw "blob" then add a new NAME=
D
> + * fw_cfg item of the file size. If @len is provided, it will contains=
 the

s/will contains/will contain/

> + * total length read from the host file. The data referenced by the st=
arting
> + * pointer is only linked, NOT copied, into the data structure of the =
fw_cfg
> + * device.

Please drop the last sentence; it does not apply here. There is no
starting pointer passed to this function.

... Should we perhaps replace the last sentence by stating that the data
read from the host filesystem is owned by the new fw_cfg entry?

> + * The next available (unused) selector key starting at FW_CFG_FILE_FI=
RST
> + * will be used; also, a new entry will be added to the file directory
> + * structure residing at key value FW_CFG_FILE_DIR, containing the ite=
m name,
> + * data size, and assigned selector key value.
> + *
> + * Returns: pointer to the file content, or NULL if an error occured.
> + */
> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
> +                                const char *host_path, size_t *len);
> +
>  /**
>   * fw_cfg_add_file_callback:
>   * @s: fw_cfg device being modified
>=20

Hmmmm. If you do return the pointer to the data just read, directly
exposing the allocation address to the caller, then we could in theory
make this new interface consistent with the rest, and make the *caller*
own the data. Then the currently proposed documentation would be sort-of
accurate (the new fw_cfg entry would not own the data just read -- the
caller would). It's hard to divine what's the best approach here,
without seeing any call sites.

... Purely from a consistency POV, I think I'm slightly attracted to
make the fw_cfg reference again a non-owning one, and force the caller
of fw_cfg_add_file_from_host() to own the data read.

Thanks
Laszlo
