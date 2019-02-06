Received: from eggs.gnu.org ([209.51.188.92]:49709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grMoH-0005fT-Av
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grMoE-0005RX-TS
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:00:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1grMoD-0005Pl-1b
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:00:09 -0500
References: <20190206124345.14942-1-berto@igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36d0c208-d4c5-712b-aa76-40009b224be5@redhat.com>
Date: Wed, 6 Feb 2019 14:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190206124345.14942-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/02/19 13:43, Alberto Garcia wrote:
>          }
> @@ -449,7 +451,9 @@ static void tcp_chr_disconnect(Chardev *chr)
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      bool emit_close =3D s->connected;
> =20
> +    qemu_mutex_lock(&chr->chr_write_lock);
>      tcp_chr_free_connection(chr);
> +    qemu_mutex_unlock(&chr->chr_write_lock);
> =20
>      if (s->listener) {
>          qio_net_listener_set_client_func_full(s->listener, tcp_chr_acc=
ept,

Should operations on the listener also be protected?  I think that apart
from emitting the closed event itself everything in this function should
be protected by the lock.   The closed event should be pushed to the
GMainContext using an idle source (perhaps it's worth writing a wrapper
qemu_idle_add that takes a GMainContext, as the same idiom is already
present in pty_chr_state and qio_task_thread_worker).

socket_reconnect_timeout should also take the lock when freeing
s->reconnect_timer.

Paolo
