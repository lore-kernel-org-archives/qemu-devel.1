Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVwPB-0003eV-8n
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVwP1-0007vh-MI
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVwP1-0007uN-Ah
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:01:19 -0400
References: <20180608200740.24915-1-danielhb413@gmail.com>
	<20180608200740.24915-2-danielhb413@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e772fa42-6380-8f5f-6273-8edc31a9b222@redhat.com>
Date: Thu, 21 Jun 2018 12:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180608200740.24915-2-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/3] scsi-block: emulate missing Block
 Limits response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 08/06/2018 22:07, Daniel Henrique Barboza wrote:
> +    unsigned int unmap_sectors =3D s->conf.discard_granularity / s->bl=
ocksize;
> +    unsigned int min_io_size =3D s->conf.min_io_size / s->blocksize;
> +    unsigned int opt_io_size =3D s->conf.opt_io_size / s->blocksize;
> +    unsigned int max_unmap_sectors =3D DEFAULT_MAX_UNMAP_SIZE / s->blo=
cksize;
> +    unsigned int max_io_sectors =3D  DEFAULT_MAX_IO_SIZE / s->blocksiz=
e;
> +
> +    int max_transfer_blk =3D blk_get_max_transfer(s->conf.blk);
> +    int max_io_sectors_blk =3D max_transfer_blk / s->blocksize;
> +
> +    max_io_sectors =3D  MIN_NON_ZERO(max_io_sectors_blk, max_io_sector=
s);
> +
> +    /* min_io_size and opt_io_size can't be greater than max_io_sector=
s */
> +    if (min_io_size) {
> +        min_io_size =3D MIN(min_io_size, max_io_sectors);
> +    }
> +    if (opt_io_size) {
> +        opt_io_size =3D MIN(opt_io_size, max_io_sectors);
> +    }
> +
> +    /* required VPD size with unmap support */
> +    buflen =3D 0x40;
> +    memset(outbuf + 4, 0, buflen - 4);
> +
> +    outbuf[4] =3D 0x1; /* wsnz */
> +
> +    /* optimal transfer length granularity */
> +    outbuf[6] =3D (min_io_size >> 8) & 0xff;
> +    outbuf[7] =3D min_io_size & 0xff;
> +
> +    /* maximum transfer length */
> +    outbuf[8] =3D (max_io_sectors >> 24) & 0xff;
> +    outbuf[9] =3D (max_io_sectors >> 16) & 0xff;
> +    outbuf[10] =3D (max_io_sectors >> 8) & 0xff;
> +    outbuf[11] =3D max_io_sectors & 0xff;
> +
> +    /* optimal transfer length */
> +    outbuf[12] =3D (opt_io_size >> 24) & 0xff;
> +    outbuf[13] =3D (opt_io_size >> 16) & 0xff;
> +    outbuf[14] =3D (opt_io_size >> 8) & 0xff;
> +    outbuf[15] =3D opt_io_size & 0xff;
> +
> +    /* max unmap LBA count, default is 1GB */
> +    outbuf[20] =3D (max_unmap_sectors >> 24) & 0xff;
> +    outbuf[21] =3D (max_unmap_sectors >> 16) & 0xff;
> +    outbuf[22] =3D (max_unmap_sectors >> 8) & 0xff;
> +    outbuf[23] =3D max_unmap_sectors & 0xff;
> +
> +    /* max unmap descriptors, 255 fit in 4 kb with an 8-byte header.  =
*/
> +    outbuf[24] =3D 0;
> +    outbuf[25] =3D 0;
> +    outbuf[26] =3D 0;
> +    outbuf[27] =3D 255;
> +
> +    /* optimal unmap granularity */
> +    outbuf[28] =3D (unmap_sectors >> 24) & 0xff;
> +    outbuf[29] =3D (unmap_sectors >> 16) & 0xff;
> +    outbuf[30] =3D (unmap_sectors >> 8) & 0xff;
> +    outbuf[31] =3D unmap_sectors & 0xff;
> +
> +    /* max write same size */
> +    outbuf[36] =3D 0;
> +    outbuf[37] =3D 0;
> +    outbuf[38] =3D 0;
> +    outbuf[39] =3D 0;
> +
> +    outbuf[40] =3D (max_io_sectors >> 24) & 0xff;
> +    outbuf[41] =3D (max_io_sectors >> 16) & 0xff;
> +    outbuf[42] =3D (max_io_sectors >> 8) & 0xff;
> +    outbuf[43] =3D max_io_sectors & 0xff;
> +
> +    /* done with EVPD */
> +    assert(buflen - start <=3D 255);
> +    outbuf[start - 1] =3D buflen - start;
> +
> +    return buflen;
> +}
> +

Please share this code with the existing block limits stuff in scsi-disk.=
c.

Also please move the inquiry handling to a separate function, since
you're adding more stuff to it in patch 2.

In fact, I would structure the series like this: patch 1 is just
refactoring, everything else can be done in a single patch.

Paolo
