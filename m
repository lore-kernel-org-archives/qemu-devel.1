Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMNmy-0007JX-8w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 20:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMNmx-00056y-IM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 20:46:48 -0500
MIME-Version: 1.0
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Nov 2018 09:45:40 +0800
Message-ID: <CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
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
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Ping.... what't the status of this patch.

I see Kevin's new pr doesn't contain this patch.

Thanks,
Li Qiang

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=882=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A

> Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> This can lead an oob access issue. This is triggerable in the guest.
> Add check to avoid this issue.
>
> Fixes CVE-2018-16847.
>
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index fc7dacb..d097add 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwaddr
> addr, uint64_t data,
>      unsigned size)
>  {
>      NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> +
> +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
> +        return;
> +    }
>      memcpy(&n->cmbuf[addr], &data, size);
>  }
>
> @@ -1183,6 +1187,9 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr
> addr, unsigned size)
>      uint64_t val;
>      NvmeCtrl *n =3D (NvmeCtrl *)opaque;
>
> +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
> +        return 0;
> +    }
>      memcpy(&val, &n->cmbuf[addr], size);
>      return val;
>  }
> --
> 1.8.3.1
>
>
