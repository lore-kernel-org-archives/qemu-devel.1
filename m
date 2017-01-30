Received: from eggs.gnu.org ([2001:4830:134:3::10]:59008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cY83j-0007aC-5b
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 04:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cY83i-0005VB-B9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 04:15:35 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1485422381-29019-4-git-send-email-eric.auger@redhat.com> (Eric
	Auger's message of "Thu, 26 Jan 2017 10:19:40 +0100")
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<1485422381-29019-4-git-send-email-eric.auger@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jan 2017 10:15:13 +0100
Message-ID: <87vasw29jy.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 3/4] hw/intc/arm_gicv3_its: Implement state
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org, christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, peterx@redhat.com, dgilbert@redhat.com

Eric Auger <eric.auger@redhat.com> wrote:
> We need to handle both registers and ITS tables. While
> register handling is standard, ITS table handling is more
> challenging since the kernel API is devised so that the
> tables are flushed into guest RAM and not in vmstate buffers.
>
> Flushing the ITS tables on device pre_save() is too late
> since the guest RAM had already been saved at this point.
>
> Table flushing needs to happen when we are sure the vcpus
> are stopped and before the last dirty page saving. The
> right point is RUN_STATE_FINISH_MIGRATE but sometimes the
> VM gets stopped before migration launch so let's simply
> flush the tables each time the VM gets stopped.
>
> For regular ITS registers we just can use vmstate pre_save
> and post_load callbacks.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Hi


> + * vm_change_state_handler - VM change state callback aiming at flushing
> + * ITS tables into guest RAM
> + *
> + * The tables get flushed to guest RAM whenever the VM gets stopped.
> + */
> +static void vm_change_state_handler(void *opaque, int running,
> +                                    RunState state)
> +{
> +    GICv3ITSState *s = (GICv3ITSState *)opaque;

Cast is unneeded.

> +
> +    if (running) {
> +        return;
> +    }
> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_TABLES,
> +                      0, NULL, false);

As you are adding it to do everytime that we stop the guest, how
expensive/slow is that?

Thanks, Juan.
