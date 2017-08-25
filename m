Received: from eggs.gnu.org ([2001:4830:134:3::10]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlGXR-0003lJ-P8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlGXQ-0008Oo-UE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:49 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlGXQ-0008OK-MU
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:48 -0400
Received: by mail-wr0-x22c.google.com with SMTP id p8so439997wrf.2
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 08:28:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825141940.20740-2-dgilbert@redhat.com>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-2-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 16:28:26 +0100
Message-ID: <CAFEAcA9kOQ-WYaDSatWKYX82FM=zGb1LJ1a0iu9C2-nu3S=o+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, shorne@gmail.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

On 25 August 2017 at 15:19, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> migration_incoming_state_destroy doesn't really destroy, it cleans up.
> After a loadvm it's called, but the loadvm command can be run twice,
> and so destroying an init-once mutex breaks on the second loadvm.
>
> Reported-by: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index c3fe0ed9ca..a625551ce5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -167,7 +167,7 @@ void migration_incoming_state_destroy(void)
>          mis->from_src_file = NULL;
>      }
>
> -    qemu_event_destroy(&mis->main_thread_load_event);
> +    qemu_event_reset(&mis->main_thread_load_event);
>  }

Is it worth doing more here? For instance:
 * rename the function to something that better reflects
   what it's doing
 * make sure it actually goes back to the state it's in
   after you first call migration_incoming_get_current()
   (eg setting mis_current.state, zeroing various fields)
 * maybe instead of a "get current state" that does a
   reset if it's not been called before and a "destroy"
   that does cleanup stuff (like telling the source we've
   stopped) and also resetting back to clean state, we
   could structure this with a function that does
   "give me a clean completely reset state" which you
   must call first, then use get_current() purely to
   get the current state with no 'reset on first call'
   semantics, and finally a "complete" function that just
   does the "tell source we've stopped" and close
   resources we no longer need  ?

PS, in migration_incoming_get_current() we do
        mis_current.state = MIGRATION_STATUS_NONE;
        memset(&mis_current, 0, sizeof(MigrationIncomingState));

and the first line there is pointless because the memset
blasts zeroes over it anyway.

thanks
-- PMM
