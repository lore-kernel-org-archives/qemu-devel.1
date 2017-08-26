Received: from eggs.gnu.org ([2001:4830:134:3::10]:46451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dlbYf-0001Hn-Ly
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 09:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dlbYc-0007ON-JY
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 09:55:29 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dlbYc-0007Nt-De
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 09:55:26 -0400
Received: by mail-pg0-x242.google.com with SMTP id t3so2819506pgt.5
	for <qemu-devel@nongnu.org>; Sat, 26 Aug 2017 06:55:23 -0700 (PDT)
Date: Sat, 26 Aug 2017 22:55:19 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170826135519.GC2587@lianli.shorne-pla.net>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825141940.20740-2-dgilbert@redhat.com>
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, mreitz@redhat.com, peterx@redhat.com, lvivier@redhat.com

On Fri, Aug 25, 2017 at 03:19:39PM +0100, Dr. David Alan Gilbert (git) wrote:
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
>  
>  static void migrate_generate_event(int new_state)

For what its worth:

Tested-by: Stafford Horne <shorne@gmail.com>

Thanks, I saw the mail from Peter as well, I agree it makes sense to not
call the parent method destroy.  But this works for me at the moment.

-Stafford
