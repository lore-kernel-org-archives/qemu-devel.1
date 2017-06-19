Received: from eggs.gnu.org ([2001:4830:134:3::10]:42469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMxiS-0007q2-4r
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMxiR-0005sK-4v
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:44 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dMxiQ-0005rA-Tr
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:43 -0400
Received: by mail-wm0-x241.google.com with SMTP id f90so16723658wmh.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 07:31:42 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Mon, 19 Jun 2017 16:28:47 +0200
Message-Id: <20170619142848.14258-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH v4 0/1] 9pfs: local: Add support for custom
 fmode/dmode in 9ps mapped security modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, el13635@mail.ntua.gr, Tobias Schramm <tobleminer@gmail.com>

Hi,

i've noticed that there is no way to control the permissions of newly created files and
folders on the host when using 9p in mapped security mode. This can be a big problem when
configuring permissions for access to such data for groups and via ACLs on the host.
Thus I added the options fmode and dmode to the fsdev and virtfs options that set the actual
permissions of newly created files and folders on the host.

This version of the patch fixes the back to front "mask" naming in the previous patches. I
always meant "mode" when actually writing "mask".

Also specifying fmode and dmode only has an effect in mapped security modes. Specifying it
in any other mode now throws an error.

Additionally I've switched fmode and dmode to QEMU_OPT_NUMBER because it handels octal input
just fine.

Also previous versions leaked a string with g_strdup if an error during parsing of fmode/dmode
occurred.

Thanks to Greg Kurz for pointing out most of the above issues to me.

Tobias Schramm

Tobias Schramm (1):
  Add support for custom fmode/dmode in 9ps mapped security modes

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 34 +++++++++++++++++++++++++---------
 hw/9pfs/9p.c            |  3 +++
 qemu-options.hx         | 20 ++++++++++++++++----
 5 files changed, 60 insertions(+), 13 deletions(-)

-- 
2.13.1
