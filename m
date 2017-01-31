Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYQX5-0003v0-LR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYQX4-0007PP-ND
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:59:07 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:35180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cYQX4-0007PK-Hh
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:59:06 -0500
Received: by mail-ua0-x22c.google.com with SMTP id y9so266947386uae.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 20:59:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127094033.GC26553@redhat.com>
References: <CAO_EM_kS-aGQdvPEO+7pkFWHOSiu8XMpZSduS=gPgUsDwJd9ig@mail.gmail.com>
	<20170127094033.GC26553@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Mon, 30 Jan 2017 20:58:25 -0800
Message-ID: <CAO_EM_no14RDCd42hJy1xbo=mYsdo8k7oAESVx2KpF277U45VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [libvirt] char: Logging serial pty output when
 disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Eric Blake <eblake@redhat.com>

On Fri, Jan 27, 2017 at 1:40 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Jan 26, 2017 at 05:07:16PM -0800, Ed Swierk wrote:
>> Currently qemu_chr_fe_write() calls qemu_chr_fe_write_log() only for
>> data consumed by the backend chr_write function. With the pty backend,
>> pty_chr_write() returns 0 indicating that the data was not consumed
>> when the pty is disconnected. Simply changing it to return len instead
>> of 0 tricks the caller into logging the data even when the pty is
>> disconnected. I don't know what problems this might cause, but one
>> data point is that tcp_chr_write() already happens to work this way.
>>
>> Alternatively, qemu_chr_fe_write() could be modified to log everything
>> passed to it, regardless of how much data chr_write claims to have
>> consumed. The trouble is that the serial device retries writing
>> unconsumed data, so when the pty is disconnected you'd see every
>> character duplicated 4 times in the log file.
>>
>> Any opinions on either approach, or other suggestions? If there are no
>> objections to the first one, I'll prepare a patch.
>
> If the pty backend intends to just drop data into a blackhole when
> no client is connected, then its chr_write() impl should return
> the length of the data discarded, not zero.

That's exactly the question: when no client is connected, should the
pty backend just drop the data into a black hole, returning the length
of the data discarded? Or should it return 0, letting the frontend
device decide what to do with it?

I can't discern a consistent pattern across all the char backends. The
closest analog is the tcp backend, which does discard the data and
return len. In contrast, several backends call
io_channel_send{,_full}(), which returns -1 if the write would block
or fails for any other reason.

It's not clear there's much the frontend can do to recover from an
error, but there's no consistent pattern across serial devices either.
Most just ignore the return value. But the 16550A serial device
retries 4 times after an error. Changing the pty backend to discard
the data on the first attempt would bypass this retry mechanism. Is
that a problem?

--Ed
