Received: from eggs.gnu.org ([2001:4830:134:3::10]:38904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFcg-0000C3-PZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFcb-0001R9-P3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSFcb-0001KH-6W
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:16:21 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-4-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd21ea2f-0e8b-5b1b-929d-8bd1f96eed4c@redhat.com>
Date: Thu, 29 Nov 2018 07:16:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181129031230.31082-4-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 3/4] virtio-net-test: accept
 variable length argument in pci_test_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 2018-11-29 04:12, Jason Wang wrote:
> This allows flexibility to be reused for all kinds of command line
> used by other tests.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/virtio-net-test.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 231e7c767e..33d26ab079 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -51,17 +51,20 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
>      return dev;
>  }
>  
> -static QOSState *pci_test_start(int socket)
> +static QOSState *pci_test_start(const char *cmd, ...)
>  {
>      QOSState *qs;
> +    va_list ap;
>      const char *arch = qtest_get_arch();
> -    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
> -                      "virtio-net-pci,netdev=hs0";
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        qs = qtest_pc_boot(cmd, socket);
> +        va_start(ap, cmd);
> +        qs = qtest_pc_vboot(cmd, ap);
> +        va_end(ap);
>      } else if (strcmp(arch, "ppc64") == 0) {
> -        qs = qtest_spapr_boot(cmd, socket);
> +        va_start(ap, cmd);
> +        qs = qtest_spapr_vboot(cmd, ap);
> +        va_end(ap);
>      } else {
>          g_printerr("virtio-net tests are only available on x86 or ppc64\n");
>          exit(EXIT_FAILURE);
> @@ -218,11 +221,13 @@ static void pci_basic(gconstpointer data)
>                    QVirtQueue *tvq,
>                    int socket) = data;
>      int sv[2], ret;
> +    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
> +                      "virtio-net-pci,netdev=hs0";
>  
>      ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
>      g_assert_cmpint(ret, !=, -1);
>  
> -    qs = pci_test_start(sv[1]);
> +    qs = pci_test_start(cmd, sv[1]);
>      dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
>  
>      rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
