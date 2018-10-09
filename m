Received: from eggs.gnu.org ([2001:4830:134:3::10]:44899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9o74-0002x6-L1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9o6u-0005Sq-7K
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:15:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9o6r-0005NW-Oa
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:15:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id 63-v6so953649wra.11
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-9-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:15:05 +0400
Message-ID: <CAJ+F1CJ2gTcYSuZygx4RqFvQkqxKBvdTbtiYWZEwfeiPkzWPow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/31] pc: Fix machine property
 nvdimm-persistence error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi
On Mon, Oct 8, 2018 at 9:38 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  pc.c's pc_machine_set_nvdimm_persistence() does that,
> and then exit()s.  Wrong.  Attempting to set machine property
> nvdimm-persistence to a bad value instantly kills the VM:
>
>     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "=
package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "qom-set", "arguments": {"path": "/machine", "property": =
"nvdimm-persistence", "value": "instadeath"}}
>     -machine nvdimm-persistence=3Dinstadeath: unsupported option
>     $ echo $?
>     1
>
> Broken when commit 11c39b5cd96 (v3.0.0) replaced error_propagate();
> return by error_report(); exit() instead of error_setg(); return.  Fix
> that.
>
> Fixes: 11c39b5cd966ddc067a1ca0c5392ec9b666c45b7
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/i386/pc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index cd5029c149..eab8572f2a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2209,8 +2209,9 @@ static void pc_machine_set_nvdimm_persistence(Objec=
t *obj, const char *value,
>      else if (strcmp(value, "mem-ctrl") =3D=3D 0)
>          nvdimm_state->persistence =3D 2;
>      else {
> -        error_report("-machine nvdimm-persistence=3D%s: unsupported opti=
on", value);
> -        exit(EXIT_FAILURE);
> +        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsupported =
option",
> +                   value);
> +        return;
>      }
>
>      g_free(nvdimm_state->persistence_string);
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
