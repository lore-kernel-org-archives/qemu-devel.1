Received: from eggs.gnu.org ([2001:4830:134:3::10]:42348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cVGYy-0006n9-4M
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 06:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cVGYx-00024T-4p
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 06:44:00 -0500
Date: Sun, 22 Jan 2017 12:43:39 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170122114339.l3ijhy3uymsru4ed@grep.be>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
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
To: Bob Chen <a175818323@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Sun, Jan 22, 2017 at 06:25:09PM +0800, Bob Chen wrote:
> Hi folks,
> 
> My time schedule doesn't allow me to wait for the community's solution, so I
> started to work on quick fix, which is to add a 'bdrv_truncate' function to the
> current NBD's BlockDriver. Basically it's an 'active resize' implementation.

Fair enough.

If you're going to do that though, please add some negotiation before
trying to use the option, too. That way, other implementations can add
support for that option too, if they want

Having given this some more thought, I'm not entirely sure anymore that
an active resize from the NBD layer is necessarily a layering violation.
There might be other cases where this is useful, and e.g., the Linux
kernel also supports active resizes of block devices in some cases
(e.g., LVM). We'll also need to define what happens in case the resize
operation isn't possible for some reason (e.g., the size increase asks
for more space than the server's storage has available).

I suggest the following semantics:

- Add a transmission flag to indicate resize is possible for
  transmission phase (NBD_FLAG_SEND_RESIZE, flag 10). I don't see any
  need for an NBD_OPT_RESIZE or some such; just the flag should suffice.
- NBD_CMD_RESIZE (command 7): resize the export. The "offset" field
  contains the new size, "length" is reserved (why not the other way
  around? offset is 64 bits, length is 32)
- resize command can fail with:
  EPERM: server configuration does not allow this resize, or
  (optionally) other clients are using the same export and the request
  was for a smaller size.
  EIO: I/O error while trying to resize the device
  ENOSPC: new export size requires more space than is available
  ESHUTDOWN: server is shutting down

I've added an "extension-resize" branch with the above. If that works
for you, then run with it. If not, just implement what you want and send
updates as you go along.

> I also realized that the 'bdrv_truncate' caller stack is not in a coroutine,
> seemed to be the main thread? Then I tried some synchronous code as below:
> 
> int nbd_truncate(BlockDriverState *bs, int64_t offset)
> {
>     //...
>     nbd_client_detach_aio_context(bs);
>     qio_channel_set_blocking(client->ioc, true, NULL);
> 
>     ret = nbd_send_request(client->ioc, &request);            // step 1, send
> custom NBD_CMD_RESIZE request
>     ret = nbd_receive_reply(client->ioc, &reply);
> 
>     read_sync(client->ioc, &new_size, sizeof(new_size));     // step 2,
> expected to receive the confirmed new_size as data
>     new_size = be64_to_cpu(new_size);
> 
>     qio_channel_set_blocking(client->ioc, false, NULL);
>     nbd_client_attach_aio_context(bs, aio_context);
>     //...
> }
> 
> However at step 2, the 'new_size' I read is not always correct. Sometimes the
> bytes are repeating, for instance 1073741824 (1GB) became 1073741824073741824
> ...
> 
> Could you help me figure out what went wrong?
> 
> 
> Regards, 
> Bob
> 
> 2017-01-18 16:01 GMT+08:00 Wouter Verhelst <w@uter.be>:
> 
>     On Mon, Jan 16, 2017 at 01:36:21PM -0600, Eric Blake wrote:
>     > Maybe the structured reply proposal can be extended into this (reserve a
>     > "reply" header that can be issued as many times as desired by the server
>     > without the client ever having issued the request first, and where the
>     > reply never uses the end-of-reply marker), but I'm not sure I want to go
>     > that direction just yet.
> 
>     It's not necessarily a bad idea, which could also be used for:
>     - keepalive probes from server to client
>     - unsolicited ESHUTDOWN messages
> 
>     both of which are currently not possible and might be useful for the
>     protocol to have.
> 
>     --
>     < ron> I mean, the main *practical* problem with C++, is there's like a
>     dozen
>            people in the world who think they really understand all of its
>     rules,
>            and pretty much all of them are just lying to themselves too.
>      -- #debian-devel, OFTC, 2016-02-12
> 
> 

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
