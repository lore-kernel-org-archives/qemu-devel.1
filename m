Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGM-0000yF-0s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGI-0003dx-Vq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:50 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:29382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGI-0003df-M4
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:46 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 16:56:11 +0100
Message-ID: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v9 00/16] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <Ian.Jackson@eu.citrix.com>, Alistair Francis <alistair.francis@wdc.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>

From: Ian Jackson <Ian.Jackson@eu.citrix.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524aeda:

  vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)

are available in the git repository at:

  https://xenbits.xen.org/git-http/people/iwj/qemu.git for-upstream.depriv-2

for you to fetch changes up to 8bbe05d77360b73c1834808023016a778ccf55ca:

  configure: do_compiler: Dump some extra info under bash (2018-04-26 16:29:52 +0100)

This series provides necessary support for running qemu as a Xen
device model without power equivalent to root.  In particular, it
makes -xen-domid-restrict effective.

The patches are unchanged since v8, apart from additional reviews, and
rebasing onto master.  All the patches are now reviewed and/or acked
apart from the patch to configure, which has a Tested-by from Thomas
Huth.  I have stripped off the per-patch-series-verson update
comments.

- ----------------------------------------------------------------

Anthony PERARD (1):
      xen: link against xentoolcore

Ian Jackson (13):
      checkpatch: Add xendevicemodel_handle to the list of types
      AccelClass: Introduce accel_setup_post
      xen: restrict: use xentoolcore_restrict_all
      xen: defer call to xen_restrict until just before os_setup_post
      xen: destroy_hvm_domain: Move reason into a variable
      xen: move xc_interface compatibility fallback further up the file
      xen: destroy_hvm_domain: Try xendevicemodel_shutdown
      os-posix: cleanup: Replace fprintfs with error_report in change_process_uid
      os-posix: Provide new -runas <uid>:<gid> facility
      xen: Remove now-obsolete xen_xc_domain_add_to_physmap
      os-posix: cleanup: Replace fprintf with error_report in remaining call sites
      os-posix: cleanup: Replace perror with error_report
      configure: do_compiler: Dump some extra info under bash

Ross Lagerwall (2):
      xen: Use newly added dmops for mapping VGA memory
      xen: Expect xenstore write to fail when restricted

 accel/accel.c               |   9 ++++
 configure                   |  33 +++++++++++-
 hw/i386/xen/xen-hvm.c       |  75 ++++++++++++++------------
 hw/xen/xen-common.c         |  21 +++++++-
 include/hw/xen/xen_common.h | 125 +++++++++++++++++++++-----------------------
 include/sysemu/accel.h      |   3 ++
 os-posix.c                  |  91 +++++++++++++++++++++++++-------
 qemu-options.hx             |   3 +-
 scripts/checkpatch.pl       |   1 +
 vl.c                        |   1 +
 10 files changed, 242 insertions(+), 120 deletions(-)


Anthony PERARD (1):
  xen: link against xentoolcore

Ian Jackson (13):
  checkpatch: Add xendevicemodel_handle to the list of types
  AccelClass: Introduce accel_setup_post
  xen: restrict: use xentoolcore_restrict_all
  xen: defer call to xen_restrict until just before os_setup_post
  xen: destroy_hvm_domain: Move reason into a variable
  xen: move xc_interface compatibility fallback further up the file
  xen: destroy_hvm_domain: Try xendevicemodel_shutdown
  os-posix: cleanup: Replace fprintfs with error_report in
    change_process_uid
  os-posix: Provide new -runas <uid>:<gid> facility
  xen: Remove now-obsolete xen_xc_domain_add_to_physmap
  os-posix: cleanup: Replace fprintf with error_report in remaining call
    sites
  os-posix: cleanup: Replace perror with error_report
  configure: do_compiler: Dump some extra info under bash

Ross Lagerwall (2):
  xen: Use newly added dmops for mapping VGA memory
  xen: Expect xenstore write to fail when restricted

 accel/accel.c               |   9 ++++
 configure                   |  33 +++++++++++-
 hw/i386/xen/xen-hvm.c       |  75 ++++++++++++++------------
 hw/xen/xen-common.c         |  21 +++++++-
 include/hw/xen/xen_common.h | 125 +++++++++++++++++++++-----------------------
 include/sysemu/accel.h      |   3 ++
 os-posix.c                  |  91 +++++++++++++++++++++++++-------
 qemu-options.hx             |   3 +-
 scripts/checkpatch.pl       |   1 +
 vl.c                        |   1 +
 10 files changed, 242 insertions(+), 120 deletions(-)

- -- 
2.1.4

-----BEGIN PGP SIGNATURE-----

iQFUBAEBCAA+FiEEVZrkbC1rbTJl58uh4+M5I0i1DTkFAlrh9pkgHGlqYWNrc29u
QGNoaWFyay5ncmVlbmVuZC5vcmcudWsACgkQ4+M5I0i1DTm6dwgAx4Y2BlEvGZZF
1ZM+ocUu97egBCRb8WOJl1zvfeaxIkLfM+zP2TNFazjWUSKHJJUmzUE6IdaJ3ddX
2XVV0u9LtERI7Si0UVHF/2n3UhpJk4fCBKNyiv5HTPDySLIBdOuONaKLg5XlFUxm
ZJ3s5S/JncgPj4/Q475OOglJyMtfRRDfFHXM5ajAExncMAKjDrX1r+VNfCU1Eg/q
lFzaB6tt8GlVXu7y0ur2B1JsF5lm/Oluo4k4paXEHi2+OJVAvlAAZvkky6laL6DI
8jONOJBhL5rVuAtQCJ7ShdJaTR7z/9Z2MWzjjBzTMY1JhslyUfPS7oPM13m+oHyY
OYzrEfZJOA==
=gdCR
-----END PGP SIGNATURE-----
