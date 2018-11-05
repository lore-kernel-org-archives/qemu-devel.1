Received: from eggs.gnu.org ([2001:4830:134:3::10]:50564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gJU8I-0005l9-Vl
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gJU8H-0004wD-LS
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:56:50 -0500
MIME-Version: 1.0
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<20181102154019.GB26292@localhost.localdomain>
In-Reply-To: <20181102154019.GB26292@localhost.localdomain>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 5 Nov 2018 09:56:02 +0800
Message-ID: <CAKXe6SJj+XotK=4e3ugs5UQH3xDWs-FgU0FTnrp8qWciw0azbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: kwolf@redhat.com, mreitz@redhat.com, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Keith Busch <keith.busch@intel.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:42=E5=86=99=E9=81=93=EF=BC=9A

> On Thu, Nov 01, 2018 at 06:22:43PM -0700, Li Qiang wrote:
> > Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> > This can lead an oob access issue. This is triggerable in the guest.
> > Add check to avoid this issue.
> >
> > Fixes CVE-2018-16847.
> >
> > Reported-by: Li Qiang <liq3ea@gmail.com>
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
>
> Hey, so why is this memory region access even considered valid if the
> request is out of range from what NVMe had registered for its
> MemoryRegion? Wouldn't it be better to not call the mr->ops->read/write
> if it's out of bounds? Otherwise every MemoryRegion needs to duplicate
> the same check, right?
>
>
Yes, This seems a good idea. Once I also encounter one issue like this.
The read callback in MR will be called even it is NULL so cause a
NULL-deref.
discussed here:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01391.html

This touchs the core design of memory subsystem I think, May Paolo or Peter
can answer this.



> Would something like the following work (minimally tested)?
>
> ---
> diff --git a/memory.c b/memory.c
> index 9b73892768..883fd818e6 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1369,6 +1369,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
>          access_size_max =3D 4;
>      }
>
> +    if (addr + size > mr->size)
> +        return false;
> +
>      access_size =3D MAX(MIN(size, access_size_max), access_size_min);
>      for (i =3D 0; i < size; i +=3D access_size) {
>          if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
> --
>
