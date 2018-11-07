Received: from eggs.gnu.org ([2001:4830:134:3::10]:59988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKQv7-0001Gd-6l
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKQv5-0005eV-Qn
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:43:09 -0500
References: <20181107121319.GC14842@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d797ae29-97ba-9c18-68ec-a2943bdf7728@redhat.com>
Date: Wed, 7 Nov 2018 10:42:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181107121319.GC14842@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Change in qemu 2.12 causes qemu-img convert to NBD
 to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: nsoffer@redhat.com

On 11/7/18 6:13 AM, Richard W.M. Jones wrote:
> (I'm not going to claim this is a bug, but it causes a large, easily
> measurable performance regression in virt-v2v).

I haven't closely looked at at this email thread yet, but a quick first 
impression:


> In qemu 2.12 this behaviour changed:
> 
>    $ nbdkit --filter=log memory size=6G logfile=/tmp/log \
>        --run './qemu-img convert ./fedora-28.img -n $nbd'
>    $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
>        193 Zero
>       1246 Write
> 
> It now zeroes the whole disk up front and then writes data over the
> top of the zeroed blocks.
> 
> The reason for the performance regression is that in the first case we
> write 6G in total.  In the second case we write 6G of zeroes up front,
> followed by the amount of data in the disk image (in this case the
> test disk image contains 1G of non-sparse data, so we write about 7G
> in total).

There was talk on the NBD list a while ago about the idea of letting the 
server advertise to the client when the image is known to start in an 
all-zero state, so that the client doesn't have to waste time writing 
zeroes (or relying on repeated NBD_CMD_BLOCK_STATUS calls to learn the 
same).  This may be justification for reviving that topic.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
