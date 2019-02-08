Received: from eggs.gnu.org ([209.51.188.92]:44319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs2Ym-0000lo-5U
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs2Yk-0008QT-98
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:35:00 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:50659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gs2Yj-0008Mx-O9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:34:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190207142649.GL19438@redhat.com>
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<20190207142649.GL19438@redhat.com>
Date: Fri, 08 Feb 2019 10:34:53 +0100
Message-ID: <w51va1u8vya.fsf@maestria.local.igalia.com>
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
> more testing around that code, so if it passes the new tests I have in:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05962.html

Forget my previous e-mail, there was a mistake on my side. The test does
pass after rebasing my series on top of that one.

> and also works with the vhostuser reconnect device, then we are
> probably ok.

How do I test this?

Berto
