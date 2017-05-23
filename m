Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD66Y-0004KH-Sl
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD66Y-0006gl-0p
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD66X-0006g6-RO
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:27:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
Date: Tue, 23 May 2017 11:27:47 +0200
In-Reply-To: <29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Tue, 23 May 2017 12:04:37 +0800")
Message-ID: <87wp97hqi4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Memory allocation functions like world_alloc, desc_ring_alloc etc,
> they are all wrappers around g_malloc, g_new etc. But g_malloc and 
> similar functions doesn't return null. Because they ignore the fact 

don't

> that g_malloc() of 0 bytes returns null. So error checks for these
> allocation failure are superfluous. Now, remove them entirely.
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

There's one more cleanup opportunity:

> diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
> index ac02797..d0df89a 100644
> --- a/hw/net/rocker/rocker_desc.c
> +++ b/hw/net/rocker/rocker_desc.c
> @@ -65,10 +65,6 @@ char *desc_get_buf(DescInfo *info, bool read_only)
>          info->buf_size = size;
>      }
>  
> -    if (!info->buf) {
> -        return NULL;
> -    }
> -
>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size)) {
>          return NULL;
>      }

None of the pci_dma_read() calls outside rocker check the return value.
Just as well, because it always returns 0.  Please clean this up in a
separate followup patch.

[...]
