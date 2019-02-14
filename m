Received: from eggs.gnu.org ([209.51.188.92]:55788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKe6-0006tZ-8z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKZG-00066r-LH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:12:59 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKZG-0005um-1L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:12:58 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so11666001otm.13
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-7-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:12:29 +0000
Message-ID: <CAFEAcA_k7xNjcmUf0dYk1zviw8t6EyNGH2Qw7-zB=hH5e2SoWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 06/18] hw/boards: Add a MachineState
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
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> On ARM, the kvm_type will be resolved by querying the KVMState.
> Let's add the MachineState handle to the callback so that we
> can retrieve the  KVMState handle. in kvm_init, when the callback
> is called, the kvm_state variable is not yet set.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> [ppc parts]
> ---
>  accel/kvm/kvm-all.c   | 2 +-
>  hw/ppc/mac_newworld.c | 3 +--
>  hw/ppc/mac_oldworld.c | 2 +-
>  hw/ppc/spapr.c        | 2 +-
>  include/hw/boards.h   | 2 +-
>  5 files changed, 5 insertions(+), 6 deletions(-)
>


> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 02f114085f..425d2c86a6 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -171,7 +171,7 @@ struct MachineClass {
>      void (*init)(MachineState *state);
>      void (*reset)(void);
>      void (*hot_add_cpu)(const int64_t id, Error **errp);
> -    int (*kvm_type)(const char *arg);
> +    int (*kvm_type)(MachineState *ms, const char *arg);
>
>      BlockInterfaceType block_default_type;
>      int units_per_default_bus;
> --

Can you add a line to the struct's documentation comment for the
@kvm_type field, please ?

We're rather inconsistent about what we name the MachineState*
parameter in methods here:
 "state" x 1   (init)
 "machine" x 3 (get_hotplug_handler, cpu_index_to_instance_props,
                possible_cpu_arch_ids)
 "ms" x 1 (get_default_cpu_node_id)

It would probably be better to follow the most common option
rather than one of the rarer ones.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
