Received: from eggs.gnu.org ([2001:4830:134:3::10]:52303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ekB93-0002Vy-Hl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ekB8z-0005q0-K9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ekB8z-0005pk-EV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:21 -0500
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<8d1183ed-c7ab-e130-c983-e5e116d80fa3@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <edaa67ca-b118-961a-c8aa-bcde1e148d88@redhat.com>
Date: Fri, 9 Feb 2018 17:03:02 +0100
MIME-Version: 1.0
In-Reply-To: <8d1183ed-c7ab-e130-c983-e5e116d80fa3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 09.02.2018 13:47, Klim Kireev wrote:
> 
> On 02/08/2018 10:13 PM, Thomas Huth wrote:
>> On 30.01.2018 20:49, Paolo Bonzini wrote:
>>> On 25/01/2018 08:51, Klim Kireev wrote:
>>>> The following behavior was observed for QEMU configured by libvirt
>>>> to use guest agent as usual for the guests without virtio-serial
>>>> driver (Windows or the guest remaining in BIOS stage).
>>>>
>>>> In QEMU on first connect to listen character device socket
>>>> the listen socket is removed from poll just after the accept().
>>>> virtio_serial_guest_ready() returns 0 and the descriptor
>>>> of the connected Unix socket is removed from poll and it will
>>>> not be present in poll() until the guest will initialize the driver
>>>> and change the state of the serial to "guest connected".
>>>>
>>>> In libvirt connect() to guest agent is performed on restart and
>>>> is run under VM state lock. Connect() is blocking and can
>>>> wait forever.
>>>> In this case libvirt can not perform ANY operation on that VM.
>>>>
>>>> The bug can be easily reproduced this way:
>>>>
>>>> Terminal 1:
>>>> qemu-system-x86_64 -m 512 -device pci-serial,chardev=serial1 -chardev socket,id=serial1,path=/tmp/console.sock,server,nowait
>>>> (virtio-serial and isa-serial also fit)
>>>>
>>>> Terminal 2:
>>>> minicom -D unix\#/tmp/console.sock
>>>> (type something and press enter)
>>>> C-a x (to exit)
>>>>
>>>> Do 3 times:
>>>> minicom -D unix\#/tmp/console.sock
>>>> C-a x
>>>>
>>>> It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
>>>> the kernel, and the 4th blocks.
>>>>
>>>> The problem is that QEMU doesn't add a read watcher after succesful read
>>>> until the guest device wants to acquire recieved data, so
>>>> I propose to install a separate pullhup watcher regardless of
>>>> whether the device waits for data or not.
>>>>
>>>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>>>> ---
>>>> Changelog:
>>>> v2: Remove timer as a redundant feature
>>>>
>>>> v3: Remove read call and return G_SOURCE_REMOVE
>>>>
>>>> v4: Move to GSource API
>>>>
>>>> v5: Fix git typos 
>>>>
>>>>  chardev/char-socket.c | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>>>> index 77cdf487eb..a340af6cd3 100644
>>>> --- a/chardev/char-socket.c
>>>> +++ b/chardev/char-socket.c
>>>> @@ -42,6 +42,7 @@ typedef struct {
>>>>      QIOChannel *ioc; /* Client I/O channel */
>>>>      QIOChannelSocket *sioc; /* Client master channel */
>>>>      QIONetListener *listener;
>>>> +    GSource *hup_source;
>>>>      QCryptoTLSCreds *tls_creds;
>>>>      int connected;
>>>>      int max_size;
>>>> @@ -352,6 +353,12 @@ static void tcp_chr_free_connection(Chardev *chr)
>>>>          s->read_msgfds_num = 0;
>>>>      }
>>>>  
>>>> +    if (s->hup_source != NULL) {
>>>> +        g_source_destroy(s->hup_source);
>>>> +        g_source_unref(s->hup_source);
>>>> +        s->hup_source = NULL;
>>>> +    }
>>>> +
>>>>      tcp_set_msgfds(chr, NULL, 0);
>>>>      remove_fd_in_watch(chr);
>>>>      object_unref(OBJECT(s->sioc));
>>>> @@ -455,6 +462,15 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>>>>      return TRUE;
>>>>  }
>>>>  
>>>> +static gboolean tcp_chr_hup(QIOChannel *channel,
>>>> +                               GIOCondition cond,
>>>> +                               void *opaque)
>>>> +{
>>>> +    Chardev *chr = CHARDEV(opaque);
>>>> +    tcp_chr_disconnect(chr);
>>>> +    return G_SOURCE_REMOVE;
>>>> +}
>>>> +
>>>>  static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
>>>>  {
>>>>      SocketChardev *s = SOCKET_CHARDEV(chr);
>>>> @@ -528,6 +544,12 @@ static void tcp_chr_connect(void *opaque)
>>>>                                             tcp_chr_read,
>>>>                                             chr, chr->gcontext);
>>>>      }
>>>> +
>>>> +    s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
>>>> +    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
>>>> +                          chr, NULL);
>>>> +    g_source_attach(s->hup_source, chr->gcontext);
>>>> +
>>>>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>>>>  }
>>>>  
>>>>
>>> Queued, thanks.
>>  Hi!
>>
>> I'm currently facing some issues with "make check -j4" (i.e. running the
>> tests in parallel). Git bisect blames this commit - though I'm not sure
>> whether this is really the right one ... Starting with this commit, I
>> saw hangs in test-filter-redirector, 
> 
> Commit 8f6d701044bc87197aac8aa2a627d70ce8471726 fixes it
> Have you tried to apply it?

That seems to be the one that fixes test-filter-redirector, but after
that, it still fails with vhost-user-test instead.

 Thomas
