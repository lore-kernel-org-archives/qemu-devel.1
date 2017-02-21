Received: from eggs.gnu.org ([2001:4830:134:3::10]:33076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgFIF-0006SO-9G
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgFIE-0001mT-9Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:36:07 -0500
Date: Tue, 21 Feb 2017 15:35:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170221183557.GI2778@thinpad.lan.raisama.net>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<1486996099-15820-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486996099-15820-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/4] cpu: add cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Mon, Feb 13, 2017 at 02:28:16PM +0000, Peter Maydell wrote:
> From: Michael Davidsaver <mdavidsaver@gmail.com>
> 
> Add a new API cpu_generic_new() which creates a QOM CPU object
> (including calling the CPU class parse_features method) but
> does not realize it, and reimplement cpu_generic_init() to
> simply call cpu_generic_new() and then immediately realize.
> the CPU.
> 
> The motivation for this is that there is currently no
> way for board code to take advantage of the cpu_generic_init()
> convenience function if it needs to set QOM properties
> on the created CPU. Instead it has to do it all manually, which
> is prone to bugs like that fixed in commit 00909b585861 (where
> a board code forgot to call parse_features which meant that
> command line +feature,-feature flags were ignored).
> 
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: renamed new function to cpu_generic_new(), rewrote
>  commit message]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qom/cpu.h | 17 +++++++++++++++++
>  qom/cpu.c         | 27 ++++++++++++++++++---------
>  2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 45bcf21..e900586 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -599,11 +599,28 @@ void cpu_reset(CPUState *cpu);
>  ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
>  
>  /**
> + * cpu_generic_new:
> + * @typename: The CPU base type.
> + * @cpu_model: The model string including optional parameters.
> + *
> + * Instantiates a CPU, processes optional parameters but does not realize it.
> + * This is the recommended way to create a CPU object which needs to be
> + * configured by then setting QOM properties on it. The configured CPU can
> + * then be realized in the usual way by calling
> + *    object_property_set_bool(cpuobj, true, "realized", &err);
> + *
> + * Returns: A #CPUState or %NULL if an error occurred.
> + */
> +CPUState *cpu_generic_new(const char *typename, const char *cpu_model);

I am not sure we will stlil add this, but in case we are going to
add this helper temporarily until we have Igor's generic
cpu_model parsing, it would be useful to make the function
signature be:
  CPUState *cpu_generic_new(const char *typename, MachineState *machine)
and parse machine->cpu_model inside the function implementation.

This way we could replace the helper with
  object_new(machine->cpu_typename)
more easily once we add Igor's cleanup.

-- 
Eduardo
