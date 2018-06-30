Received: from eggs.gnu.org ([2001:4830:134:3::10]:58822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZFSg-0000Cn-TY
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZFSg-0002rf-5T
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:58:47 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZFSP-0002VJ-Pc
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:58:46 -0400
Received: by mail-ot0-x244.google.com with SMTP id l15-v6so12772384oth.6
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 05:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601171521.1770-4-pbonzini@redhat.com>
References: <20180601171521.1770-1-pbonzini@redhat.com>
	<20180601171521.1770-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 13:58:08 +0100
Message-ID: <CAFEAcA_hJAWZVfC8bm1cNec5YLK1VJfVF6TfP+94jsWoGMEehQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 56/56] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 June 2018 at 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This is only half of the work, because the proxy devices (virtio-*-pci,
> virtio-*-ccw, etc.) are still included unconditionally.  It is still a
> move in the right direction.
>
> Based-on: <20180522194943.24871-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi. It looks like this commit breaks building with
CONFIG_VIRTIO set but CONFIG_VIRTIO_9P not set (as
we found out with the latest riscv pullreq):

> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index fd90b62900..e3fa673665 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -1,3 +1,4 @@
> +ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
>  common-obj-y  = 9p.o 9p-util.o
>  common-obj-y += 9p-local.o 9p-xattr.o
>  common-obj-y += 9p-xattr-user.o 9p-posix-acl.o

This if condition guards the definitions of various
FileOperations structs local_ops, etc, but it doesn't
match up with the if guard on the code that uses them,
which is in fsdev/Makefile.obj:

common-obj-$(call land,$(CONFIG_VIRTFS),$(call
lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) = qemu-fsdev.o 9p-marshal.o
9p-iov-marshal.o

so if you set VIRTIO but not VIRTIO_9P we build the
use but not the definition and linking fails.

thanks
-- PMM
