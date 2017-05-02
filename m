Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5YeA-0004Wx-Is
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Ye9-0001UV-8K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:19:22 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 15:18:53 +0100
Message-Id: <20170502141858.24805-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/5] Improve convert and dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Update to

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05699.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00728.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04391.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02153.html
  v5: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04109.html

This series is in response to Max pointing out that you cannot
use 'convert' for an encrypted target image.

The 'convert' and 'dd' commands need to first create the image
and then open it. The bdrv_create() method takes a set of options
for creating the image, which let us provide a key-secret for the
encryption key. When the commands then open the new image, they
don't provide any options, so the image is unable to be opened
due to lack of encryption key. It is also not possible to use
the --image-opts argument to provide structured options in the
target image name - it must be a plain filename to satisfy the
bdrv_create() API contract.

This series addresses these problems to some extent

 - Adds a new --target-image-opts flag which is used to say
   that the target filename is using structured options.
   It is *only* permitted to use this when -n is also set.
   ie the target image must be pre-created so convert/dd
   don't need to run bdrv_create().

 - When --target-image-opts is not used, add special case
   code that identifies options passed to bdrv_create()
   named "*key-secret" and adds them to the options used
   to open the new image

In future it is desirable to make --target-image-opts work even when -n is
*not* given. This requires considerable work to create a new bdrv_create()
API impl.

The first patch fixes a bug in the 'dd' command while the second adds support
for the missing '--object' arg to 'dd', allowing it to reference secrets when
opening files.  The last two patches implement the new features described above
for the 'convert' command.

NB, this is now rebased against the block-next branch from

  git://github.com/XanClic/qemu.git

Changed in v6:

 - Fix misc typos (Fam)
 - Resolve messy conflicts wrt max/block-next (Max)

Changed in v5:

 - Fix return value (Max)
 - Misc doc changes (Max)
 - Use error_abort (Max)

Changed in v4:

 - Refactor img_open_new_file in terms of img_open_file (Kevin)

Changed in v3:

 - Drop all patches affecting the 'dd' command except for the clear bug fix
   and the --object support. They can be re-considered once dd is rewritten
   to run ontop of convert.
 - Use consistent return/goto style in dd command (Max)
 - Fix error reporting when using compressed image and skip-create (Max)
 - Unconditionally create QDict when open files (Max)

Changed in v2:

 - Replace dd -n flag with support for conv=nocreat,notrunc
 - Misc typos (Eric, Fam)

Daniel P. Berrange (5):
  qemu-img: add support for --object with 'dd' command
  qemu-img: fix --image-opts usage with dd command
  qemu-img: introduce --target-image-opts for 'convert' command
  qemu-img: copy *key-secret opts when opening newly created files
  Revert "qemu-img: copy *key-secret opts when opening newly created
    files"

 qemu-img-cmds.hx |   4 +--
 qemu-img.c       | 104 ++++++++++++++++++++++++++++++++++++++++---------------
 qemu-img.texi    |  12 +++++--
 3 files changed, 88 insertions(+), 32 deletions(-)

-- 
2.9.3
