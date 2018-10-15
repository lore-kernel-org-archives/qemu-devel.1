Received: from eggs.gnu.org ([2001:4830:134:3::10]:46824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBybd-00080j-3I
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBybZ-000895-VA
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:52:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBybZ-00087q-HS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:52:01 -0400
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
	<f203d1b772f7e4087f8e64f5f23ae313835413d4.1539528213.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b7ba6fc-a676-7535-0467-7433273ce8b0@redhat.com>
Date: Mon, 15 Oct 2018 10:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <f203d1b772f7e4087f8e64f5f23ae313835413d4.1539528213.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] Restores record/replay behavior
 related to special virtual clock processing for timers used in external
 subsystems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Gerd Hoffmann <kraxel@redhat.com>

On 14/10/2018 16:55, Artem Pisarenko wrote:
> +            qemu_mutex_lock(&timer_list->active_timers_lock);
> +            ts =3D timer_list->active_timers;
> +            while (timer_expired_ns(ts, current_time)) {
> +                if (!(ts->attributes & QEMU_TIMER_ATTR(EXTERNAL))) {
> +                    need_replay_checkpoint =3D true;
> +                    break;
> +                }
> +                ts =3D ts->next;
> +            }
> +            qemu_mutex_unlock(&timer_list->active_timers_lock);

This can be applied to all the timerlists, it doesn't have to be limited
to the "virtual" clock, something like (untested):

    qemu_mutex_lock(&timer_list->active_timers_lock);
    current_time =3D qemu_clock_get_ns(timer_list->clock->type);
    ts =3D timer_list->active_timers;
    if (replay_mode !=3D REPLAY_MODE_NONE) {
         while (timer_expired_ns(ts, current_time)) {
             if (!(ts->attributes & QEMU_TIMER_ATTR(EXTERNAL))) {
                 qemu_mutex_unlock(&timer_list->active_timers_lock);
                 timerlist_checkpoint(timer_list);
                 qemu_mutex_lock(&timer_list->active_timers_lock);
                 break;
              }
              ts =3D ts->next;
         }
        ts =3D timer_list->active_timers;
    }

    while (timer_expired_ns(ts, current_time)) {
        /* remove timer from the list before calling the callback */
        timer_list->active_timers =3D ts->next;
        ts->next =3D NULL;
        ts->expire_time =3D -1;
        cb =3D ts->cb;
        opaque =3D ts->opaque;

        /* run the callback (the timer list can be modified) */
        qemu_mutex_unlock(&timer_list->active_timers_lock);
        cb(opaque);
        qemu_mutex_lock(&timer_list->active_timers_lock);
        progress =3D true;
        ts =3D timer_list->active_timers;
    }
    qemu_mutex_unlock(&timer_list->active_timers_lock);

Thanks,

Paolo
