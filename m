Received: from eggs.gnu.org ([209.51.188.92]:57194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glcG7-0002BV-Of
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glcG7-0003gb-2V
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:17:11 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glcG6-0003fQ-QU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:17:11 -0500
Date: Mon, 21 Jan 2019 16:16:35 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190121161635.GL1271@perard.uk.xensource.com>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

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

I can't reproduce this build issue.

I've build QEMU 2.9.1 against Xen 4.11, and it build just fine. (I just
needed -DXC_WANT_COMPAT_DEVICEMODEL_API).
But when building againt unstable (to be 4.12), it's configure that
fails. That patch would not work.

Could you tell me a configuration of QEMU and Xen that fails? Their
versions, or theirs commit id.
And can you attach the output of ./configure, as well as the build
failures?


As for https://lists.xenproject.org/archives/html/xen-devel/2018-10/msg01950.html
It appear that the same QEMU 2.9.1 is used, but QEMU isn't supposed to
use the function xc_map_foreign_bulk when built against Xen 4.12. That
function is only supposed to be used when building against Xen 4.6 and
earlier.  QEMU 2.9.1 knows about Xen up to 4.8, it should have used
xenforeignmemory_map directly. So, this is probably an issue with
./configure.

Thanks,

-- 
Anthony PERARD
