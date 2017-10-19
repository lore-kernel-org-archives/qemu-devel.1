Received: from eggs.gnu.org ([2001:4830:134:3::10]:38791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3F-0006Px-2f
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3B-0006Ga-49
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:09 -0400
Received: from smtp.citrix.com ([66.165.176.89]:55845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3A-0006GC-Ti
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:05 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Oct 2017 17:51:48 +0100
Message-ID: <1508431916-9412-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/8] xen: xen-domid-restrict improvements
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

 * Additionally, we want to be able to set aside a uid range for these
   qemus to run in, and that involves being able to tell qemu to drop
   privilege by numeric uid and gid.

Thanks to Anthony Perard, Ross Lagerwall, Peter Maydell, Markus
Armbruster and Daniel P. Berrange for assistance, review and testing.

  m 1/8  xen: link against xentoolcore
 r  2/8  xen: restrict: use xentoolcore_restrict_all
 rm 3/8  xen: defer call to xen_restrict until just before
 r  4/8  xen: destroy_hvm_domain: Move reason into a variable
 a  5/8  xen: move xc_interface compatibility fallback further up
 r  6/8  xen: destroy_hvm_domain: Try xendevicemodel_shutdown
  * 7/8  os-posix: Provide new -runas <uid>.<gid> facility
    8/8  configure: do_compiler: Dump some extra info under bash

 m = commit message (only) changed in v5 of the series
 * = patch changed in v5 of the series
 r = reviewed
 a = acked

Thanks,
Ian.
