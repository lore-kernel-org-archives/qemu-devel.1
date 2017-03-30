Received: from eggs.gnu.org ([2001:4830:134:3::10]:53781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ctjas-0008FQ-Jk
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ctjao-0000wK-N4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ctjao-0000u8-EA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:35:02 -0400
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
	<1490750257-19907-3-git-send-email-mst@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <89fb2da6-1fa6-1f4f-6eb1-d3d29acf5e48@redhat.com>
Date: Thu, 30 Mar 2017 19:34:49 -0400
MIME-Version: 1.0
In-Reply-To: <1490750257-19907-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/3] pci: Add missing drop of bus master AS
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 03/28/2017 09:18 PM, Michael S. Tsirkin wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> The recent introduction of a bus master container added
> memory_region_add_subregion() into the PCI device registering path but
> missed memory_region_del_subregion() in the unregistering path leaving
> a reference to the root memory region of the new container.
> 
> This adds missing memory_region_del_subregion().
> 
> Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e6b08e1..bd8043c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
>      pci_dev->bus->devices[pci_dev->devfn] = NULL;
>      pci_config_free(pci_dev);
>  
> +    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> +                                &pci_dev->bus_master_enable_region);
>      address_space_destroy(&pci_dev->bus_master_as);
>  }
>  
> 

This causes a regression in iotest 051:

051 7s ... - output mismatch (see 051.out.bad)
--- /home/bos/jhuston/src/qemu/tests/qemu-iotests/051.pc.out	2017-03-27
12:30:59.945613766 -0400
+++ 051.out.bad	2017-03-30 19:32:20.708131152 -0400
@@ -133,7 +133,10 @@

 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
+(qemu) QEMU_PROG: /home/bos/jhuston/src/qemu/memory.c:2078:
memory_region_del_subregion: Assertion `subregion->container == mr' failed.
+./common.config: line 109: 27667 Aborted                 (core dumped)
( if [ -n "${QEMU_NEED_PID}" ]; then
+    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
+fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )

 Testing: -drive if=none,id=disk -device ide-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
Failures: 051
Failed 1 of 1 tests
