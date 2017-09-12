Received: from eggs.gnu.org ([2001:4830:134:3::10]:34964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drkur-0000MJ-Kr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drkun-0003Qz-Ct
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drkun-0003P7-3Z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:07:45 -0400
Date: Tue, 12 Sep 2017 15:07:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912150737.395a5045@nial.brq.redhat.com>
In-Reply-To: <20170911152150.12535-14-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/21] target/s390x: use "core-id" for
 cpu number/address/id handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 11 Sep 2017 17:21:42 +0200
David Hildenbrand <david@redhat.com> wrote:

> Some time ago we discussed that using "id" as property name is not the
> right thing to do, as it is a reserved property for other devices and
> will not work with device_add.
> 
> Switch to the term "core-id" instead, and use it as an equivalent to
> "CPU address" mentioned in the PoP. There is no such thing as cpu number,
> so rename env.cpu_num to env.core_id. We use "core-id" as this is the
> common term to use for device_add later on (x86 and ppc).
is there possibility that later The core (something that contains threads)
would appear/exist in real hw?
(my concern here is that we would have to use some other name for it as
renaming of already shipped public property name would be not an option)


> We can get rid of cpu->id now. Keep cpu_index and env->core_id in sync.
> cpu_index was already implicitly used by e.g. cpu_exists(), so keeping
> both in sync seems to be the right thing to do.
> 
> cpu_index will now no longer automatically get set via
> cpu_exec_realizefn(). For now, we were lucky that both implicitly stayed
> in sync.
> 
> Our new cpu property "core-id" can be a static property. Range checks can
> be avoided by using the correct type and the "setting after realized"
> check is done implicitly.
> 
> device_add will later need the reserved "id" property. Hotplugging a CPU
> on s390x will then be: "device_add host-s390-cpu,id=cpu2,core-id=2".
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]

> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index f3624d75eb..293fc8428a 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -232,7 +232,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>              /* XXX make different for different CPUs? */
>              ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
>              ebcdic_put(sysib.plant, "QEMU", 4);
> -            stw_p(&sysib.cpu_addr, env->cpu_num);
> +            stw_p(&sysib.cpu_addr, env->core_id);
>              cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
>          } else if ((sel1 == 2) && (sel2 == 2)) {
>              /* Basic Machine CPUs */
> @@ -260,7 +260,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>                  /* XXX make different for different CPUs? */
>                  ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
>                  ebcdic_put(sysib.plant, "QEMU", 4);
> -                stw_p(&sysib.cpu_addr, env->cpu_num);
> +                stw_p(&sysib.cpu_addr, env->core_id);
>                  stw_p(&sysib.cpu_id, 0);
>                  cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
>              } else if ((sel1 == 2) && (sel2 == 2)) {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 909b12818d..5abd34fb34 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3823,10 +3823,7 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
>  static ExitStatus op_stap(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> -    /* ??? Surely cpu address != cpu number.  In any case the previous
> -       version of this stored more than the required half-word, so it
> -       is unlikely this has ever been tested.  */
> -    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
> +    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
>      return NO_EXIT;
>  }
I see core_id is used in several instructions,
does it really have any influence on code executed by *-user target?
