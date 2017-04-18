Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d0OJ8-0005V3-EK
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d0OJ5-000503-3z
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:16:18 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
	<80449391-88a6-d517-0682-de555fe4c169@redhat.com>
	<20170416093743.GA24137@stefanha-x1.localdomain>
	<20170417033334.GA6717@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c8dd49d-e8d8-bdee-fd65-9174dada7b24@redhat.com>
Date: Tue, 18 Apr 2017 10:16:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170417033334.GA6717@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 17/04/2017 05:33, Fam Zheng wrote:
> BDRV_POLL_WHILE in both IOThread and main loop has aio_context_acquire(ctx)
> around it; in the branch where main loop calls aio_poll(ctx, false),
> there is also no aio_context_release(ctx). So I thinki it is protected by the
> AioContext lock, and is safe.
> 
> I tested your suggested "aio_poll(qemu_get_aio_context(), false)", but it
> doesn't work.

Right, that's because "aio_poll(qemu_get_aio_context(), false)" relies
on bdrv_wakeup on the I/O thread side (which in turn is triggered by
bdrv_inc_in_flight/bdrv_dec_in_flight), but the bottom half does not
have bdrv_inc_in_flight/bdrv_dec_in_flight around it.

Paolo
