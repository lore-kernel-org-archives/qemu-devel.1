Received: from eggs.gnu.org ([2001:4830:134:3::10]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4SsD-00067u-03
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Ss8-0000uI-Sv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:29:37 -0400
Date: Tue, 17 Oct 2017 16:29:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017162927.5ee8b9cd.cohuck@redhat.com>
In-Reply-To: <1508247680-98800-3-git-send-email-imammedo@redhat.com>
References: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
	<1508247680-98800-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x: move s390x_new_cpu() into board
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On Tue, 17 Oct 2017 15:41:20 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> s390-virtio-ccw.c is the sole user of s390x_new_cpu(),
> so move this helper there.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/s390x/cpu.h         |  1 -
>  hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
>  target/s390x/helper.c      | 20 --------------------
>  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 7e864c8..b177be9 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -695,7 +695,6 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  
>  /* helper.c */
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
> -S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp);
>  
>  #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
>  #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 32d3f11..f64db51 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -52,6 +52,27 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>      return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
>  }
>  
> +static
> +S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)

I don't like this wrap; better wrap the argument list.

> +{
> +    S390CPU *cpu = S390_CPU(object_new(typename));
> +    Error *err = NULL;
> +
> +    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
> +    if (err != NULL) {
> +        goto out;
> +    }
> +    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
> +
> +out:
> +    object_unref(OBJECT(cpu));
> +    if (err) {
> +        error_propagate(errp, err);
> +        cpu = NULL;
> +    }
> +    return cpu;
> +}
> +
>  static void s390_init_cpus(MachineState *machine)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 64d4c48..52aa64b 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -68,26 +68,6 @@ void s390x_cpu_timer(void *opaque)
>  }
>  #endif
>  
> -S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
> -{
> -    S390CPU *cpu = S390_CPU(object_new(typename));
> -    Error *err = NULL;
> -
> -    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
> -    if (err != NULL) {
> -        goto out;
> -    }
> -    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
> -
> -out:
> -    object_unref(OBJECT(cpu));
> -    if (err) {
> -        error_propagate(errp, err);
> -        cpu = NULL;
> -    }
> -    return cpu;
> -}
> -
>  #ifndef CONFIG_USER_ONLY
>  
>  hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)

Otherwise, looks sane.
