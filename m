Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkr1y-0003S5-ST
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkr1x-0001MK-O4
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkr1x-0001MD-HV
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AFA687A76
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 13:19:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180801093401.9160-1-marcandre.lureau@redhat.com>
Date: Wed, 01 Aug 2018 15:19:05 +0200
In-Reply-To: <20180801093401.9160-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 1 Aug 2018 11:34:01 +0200")
Message-ID: <871sbi8bsm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: avoid potential dead-lock when
 cleaning up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> When a monitor is connected to a Spice chardev, the monitor cleanup
> can dead-lock:
>
>  #0  0x00007f43446637fd in __lll_lock_wait () at /lib64/libpthread.so.0
>  #1  0x00007f434465ccf4 in pthread_mutex_lock () at /lib64/libpthread.so.0
>  #2  0x0000556dd79f22ba in qemu_mutex_lock_impl (mutex=3D0x556dd81c9220 <=
monitor_lock>, file=3D0x556dd7ae3648 "/home/elmarco/src/qq/monitor.c", line=
=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
>  #3  0x0000556dd7431bd5 in monitor_qapi_event_queue (event=3DQAPI_EVENT_S=
PICE_DISCONNECTED, qdict=3D0x556dd9abc850, errp=3D0x7fffb7bbddd8) at /home/=
elmarco/src/qq/monitor.c:645
>  #4  0x0000556dd79d476b in qapi_event_send_spice_disconnected (server=3D0=
x556dd98ee760, client=3D0x556ddaaa8560, errp=3D0x556dd82180d0 <error_abort>=
) at qapi/qapi-events-ui.c:149
>  #5  0x0000556dd7870fc1 in channel_event (event=3D3, info=3D0x556ddad1b59=
0) at /home/elmarco/src/qq/ui/spice-core.c:235
>  #6  0x00007f434560a6bb in reds_handle_channel_event (reds=3D<optimized o=
ut>, event=3D3, info=3D0x556ddad1b590) at reds.c:316
>  #7  0x00007f43455f393b in main_dispatcher_self_handle_channel_event (inf=
o=3D0x556ddad1b590, event=3D3, self=3D0x556dd9a7d8c0) at main-dispatcher.c:=
197
>  #8  0x00007f43455f393b in main_dispatcher_channel_event (self=3D0x556dd9=
a7d8c0, event=3Devent@entry=3D3, info=3D0x556ddad1b590) at main-dispatcher.=
c:197
>  #9  0x00007f4345612833 in red_stream_push_channel_event (s=3Ds@entry=3D0=
x556ddae2ef40, event=3Devent@entry=3D3) at red-stream.c:414
>  #10 0x00007f434561286b in red_stream_free (s=3D0x556ddae2ef40) at red-st=
ream.c:388
>  #11 0x00007f43455f9ddc in red_channel_client_finalize (object=3D0x556dd9=
bb21a0) at red-channel-client.c:347
>  #12 0x00007f434b5f9fb9 in g_object_unref () at /lib64/libgobject-2.0.so.0
>  #13 0x00007f43455fc212 in red_channel_client_push (rcc=3D0x556dd9bb21a0)=
 at red-channel-client.c:1341
>  #14 0x0000556dd76081ba in spice_port_set_fe_open (chr=3D0x556dd9925e20, =
fe_open=3D0) at /home/elmarco/src/qq/chardev/spice.c:241
>  #15 0x0000556dd796d74a in qemu_chr_fe_set_open (be=3D0x556dd9a37c00, fe_=
open=3D0) at /home/elmarco/src/qq/chardev/char-fe.c:340
>  #16 0x0000556dd796d4d9 in qemu_chr_fe_set_handlers (b=3D0x556dd9a37c00, =
fd_can_read=3D0x0, fd_read=3D0x0, fd_event=3D0x0, be_change=3D0x0, opaque=
=3D0x0, context=3D0x0, set_open=3Dtrue) at /home/elmarco/src/qq/chardev/cha=
r-fe.c:280
>  #17 0x0000556dd796d359 in qemu_chr_fe_deinit (b=3D0x556dd9a37c00, del=3D=
false) at /home/elmarco/src/qq/chardev/char-fe.c:233
>  #18 0x0000556dd7432240 in monitor_data_destroy (mon=3D0x556dd9a37c00) at=
 /home/elmarco/src/qq/monitor.c:786
>  #19 0x0000556dd743b968 in monitor_cleanup () at /home/elmarco/src/qq/mon=
itor.c:4683
>  #20 0x0000556dd75ce776 in main (argc=3D3, argv=3D0x7fffb7bbe458, envp=3D=
0x7fffb7bbe478) at /home/elmarco/src/qq/vl.c:4660
>
> Because spice code tries to emit a "disconnected" signal on the
> monitors. Fix this situation by tightening the monitor lock time to
> the monitor list removal.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Do you think this should go into 3.0?

> ---
>  monitor.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 0fa0910a2a..a16a6c5311 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4702,8 +4702,6 @@ void monitor_init(Chardev *chr, int flags)
>=20=20
>  void monitor_cleanup(void)
>  {
> -    Monitor *mon, *next;
> -
>      /*
>       * We need to explicitly stop the I/O thread (but not destroy it),
>       * clean up the monitor resources, then destroy the I/O thread since
> @@ -4719,14 +4717,24 @@ void monitor_cleanup(void)
>      monitor_qmp_bh_responder(NULL);
>=20=20
>      /* Flush output buffers and destroy monitors */
> -    qemu_mutex_lock(&monitor_lock);
> -    QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> -        QTAILQ_REMOVE(&mon_list, mon, entry);
> +    do {

for (;;), please.

> +        Monitor *mon;
> +
> +        qemu_mutex_lock(&monitor_lock);
> +        mon =3D QTAILQ_FIRST(&mon_list);
> +        if (mon) {
> +            QTAILQ_REMOVE(&mon_list, mon, entry);
> +        }
> +        qemu_mutex_unlock(&monitor_lock);
> +
> +        if (!mon) {
> +            break;
> +        }
> +
>          monitor_flush(mon);
>          monitor_data_destroy(mon);
>          g_free(mon);
> -    }
> -    qemu_mutex_unlock(&monitor_lock);
> +    } while (true);
>=20=20
>      /* QEMUBHs needs to be deleted before destroying the I/O thread */
>      qemu_bh_delete(qmp_dispatcher_bh);

Iterating safely over a list protected by a lock should be easier than
that.  Sad.

Hmm, what about this:

diff --git a/monitor.c b/monitor.c
index 77861e96af..4a23f6c7bc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4721,9 +4721,11 @@ void monitor_cleanup(void)
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
+        qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
         monitor_data_destroy(mon);
         g_free(mon);
+        qemu_mutex_lock(&monitor_lock);
     }
     qemu_mutex_unlock(&monitor_lock);
=20
