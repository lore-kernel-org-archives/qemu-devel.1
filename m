Received: from eggs.gnu.org ([2001:4830:134:3::10]:42865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCilh-0008Vx-0w
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCild-0001PZ-Q1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:05:01 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e5c116d2-0e14-d357-60a7-73582691980d@virtuozzo.com>
Date: Thu, 9 Nov 2017 12:04:38 +0300
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/7] nbd-client: Refuse read-only client
 with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

09.11.2017 00:56, Eric Blake wrote:
> The NBD spec says that clients should not try to write/trim to
> an export advertised as read-only by the server.  But we failed
> to check that, and would allow the block layer to use NBD with
> BDRV_O_RDWR even when the server is read-only, which meant we
> were depending on the server sending a proper EPERM failure for
> various commands, and also exposes a leaky abstraction: using
> qemu-io in read-write mode would succeed on 'w -z 0 0' because
> of local short-circuiting logic, but 'w 0 0' would send a
> request over the wire (where it then depends on the server, and
> fails at least for qemu-nbd but might pass for other NBD
> implementations).
>
> With this patch, a client MUST request read-only mode to access
> a server that is doing a read-only export, or else it will get
> a message like:
>
> can't open device nbd://localhost:10809/foo: request for write access conflicts with read-only export
>
> It is no longer possible to even attempt writes over the wire
> (including the corner case of 0-length writes), because the block
> layer enforces the explicit read-only request; this matches the
> behavior of qcow2 when backed by a read-only POSIX file.
>
> Fix iotest 147 to comply with the new behavior (since nbd-server-add
> defaults to a read-only export, we must tell blockdev-add to set up a
> read-only client).
>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
