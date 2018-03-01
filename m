Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erR64-0001Xq-Lx
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erR61-0005hH-UF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:20 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erR61-0005fD-0j
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:17 -0500
Received: by mail-oi0-x244.google.com with SMTP id g5so4900919oiy.8
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:30:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519815685-29200-3-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-3-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 16:29:55 +0000
Message-ID: <CAFEAcA8hSz-WUsAo2J3VJWSQTg4_ueX8RgAhAG15wvjBeRf4tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/arm: Add "_S" suffix to the
 secure version of a sysreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 28 February 2018 at 11:01, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> This is a preparation for the coming feature of creating dynamically an XML
> description for the ARM sysregs.
> Add "_S" suffix to the secure version of sysregs that have both S and NS views
> Replace (S) and (NS) by _S and _NS for the register that are manually defined,
> so all the registers follow the same convention.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>  target/arm/helper.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index bdd212f..1594ec45 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -694,12 +694,12 @@ static const ARMCPRegInfo cp_reginfo[] = {
>       * the secure register to be properly reset and migrated. There is also no
>       * v8 EL1 version of the register so the non-secure instance stands alone.
>       */
> -    { .name = "FCSEIDR(NS)",
> +    { .name = "FCSEIDR_NS",

I think this should just be "FCSEIDR", because the convention we
seem to be going with is "_S" for the secure banked register, and
no suffix for the non-secure banked register.

> @@ -5562,7 +5562,8 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
>
>  static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>                                     void *opaque, int state, int secstate,
> -                                   int crm, int opc1, int opc2)
> +                                   int crm, int opc1, int opc2,
> +                                   const char *name)
>  {
>      /* Private utility function for define_one_arm_cp_reg_with_opaque():
>       * add a single reginfo struct to the hash table.
> @@ -5572,6 +5573,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>      int is64 = (r->type & ARM_CP_64BIT) ? 1 : 0;
>      int ns = (secstate & ARM_CP_SECSTATE_NS) ? 1 : 0;
>
> +    r2->name = name;
>      /* Reset the secure state to the specific incoming state.  This is
>       * necessary as the register may have been defined with both states.
>       */
> @@ -5803,19 +5805,26 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>                          /* Under AArch32 CP registers can be common
>                           * (same for secure and non-secure world) or banked.
>                           */
> +                        const char *name;
> +                        GString *s;
> +
>                          switch (r->secure) {
>                          case ARM_CP_SECSTATE_S:
>                          case ARM_CP_SECSTATE_NS:
>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
> -                                                   r->secure, crm, opc1, opc2);
> +                                                   r->secure, crm, opc1, opc2,
> +                                                   r->name);
>                              break;
>                          default:
> +                            s = g_string_new(r->name);
> +                            g_string_append_printf(s, "_S");
> +                            name = g_string_free(s, false);

You can do this more simply with just
     name = g_strdup_printf("%s_S", r->name);

You only need to use the g_string APIs when you're appending to the
same string multiple times; if you're creating the entire string in
one go this is simpler.

>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
>                                                     ARM_CP_SECSTATE_S,
> -                                                   crm, opc1, opc2);
> +                                                   crm, opc1, opc2, name);
>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
>                                                     ARM_CP_SECSTATE_NS,
> -                                                   crm, opc1, opc2);
> +                                                   crm, opc1, opc2, r->name);
>                              break;
>                          }
>                      } else {

This means we're going to have the hashtable entries be a mix of
structs that point to constant strings and structs that point to
dynamically allocated strings. That's OK right now, because you
can't dynamically construct and delete Arm CPU objects. But if/when
we add support for that (eg for cpu hotplug) it'll mean memory leaks.
I think the simplest approach is that:
 * in add_cpreg_to_hashtable() instead of r2->name = name we should
   r2->name = g_strdup(name);
 * the code here which allocates memory for the _S variant name
   should then do a g_free(name) once it's called add_cpreg_to_hashtable()

Then disposal of hashtable entries (when we write it) will be simple:
always free r->name.

thanks
-- PMM
