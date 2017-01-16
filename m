Received: from eggs.gnu.org ([2001:4830:134:3::10]:52773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT6L7-0000xS-EY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT6L2-0003C5-Gx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:24:45 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cT6L2-0003Bx-9z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:24:40 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so12406779lfi.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 04:24:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170116113824.GD14226@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9183a4e-8e45-ec47-afcf-187cb5e81411@redhat.com>
Date: Mon, 16 Jan 2017 13:24:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170116113824.GD14226@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 16/01/2017 12:38, Fam Zheng wrote:
>> +void qio_channel_detach_aio_context(QIOChannel *ioc)
>> +{
>> +    ioc->read_coroutine = NULL;
>> +    ioc->write_coroutine = NULL;
>> +    qio_channel_set_aio_fd_handlers(ioc);
>> +    ioc->ctx = NULL;
>
> Why is qio_channel_set_aio_fd_handler not needed here?

Because there are no read_coroutine and write_coroutine anymore.  The
caller needs to schedule them on the right AioContext after calling
qio_channel_set_aio_context.  See nbd_client_attach_aio_context in the
next patch for an example.

>> -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
>> +tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(test-block-obj-y)
> 
> I guess this is a hint for moving coroutine code into a lower level library like
> util.

Coroutine, or AioContext?  The reason for this is that io/ now uses
aio_co_wake.

Paolo
