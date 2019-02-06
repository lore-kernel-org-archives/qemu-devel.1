Received: from eggs.gnu.org ([209.51.188.92]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grNBB-0006Qc-DE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grNBA-0007bu-Ia
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:53 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:35969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grNB9-0007Xb-Vz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <36d0c208-d4c5-712b-aa76-40009b224be5@redhat.com>
References: <20190206124345.14942-1-berto@igalia.com>
	<36d0c208-d4c5-712b-aa76-40009b224be5@redhat.com>
Date: Wed, 06 Feb 2019 14:23:34 +0100
Message-ID: <w51r2clrqy1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] char-socket: hold chr_write_lock
 during tcp_chr_free_connection()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed 06 Feb 2019 02:00:03 PM CET, Paolo Bonzini wrote:
> On 06/02/19 13:43, Alberto Garcia wrote:
>>          }
>> @@ -449,7 +451,9 @@ static void tcp_chr_disconnect(Chardev *chr)
>>      SocketChardev *s = SOCKET_CHARDEV(chr);
>>      bool emit_close = s->connected;
>>  
>> +    qemu_mutex_lock(&chr->chr_write_lock);
>>      tcp_chr_free_connection(chr);
>> +    qemu_mutex_unlock(&chr->chr_write_lock);
>>  
>>      if (s->listener) {
>>          qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
>
> Should operations on the listener also be protected?  I think that apart
> from emitting the closed event itself everything in this function should
> be protected by the lock.   The closed event should be pushed to the
> GMainContext using an idle source (perhaps it's worth writing a wrapper
> qemu_idle_add that takes a GMainContext, as the same idiom is already
> present in pty_chr_state and qio_task_thread_worker).

Now that you mention this it seems that we are leaking the GSources in
those two cases? GLib's g_idle_add_full() implementation does unref the
source after attaching it to the GMainContext.

   https://gitlab.gnome.org/GNOME/glib/blob/master/glib/gmain.c#L5684

Berto
