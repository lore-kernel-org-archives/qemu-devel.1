Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbTj-0004FO-HC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbTi-0002gb-HY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:17:11 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a183b22-b934-13b9-f5ab-2d0c6bfbad77@redhat.com>
Date: Thu, 28 Jun 2018 13:17:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180628180042.3881-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add 222 to test basic
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
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/28/2018 01:00 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/222     | 149 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/222.out |  60 ++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 210 insertions(+)
>   create mode 100644 tests/qemu-iotests/222
>   create mode 100644 tests/qemu-iotests/222.out
> 

> +iotests.verify_platform(['linux'])
> +
> +patterns = [("0x5d", "0",         "64k"),
> +            ("0xd5", "1M",        "64k"),
> +            ("0xdc", "32M",       "64k"),
> +            ("0xcd", "0x3ff0000", "64k")]  # 64M - 64K
> +
> +overwrite = [("0xab", "0",         "64k"), # Full overwrite
> +             ("0xad", "0x00f8000", "64k"), # Partial-left (1M-32K)
> +             ("0x1d", "0x2008000", "64k"), # Partial-right (32M+32K)
> +             ("0xea", "0x3fe0000", "64k")] # Adjacent-left (64M - 128K)
> +
> +remainder = [("0xd5", "0x108000",  "32K"), # Right-end of partial-left [1]
> +             ("0xdc", "32M",       "32k"), # Left-end of partial-right [2]
> +             ("0xcd", "0x3ff0000", "64k")] # patterns[3]

What if you also add:

zeroes =  [("0x00", "0x108000",  "32K"), # Right-end of partial-left [1]
            ("0x00", "32M",       "32k"), # Left-end of partial-right [2]
            ("0x00", "0x3ff0000", "64k")] # patterns[3]

then...

> +    log('')
> +    log('--- Sanity Check ---')
> +    log('')
> +
> +    for p in patterns:

for p in (patterns + zeroes)

> +        cmd = "read -P%s %s %s" % p
> +        log(cmd)
> +        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
> +
> +    log('')
> +    log('--- Testing COW ---')
> +    log('')
> +
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

for p in (patterns + zeroes)

> +        cmd = "read -P%s %s %s" % p
> +        log(cmd)
> +        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
> +
> +    log('')
> +    log('--- Cleanup ---')
> +    log('')
> +
> +    #log(vm.hmp_qemu_io(srcNode, 'flush'))
> +    log(vm.qmp('block-job-cancel', device=srcNode))
> +    log(vm.qmp('nbd-server-stop'))
> +    log(vm.qmp('blockdev-del', node_name=tgtNode))
> +    vm.shutdown()
> +
> +    log('')
> +    log('--- Confirming writes ---')
> +    log('')
> +
> +    for p in (overwrite + remainder):

so that reads of both the fleeced point in time and of the final image 
cover the same set of byte ranges.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
