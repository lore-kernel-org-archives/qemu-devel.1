Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1cjgtW-0006IE-HO
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1cjgtS-00084G-NO
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:40:50 -0500
Date: Thu, 2 Mar 2017 22:40:35 -0800
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170303064035.GR16140@ndevos-x240.usersys.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-11-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488491046-2549-11-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/15] gluster: Drop
 assumptions on SocketTransport names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, qemu-block@nongnu.org, namei.unix@gmail.com

On Thu, Mar 02, 2017 at 10:44:01PM +0100, Markus Armbruster wrote:
> qemu_gluster_glfs_init() passes the names of QAPI enumeration type
> SocketTransport to glfs_set_volfile_server().  Works, because they
> were chosen to match.  But the coupling is artificial.  Use the
> appropriate literal strings instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 56b4abe..7236d59 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -412,8 +412,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
>  
>      for (server = gconf->server; server; server = server->next) {
>          if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
> -            ret = glfs_set_volfile_server(glfs,
> -                                   GlusterTransport_lookup[server->value->type],
> +            ret = glfs_set_volfile_server(glfs, "unix",
>                                     server->value->u.q_unix.path, 0);
>          } else {
>              if (parse_uint_full(server->value->u.tcp.port, &port, 10) < 0 ||
> @@ -423,8 +422,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
>                  errno = EINVAL;
>                  goto out;
>              }
> -            ret = glfs_set_volfile_server(glfs,
> -                                   GlusterTransport_lookup[server->value->type],
> +            ret = glfs_set_volfile_server(glfs, "tcp",
>                                     server->value->u.tcp.host,
>                                     (int)port);
>          }
> -- 
> 2.7.4

Instead of the strings for "unix" and "tcp", I would have liked
#define's. Unfortunately it seems that these are not available in public
headers :-/

If this is easier to understand, I don't have any objections.

Reviewed-by: Niels de Vos <ndevos@redhat.com>
