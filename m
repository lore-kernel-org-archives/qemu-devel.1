Received: from eggs.gnu.org ([2001:4830:134:3::10]:42556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUTLs-0007Pw-TR
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUTLp-0003ht-Pd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:20:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gUTLp-0003gN-Hw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:20:13 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so18835170wra.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 01:20:13 -0800 (PST)
Date: Wed, 5 Dec 2018 09:20:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181205092010.GB20933@stefanha-x1.localdomain>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
	<9e6954b1c07ad802c6b58be23781188d9914a0fd.1541425595.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <9e6954b1c07ad802c6b58be23781188d9914a0fd.1541425595.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/7] util/mmap-alloc: switch
 qemu_ram_mmap() to 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, yu.c.zhang@linux.intel.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2018 at 04:08:12PM +0800, Zhang Yi wrote:
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fbd0dc8..c28869d 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -203,7 +203,9 @@ void *qemu_memalign(size_t alignment, size_t size)
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>  {
>      size_t align = QEMU_VMALLOC_ALIGN;
> -    void *ptr = qemu_ram_mmap(-1, size, align, shared);
> +    uint32_t flags = 0;
> +    flags |= shared;

O_o .o(???)

shared is bool, what is going on here?  Did you mean:

  uint32_t flags = 0;
  void *ptr;

  if (shared) {
      flags |= MAP_SHARED;
  }

  ptr = qemu_ram_mmap(-1, size, align, flags);

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcB5hKAAoJEJykq7OBq3PI+XIIAKTQ8Fax1FIogsy5PwrA6olw
9wEbZL/zHGnN2t1nOYcXUArErxmAx7yD51YONxLCLbipj06NRBPQU1//JwvKsfnP
qYBUXmU+5sIrucxySgj5bCV9PcKwVzF2NMgcJyUwrvnFnAD52S2w4W5eAAJTIEGt
EoChN+qXRTy1m/zW1DXHyjxYnd9yQtDpNH+jzo74CoSsAQeiFWgg11ePBPtix61k
ugchOTy/ZOb12z0IoTCT8eRMuAPTivZkGPJuD7RxaSElouJ707Gke43qwZAUEyXG
g9EePkizTjvqhrj2+Zfpgl7raQLnzPnsfet1RjLks2u6R/f51wscrLI8Jl3R1xE=
=ppEX
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
