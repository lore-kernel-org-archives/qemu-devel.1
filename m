Received: from eggs.gnu.org ([2001:4830:134:3::10]:56763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6hE-00045K-PK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6hA-0003eJ-Sl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:47:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT6hA-0003e3-Mw
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:47:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8E884E326
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:47:32 +0000 (UTC)
Date: Mon, 16 Jan 2017 20:47:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116124728.GB10221@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170116113824.GD14226@lemon.Home>
	<b9183a4e-8e45-ec47-afcf-187cb5e81411@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9183a4e-8e45-ec47-afcf-187cb5e81411@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, 01/16 13:24, Paolo Bonzini wrote:
> 
> 
> On 16/01/2017 12:38, Fam Zheng wrote:
> >> +void qio_channel_detach_aio_context(QIOChannel *ioc)
> >> +{
> >> +    ioc->read_coroutine = NULL;
> >> +    ioc->write_coroutine = NULL;
> >> +    qio_channel_set_aio_fd_handlers(ioc);
> >> +    ioc->ctx = NULL;
> >
> > Why is qio_channel_set_aio_fd_handler not needed here?
> 
> Because there are no read_coroutine and write_coroutine anymore.  The
> caller needs to schedule them on the right AioContext after calling
> qio_channel_set_aio_context.  See nbd_client_attach_aio_context in the
> next patch for an example.
> 
> >> -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
> >> +tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(test-block-obj-y)
> > 
> > I guess this is a hint for moving coroutine code into a lower level library like
> > util.
> 
> Coroutine, or AioContext?  The reason for this is that io/ now uses
> aio_co_wake.

Or both. It just feels a bit odd to see *char* depend on *block*, maybe there're
more such dependencies to come even outside tests/?

Not necessarily for this series, of course.

Fam
