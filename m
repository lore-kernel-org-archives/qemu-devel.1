Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkJu-0005qS-19
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkJs-0004WB-I3
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:03:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSkJs-0004UL-4K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:03:04 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-4-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6049f2d-36b3-04b7-18ea-e0eebae5777c@redhat.com>
Date: Fri, 30 Nov 2018 09:02:37 -0600
MIME-Version: 1.0
In-Reply-To: <20181129031230.31082-4-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 11/28/18 9:12 PM, Jason Wang wrote:
> This allows flexibility to be reused for all kinds of command line
> used by other tests.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   tests/virtio-net-test.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 231e7c767e..33d26ab079 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -51,17 +51,20 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
>       return dev;
>   }
>   
> -static QOSState *pci_test_start(int socket)
> +static QOSState *pci_test_start(const char *cmd, ...)

This should probably be tagged with GCC_FMT_ATTR(1, 2).


> @@ -218,11 +221,13 @@ static void pci_basic(gconstpointer data)
>                     QVirtQueue *tvq,
>                     int socket) = data;
>       int sv[2], ret;
> +    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
> +                      "virtio-net-pci,netdev=hs0";
>   
>       ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
>       g_assert_cmpint(ret, !=, -1);
>   
> -    qs = pci_test_start(sv[1]);
> +    qs = pci_test_start(cmd, sv[1]);

Do you really need an intermediate 'cmd' variable, or can you just 
inline the string constant command at the point of the call? 
-Wformat=non-literal may warn if you don't inline.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
