Received: from eggs.gnu.org ([2001:4830:134:3::10]:48811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0X6s-0000Bx-Jg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0X6r-0003OH-Qt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:44:46 -0400
References: <4013d078-5496-1b7f-dab3-c70ad75ac061@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0782985e-663d-7692-2586-282469592699@redhat.com>
Date: Mon, 26 Mar 2018 13:44:39 -0500
MIME-Version: 1.0
In-Reply-To: <4013d078-5496-1b7f-dab3-c70ad75ac061@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nbd BLOCK_STATUS with -m32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 03/26/2018 01:39 PM, Max Reitz wrote:
> Hi,
> 
> iotests 209 and 123 fail under 32-bit (or at least with -m32), both with
> gcc and mingw.
> 
> Diff for 209:
> 
> @@ -1,2 +1,2 @@
> -[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true},
> -{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data":
> false}]
> +qemu-img: Protocol error: invalid payload for NBD_REPLY_TYPE_BLOCK_STATUS
> +qemu-img: Could not read file metadata: Invalid argument
> 
> 
> Diff for 123:
> 
> @@ -3,6 +3,10 @@
>   Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=1048576
>   wrote 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qemu-img: Protocol error: invalid payload for NBD_REPLY_TYPE_BLOCK_STATUS
> +qemu-img: error getting block status at offset 0: Invalid argument

Looks to be same root cause; probably an incorrect type promotion or 
truncation somewhere.  I'll step through the code and submit a patch, 
hopefully in time for -rc1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
