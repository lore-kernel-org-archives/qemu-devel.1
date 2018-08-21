Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsBOh-0005vg-Vv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsBAO-0007Cl-1F
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:14:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fsBAN-000768-Qi
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:14:07 -0400
Received: by mail-io0-f193.google.com with SMTP id y12-v6so6420121ioj.13
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 11:14:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815133747.25032-2-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-2-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Aug 2018 20:13:59 +0200
Message-ID: <CAMxuvaxKmT_MqXOhbYbwbJo0LtuACO8wXantiMY-9VvXd=o7DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 01/13] monitor: simplify
 monitor_qmp_setup_handlers_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Wed, Aug 15, 2018 at 3:37 PM, Peter Xu <peterx@redhat.com> wrote:
> When we reach monitor_qmp_setup_handlers_bh() we must be using the
> IOThread then, so no need to check against it any more.  Instead, we
> assert.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

That's a clear simplification that I also found, so ack in principle.

However, I don't understand the need of a BH in the first place.
monitor_get_io_context() will return the iothread associated context.
Could you explain?
thanks


> ---
>  monitor.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 77861e96af..5cd9398824 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4624,15 +4624,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      Monitor *mon = opaque;
>      GMainContext *context;
>
> -    if (mon->use_io_thread) {
> -        /* Use @mon_iothread context */
> -        context = monitor_get_io_context();
> -        assert(context);
> -    } else {
> -        /* Use default main loop context */
> -        context = NULL;
> -    }
> -
> +    assert(mon->use_io_thread);
> +    /* Use @mon_iothread context */
> +    context = monitor_get_io_context();
> +    assert(context);
>      qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
>                               monitor_qmp_event, NULL, mon, context, true);
>      monitor_list_append(mon);
> --
> 2.17.1
>
