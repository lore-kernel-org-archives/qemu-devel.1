Received: from eggs.gnu.org ([209.51.188.92]:32986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx3qe-0000FJ-Hh
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx3qd-0005q2-A1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:58:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190221183829.31019-1-philmd@redhat.com>
Date: Fri, 22 Feb 2019 06:57:34 +0100
In-Reply-To: <20190221183829.31019-1-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	21 Feb 2019 19:38:29 +0100")
Message-ID: <87mumotlf5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Joel Stanley <joel@jms.id.au>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> As Thomas Huth explained:
> "Both functions, object_initialize() and object_property_add_child()
> increase the reference counter of the new object, so one of the
> references has to be dropped afterwards to get the reference counting
> right. Otherwise the child object will not be properly cleaned up
> when the parent gets destroyed.
> Thus let's use now object_initialize_child() instead to get the
> reference counting here right."
>
> This patch was generated using the following Coccinelle script:
>
>  @use_object_initialize_child@
>  identifier parent_obj;
>  expression child;
>  expression propname;
>  expression child_type;
>  expression errp;
>  @@
>  (
>  -    object_initialize(&child, sizeof(child), child_type);
>  -    object_property_add_child(parent_obj, propname, OBJECT(&child), NUL=
L);
>  +    object_initialize_child(parent_obj, propname,  &child, sizeof(child=
),
>  +                            child_type, &error_abort, NULL);
>  |
>  -    object_initialize(&child, sizeof(child), child_type);
>  -    object_property_add_child(parent_obj, propname, OBJECT(&child), err=
p);
>  +    object_initialize_child(parent_obj, propname,  &child, sizeof(child=
),
>  +                            child_type, errp, NULL);
>  )
>
> and a bit of manual fix-up for overly long lines.
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/aspeed_soc.c          | 43 ++++++++++++++++++------------------
>  hw/arm/bcm2835_peripherals.c | 41 +++++++++++++++++-----------------
>  hw/arm/digic.c               |  4 ++--
>  3 files changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d487..81665f2948 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -106,11 +106,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      int i;
>=20=20
> -    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            sc->info->cpu_type, &error_abort, NULL);

This flips from "ignore errors" to "abort on error".  Quite probably an
improvement, but should be mentioned and justified in the commit
message.

[...]
