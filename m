Received: from eggs.gnu.org ([209.51.188.92]:55104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx7va-0000XC-I0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx7vK-0002Se-AD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:19:22 -0500
Date: Fri, 22 Feb 2019 11:18:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222111859.2703fc7f@redhat.com>
In-Reply-To: <20190220224003.4420-5-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 04/17] hw/boards: Add a MachineState
 parameter to kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

On Wed, 20 Feb 2019 23:39:50 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> On ARM, the kvm_type will be resolved by querying the KVMState.
> Let's add the MachineState handle to the callback so that we
> can retrieve the  KVMState handle. in kvm_init, when the callback
> is called, the kvm_state variable is not yet set.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> [ppc parts]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v6 -> v7:
> - add a comment for kvm_type
> - use machine instead of ms in the declaration
> - add Peter's R-b
> ---
>  accel/kvm/kvm-all.c   | 2 +-
>  hw/ppc/mac_newworld.c | 3 +--
>  hw/ppc/mac_oldworld.c | 2 +-
>  hw/ppc/spapr.c        | 2 +-
>  include/hw/boards.h   | 5 ++++-
>  5 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index fd92b6f375..241db496c3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1593,7 +1593,7 @@ static int kvm_init(MachineState *ms)
>  
>      kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>      if (mc->kvm_type) {
> -        type = mc->kvm_type(kvm_type);
> +        type = mc->kvm_type(ms, kvm_type);
>      } else if (kvm_type) {
>          ret = -EINVAL;
>          fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 98461052ac..97e8817145 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -564,8 +564,7 @@ static char *core99_fw_dev_path(FWPathProvider *p, BusState *bus,
>  
>      return NULL;
>  }
> -
> -static int core99_kvm_type(const char *arg)
> +static int core99_kvm_type(MachineState *machine, const char *arg)
>  {
>      /* Always force PR KVM */
>      return 2;
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 284431ddd6..cc1e463466 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -420,7 +420,7 @@ static char *heathrow_fw_dev_path(FWPathProvider *p, BusState *bus,
>      return NULL;
>  }
>  
> -static int heathrow_kvm_type(const char *arg)
> +static int heathrow_kvm_type(MachineState *machine, const char *arg)
>  {
>      /* Always force PR KVM */
>      return 2;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abf9ebce59..3d0811fa81 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2920,7 +2920,7 @@ static void spapr_machine_init(MachineState *machine)
>      }
>  }
>  
> -static int spapr_kvm_type(const char *vm_type)
> +static int spapr_kvm_type(MachineState *machine, const char *vm_type)
>  {
>      if (!vm_type) {
>          return 0;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 05f9f45c3d..ed2fec82d5 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -156,6 +156,9 @@ typedef struct {
>   *    should instead use "unimplemented-device" for all memory ranges where
>   *    the guest will attempt to probe for a device that QEMU doesn't
>   *    implement and a stub device is required.
> + * @kvm_type:
> + *    Return the type of KVM corresponding to the kvm-type string option or
> + *    computed based on other criteria such as the host kernel capabilities.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -171,7 +174,7 @@ struct MachineClass {
>      void (*init)(MachineState *state);
>      void (*reset)(void);
>      void (*hot_add_cpu)(const int64_t id, Error **errp);
> -    int (*kvm_type)(const char *arg);
> +    int (*kvm_type)(MachineState *machine, const char *arg);
>  
>      BlockInterfaceType block_default_type;
>      int units_per_default_bus;
