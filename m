Received: from eggs.gnu.org ([2001:4830:134:3::10]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <coli@redhat.com>) id 1gRsgw-0003Tm-7R
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <coli@redhat.com>) id 1gRsgt-00018p-2i
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:47:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <coli@redhat.com>) id 1gRsgs-00018L-TD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:47:15 -0500
Date: Wed, 28 Nov 2018 00:47:12 -0500 (EST)
From: Cong Li <coli@redhat.com>
Message-ID: <2053358166.79400709.1543384032966.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181127084143.1113-1-armbru@redhat.com>
References: <20181127084143.1113-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] vfio-helpers: Fix
 qemu_vfio_open_pci() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com, pbonzini@redhat.com


----- Original Message -----
> From: "Markus Armbruster" <armbru@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: coli@redhat.com, fam@euphon.net, stefanha@redhat.com, pbonzini@redhat.com
> Sent: Tuesday, November 27, 2018 4:41:43 PM
> Subject: [PATCH for-3.1] vfio-helpers: Fix qemu_vfio_open_pci() crash
> 
> qemu_vfio_open_common() initializes s->lock only after passing s to
> qemu_vfio_dma_map() via qemu_vfio_init_ramblock().
> qemu_vfio_dma_map() tries to lock the uninitialized lock and crashes.
> 
> Fix by initializing s->lock first.
> 
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1645840
> Fixes: 418026ca43bc2626db092d7558258f9594366f28
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> Compile-tested only, as I lack suitable hardware.  Cong Li (cc'ed) is
> going to test it for real.  It looks obvious enough to me to put it
> into -rc3 without waiting for the test results.  We can also wait and
> put it into -rc4.

Smoke test of nvme:// pass with this patch.

Ack.

> 
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 1d9272efa4..cccc9cd42e 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -411,13 +411,13 @@ static int qemu_vfio_init_ramblock(const char
> *block_name, void *host_addr,
>  
>  static void qemu_vfio_open_common(QEMUVFIOState *s)
>  {
> +    qemu_mutex_init(&s->lock);
>      s->ram_notifier.ram_block_added = qemu_vfio_ram_block_added;
>      s->ram_notifier.ram_block_removed = qemu_vfio_ram_block_removed;
>      ram_block_notifier_add(&s->ram_notifier);
>      s->low_water_mark = QEMU_VFIO_IOVA_MIN;
>      s->high_water_mark = QEMU_VFIO_IOVA_MAX;
>      qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
> -    qemu_mutex_init(&s->lock);
>  }
>  
>  /**
> --
> 2.17.2
> 
> 
