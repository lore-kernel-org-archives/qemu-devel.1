Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbR-00084B-8I
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-000138-Nr
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:25 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-0000xk-IH
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:23 -0500
Received: from build64-par (unknown
	[IPv6:2601:803:202:9275:da50:e6ff:fe00:4a5b])
	by mav.lukeshu.com (Postfix) with ESMTPSA id 89E2A804D0
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 13:08:14 -0500 (EST)
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:03 -0500
Message-Id: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 00/10] linux-user: Speed up guest space
 initialization on 32-bit ARM target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luke Shumaker <lukeshu@parabola.nu>

The goal of this patchset is to fix
https://bugs.launchpad.net/qemu/+bug/1740219

The gist is that the current linear search for an acceptable address
range is a bad strategy when the reason we didn't get a good address
on the first try is that we've having problems mapping the commpage
for the 32-bit ARM target; especially if ASLR is disabled.

I think that only the final patch in this patchset is actually
necessary to fix the issue; but I didn't feel comfortable writing it
without also makeing the preceding (small) changes.

Luke Shumaker (10):
  linux-user: Use #if to only call validate_guest_space for 32-bit ARM
    target
  linux-user: Rename validate_guest_space => init_guest_commpage
  linux-user: init_guest_space: Clean up if we can't initialize the
    commpage
  linux-user: init_guest_space: Correctly handle guest_start in commpage
    initialization
  linux-user: init_guest_space: Clarify page alignment logic
  linux-user: init_guest_commpage: Add a comment about size check
  linux-user: init_guest_space: Clean up control flow a bit
  linux-user: init_guest_space: Don't try to align if we'll reject it
  linux-user: init_guest_space: Add a comment about search strategy
  linux-user: init_guest_space: Try to make ARM space+commpage
    continuous

 linux-user/elfload.c | 145 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 114 insertions(+), 31 deletions(-)

-- 
2.15.1

Happy hacking,
~ Luke Shumaker
