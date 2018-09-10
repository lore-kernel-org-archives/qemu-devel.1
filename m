Received: from eggs.gnu.org ([2001:4830:134:3::10]:36894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzSIO-0003oV-BD
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 15:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzRxw-0006KV-Rt
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 15:35:21 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<f58d46ef-744b-e886-4b5b-a3dd2e2a57d8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42d6dbed-5b91-39d9-24a0-105f63ff741e@redhat.com>
Date: Mon, 10 Sep 2018 14:35:11 -0500
MIME-Version: 1.0
In-Reply-To: <f58d46ef-744b-e886-4b5b-a3dd2e2a57d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/4 for-3.0?] NBD fixes for
 unaligned images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 9/10/18 2:25 PM, John Snow wrote:
> Hi, has this series been superseded or do we need a respin for 3.1?

Needs a respin.

There are two issues still to be solved:

1. Asking the top-most block layer for its alignment isn't necessarily 
right for qemu as server.  If we have:

backing (512) <- active (4k)

and tell the client that they can't access anything smaller than 4k 
granularity, but then read through to the backing layer which does just 
that, then we're wrong.  Either the block layer has to be beefed up to 
make bdrv_block_status() round backing file's smaller granularity into 
the size we advertised (perhaps by adding a flag to bdrv_block_status() 
to declare whether we prefer the most accurate information vs. the 
rounded information) - or else qemu as NBD server should ALWAYS 
advertise a blocksize of 1-512 (1 because we can, even if by 
read-modify-write; or 512 because except for EOF issues on a 
non-sector-aligned file, we don't encounter mid-sector transitions 
anywhere else, and EOF is easier to special case than everywhere).

2. Patch 5 fixes qemu as client to not round valid requests past EOF, 
but does not fix the case of a request that intentionally exceeds EOF 
but fits within the rounded file size from reaching the server. Either 
the NBD client code should itself perform EOF validation (reads from the 
EOF hole see zero, writes of anything other than zero fail with ENOSPC), 
or the NBD client code should round the server's file size down instead 
of up.  I haven't decided which approach is better.

But right now, these fixes are taking a back seat to me trying to get a 
libvirt incremental backup demo working.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
