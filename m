Received: from eggs.gnu.org ([2001:4830:134:3::10]:41782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1coCgb-0003EF-Is
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1coCga-0001yi-KK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:26:09 -0400
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:34731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1coCga-0001xR-Ac
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:26:08 -0400
Received: by mail-ua0-x22b.google.com with SMTP id f54so13272165uaa.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314153626.16989-3-famz@redhat.com>
References: <20170314153626.16989-1-famz@redhat.com>
	<20170314153626.16989-3-famz@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 15 Mar 2017 10:25:26 -0700
Message-ID: <CAO_EM_=7u2L=HO+ipbyqeTOPAbfEa0+Xa9SpW+OSTMF+dJ3c6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Mar 14, 2017 at 8:36 AM, Fam Zheng <famz@redhat.com> wrote:
> After the AioContext lock push down, there is a race between
> virtio_scsi_dataplane_start and those "assert(s->ctx &&
> s->dataplane_started)", because the latter doesn't isn't wrapped in
> aio_context_acquire.
>
> Reproducer is simply booting a Fedora guest with an empty
> virtio-scsi-dataplane controller:
>
>     qemu-system-x86_64 \
>       -drive if=none,id=root,format=raw,file=Fedora-Cloud-Base-25-1.3.x86_64.raw \
>       -device virtio-scsi \
>       -device scsi-disk,drive=root,bootindex=1 \
>       -object iothread,id=io \
>       -device virtio-scsi-pci,iothread=io \
>       -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 2048 \
>       --enable-kvm
>
> Fix this by moving acquire/release pairs from virtio_scsi_handle_*_vq to
> their callers - and wrap the broken assertions in.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Verified this fixes the assertion failure on 2.9.0-rc0.

Tested-by: Ed Swierk <eswierk@skyportsystems.com>
