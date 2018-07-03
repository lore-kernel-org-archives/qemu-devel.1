Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1faGF7-0006JS-GB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1faGF1-00026M-Q8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:00:57 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:37419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1faGF1-000269-Hr
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:00:51 -0400
Received: from player756.ha.ovh.net (unknown [10.109.105.104])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 31034C839B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 10:00:49 +0200 (CEST)
Date: Tue, 3 Jul 2018 10:00:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180703100044.5d265acb@bahia.lan>
In-Reply-To: <20180702163125.28729-1-pbonzini@redhat.com>
References: <20180702163125.28729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix compilation with VIRTIO but not
 VIRTIO_9P
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon,  2 Jul 2018 18:31:25 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
> FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
> to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
> is set but CONFIG_VIRTIO_9P is not.
> 
> Fix it and use if/else to clarify that the two lines are for opposite
> conditions.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>

Peter,

I see this patch is needed for the latest RISC-V pull req. Will you
apply it to master directly or should it go through my tree and I send
you a pull req ASAP ?

>  fsdev/Makefile.objs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> index fb38017c0b..24bbb3e75c 100644
> --- a/fsdev/Makefile.objs
> +++ b/fsdev/Makefile.objs
> @@ -1,7 +1,10 @@
>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
>  # only pull in the actual 9p backend if we also enabled virtio or xen.
> -common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> -common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN)))) = qemu-fsdev-dummy.o
> +ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN))),y)
> +common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> +else
> +common-obj-y = qemu-fsdev-dummy.o
> +endif
>  common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
>  
>  # Toplevel always builds this; targets without virtio will put it in
