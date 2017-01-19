Received: from eggs.gnu.org ([2001:4830:134:3::10]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEOl-00049s-AT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEOk-0004ny-7F
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:13:11 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUEOk-0004nU-2Y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:13:10 -0500
Received: by mail-ua0-x236.google.com with SMTP id y9so35788956uae.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:13:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118165256.GC6657@thinpad.lan.raisama.net>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
	<20170112142836.53bbd87b@squid.athome>
	<CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
	<20170118165256.GC6657@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 15:12:49 +0000
Message-ID: <CAFEAcA-VmK+oMdV7GONa=H2v6Oz1uO=gaM3UgRf0SvK1QHO+3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Julian Brown <julian@codesourcery.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 January 2017 at 16:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Jan 17, 2017 at 11:52:24AM +0000, Peter Maydell wrote:
>> Oops, I'd forgotten there was board-specific code for handling
>> cpu feature flags. I think we want to change the other boards
>> to do it like the virt board does, but maybe I'm wrong.
>> I've cc'd Eduardo who will hopefully know the right way to handle
>> this.
>
> I don't understand what's missing here: cpu_arm_init() already
> calls cpu_generic_init(), which already calls
> CPUClass::parse_features() after splitting the cpu_model string
> and calling CPUClass::class_by_name().

Well, the 'virt' board calls cc->parse_features() directly,
and so (judging by grep) do a handful of other boards, but most
don't. Is this the right new thing going forward, and do we
need to convert the remaining boards over to match?

> Which board aree you using to test this? Is the board calling
> cpu_arm_init() to create the CPU?

It looks like only a very few ARM boards still call
cpu_arm_init() [just musicpal, omap, pxa2xx, strongarm and the
v7m ones] -- most do something like:

   ObjectClass *cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
   [...]

        Object *cpuobj = object_new(object_class_get_name(cpu_oc));

        if (!secure) {
            object_property_set_bool(cpuobj, false, "has_el3", NULL);
        }

        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
            object_property_set_int(cpuobj, periphbase,
                                    "reset-cbar", &error_abort);
        }
        object_property_set_bool(cpuobj, true, "realized", &error_fatal);

(that example is from hw/arm/vexpress.c)

This is because cpu_generic_init() provides no way for the
board to set CPU properties -- it does both the object init
and realize in one go.

I'm actually looking at a patch at the moment that attempts
to fix this by adding a cpu_generic_init_unrealized(),
which does everything that cpu_generic_init() does except
the final "set the realized prop to true" step, so that you
can call it, set CPU properties and then realize the CPU
yourself. Does that sound like a good idea, or a bad idea?
[https://github.com/mdavidsaver/qemu/commit/82823fb6f97859dc5f2945bd3b2733df2c81b2d8]

I'm not sure which board Julian is using, but I guess it's one
of the ones that doesn't call cpu_generic_init().

thanks
-- PMM
