Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSr9W-0004UH-7K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSr9V-0000YD-Ai
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:20:50 -0500
Date: Fri, 30 Nov 2018 22:20:43 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130222043.GZ27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/14] nbd/client: More consistent error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Fri, Nov 30, 2018 at 04:03:31PM -0600, Eric Blake wrote:
> Consolidate on using decimal (not hex) and on outputting the
> option reply name (not just value) when the client reports
> protocol discrepancies from the server.  While it won't affect
> normal operation, it makes debugging additions easier.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index b4d457a19ad..b667a1b56fd 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -132,8 +132,9 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
>          return -1;
>      }
>      if (reply->option != opt) {
> -        error_setg(errp, "Unexpected option type %x expected %x",
> -                   reply->option, opt);
> +        error_setg(errp, "Unexpected option type %u (%s) expected %u (%s)",
> +                   reply->option, nbd_opt_lookup(reply->option),
> +                   opt, nbd_opt_lookup(opt));
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }
> @@ -265,8 +266,9 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
>          }
>          return 0;
>      } else if (reply.type != NBD_REP_SERVER) {
> -        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
> -                   reply.type, NBD_REP_SERVER);
> +        error_setg(errp, "Unexpected reply type %u (%s) expected %u (%s)",
> +                   reply.type, nbd_rep_lookup(reply.type),
> +                   NBD_REP_SERVER, nbd_rep_lookup(NBD_REP_SERVER));
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }
> @@ -378,9 +380,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>              return 1;
>          }
>          if (reply.type != NBD_REP_INFO) {
> -            error_setg(errp, "unexpected reply type %" PRIu32
> -                       " (%s), expected %u",
> -                       reply.type, nbd_rep_lookup(reply.type), NBD_REP_INFO);
> +            error_setg(errp, "unexpected reply type %u (%s), expected %u (%s)",
> +                       reply.type, nbd_rep_lookup(reply.type),
> +                       NBD_REP_INFO, nbd_rep_lookup(NBD_REP_INFO));
>              nbd_send_opt_abort(ioc);
>              return -1;
>          }
> @@ -704,8 +706,9 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>      }
> 
>      if (reply.type != NBD_REP_ACK) {
> -        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
> -                   reply.type, NBD_REP_ACK);
> +        error_setg(errp, "Unexpected reply type %u (%s) expected %u (%s)",
> +                   reply.type, nbd_rep_lookup(reply.type),
> +                   NBD_REP_ACK, nbd_rep_lookup(NBD_REP_ACK));
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }

The NBD protocol doc seems to use integers pretty consistently (and
certainly not "bare" hex numbers).  Obviously having the mnemonic name
too is helpful.  So:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
