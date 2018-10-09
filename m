Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q9I-0004uV-NR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q9I-0000s8-13
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:26:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9q9H-0000rZ-P0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:25:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id z25-v6so10808917wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-23-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-23-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:25:46 +0400
Message-ID: <CAJ+F1CJjKnXjb=eMrFf-zJZVrO_Zy+MQin_8Sif5HvQWW8gjOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/31] vl: Clean up error reporting in
 parse_fw_cfg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi


On Mon, Oct 8, 2018 at 9:57 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_fw_cfg() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 1009d708a0..a3a39ec06b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2174,7 +2174,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
>      FWCfgState *fw_cfg =3D (FWCfgState *) opaque;
>
>      if (fw_cfg =3D=3D NULL) {
> -        error_report("fw_cfg device not available");
> +        error_setg(errp, "fw_cfg device not available");
>          return -1;
>      }
>      name =3D qemu_opt_get(opts, "name");
> @@ -2183,15 +2183,16 @@ static int parse_fw_cfg(void *opaque, QemuOpts *o=
pts, Error **errp)
>
>      /* we need name and either a file or the content string */
>      if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)=
))) {
> -        error_report("invalid argument(s)");
> +        error_setg(errp, "invalid argument(s)");
>          return -1;
>      }
>      if (nonempty_str(file) && nonempty_str(str)) {
> -        error_report("file and string are mutually exclusive");
> +        error_setg(errp, "file and string are mutually exclusive");
>          return -1;
>      }
>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
> -        error_report("name too long (max. %d char)", FW_CFG_MAX_FILE_PAT=
H - 1);
> +        error_setg(errp, "name too long (max. %d char)",
> +                   FW_CFG_MAX_FILE_PATH - 1);
>          return -1;
>      }
>      if (strncmp(name, "opt/", 4) !=3D 0) {
> @@ -2203,7 +2204,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
>          buf =3D g_memdup(str, size);
>      } else {
>          if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_report("can't load %s", file);
> +            error_setg(errp, "can't load %s", file);
>              return -1;
>          }
>      }
> @@ -4429,10 +4430,8 @@ int main(int argc, char **argv, char **envp)
>          hax_sync_vcpus();
>      }
>
> -    if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
> -                          parse_fw_cfg, fw_cfg_find(), NULL) !=3D 0) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("fw_cfg"),
> +                      parse_fw_cfg, fw_cfg_find(), &error_fatal);
>
>      /* init USB devices */
>      if (machine_usb(current_machine)) {
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
