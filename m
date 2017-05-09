Received: from eggs.gnu.org ([2001:4830:134:3::10]:47310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1d86Dl-0002ET-Q8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1d86Dh-0002lU-NP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:34:37 -0400
From: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20170508211953.28017-4-eblake@redhat.com> (Eric Blake's message
	of "Mon, 8 May 2017 16:19:51 -0500")
Date: Tue, 09 May 2017 13:56:46 +0200
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-4-eblake@redhat.com>
Message-ID: <87efvyhzfc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, alistair.francis@xilinx.com, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:Old World" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Resending because first send didn't get through to some recipients...

Eric Blake <eblake@redhat.com> writes:

> Time to wire up all the call sites that request a shutdown or
> reset to use the enum added in the previous patch.
>
> It would have been less churn to keep the common case with no
> arguments as meaning guest-triggered, and only modified the
> host-triggered code paths, via a wrapper function, but then we'd
> still have to audit that I didn't miss any host-triggered spots;
> changing the signature forces us to double-check that I correctly
> categorized all callers.
>
> Since command line options can change whether a guest reset request
> causes an actual reset vs. a shutdown, it's easy to also add the
> information to reset requests.
>
> Replay adds a FIXME to preserve the cause across the replay stream,
> that will be tackled in the next patch.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC part]
[...]
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index e890a5d..95fcac9 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -561,7 +561,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>          uint16_t sus_typ = (val >> 10) & 7;
>          switch(sus_typ) {
>          case 0: /* soft power off */
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>              break;
>          case 1:
>              qemu_system_suspend_request();
> @@ -569,7 +569,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>          default:
>              if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>                  qapi_event_send_suspend_disk(&error_abort);
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);

I'm fine with using SHUTDOWN_CAUSE_GUEST_SHUTDOWN for suspend, but have
you considered SHUTDOWN_CAUSE_GUEST_SUSPEND?

>              }
>              break;
>          }
[...]
> diff --git a/qmp.c b/qmp.c
> index ab74cd7..95949d0 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -84,7 +84,7 @@ UuidInfo *qmp_query_uuid(Error **errp)
>  void qmp_quit(Error **errp)
>  {
>      no_shutdown = 0;
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP);
>  }
>
>  void qmp_stop(Error **errp)
> @@ -105,7 +105,7 @@ void qmp_stop(Error **errp)
>
>  void qmp_system_reset(Error **errp)
>  {
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);

This is the only place where we pass something other than
SHUTDOWN_CAUSE_GUEST_RESET.  We could avoid churn the obvious way, but I
guess having the churn eases patch review.  Okay.

>  }
>
>  void qmp_system_powerdown(Error **erp)
> diff --git a/replay/replay.c b/replay/replay.c
> index f810628..604fa4f 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -51,7 +51,8 @@ bool replay_next_event_is(int event)
>          switch (replay_state.data_kind) {
>          case EVENT_SHUTDOWN:
>              replay_finish_event();
> -            qemu_system_shutdown_request();
> +            /* FIXME - store actual reason */
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);

The temporary replay breakage is no big deal.  Still, can we avoid it by
extending replay first, using a dummy value like
SHUTDOWN_CAUSE_HOST_ERROR until the real cause becomes available?  Not
sure it's worth a respin, though.

>              break;
>          default:
>              /* clock, time_t, checkpoint and other events */
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>
