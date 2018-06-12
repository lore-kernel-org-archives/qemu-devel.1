Received: from eggs.gnu.org ([2001:4830:134:3::10]:47080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSihx-00027r-9a
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSihw-0004yl-7U
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:47:33 -0400
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
	<20180609153217.19683-11-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f6f298d1-d116-5dff-43db-001492c29e87@virtuozzo.com>
Date: Tue, 12 Jun 2018 15:47:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180609153217.19683-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 10/11] block/nbd-client: nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

09.06.2018 18:32, Vladimir Sementsov-Ogievskiy wrote:
> Implement reconnect. To achieve this:
>
> 1. Move from quit bool variable to state. 4 states are introduced:
>     connecting-wait: means, that reconnecting is in progress, and there
>       were small number of reconnect attempts, so all requests are
>       waiting for the connection.
>     connecting-nowait: reconnecting is in progress, there were a lot of
>       attempts of reconnect, all requests will return errors.
>     connected: normal state
>     quit: exiting after fatal error or on close
>
> Possible transitions are:
>
>     * -> quit
>     connecting-* -> connected
>     connecting-wait -> connecting-nowait
>     connected -> connecting-wait
>
> 2. Implement reconnect in connection_co. So, in connecting-* mode,
>      connection_co, tries to reconnect every NBD_RECONNECT_NS.
>      Configuring of this parameter (as well as NBD_RECONNECT_ATTEMPTS,
>      which specifies bound of transition from connecting-wait to
>      connecting-nowait) may be done as a follow-up patch.
>
> 3. Retry nbd queries on channel error, if we are in connecting-wait
>      state.
>
> 4. In init, wait until for connection until transition to
>      connecting-nowait. So, NBD_RECONNECT_ATTEMPTS is a bound of fail
>      for initial connection too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

squash:

@@ -616,7 +617,10 @@ static coroutine_fn int nbd_co_receive_one_chunk(
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->reply.handle =3D 0;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

-=C2=A0=C2=A0=C2=A0 if (s->connection_co) {
+=C2=A0=C2=A0=C2=A0 if (s->connection_co && !s->wait_in_flight) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We must check s->wait_in_fli=
ght, because we may entered by
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nbd_recv_coroutines_wak=
e_all(), int this case we should not
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * wake connection_co here=
, it will woken by last request. */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_co_wake(s->connection=
_co);
 =C2=A0=C2=A0=C2=A0=C2=A0 }



--=20
Best regards,
Vladimir
