Received: from eggs.gnu.org ([2001:4830:134:3::10]:53224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P7d-0003Bf-4h
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P7Z-0003fY-94
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:45:33 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P7Z-0003fQ-5K
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:45:29 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so4008375qka.1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 03:45:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-2-git-send-email-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad16bde8-9e4a-3d57-45c1-05baccb3efb7@amsat.org>
Date: Wed, 10 May 2017 07:45:25 -0300
MIME-Version: 1.0
In-Reply-To: <1494309644-18743-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] kvm: irqchip: trace changes on msi
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 05/09/2017 03:00 AM, Peter Xu wrote:
> It'll be nice to know which virq belongs to which device/vector when
> adding msi routes, so adding two more parameters for the add trace.
>
> Meanwhile, releasing virq has no tracing before. Add one for it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  kvm-all.c    | 4 +++-
>  trace-events | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..2598b1f 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1144,6 +1144,7 @@ void kvm_irqchip_release_virq(KVMState *s, int virq)
>      }
>      clear_gsi(s, virq);
>      kvm_arch_release_virq_post(virq);
> +    trace_kvm_irqchip_release_virq(virq);
>  }
>
>  static unsigned int kvm_hash_msi(uint32_t data)
> @@ -1287,7 +1288,8 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>          return -EINVAL;
>      }
>
> -    trace_kvm_irqchip_add_msi_route(virq);
> +    trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
> +                                    vector, virq);
>
>      kvm_add_routing_entry(s, &kroute);
>      kvm_arch_add_msi_route_post(&kroute, vector, dev);
> diff --git a/trace-events b/trace-events
> index e582d63..f01ec05 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -69,8 +69,9 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_irqchip_commit_routes(void) ""
> -kvm_irqchip_add_msi_route(int virq) "Adding MSI route virq=%d"
> +kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> +kvm_irqchip_release_virq(int virq) "virq %d"
>
>  # TCG related tracing (mostly disabled by default)
>  # cpu-exec.c
>
