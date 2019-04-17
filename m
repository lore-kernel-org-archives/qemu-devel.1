Received: from eggs.gnu.org ([209.51.188.92]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGl2Q-0006aQ-Vw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGl2O-000772-RR
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:55:46 -0400
Date: Wed, 17 Apr 2019 10:55:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190417135538.GA25134@habkost.net>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-3-ehabkost@redhat.com>
	<871s21194s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s21194s.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, Apr 17, 2019 at 07:41:23AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > The new function will be useful in user mode, when we already
> > have a CPU model and don't need to parse any extra options.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/qom/cpu.h |  9 +++++++++
> >  exec.c            | 22 ++++++++++++----------
> >  2 files changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index d28c690b27..e11b14d9ac 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
> >   */
> >  const char *parse_cpu_option(const char *cpu_option);
> >  
> > +/**
> > + * lookup_cpu_class:
> > + * @cpu_model: CPU model name
> > + *
> > + * Look up CPU class corresponding to a given CPU model name.
> > + */
> > +CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);
> 
> Nitpicks, feel free to ignore.
> 
> Naming: lookup_cpu_class() makes my reading circuits stall momentarily,
> because lookup is a noun. The verb is spelled look up.  No stall:
> cpu_class_lookup(), look_up_cpu_class(), cpu_class_by_name_err(),
> cpu_class_parse(), ...
> 
> Doc string: this is a wrapper around cpu_class_by_name().  Perhaps that
> should be spelled out.
> 
> Apropos cpu_class_by_name(): it returns ObjectClass, not CPUClass.
> Isn't that odd?
> 
> Position: If you put it before cpu_create() rather than after, it's next
> to the function it wraps.  But perhaps you prefer to keep it next to
> parse_cpu_option().

Your suggestions make sense.  I didn't notice how close
lookup_cpu_class() was to the declaration of cpu_class_by_name().
I was seeing lookup_cpu_class() as "this portion of
parse_cpu_option() I need", and not as "a wrapper to
cpu_class_by_name()".

What about:

/**
 * arch_cpu_class_by_name:
 * @cpu_model: CPU model name
 *
 * Arch-specific wrapper around cpu_class_by_name(), uses CPU_RESOLVING_TYPE
 * for the current architecture.
 */
CPUClass *arch_cpu_class_by_name(const char *cpu_model, Error **errp);


-- 
Eduardo
