Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gKlWZ-00045c-71
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gKlWY-0003on-E5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:43:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gKlWY-0003jy-1b
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:43:10 -0500
References: <20181108143306.20187-1-liq3ea@163.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <39d3e8a4-4166-996a-8f62-89dc0dcebe6c@redhat.com>
Date: Thu, 8 Nov 2018 15:43:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181108143306.20187-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: set_netdev: make peers an empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, stefanha@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 08/11/2018 15:33, Li Qiang wrote:
> Though there is no inconsistency between 'queues'
> and 'peers[i]' currently, this makes the 'peers[i] == NULL'
> meaningful.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/core/qdev-properties-system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 8b22fb51c9..74004a2f33 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -257,7 +257,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>      Property *prop = opaque;
>      NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
>      NetClientState **ncs = peers_ptr->ncs;
> -    NetClientState *peers[MAX_QUEUE_NUM];
> +    NetClientState *peers[MAX_QUEUE_NUM] = {NULL};
>      Error *local_err = NULL;
>      int queues, err = 0, i = 0;
>      char *str;
> 

peers[] is initialized by qemu_find_net_clients_excep() until "queues"
entries. So between 0 and "queues" peers[] cannot be NULL.

IMHO, you should remove the "if (peers[i] == NULL)" block instead.

Thanks,
Laurent
