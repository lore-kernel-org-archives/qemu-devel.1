Received: from eggs.gnu.org ([2001:4830:134:3::10]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCWyb-0007Lt-Bl
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCWyY-0008DX-7c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:29:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eCWyX-0008Cz-Uz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:29:30 -0500
Date: Wed, 8 Nov 2017 18:29:24 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171108202924.GV3111@localhost.localdomain>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171108022828.7242-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] machine: add a deprecated_reason
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, Nov 07, 2017 at 11:28:23PM -0300, Philippe Mathieu-Daud=E9 wrote:
> If a machine has the deprecated_reason property set:
> - it won't get listed anymore by the "-M help" command,
> - a warning will be displayed if the machine is used.
>=20
> Example:
>   $ ppc-softmmu/qemu-system-ppc -M prep
>   qemu-system-ppc: -M prep: warning: The PowerPC PREP platform machine =
is deprecated (Obsoleted by the "40p" machine)
>   [machine starting ...]
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  include/hw/boards.h | 1 +
>  vl.c                | 7 +++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 191a5b3cd8..4d5c180968 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -182,6 +182,7 @@ struct MachineClass {
>      const char *default_boot_order;
>      const char *default_display;
>      GArray *compat_props;
> +    const char *deprecated_reason;

This series introduces 5 different flavors of deprecation
messages:

* "Too old"
* "Unmaintained"
* "The ZCU102 machine has the same features supported"
* "Use the \"pc\" machine instead"
* "Obsoleted by the \"40p\" machine"

Can we clearly document guidelines and examples for values of
this field, to help ensure consistency?

Examples of questions that could be answered in the field
documentation:

* Should the message start with an uppercase letter?
* Should it really explain _why_ it was deprecated, or is a
  simple "please use xlnx-zcu102 instead" good enough?
* Which of the following is preferred:
  * "obsoleted by the \"pc\" machine"
  * "obsoleted by \"pc\""
  * "use \"pc\" instead"
  * "too old, use \"pc\" instead"
  * "too old; use \"pc\" instead"
  * <something else?>


Minor suggestion: name the field 'deprecation_reason' instead of
'deprecated_reason'.

>      const char *hw_version;
>      ram_addr_t default_ram_size;
>      const char *default_cpu_type;
> diff --git a/vl.c b/vl.c
> index ec299099ff..9ed4648af2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2742,6 +2742,10 @@ static gint machine_class_cmp(gconstpointer a, g=
constpointer b)
>      }
>      if (mc) {
>          g_slist_free(machines);
> +        if (mc->deprecated_reason) {
> +            warn_report("The %s machine is deprecated (%s)",
> +                        mc->desc, mc->deprecated_reason);

I would use mc->name instead of mc->desc.


> +        }
>          return mc;
>      }
>      if (name && !is_help_option(name)) {
> @@ -2752,6 +2756,9 @@ static gint machine_class_cmp(gconstpointer a, gc=
onstpointer b)
>          machines =3D g_slist_sort(machines, machine_class_cmp);
>          for (el =3D machines; el; el =3D el->next) {
>              MachineClass *mc =3D el->data;
> +            if (mc->deprecated_reason) {
> +                continue;
> +            }
>              if (mc->alias) {
>                  printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc=
, mc->name);
>              }
> --=20
> 2.15.0
>=20

--=20
Eduardo
