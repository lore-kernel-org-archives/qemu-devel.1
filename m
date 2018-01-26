Received: from eggs.gnu.org ([2001:4830:134:3::10]:44284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef3nn-0002kX-4c
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef3nl-0005KV-LT
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:12:19 -0500
Date: Fri, 26 Jan 2018 08:42:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180126104247.GF25150@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
	<20180122183301.GA31237@localhost.localdomain>
	<CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Thu, Jan 25, 2018 at 02:41:50PM +0000, Peter Maydell wrote:
> On 22 January 2018 at 18:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > About QOM type names:
> >
> > On x86, all CPU models are resolved to "<model>-<suffix>", and
> > i386 and x86_64 have different suffixes.  So the QOM type name is
> > "max-x86_64-cpu" on qemu-system-x86_64, and "max-i386-cpu" on
> > qemu-system-i386.
> 
> OK. Looking at the target/arm code we do a similar suffix
> trick, but we seem to have cut-n-pasted the handling in
> aarch64_cpu_register(), so it uses the TYPE_ARM_CPU as the
> suffix, rather the TYPE_AARCH64_CPU.
> 
> Am I right in thinking that we can fix this (changing the
> QOM type names for all the aarch64 CPUs) without breaking
> migration? (I guess I can just test this easily enough.)

This is not supposed to affect migration (at least it didn't when
we introduced per-cpu-model subclasses), but it's a good idea to
test it anyway.  It might break other code that tries to extract
info from the class names.


> 
> If we did that then we'd have, like x86, "max-arm-cpu" in
> the qemu-system-arm binary, and "max-aarch64-cpu" in
> the qemu-system-aarch64 binary.
> 
> Does x86 provide a way to say "give me the max-i386-cpu"
> in the qemu-system-x86_64 binary ?

No, the *-i386-cpu classes aren't even compiled in on
qemu-system-x86_64.

> 
> > About how it should behave:
> >
> > An important expectation about "max" is about the
> > query-cpu-model-expansion return value.  Having a property set to
> > true on the return value of "query-cpu-model-expansion model=max"
> > means the corresponding feature is supported on the current host
> > and can be enabled on the command-line.
> 
> On Arm when I try to use this I get:
> { "execute": "query-cpu-model-expansion", "arguments": { "type":
> "static", "model": { "model": { "name": "max" } } } }
> {
>     "error": {
>         "class": "CommandNotFound",
>         "desc": "The command query-cpu-model-expansion has not been found"
>     }
> }
> 
> It looks like we only implement this QMP API for x86 and S390
> (via #ifdeffery in monitor.c).
> 
> I'm not sure if we actually support command line setting/unsetting
> of features for Arm CPUs -- is there a command line option to
> get QEMU to print the features it thinks can be set this way?

Unfortunately -cpu command-line parsing is still a mess (we
currently have lots of arch-specific parsing hooks).  Once we
make this uniform across targets, we could make "-cpu ?" print
all known properties.

But you can look at the list of QOM properties for your CPU
classes (-cpu options are simply translated to QOM properties).
e.g.:

  (QEMU) device-list-properties typename=pxa270-a0-arm-cpu
  {"return": [{"type": "uint32", "name": "midr"}, {"type": "uint64", "name": "mp-affinity"}, {"type": "child<irq>", "name": "unnamed-gpio-in[0]"}, {"type": "uint32", "name": "psci-conduit"}, {"type": "bool", "name": "reset-hivecs"}, {"type": "link<qemu:memory-region>", "name": "memory"}, {"type": "link<irq>", "name": "unnamed-gpio-out[2]"}, {"type": "link<irq>", "name": "unnamed-gpio-out[3]"}, {"type": "int32", "name": "node-id"}, {"type": "bool", "name": "start-powered-off"}, {"type": "link<irq>", "name": "unnamed-gpio-out[1]"}, {"type": "link<irq>", "name": "unnamed-gpio-out[0]"}, {"type": "link<irq>", "name": "gicv3-maintenance-interrupt[0]"}, {"type": "bool", "name": "cfgend"}, {"type": "child<irq>", "name": "unnamed-gpio-in[2]"}, {"type": "child<irq>", "name": "unnamed-gpio-in[3]"}, {"type": "child<irq>", "name": "unnamed-gpio-in[1]"}]}



> 
> >> (The code in this patchset makes '-cpu max' give the same
> >> QOM type name for both qemu-system-arm and qemu-system-aarch64,
> >> with different behaviour depending on the binary. If that means
> >> we don't provide the same behaviour as x86 then I can change that,
> >> but I'm not sure where the difference is exposed to the user?)
> >
> > This is not how the QOM names work on x86, but I don't think QOM
> > type names choices have important user-visible side-effects
> > today.  Choosing unique QOM type names is more important to make
> > the code future-proof for when we merge QEMU binaries, than to
> > make user-visible behavior consistent.
> 
> Good point -- assuming it doesn't break migration I can fix
> the aarch64 types to use the right suffix string and then they'll
> have different QOM type names.
> 
> thanks
> -- PMM

-- 
Eduardo
