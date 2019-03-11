Received: from eggs.gnu.org ([209.51.188.92]:48476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3FMi-00024b-Dw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3F9m-0000LB-3f
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:15:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3F9l-0000KX-Pe
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:15:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 604BE30821FA
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:15:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190310004749.27029-1-philmd@redhat.com>
	<20190310004749.27029-2-philmd@redhat.com>
Date: Mon, 11 Mar 2019 08:15:15 +0100
In-Reply-To: <20190310004749.27029-2-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun,
	10 Mar 2019 01:47:46 +0100")
Message-ID: <87d0mxswzg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/nvram/fw_cfg: Add
 fw_cfg_add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add a function to read the full content of file on the host, and add
> a new 'file' name item to the fw_cfg device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: s/ptr/data, corrected documentation (Laszlo)
> v3: inverted the if() logic
> ---
>  hw/nvram/fw_cfg.c         | 21 +++++++++++++++++++++
>  include/hw/nvram/fw_cfg.h | 23 +++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7fdf04adc9..2a345bfd5c 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -826,6 +826,27 @@ void fw_cfg_add_file(FWCfgState *s,  const char *fil=
ename,
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);
>  }
>=20=20
> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
> +                                const char *host_path, size_t *len)
> +{
> +    GError *gerr =3D NULL;
> +    gchar *data =3D NULL;
> +    gsize contents_len =3D 0;
> +
> +    if (!g_file_get_contents(host_path, &data, &contents_len, &gerr)) {
> +        error_report("%s", gerr->message);
> +        g_error_free(gerr);
> +        return NULL;
> +    }
> +    fw_cfg_add_file(s, filename, data, contents_len);
> +
> +    if (len) {
> +        *len =3D contents_len;
> +    }
> +
> +    return data;
> +}
> +
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>                          void *data, size_t len)
>  {
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index f5a6895a74..7c4dbe2a2a 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -166,6 +166,29 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uin=
t64_t value);
>  void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
>                       size_t len);
>=20=20
> +/**
> + * fw_cfg_add_file_from_host:
> + * @s: fw_cfg device being modified
> + * @filename: name of new fw_cfg file item
> + * @host_path: path of the host file to read the data from
> + * @len: pointer to hold the length of the host file (optional)
> + *
> + * Read the content of a host file as a raw "blob" then add a new NAMED
> + * fw_cfg item of the file size. If @len is provided, it will contain the
> + * total length read from the host file. The data read from the host
> + * filesystem is owned by the new fw_cfg entry, and is stored into the d=
ata
> + * structure of the fw_cfg device.
> + * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
> + * will be used; also, a new entry will be added to the file directory
> + * structure residing at key value FW_CFG_FILE_DIR, containing the item =
name,
> + * data size, and assigned selector key value.
> + *
> + * Returns: pointer to the newly allocated file content, or NULL if an e=
rror
> + * occured. The returned pointer must be freed with g_free().

In theory.  In practice, your callers (in PATCH 2) ignore the value.

The file contents needs to live as long as FWCfgState (something the
function comments in this file neglect to spell out; doc fix patch would
be nice, not necessarily in this series).  An FWCfgState generally
belongs to a machine (see PATCH 3+4).

It looks like we destroy neither the machine (in a quick test,
machine_finalize() never gets called), nor its fw_cfg device (if I add
an instance_finalize() method to TYPE_FW_CFG_IO, it doesn't get called),
so both machine and its FWCfgState live forever.  There's no point in
time where the caller can obey the function comment's demand to free
without leaving dangling pointers in FWCfgState.

Pushing the responsibility to free the file contents on the caller is
not a nice interface anyway.  I feel fw_cfg should take over ownership.
In the current state of things, that's trivial: document it does, done.

If we ever get around to cleaning up machines and onboard devices
properly, then fw_cfg.c will have to grow a suitable instance_finalize()
method, even without your patch.  We lack such resource cleanup all over
the place, but feel free to a TODO comment here anyway.

Are there more functions in fw_cfg.h with the same interface issue?
Besides FWCfgState constructors, the only one returning a pointer is
fw_cfg_modify_file().  Function comment:

 * Replace a NAMED fw_cfg item. If an existing item is found, its callback
 * information will be cleared, and a pointer to its data will be returned
 * to the caller, so that it may be freed if necessary. If an existing item
 * is not found, this call defaults to fw_cfg_add_file(), and NULL is
 * returned to the caller.

Okay, not the same issue, but there's still an issue: this function's
caller needs to know how the old file contents was added!  Remember,
fw_cfg_add_file() lets you add both malloc'ed and other memory.  Needs
an interface fix or at least a comment pointing out the issue.  Separate
patch, not necessarily in this series.

> + */
> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
> +                                const char *host_path, size_t *len);
> +
>  /**
>   * fw_cfg_add_file_callback:
>   * @s: fw_cfg device being modified
