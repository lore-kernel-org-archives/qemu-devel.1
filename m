Received: from eggs.gnu.org ([2001:4830:134:3::10]:34770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftETY-00047T-Qk
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftETV-0000tv-Ke
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:58:16 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:50474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftETV-0000q7-9I
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:58:13 -0400
Date: Fri, 24 Aug 2018 17:58:04 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20180824155804.azxqj5kvhbswyy5n@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] usage of mremap in pvrdma break FreeBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

Hello,

The usage of mremap in the pvrdma code breaks the build on FreeBSD:

/root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: implicit declaration of
      function 'mremap' is invalid in C99 [-Wimplicit-function-declaration]
    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
                ^
/root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: this function
      declaration is not a prototype [-Wstrict-prototypes]
/root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:46: error: use of undeclared
      identifier 'MREMAP_MAYMOVE'
    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
                                             ^
/root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:48: error: use of undeclared
      identifier 'MREMAP_MAYMOVE'
        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
                                               ^
/root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:65: error: use of undeclared
      identifier 'MREMAP_FIXED'
        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
                                                                ^

FreeBSD has librdma in base so by default QEMU configure script will
enable the build of the rdma bits in QEMU. Sadly this code uses mremap
which is Linux-specific.

AFAICT either the build of pvrdma is limited to Linux in the configure
script, or the calls to mremap are replaced with a portable
equivalent.

Thanks, Roger.
