Received: from eggs.gnu.org ([2001:4830:134:3::10]:50124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6ujM-00042v-8e
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6ujH-00073D-80
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g6ujG-00072U-Vx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FCF9308FE94
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:43:02 +0000 (UTC)
References: <20180926163709.22876-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55838024-13d8-792c-24f1-f9b4f62b59f2@redhat.com>
Date: Mon, 1 Oct 2018 11:42:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180926163709.22876-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ivshmem: Fix unplug of device
 "ivshmem-plain"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 26/09/2018 18:37, Markus Armbruster wrote:
> Commit 2aece63c8a "hostmem: detect host backend memory is being used
> properly" fixed "ivshmem-plain" to reject memory backends that are
> already in use, and to block their deletion while in use.  Two bugs
> escaped review:
> 
> * New ivshmem_plain_exit() fails to call ivshmem_exit().  This breaks
>   unplug.  Reproducer: migration after unplug still fails with
>   "Migration is disabled when using feature 'peer mode' in device
>   'ivshmem'".
> 
> * It failed to update legacy "ivshmem".  Harmless, because it creates
>   the memory backend itself, and nothing else should use it.
> 
> Fix by moving the two host_memory_backend_set_mapped() calls into
> ivshmem_common_realize() and ivshmem_exit(), guarded by s->hostmem.
> 
> Fixes: 2aece63c8a9d2c3a8ff41d2febc4cdeff2633331
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/misc/ivshmem.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 6febbabcaa..8cb17b9dd4 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -911,6 +911,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>          IVSHMEM_DPRINTF("using hostmem\n");
>  
>          s->ivshmem_bar2 = host_memory_backend_get_memory(s->hostmem);
> +        host_memory_backend_set_mapped(s->hostmem, true);
>      } else {
>          Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
>          assert(chr);
> @@ -993,6 +994,10 @@ static void ivshmem_exit(PCIDevice *dev)
>          vmstate_unregister_ram(s->ivshmem_bar2, DEVICE(dev));
>      }
>  
> +    if (s->hostmem) {
> +        host_memory_backend_set_mapped(s->hostmem, false);
> +    }
> +
>      if (s->peers) {
>          for (i = 0; i < s->nb_peers; i++) {
>              close_peer_eventfds(s, i);
> @@ -1101,14 +1106,6 @@ static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
>      }
>  
>      ivshmem_common_realize(dev, errp);
> -    host_memory_backend_set_mapped(s->hostmem, true);
> -}
> -
> -static void ivshmem_plain_exit(PCIDevice *pci_dev)
> -{
> -    IVShmemState *s = IVSHMEM_COMMON(pci_dev);
> -
> -    host_memory_backend_set_mapped(s->hostmem, false);
>  }
>  
>  static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
> @@ -1117,7 +1114,6 @@ static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
>      k->realize = ivshmem_plain_realize;
> -    k->exit = ivshmem_plain_exit;
>      dc->props = ivshmem_plain_properties;
>      dc->vmsd = &ivshmem_plain_vmsd;
>  }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks for the fix!

Paolo
