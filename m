Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gJgL4-0007bs-To
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gJgL3-0000V3-Mp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:58:50 -0500
MIME-Version: 1.0
References: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
	<1540794581-33578-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540794581-33578-2-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 5 Nov 2018 22:57:52 +0800
Message-ID: <CAKXe6SL40=EYeGajxs8KbLLCBhfRkEFx0HD0L6tL=3dNQ-v9dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: don't unref ctrl_mem when device
 unrealized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Ping...

I think this is a serious issue, can go 3.1

Thanks,
Li Qiang

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:29=E5=86=99=E9=81=93=EF=BC=9A

> Currently, when hotplug/unhotplug nvme device, it will cause an
> assert in object.c. Following is the backtrack:
>
> ERROR:qom/object.c:981:object_unref: assertion failed: (obj->ref > 0)
>
> Thread 2 "qemu-system-x86" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7fffcbd32700 (LWP 18844)]
> 0x00007fffdb9e4fff in raise () from /lib/x86_64-linux-gnu/libc.so.6
> (gdb) bt
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> qom/object.c:981
> /home/liqiang02/qemu-upstream/qemu/memory.c:1732
> /home/liqiang02/qemu-upstream/qemu/memory.c:285
> util/qemu-thread-posix.c:504
> /lib/x86_64-linux-gnu/libpthread.so.0
>
> This is caused by memory_region_unref in nvme_exit.
>
> Remove it to make the PCIdevice refcount correct.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index fc7dacb816..359a06d0ad 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1331,9 +1331,6 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> -    if (n->cmbsz) {
> -        memory_region_unref(&n->ctrl_mem);
> -    }
>
>      msix_uninit_exclusive_bar(pci_dev);
>  }
> --
> 2.11.0
>
>
