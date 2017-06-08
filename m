Received: from eggs.gnu.org ([2001:4830:134:3::10]:37641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dItmo-00033S-Q5
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dItmj-0004iR-U8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dItmj-0004i5-LC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:31:21 -0400
Date: Thu, 8 Jun 2017 10:31:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170608093113.GB2082@work-vm>
References: <20170605085254.16485-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170605085254.16485-1-sf@sfritsch.de>
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Stefan Fritsch (sf@sfritsch.de) wrote:
> Sending a break on a serial console can be useful for debugging the
> guest. But not all chardev backends support sending breaks (only telnet
> and mux do). The chardev-send-break command allows to send a break even
> if using other backends.
>=20
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>

=46rom the HMP side, it looks OK, you could easily add a line to
tests/test-hmp.c's command list.

But,

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> ---
>  chardev/char.c   | 12 ++++++++++++
>  hmp-commands.hx  | 16 ++++++++++++++++
>  hmp.c            |  8 ++++++++
>  hmp.h            |  1 +
>  qapi-schema.json | 20 ++++++++++++++++++++
>  5 files changed, 57 insertions(+)
>=20
> diff --git a/chardev/char.c b/chardev/char.c
> index 4e24dc39af..fa54f7c915 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1307,6 +1307,18 @@ void qmp_chardev_remove(const char *id, Error **er=
rp)
>      object_unparent(OBJECT(chr));
>  }
> =20
> +void qmp_chardev_send_break(const char *id, Error **errp)
> +{
> +    Chardev *chr;
> +
> +    chr =3D qemu_chr_find(id);
> +    if (chr =3D=3D NULL) {
> +        error_setg(errp, "Chardev '%s' not found", id);
> +        return;
> +    }
> +    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> +}
> +
>  void qemu_chr_cleanup(void)
>  {
>      object_unparent(get_chardevs_root());
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index e763606fe5..fc8d54b52a 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
>  ETEXI
> =20
>      {
> +        .name       =3D "chardev-send-break",
> +        .args_type  =3D "id:s",
> +        .params     =3D "id",
> +        .help       =3D "send break on chardev",
> +        .cmd        =3D hmp_chardev_send_break,
> +        .command_completion =3D chardev_remove_completion,
> +    },
> +
> +STEXI
> +@item chardev-send-break id
> +@findex chardev-send-break
> +Sends break on the chardev @var{id}.
> +
> +ETEXI
> +
> +    {
>          .name       =3D "qemu-io",
>          .args_type  =3D "device:B,command:s",
>          .params     =3D "[device] \"[command]\"",
> diff --git a/hmp.c b/hmp.c
> index ad723903a6..fb2a38b7d6 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2233,6 +2233,14 @@ void hmp_chardev_remove(Monitor *mon, const QDict =
*qdict)
>      hmp_handle_error(mon, &local_err);
>  }
> =20
> +void hmp_chardev_send_break(Monitor *mon, const QDict *qdict)
> +{
> +    Error *local_err =3D NULL;
> +
> +    qmp_chardev_send_break(qdict_get_str(qdict, "id"), &local_err);
> +    hmp_handle_error(mon, &local_err);
> +}
> +
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict)
>  {
>      BlockBackend *blk;
> diff --git a/hmp.h b/hmp.h
> index d8b94ce9dc..214b2617e7 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -103,6 +103,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qd=
ict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
> +void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>  void hmp_cpu_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_add(Monitor *mon, const QDict *qdict);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 4b50b652d3..e01dd83dd9 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5114,6 +5114,26 @@
>  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> =20
>  ##
> +# @chardev-send-break:
> +#
> +# Send a break to a character device
> +#
> +# @id: the chardev's ID, must exist
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'chardev-send-break', 'data': {'id': 'str'} }
> +
> +
> +##
>  # @TpmModel:
>  #
>  # An enumeration of TPM models
> --=20
> 2.11.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
