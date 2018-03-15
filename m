Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewLSd-0001Nc-Rt
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewLSa-00018L-Nt
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:29:55 -0400
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-2-kwolf@redhat.com>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
Date: Wed, 14 Mar 2018 22:19:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180314173213.18563-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] multiboot: Reject kernels exceeding
 the address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, anatol.pomozov@gmail.com, ppandit@redhat.com

Hi Kevin.

My comments are inline...

On 2018-03-14 10:32, Kevin Wolf wrote:
> The code path with a manually set mh_load_addr in the Multiboot header
> checks that load_end_addr <=3D load_addr, but the path where load_end_a=
ddr
> is automatically detected if 0 is given in the header misses the
> corresponding check.
1) The code checks that load_end_addr >=3D load_addr (before letting it
through).

2) load_end_addr is used only when it is read in as non-zero, so no=20
check is needed if zero.=C2=A0 (It gets debug-printed even when zero, but=
 is=20
used only to calculate mb_load_size and only when non-zero.)
> If the kernel binary size is larger than can fit in
> the address space after load_addr, we ended up with a kernel_size that
> is smaller than load_size, which means that we read the file into a too
> small buffer.
>
> Add a check to reject kernel files with such Multiboot headers.
Code itself looks fine.

Modulo above comments:
 =C2=A0=C2=A0=C2=A0 Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/i386/multiboot.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index b9064264d8..1e215bf8d3 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -247,6 +247,10 @@ int load_multiboot(FWCfgState *fw_cfg,
>               }
>               mb_load_size =3D kernel_file_size - mb_kernel_text_offset=
;
>           }
> +        if (mb_load_size > UINT32_MAX - mh_load_addr) {
> +            error_report("kernel does not fit in address space");
> +            exit(1);
> +        }
>           if (mh_bss_end_addr) {
>               if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
>                   error_report("invalid bss_end_addr address");
