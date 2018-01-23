Received: from eggs.gnu.org ([2001:4830:134:3::10]:36812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1edzYK-0007WB-P7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1edzYH-0002j8-M4
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:27:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1edzYH-0002eh-Cd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:27:53 -0500
References: <20180123132021.27593-1-joserz@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <37eece67-9b28-b574-6cf6-f25fe77c19ff@redhat.com>
Date: Tue, 23 Jan 2018 15:27:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180123132021.27593-1-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "virtio: postpone the execution of
 event_notifier_cleanup function"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mst@redhat.com, ghammer@redhat.com
Cc: pbonzini@redhat.com, danielhb@linux.vnet.ibm.com, anton@samba.org

On 23/01/2018 14:20, Jose Ricardo Ziviani wrote:
> This reverts commit 4fe6d78b2e241f41208dfb07605aace4becfc747.
> 
> As reported http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
> The referred commit is causing regression issues in virtio.
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Reported-by: Anton Blanchard <anton@samba.org>
> ---
>  accel/kvm/kvm-all.c    |  4 ----
>  hw/virtio/virtio-bus.c | 19 ++++++++-----------
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 071f4f57c0..f290f487a5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
>      if (r < 0) {
>          abort();
>      }
> -
> -    if (e->cleanup) {
> -        e->cleanup(e);
> -    }
>  }
>  
>  static void kvm_io_ioeventfd_add(MemoryListener *listener,
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 8106346927..3042232daf 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -256,15 +256,6 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
>      return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
>  }
>  
> -static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
> -{
> -    /* Test and clear notifier after disabling event,
> -     * in case poll callback didn't have time to run.
> -     */
> -    virtio_queue_host_notifier_read(notifier);
> -    event_notifier_cleanup(notifier);
> -}
> -
>  /*
>   * This function switches ioeventfd on/off in the device.
>   * The caller must set or clear the handlers for the EventNotifier.
> @@ -292,13 +283,19 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
>          r = k->ioeventfd_assign(proxy, notifier, n, true);
>          if (r < 0) {
>              error_report("%s: unable to assign ioeventfd: %d", __func__, r);
> -            virtio_bus_cleanup_event_notifier(notifier);
> +            goto cleanup_event_notifier;
>          }
> +        return 0;
>      } else {
> -        notifier->cleanup = virtio_bus_cleanup_event_notifier;
>          k->ioeventfd_assign(proxy, notifier, n, false);
>      }
>  
> +cleanup_event_notifier:
> +    /* Test and clear notifier after disabling event,
> +     * in case poll callback didn't have time to run.
> +     */
> +    virtio_queue_host_notifier_read(notifier);
> +    event_notifier_cleanup(notifier);
>      return r;
>  }
>  
> 

Tested-by: Laurent Vivier <lvivier@redhat.com>
