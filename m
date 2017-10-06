Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLe-0002Ng-Lj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLb-0002t0-IN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:46 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLb-0002rk-CP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:43 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 6 Oct 2017 19:27:16 +0100
Message-ID: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/8] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

I have been working on trying to get qemu, when running as a Xen
device model, to _actually_ not have power equivalent to root.

I think I have achieved this, with some limitations (which are
discussed in my series against xen.git.

However, there are changes to qemu needed.  In particular

 * The -xen-domid-restrict option does not work properly right now.
   It only restricts a small subset of the descriptors qemu has open.
   I am introducing a new library call in the Xen libraries for this,
   xentoolcore_restrict_all.

 * We need to call a different function on domain shutdown.

 * The restriction operation needs to be done at a slightly different
   time, necessitating a new hook.

 * Additionally, in the future, we intend to be able to set aside
   a uid range for these qemus to run in, and that involves being
   able to tell qemu to drop privilege by numeric uid and gid.

Thanks to Anthony Perard, Peter Maydell and Ross Lagerwall for
assistance, review and testing.

At least the first patch of this, "xen: link against xentoolcore",
will very likely be necessary, since the corresponding xen.git series
is likely to make Xen 4.10.

Ian.
