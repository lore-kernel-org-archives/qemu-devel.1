Received: from eggs.gnu.org ([209.51.188.92]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdK4-0001iq-CS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdK3-0001Kk-HG
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:41:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-3-ehabkost@redhat.com>
Date: Wed, 17 Apr 2019 07:41:23 +0200
In-Reply-To: <20190417025944.16154-3-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 16 Apr 2019 23:59:41 -0300")
Message-ID: <871s21194s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] cpu: Extract CPU class lookup from
 parse_cpu_option()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The new function will be useful in user mode, when we already
> have a CPU model and don't need to parse any extra options.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/cpu.h |  9 +++++++++
>  exec.c            | 22 ++++++++++++----------
>  2 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index d28c690b27..e11b14d9ac 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
>   */
>  const char *parse_cpu_option(const char *cpu_option);
>  
> +/**
> + * lookup_cpu_class:
> + * @cpu_model: CPU model name
> + *
> + * Look up CPU class corresponding to a given CPU model name.
> + */
> +CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);

Nitpicks, feel free to ignore.

Naming: lookup_cpu_class() makes my reading circuits stall momentarily,
because lookup is a noun. The verb is spelled look up.  No stall:
cpu_class_lookup(), look_up_cpu_class(), cpu_class_by_name_err(),
cpu_class_parse(), ...

Doc string: this is a wrapper around cpu_class_by_name().  Perhaps that
should be spelled out.

Apropos cpu_class_by_name(): it returns ObjectClass, not CPUClass.
Isn't that odd?

Position: If you put it before cpu_create() rather than after, it's next
to the function it wraps.  But perhaps you prefer to keep it next to
parse_cpu_option().

[...]
