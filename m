Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e7gTR-0001xG-3M
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e7gTP-0003VC-Mx
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:37:20 -0400
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:56805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e7gTP-0003Uu-GP
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:37:19 -0400
Received: by mail-ua0-x234.google.com with SMTP id n22so2200849uaj.13
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 04:37:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023151310.6462-2-vadim.galitsyn@profitbricks.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
	<20171023151310.6462-2-vadim.galitsyn@profitbricks.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2017 13:37:18 +0200
Message-ID: <CAJ+F1CJr_uVrsWLYhOo-F-ehEcJoH=kr0WOJH2WPMmacXMHsgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] qmp: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Hi

On Mon, Oct 23, 2017 at 5:13 PM, Vadim Galitsyn <
vadim.galitsyn@profitbricks.com> wrote:

> Add support for `writeconfig' command for QMP monitor.
> This is a simple way to keep track of current state of VM
> after series of hotplugs and/or hotunplugs of different devices.
>
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  qapi-schema.json | 18 ++++++++++++++++++
>  qmp.c            | 21 +++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index a9dd043f65..083f8f3258 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3200,3 +3200,21 @@
>  # Since: 2.11
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'=
}
> }
> +
> +##
> +# @writeconfig:
> +#
> +# Dump current configuration into specified file
> +#
> +# @file: pathname of a file to store current configuration
> +#
> +# Since: 2.11
> +#
> +# Example:
> +#
> +# -> { "execute": "writeconfig",
> +#      "arguments": { "file": "/tmp/qemu.conf" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'writeconfig', 'data': {'file': 'str'} }
> diff --git a/qmp.c b/qmp.c
> index e8c303116a..fcb911cabb 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -722,3 +722,24 @@ MemoryInfo *qmp_query_memory_size_summary(Error
> **errp)
>
>      return mem_info;
>  }
> +
> +void qmp_writeconfig(const char *file, Error **errp)
> +{
> +    int fd;
> +    FILE *fp;
> +
> +    fd =3D qemu_open(file,  O_WRONLY | O_CREAT | O_TRUNC, 0600);
> +    if (fd !=3D -1) {
> +
> +        fp =3D fdopen(fd, "wb");
> +        if (fp) {
> +            qemu_config_write(fp);
> +            fclose(fp);
>

If you use /dev/fdset, this will close the underlying file, but not remove
the file from the fdset.

Dup it or remove it with monitor_fdset_dup_fd_remove() etc?

+            return;
> +        }
> +
> +        qemu_close(fd);
>

But this will close & remove it from fdset (when the operation failed)

Whatever we do, I think it make sense to document the behaviour.



> +    }
> +
> +    error_setg(errp, "cannot write configuration file: '%s'", file);
> +}
> --
> 2.13.1.394.g41dd433
>
>
>


--=20
Marc-Andr=C3=A9 Lureau
