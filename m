Received: from eggs.gnu.org ([2001:4830:134:3::10]:59512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cVFKn-00082I-0E
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 05:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cVFKl-0002Ld-Pl
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 05:25:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170118080126.nyldkjhxdsxd4u2b@grep.be>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
From: Bob Chen <a175818323@gmail.com>
Date: Sun, 22 Jan 2017 18:25:09 +0800
Message-ID: <CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi folks,

My time schedule doesn't allow me to wait for the community's solution, so
I started to work on quick fix, which is to add a 'bdrv_truncate' function
to the current NBD's BlockDriver. Basically it's an 'active resize'
implementation.

I also realized that the 'bdrv_truncate' caller stack is not in a
coroutine, seemed to be the main thread? Then I tried some synchronous code
as below:

int nbd_truncate(BlockDriverState *bs, int64_t offset)
{
    //...
    nbd_client_detach_aio_context(bs);
    qio_channel_set_blocking(client->ioc, true, NULL);

    ret = nbd_send_request(client->ioc, &request);            // step 1,
send custom NBD_CMD_RESIZE request
    ret = nbd_receive_reply(client->ioc, &reply);

    read_sync(client->ioc, &new_size, sizeof(new_size));     // step 2,
expected to receive the confirmed new_size as data
    new_size = be64_to_cpu(new_size);

    qio_channel_set_blocking(client->ioc, false, NULL);
    nbd_client_attach_aio_context(bs, aio_context);
    //...
}

However at step 2, the 'new_size' I read is not always correct. Sometimes
the bytes are repeating, for instance 1073741824 (1GB)
became 1073741824073741824 ...

Could you help me figure out what went wrong?


Regards,
Bob

2017-01-18 16:01 GMT+08:00 Wouter Verhelst <w@uter.be>:

> On Mon, Jan 16, 2017 at 01:36:21PM -0600, Eric Blake wrote:
> > Maybe the structured reply proposal can be extended into this (reserve a
> > "reply" header that can be issued as many times as desired by the server
> > without the client ever having issued the request first, and where the
> > reply never uses the end-of-reply marker), but I'm not sure I want to go
> > that direction just yet.
>
> It's not necessarily a bad idea, which could also be used for:
> - keepalive probes from server to client
> - unsolicited ESHUTDOWN messages
>
> both of which are currently not possible and might be useful for the
> protocol to have.
>
> --
> < ron> I mean, the main *practical* problem with C++, is there's like a
> dozen
>        people in the world who think they really understand all of its
> rules,
>        and pretty much all of them are just lying to themselves too.
>  -- #debian-devel, OFTC, 2016-02-12
>
