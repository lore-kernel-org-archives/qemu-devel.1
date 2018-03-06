Received: from eggs.gnu.org ([2001:4830:134:3::10]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1etIMX-00013O-UC
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1etIMU-0005YF-Q9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:35:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1etIMU-0005XH-FJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:34:58 -0500
References: <20180227194816.17940-1-ppandit@redhat.com>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <596af722-6990-482d-2fc5-0d03bd7b4711@oracle.com>
Date: Tue, 6 Mar 2018 11:30:54 -0800
MIME-Version: 1.0
In-Reply-To: <20180227194816.17940-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] multiboot: check mh_load_end_addr address
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, CERT CC <cert.cc@orange.co>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Prasad.

The Multiboot Spec will allow for a zero bss end address.=C2=A0 (Please s=
ee=20
section 3.1.3 at https://www.gnu.org/software/grub/manual/multiboot/=C2=A0=
 .=20
) For a zero bss end address, this patch will not do the right thing.

I had proposed some patches to properly handle zero bss end address, but=20
they got delayed.=C2=A0 However, I will be re-sending updated patches out=
=20
later today.=C2=A0 Please stay tuned...

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack

On 02/27/18 11:48, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While loading kernel via multiboot-v1 image, (flags & 0x00010000)
> indicates that multiboot header contains valid addresses to load
> the kernel image. In that, end of the data segment address
> 'mh_load_end_addr' should be less than the bss segment address
> 'mh_bss_end_addr'. Add check to validate that.
>
> Reported-by: CERT CC <cert.cc@orange.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/i386/multiboot.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 46d9c68bf5..d16e32bf4a 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -227,6 +227,10 @@ int load_multiboot(FWCfgState *fw_cfg,
>               fprintf(stderr, "invalid mh_load_addr address\n");
>               exit(1);
>           }
> +        if (mh_load_end_addr > mh_bss_end_addr) {
> +            fprintf(stderr, "invalid mh_load_end_addr address\n");
> +            exit(1);
> +        }
>  =20
>           uint32_t mb_kernel_text_offset =3D i - (mh_header_addr - mh_l=
oad_addr);
>           uint32_t mb_load_size =3D 0;
