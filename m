Received: from eggs.gnu.org ([2001:4830:134:3::10]:50177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkH-00049F-95
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkF-0003j9-Ou
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coRkF-0003in-Ij
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 928FDC054909
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:30:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 10:30:35 +0100
Message-Id: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/7] cirrus: more blitter security fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Another pile of cirrus blitter fixes, including cve fixes for known
issues, so clearly 2.9 material.

Patches 6+7 implement a new approach to blitter memory access sanity
checking.  We pass around offsets not pointers, and at the place where
the actual memory access happens we mask the offset to the valid
range before calculating the pointer.

That should put an end to security holes due to blit_is_unsafe() sanity
checks failing to calculate some special case correctly, or due to
blit_is_unsafe() calls missing, and kill any dragons which might still
be lurking in the code.  In theory this even obsoletes blit_is_unsafe(),
but I don't feel like ripping it out right away ...

please pull,
  Gerd

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-cirrus-20170316-1

for you to fetch changes up to ffaf857778286ca54e3804432a2369a279e73aa7:

  cirrus: stop passing around src pointers in the blitter (2017-03-16 08:58:16 +0100)

----------------------------------------------------------------
cirrus: blitter fixes.

----------------------------------------------------------------
Gerd Hoffmann (6):
      cirrus/vnc: zap bitblit support from console code.
      cirrus: switch to 4 MB video memory by default
      cirrus: add option to disable blitter
      cirrus: fix cirrus_invalidate_region
      cirrus: stop passing around dst pointers in the blitter
      cirrus: stop passing around src pointers in the blitter

hangaohuai (1):
      fix :cirrus_vga fix OOB read case qemu Segmentation fault

 hw/display/cirrus_vga.c      | 106 ++++++++++++++++--------
 hw/display/cirrus_vga_rop.h  | 191 ++++++++++++++++++++++++++-----------------
 hw/display/cirrus_vga_rop2.h | 125 ++++++++++++++--------------
 include/hw/compat.h          |   8 ++
 include/ui/console.h         |   7 --
 ui/console.c                 |  28 -------
 ui/vnc.c                     | 100 ----------------------
 7 files changed, 259 insertions(+), 306 deletions(-)
