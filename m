Received: from eggs.gnu.org ([2001:4830:134:3::10]:47676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=372f2a2d8=anthony.perard@citrix.com>)
	id 1da3OQ-0001Fc-LC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=372f2a2d8=anthony.perard@citrix.com>)
	id 1da3OM-0005rI-Km
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:13:10 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=372f2a2d8=anthony.perard@citrix.com>)
	id 1da3OM-0005qz-FC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:13:06 -0400
Date: Tue, 25 Jul 2017 18:13:02 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170725171302.GK1587@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] QEMU commit 04bf2526ce breaks use of xen-mapcache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xen.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Hi,

Commits 04bf2526ce (exec: use qemu_ram_ptr_length to access guest ram)
start using qemu_ram_ptr_length() instead of qemu_map_ram_ptr().
That result in calling xen_map_cache() with lock=true, but this mapping
is never invalidated.
So QEMU use more and more RAM until it stop working for a reason or an
other. (crash if host have little RAM or stop emulating but no crash)

I don't know if calling xen_invalidate_map_cache_entry() in
address_space_read_continue() and address_space_write_continue() is the
right answer.  Is there something better to do ?

(A good way to reproduce: Install Windows, so without pv driver.)

Thanks,

-- 
Anthony PERARD
