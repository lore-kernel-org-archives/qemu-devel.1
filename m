Received: from eggs.gnu.org ([2001:4830:134:3::10]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e5HsL-0000FW-Tv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e5HsK-00081f-VL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:57:10 -0400
Date: Thu, 19 Oct 2017 13:56:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA_v=UsQ4hfn2oVLt3MPU3yJUnHLfzZHrdkstQ0VVgSDbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710191354020.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710181439060.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA_v=UsQ4hfn2oVLt3MPU3yJUnHLfzZHrdkstQ0VVgSDbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On Thu, 19 Oct 2017, Peter Maydell wrote:
> On 18 October 2017 at 23:03, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > WFI/E are 4 bytes long: set ARM_EL_IL_SHIFT in the syndrome.
> >
> > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index 1f6efef..cf8c966 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -398,6 +398,7 @@ static inline uint32_t syn_breakpoint(int same_el)
> >  static inline uint32_t syn_wfx(int cv, int cond, int ti)
> >  {
> >      return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
> > +           (1 << ARM_EL_IL_SHIFT) |
> >             (cv << 24) | (cond << 20) | ti;
> >  }
> 
> Hmm. What we do now is definitely wrong, but WFI and WFE can be 2 bytes:
> there is a T1 Thumb encoding that is 2 bytes.
> 
> HELPER(wfi) doesn't get that right, though:
>     if (target_el) {
>         env->pc -= 4;
>         raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0), target_el);
>     }
> 
> So I think that HELPER(wfi) needs to be passed an extra
> parameter is_16bit, which it can then use both in its adjustment
> of env->pc and to pass as an extra parameter to syn_wfx(),
> which is then syn_wfx(int cv, int cond, int ti, bool is_16bit).
> 
> (In theory HELPER(wfe) should also be passed is_16bit, but
> since it doesn't currently ever raise an exception it
> doesn't matter.)

Wouldn't it be better to just check on env->thumb like
HELPER(cpsr_write_eret) for example?

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07a..a451763 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 43106a2..55c70b4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -428,9 +428,10 @@ static inline uint32_t syn_breakpoint(int same_el)
         | ARM_EL_IL | 0x22;
 }
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti)
+static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
     return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
+           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
            (cv << 24) | (cond << 20) | ti;
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 3914145..ea16c9a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -476,8 +476,8 @@ void HELPER(wfi)(CPUARMState *env)
     }
 
     if (target_el) {
-        env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0), target_el);
+        env->pc -= env->thumb ? 2 : 4;
+        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, env->thumb), target_el);
     }
 
     cs->exception_index = EXCP_HLT;
