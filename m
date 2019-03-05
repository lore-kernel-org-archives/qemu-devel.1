Received: from eggs.gnu.org ([209.51.188.92]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h1EDU-0005xK-Bf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h1EDT-0001fy-9D
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:51:00 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h1EDS-0001bU-Is
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:50:59 -0500
Date: Tue, 5 Mar 2019 12:50:55 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190305175055.GA21325@flamenco>
References: <20190305150123.25048-1-richard.henderson@linaro.org>
	<CAFEAcA-1OaDU0T64TyXHfDZGLse5fknT7uVmRsX68mRcxqC4Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-1OaDU0T64TyXHfDZGLse5fknT7uVmRsX68mRcxqC4Xg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/73] tcg: per-cpu locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 05, 2019 at 16:01:45 +0000, Peter Maydell wrote:
> On Tue, 5 Mar 2019 at 15:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > This is Emilio's v7, unchanged, so I'm not re-posting the 73 patches.
> >
> > I also didn't want to add Signed-off-by to 73 patches, so I verified
> > that there was nothing on Emilio's branch that shouldn't be there and
> > then used git-merge -S --signoff.
> 
> Hi; I'm afraid this doesn't build on OSX:
> 
> /Users/pm215/src/qemu-for-merges/target/i386/hvf/x86hvf.c:361:14:
> error: unused variable 'interrupt_request' [-Werror,-Wunused-variable]
>     uint32_t interrupt_request;

Fixed on "i386: convert to cpu_halted".

> /Users/pm215/src/qemu-for-merges/target/i386/hvf/x86hvf.c:465:23:
> error: incompatible pointer types passing 'X86CPU *' (aka 'struct
> X86CPU *') to parameter of type 'CPUState *' (aka 'struct CPUState *')
> [-Werror,-Wincompatible-pointer-types]
>     return cpu_halted(cpu);
>                       ^~~
> /Users/pm215/src/qemu-for-merges/include/qom/cpu.h:510:45: note:
> passing argument to parameter 'cpu' here
> static inline uint32_t cpu_halted(CPUState *cpu)
>                                             ^

Fixed on "i386/hvf: convert to cpu_request_interrupt".


I've pushed a new branch with these two patches fixed up:
  https://github.com/cota/qemu/tree/cpu-lock-v7b

$ git diff cpu-lock-v7..cpu-lock-v7b
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 91feafeedc..c13d144fb3 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -358,7 +358,6 @@ bool hvf_inject_interrupts(CPUState *cpu_state)

     uint8_t vector;
     uint64_t intr_type;
-    uint32_t interrupt_request;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
@@ -462,5 +461,5 @@ int hvf_process_events(CPUState *cpu_state)
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-    return cpu_halted(cpu);
+    return cpu_halted(cpu_state);
 }

Thanks,

		Emilio
