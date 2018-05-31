Received: from eggs.gnu.org ([2001:4830:134:3::10]:46169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOMyi-0007f4-9j
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOMyf-0003rp-4U
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:46:52 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOMye-0003qw-Q5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:46:49 -0400
Received: by mail-wr0-x244.google.com with SMTP id d2-v6so17428171wrm.10
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 05:46:48 -0700 (PDT)
Date: Thu, 31 May 2018 13:46:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531124645.GI27838@stefanha-x1.localdomain>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-2-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Content-Disposition: inline
In-Reply-To: <1525918138-6189-2-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 1/9 V5] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2018 at 10:08:50AM +0800, junyan.he@gmx.com wrote:
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 31eae0a..0460313 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -507,6 +507,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                         void *host),
>                                         Error **errp);
>  #ifdef __linux__
> +
> +#define QEMU_RAM_SHARE      (1UL << 0)

Please expose RAMBlock flags instead of redefining this flag and call
the argument ram_flags.  Ultimately MemoryRegion doesn't store this or
care about it.  The value simply gets passed to the RAMBlock code.

> +
> +/**
> + * qemu_ram_alloc_from_file,
> + * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back
> + *                          file or device
> + *
> + * Parameters:
> + *  @size: the size in bytes of the ram block
> + *  @mr: the memory region where the ram block is
> + *  @flags: specify the properties of the ram block, which can be one
> + *          or bit-or of following values
> + *          - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED

s/back//

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD+61AAoJEJykq7OBq3PIK+MH/32yocxwRda9yz8cZGK2t9G3
mqwpQGUwyU9gKyJnEqk/I6U7vXSn8pw6VspGgauhZZY09D/jPegGraJ0MXkRWQTE
7dTz1zA6cg5Ssl9+67kcVrCtQ4v7tTP8RVFUOMfon8s9MRf9m8DX6+t4yS1Wrl5t
rqOppHs2k7+f6mNFiBYZWqDKrf58H+JVllkMoQ7o4KhMsrbhNi7ccdWDAhAd+9d5
4fWWxPBZVTJA+L4dT5TRYj0h8bKX4BpozvQ7DRw2k87UA7v28LxIAuzrdejiUcWk
dtQZ6Hlvvadk2AkXrSZtJ85ZcSuPj2OOMk5gKsHcOu7KR1mfw827eqTW5LRuR88=
=x1gA
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
