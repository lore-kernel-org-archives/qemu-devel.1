Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXzaD-00022U-DZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXzaC-0003p7-FL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:49:21 -0400
References: <20180626222226.27620-1-jsnow@redhat.com>
	<20180626222226.27620-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <841140e6-0ea5-6ca0-f9e4-1f9224b313f5@redhat.com>
Date: Tue, 26 Jun 2018 20:49:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180626222226.27620-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 06/26/2018 05:22 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/222   | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group |   1 +
>   2 files changed, 122 insertions(+)
>   create mode 100644 tests/qemu-iotests/222
> 
> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
> new file mode 100644
> index 0000000000..133d10c351
> --- /dev/null
> +++ b/tests/qemu-iotests/222
> @@ -0,0 +1,121 @@
> +#!/usr/bin/env python
> +#
> +# This test covers the basic fleecing workflow.
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +# John helped, too.

LOL.

> +
> +patterns = [("0x5d", "0", "64k"),
> +            ("0xd5", "1M", "64k"),
> +            ("0xdc", "32M", "64k"),
> +            ("0xcd", "67043328", "64k")]  # 64M - 64K
> +
> +overwrite = [("0xab", "0",        "64k"), # Full overwrite
> +             ("0xad", "1015808",  "64k"), # Partial-left (1M-32K)
> +             ("0x1d", "33587200", "64k"), # Partial-right (32M+32K)
> +             ("0xea", "64M", "64k")]      # Adjacent-right (64M)
> +
> +with iotests.FilePath('base.img') as base_img_path, \
> +     iotests.FilePath('fleece.img') as fleece_img_path, \
> +     iotests.FilePath('nbd.sock') as nbd_sock_path, \
> +     iotests.VM() as vm:

Does python require \ even after ','?

The test looks valid - you are definitely reading data over NBD from the 
point in time that you started the blockdev-backup job, even while the 
source image continues to be modified.

> +    for p in overwrite:
> +        cmd = "write -P%s %s %s" % p
> +        log(cmd)
> +        log(vm.hmp_qemu_io(srcNode, cmd))
> +
> +    log('')
> +    log('--- Verifying Data ---')
> +    log('')
> +
> +    for p in patterns:
> +        cmd = "read -P%s %s %s" % p
> +        log(cmd)
> +        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0

Perhaps additional steps would be to then stop the NBD export, stop the 
block job, delete the tgtNode fleecing file, then stop qemu, and finally 
check that the overwritten patterns correctly show up in the source 
image (that is, also prove that we can tear down a job, and that the 
overwrites worked).  And we may want to enhance this test (or use it as 
a starting point to copy into a new test) to play with persistent dirty 
bitmaps thrown into the mix as well.  But what you have is already a 
great start to prevent regressions, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
