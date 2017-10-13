Received: from eggs.gnu.org ([2001:4830:134:3::10]:57538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gugnani.2@buckeyemail.osu.edu>) id 1e37KP-0006RH-9i
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 17:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gugnani.2@buckeyemail.osu.edu>) id 1e37KM-0003Kw-2U
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 17:17:09 -0400
From: "Gugnani, Shashank" <gugnani.2@buckeyemail.osu.edu>
Date: Fri, 13 Oct 2017 21:17:01 +0000
Message-ID: <CY4PR0101MB291845DB32D4CA76E3EBF0E0E9480@CY4PR0101MB2918.prod.exchangelabs.com>
References: <CY4PR0101MB291815E29308B3C75D26876FE9740@CY4PR0101MB2918.prod.exchangelabs.com>,
	<20171011120706.GF4593@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171011120706.GF4593@dhcp-200-186.str.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Co-routine re-entered recursively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi,


I'm using this to get the aio context:

n->aio_ctx =3D blk_get_aio_context(n->conf.blk);


And then I acquire the aio context before doing block i/o:

aio_context_acquire(n->aio_ctx);

// block i/o

aio_context_release(n->aio_ctx);


However, I still see the error:

Co-routine re-entered recursively


Thanks,

Shashank

________________________________
From: Kevin Wolf <kwolf@redhat.com>
Sent: Wednesday, October 11, 2017 8:07:06 AM
To: Gugnani, Shashank
Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org
Subject: Re: [Qemu-devel] Co-routine re-entered recursively

[ Cc: qemu-block ]

Am 09.10.2017 um 21:11 hat Gugnani, Shashank geschrieben:
> Hi,
>
> I'm trying to modify the NVMe emulator in QEMU to use multiple threads.
>
> After making necessary changes, I see this error: 'Co-routine re-entered =
recursively'
>
> Can anybody tell me the reason for this error? Is there anything I can do=
 to fix this issue?

I suspect that you need to fix your locking. Are you sure you're holding
the AioContext locks while you're making requests to the block layer?

Kevin
