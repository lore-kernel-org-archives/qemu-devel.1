Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aVB-0005kC-Gs
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aV8-0004In-D6
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:01:57 -0400
Received: from smtp.citrix.com ([66.165.176.89]:3781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aV8-0004Hj-7A
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:01:54 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Mon, 9 Oct 2017 17:01:34 +0100
Message-ID: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/8] xen: xen-domid-restrict improvements
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

   1/8  xen: link against xentoolcore
   2/8  xen: restrict: use xentoolcore_restrict_all
   3/8  xen: defer call to xen_restrict until just before
   4/8  xen: destroy_hvm_domain: Move reason into a variable
   5/8  xen: move xc_interface compatibility fallback further up
   6/8  xen: destroy_hvm_domain: Try xendevicemodel_shutdown
 * 7/8  os-posix: Provide new -runas <uid>.<gid> facility
 @ 8/8  configure: do_compiler: Dump some extra info under bash

 * = patch changed in v4 of the series
 @ = "RFC" tag removed

Thanks,
Ian.
