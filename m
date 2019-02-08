Received: from eggs.gnu.org ([209.51.188.92]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs1s5-0000jG-77
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs1s3-00038L-T0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:50:53 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:43397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gs1s3-00031g-7L
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:50:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190207142649.GL19438@redhat.com>
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<20190207142649.GL19438@redhat.com>
Date: Fri, 08 Feb 2019 09:50:31 +0100
Message-ID: <w51zhr68y08.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: Lock tcp_chr_disconnect()
 and socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu 07 Feb 2019 03:26:49 PM CET, Daniel P. Berrang=C3=A9 wrote:
>> @@ -457,11 +469,12 @@ static void tcp_chr_disconnect(Chardev *chr)
>>      }
>>      update_disconnected_filename(s);
>>      if (emit_close) {
>> -        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>> +        qemu_idle_add(tcp_chr_be_event_closed, chr, chr->gcontext);
>
> I'm a little concerned that this change might trigger some unexpected
> interactions with the qemu_chr_wait_connected() function. I added some
> more testing around that code, so if it passes the new tests I have
> in:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05962.html
>
> and also works with the vhostuser reconnect device, then we are
> probably ok.

Seems that it doesn't ...

/char/null: OK
/char/invalid: OK
/char/ringbuf: OK
/char/mux: OK
/char/stdio: OK
/char/pipe: OK
/char/file: OK
/char/file-fifo: OK
/char/udp: OK
/char/serial: OK
/char/hotswap: OK
/char/websocket: OK
/char/socket/server/mainloop/tcp: OK
/char/socket/server/mainloop/unix: OK
/char/socket/server/wait-conn/tcp: OK
/char/socket/server/wait-conn/unix: OK
/char/socket/server/mainloop-fdpass/tcp: OK
/char/socket/server/mainloop-fdpass/unix: OK
/char/socket/server/wait-conn-fdpass/tcp: OK
/char/socket/server/wait-conn-fdpass/unix: OK
/char/socket/client/mainloop/tcp: OK
/char/socket/client/mainloop/unix: OK
/char/socket/client/wait-conn/tcp: OK
/char/socket/client/wait-conn/unix: OK
/char/socket/client/mainloop-reconnect/tcp: OK
/char/socket/client/mainloop-reconnect/unix: OK
/char/socket/client/wait-conn-reconnect/tcp: Unexpected error in qio_channe=
l_readv_all() at /home/berto/work/qemu/qemu/io/channel.c:147:
Unexpected end-of-file before all bytes were read

Berto
