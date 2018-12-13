Received: from eggs.gnu.org ([2001:4830:134:3::10]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXOoN-0001eV-3G
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXOoI-0006K3-AL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:05:46 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:5212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXOoH-0006HA-GE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:05:41 -0500
Date: Thu, 13 Dec 2018 11:05:25 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181213110525.GY18875@perard.uk.xensource.com>
References: <20181026101016.28584-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181026101016.28584-1-olaf@aepfle.de>
Subject: Re: [Qemu-devel] [PATCH v1] xen: preserve COMPAT in CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, Ian Jackson <ian.jackson@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

Hi,

Ian, we have those XC_WANT_COMPAT_* #defines to allow consumers of Xen
libs be able to use old interfaces. Do you think it's a good idea to
have this consumers (QEMU here) #undef the flag when it has implemented
the newer interface?

I guess the issue we have here is that when libxc interface are
re-implemented into a xen libs, the meaning of XC_WANT_COMPAT_* flags is
changed. And the QEMU fails to build even with the flags supplied in
cflags.

There is another thread that Olaf have started here:
<20181025140808.13eefc21.olaf@aepfle.de>
https://lists.xenproject.org/archives/html/xen-devel/2018-10/msg01950.html

On Fri, Oct 26, 2018 at 12:10:16PM +0200, Olaf Hering wrote:
> A given Qemu version can not predict what version of Xen it will run on.
> There are some checks in configure to decide what Xen libraries and
> functions are available. How exactly these functions must be accessed
> has to be decided by configure and the user who is compiling Qemu.
> In no way some random header file must override this decision.
> 
> Remove the breakage introduced by commit 5eeb39c24b, which would always
> hide the libxc interfaces the given version of Qemu knows about.
> 
> The current symptom of such breakage is a build failure with qemu-2.9
> and older, in combination with Xen 4.12.
> 
> Fixes: 5eeb39c24b7d4da5d129bfdd9c4fd21cfb3d28d6
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  include/hw/xen/xen_common.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 5f1402b494..33fa2d3497 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -1,15 +1,6 @@
>  #ifndef QEMU_HW_XEN_COMMON_H
>  #define QEMU_HW_XEN_COMMON_H
>  
> -/*
> - * If we have new enough libxenctrl then we do not want/need these compat
> - * interfaces, despite what the user supplied cflags might say. They
> - * must be undefined before including xenctrl.h
> - */
> -#undef XC_WANT_COMPAT_EVTCHN_API
> -#undef XC_WANT_COMPAT_GNTTAB_API
> -#undef XC_WANT_COMPAT_MAP_FOREIGN_API
> -
>  #include <xenctrl.h>
>  #include <xenstore.h>
>  #include <xen/io/xenbus.h>

-- 
Anthony PERARD
