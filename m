Received: from eggs.gnu.org ([2001:4830:134:3::10]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRArr-00087W-NT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRArq-0004nL-Nx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:27:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-4-f4bug@amsat.org>
Date: Fri, 08 Jun 2018 08:27:15 +0200
In-Reply-To: <20180607144645.10187-4-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 Jun 2018 11:46:44
	-0300")
Message-ID: <877en9bxoc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/sysbus-fdt: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Use error_report() + exit() instead of error_setg(&error_fatal),
> as suggested by the "qapi/error.h" documentation:
>
>    Please don't error_setg(&error_fatal, ...), use error_report() and
>    exit(), because that's more obvious.
>
> This fixes CID 1352173:
>     "Passing null pointer dt_name to qemu_fdt_node_path, which dereferenc=
es it."
>
> And this also fixes:
>
>     hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node=
_path') results in a null pointer dereference
>         if (node_path[1]) {
>             ^~~~~~~~~~~~
>
> Fixes: Coverity CID 1352173 (Dereference after null check)

You lost

  Suggested-by: Eric Blake <eblake@redhat.com>

Intentional?

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/sysbus-fdt.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index e4c492ea44..8e2784fa11 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -91,7 +91,7 @@ static void copy_properties_from_host(HostProperty *pro=
ps, int nb_props,
>          r =3D qemu_fdt_getprop(host_fdt, node_path,
>                               props[i].name,
>                               &prop_len,
> -                             props[i].optional ? &err : &error_fatal);
> +                             &err);
>          if (r) {
>              qemu_fdt_setprop(guest_fdt, nodename,
>                               props[i].name, r, prop_len);
> @@ -102,6 +102,7 @@ static void copy_properties_from_host(HostProperty *p=
rops, int nb_props,
>              } else {
>                  error_free(err);
>              }
> +            assert(props[i].optional); /* mandatory property not found */
>          }
>      }
>  }

This is not the conversion the commit message promised: it replaces
exit(1) by abort().  Why?

[Remainder of the patch is unchanged]
