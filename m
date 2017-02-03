Received: from eggs.gnu.org ([2001:4830:134:3::10]:48365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbT-000382-EB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbR-0001nZ-IQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:35 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Feb 2017 12:02:48 +0000
Message-Id: <20170203120254.15062-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] qemu-img: improve convert & dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Update to

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05699.html

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

In future it is desirable to make --target-image-opts work
even when -n is *not* given. This requires considerable
work to create a new bdrv_create() API impl.

The first four patches improve the 'dd' command to address
feature gaps wrt the 'convert' command. The last two patches
implement the improvements described above.

Changed in v2:

 - Replace dd -n flag with support for conv=nocreat,notrunc
 - Misc typos (Eric, Fam)

Daniel P. Berrange (6):
  qemu-img: add support for --object with 'dd' command
  qemu-img: fix --image-opts usage with dd command
  qemu-img: add support for conv=nocreat,notrunc args to dd command
  qemu-img: add support for -o arg to dd command
  qemu-img: introduce --target-image-opts for 'convert' command
  qemu-img: copy *key-secret opts when opening newly created files

 qemu-img-cmds.hx |   8 +-
 qemu-img.c       | 342 ++++++++++++++++++++++++++++++++++++++++++++-----------
 qemu-img.texi    |  26 ++++-
 3 files changed, 299 insertions(+), 77 deletions(-)

-- 
2.9.3
