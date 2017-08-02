Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dctvF-0005Iq-Dj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dctvE-0007vb-OL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:42:49 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170802103259.25940-1-lvivier@redhat.com>
References: <20170802103259.25940-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 2 Aug 2017 10:42:41 -0300
Message-ID: <CAAdtpL4fDx3JLm7+=TcJTZXwq_zuwup4=zkGH8QMLJ1ES=kqHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Laurent,

On Wed, Aug 2, 2017 at 7:32 AM, Laurent Vivier <lvivier@redhat.com> wrote:
> With pseries machine type a negative core-id is not managed properly:
> -1 gives an inaccurate error message ("core -1 already populated"),
> -2 crashes QEMU (core dump)
>
> As it seems a negative value is invalid for any architecture,
> instead of checking this in spapr_core_pre_plug() I think it's better
> to check this in the generic part, core_prop_set_core_id()

Why is this property signed? If there is not reason to use it negative,
is it possible to use object_property_add(.."uint"..)?

Also what about core_prop_set_nr_threads()? It might coredump the
same way.

Regards,

Phil.

>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/cpu/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 2bf960d..bd578ab 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -33,6 +33,11 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>
> +    if (value < 0) {
> +        error_setg(errp, "Invalid core id %"PRId64, value);
> +        return;
> +    }
> +
>      core->core_id = value;
>  }
>
> --
> 2.9.4
>
>
