Received: from eggs.gnu.org ([209.51.188.92]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzlFq-0008Vo-Ox
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzlFq-000584-2B
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:43:22 -0500
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47be1186-69de-3216-960a-d3fdcf1127a5@redhat.com>
Date: Fri, 1 Mar 2019 10:43:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190227172256.30368-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/20] qemu-iotests: Test qcow2
 preallocation modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

On 2/27/19 11:22 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/tests/qemu-iotests/243
> @@ -0,0 +1,63 @@


> +
> +    echo -n "File size: "

echo -n is non-portable (bash has shopt -s xpg_echo); better is to just
use printf.  See commit b43671f8

> +    du -b $TEST_IMG | cut -f1
> +
> +    # Can't use precise numbers here because they differ between filesystems
> +    echo -n "Disk usage: "

and again

> +    [ $(du -B1 $TEST_IMG | cut -f1) -lt 1048576 ] && echo "low" || echo "high"

du -b/-B are not portable to POSIX, but you did limit the test to just
Linux where they are fairly likely, so I don't have any better
suggestions.  I like the masking into high/low to work around file
system granularity quirks as well as image metadata size differences.

As using printf instead of echo -n is trivial,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
