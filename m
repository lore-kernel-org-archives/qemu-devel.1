Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ec6hD-0000xy-Rx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ec6hB-0004ai-5k
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:41:19 -0500
Received: from mail-eopbgr20133.outbound.protection.outlook.com
	([40.107.2.133]:34266
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ec6hA-0004Yv-Kh
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:41:17 -0500
References: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
	<71031eb9-06a0-21fe-dd89-4b49e23b97be@redhat.com>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <fe310a84-9ffd-b167-0c42-5073e01afb04@virtuozzo.com>
Date: Thu, 18 Jan 2018 12:41:08 +0300
MIME-Version: 1.0
In-Reply-To: <71031eb9-06a0-21fe-dd89-4b49e23b97be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, den@virtuozzo.com

On 01/16/2018 08:25 PM, Paolo Bonzini wrote:
> On 10/01/2018 14:18, Klim Kireev wrote:
>> The following behavior was observed for QEMU configured by libvirt
>> to use guest agent as usual for the guests without virtio-serial
>> driver (Windows or the guest remaining in BIOS stage).
>>
>> In QEMU on first connect to listen character device socket
>> the listen socket is removed from poll just after the accept().
>> virtio_serial_guest_ready() returns 0 and the descriptor
>> of the connected Unix socket is removed from poll and it will
>> not be present in poll() until the guest will initialize the driver
>> and change the state of the serial to "guest connected".
>>
>> In libvirt connect() to guest agent is performed on restart and
>> is run under VM state lock. Connect() is blocking and can
>> wait forever.
>> In this case libvirt can not perform ANY operation on that VM.
>>
>> The bug can be easily reproduced this way:
>>
>> Terminal 1:
>> qemu-system-x86_64 -m 512 -device pci-serial,chardev=serial1 -chardev socket,id=serial1,path=/tmp/console.sock,server,nowait
>> (virtio-serial and isa-serial also fit)
>>
>> Terminal 2:
>> minicom -D unix\#/tmp/console.sock
>> (type something and pres enter)
>> C-a x (to exit)
>>
>> Do 3 times:
>> minicom -D unix\#/tmp/console.sock
>> C-a x
>>
>> It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
>> the kernel, and the 4th blocks.
>>
>> The problem is that QEMU doesn't add a read watcher after succesful read
>> until the guest device wants to acquire recieved data, so
>> I propose to install a separate pullhup watcher regardless of
>> whether the device waits for data or not. After closing the connection,
>> the guest has a capability to read the data within timeout.
> I don't understand the timeout part.
The timeout is important, because of following situation:
client sends to the guest big bunch of data and closes his end of socket.
if we just destroy the connection on the qemu's side, the guest can't 
read remaining data in channel.
(which can be much more than guest's buffer), although he would do it later.
For this case timeout after POLLHUP is added. It is set after receiving 
POLLHUP and reset after each reading.
> Apart from that, maybe the bug is in io_watch_poll_prepare, which needs
> to _always_ set up a "G_IO_ERR | G_IO_HUP | G_IO_NVAL" watch.  Only
> G_IO_IN depends on iwp->fd_can_read(...) > 0.
>
> So the change would start with something like this:
>
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f81052481a..a5e65d4e7c 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -29,6 +29,7 @@ typedef struct IOWatchPoll {
>   
>       QIOChannel *ioc;
>       GSource *src;
> +    GIOCondition cond;
>   
>       IOCanReadHandler *fd_can_read;
>       GSourceFunc fd_read;
> @@ -41,25 +42,32 @@ static IOWatchPoll *io_watch_poll_from_source(GSource *source)
>       return container_of(source, IOWatchPoll, parent);
>   }
>   
> +static void io_watch_poll_destroy_source(IOWatchPoll *iwp)
> +{
> +    if (iwp->src) {
> +        g_source_destroy(iwp->src);
> +        g_source_unref(iwp->src);
> +        iwp->src = NULL;
> +        iwp->cond = 0;
> +    }
> +}
> +
>   static gboolean io_watch_poll_prepare(GSource *source,
>                                         gint *timeout)
>   {
>       IOWatchPoll *iwp = io_watch_poll_from_source(source);
>       bool now_active = iwp->fd_can_read(iwp->opaque) > 0;
> -    bool was_active = iwp->src != NULL;
> -    if (was_active == now_active) {
> -        return FALSE;
> +    GIOCondition cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> +    if (now_active) {
> +        cond |= G_IO_IN;
>       }
>   
> -    if (now_active) {
> -        iwp->src = qio_channel_create_watch(
> -            iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
> +    if (iwp->cond != cond) {
> +        io_watch_poll_destroy_source(iwp);
> +        iwp->cond = cond;
> +        iwp->src = qio_channel_create_watch(iwp->ioc, cond);
>           g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL);
>           g_source_attach(iwp->src, iwp->context);
> -    } else {
> -        g_source_destroy(iwp->src);
> -        g_source_unref(iwp->src);
> -        iwp->src = NULL;
>       }
>       return FALSE;
>   }
> @@ -131,11 +139,7 @@ static void io_remove_watch_poll(GSource *source)
>       IOWatchPoll *iwp;
>   
>       iwp = io_watch_poll_from_source(source);
> -    if (iwp->src) {
> -        g_source_destroy(iwp->src);
> -        g_source_unref(iwp->src);
> -        iwp->src = NULL;
> -    }
> +    io_watch_poll_destroy_source(iwp);
>       g_source_destroy(&iwp->parent);
>   }
>   
>
>
> Thanks,
>
> Paolo
