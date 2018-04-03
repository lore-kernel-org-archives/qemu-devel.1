Received: from eggs.gnu.org ([2001:4830:134:3::10]:33476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3MPf-0006hh-K4
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3MPb-0000qH-Ji
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:55:51 -0400
Date: Tue, 3 Apr 2018 09:55:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180403135538.GB31365@localhost.localdomain>
References: <20180403110810.25624-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403110810.25624-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] gluster: Fix blockdev-add with
 server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, prasanna.kalever@redhat.com, qemu-devel@nongnu.org

On Tue, Apr 03, 2018 at 01:08:10PM +0200, Kevin Wolf wrote:
> The legacy command line interface gets the socket path from an option
> called 'socket'. QAPI in contract uses SocketAddress, where the
> corresponding option is called 'path'.
> 
> Fix the gluster block driver to accept both 'socket' and 'path', with
> 'path' being the preferred syntax.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1545155
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/gluster.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 296e036b3d..4adc1a875b 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -167,7 +167,12 @@ static QemuOptsList runtime_unix_opts = {
>          {
>              .name = GLUSTER_OPT_SOCKET,
>              .type = QEMU_OPT_STRING,
> -            .help = "socket file path)",
> +            .help = "socket file path (legacy)",
> +        },
> +        {
> +            .name = GLUSTER_OPT_PATH,
> +            .type = QEMU_OPT_STRING,
> +            .help = "socket file path (QAPI)",
>          },
>          { /* end of list */ }
>      },
> @@ -615,10 +620,18 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>                  goto out;
>              }
>  
> -            ptr = qemu_opt_get(opts, GLUSTER_OPT_SOCKET);
> +            ptr = qemu_opt_get(opts, GLUSTER_OPT_PATH);
> +            if (!ptr) {
> +                ptr = qemu_opt_get(opts, GLUSTER_OPT_SOCKET);
> +            } else if (qemu_opt_get(opts, GLUSTER_OPT_SOCKET)) {
> +                error_setg(&local_err,
> +                           "Conflicting parameters 'path' and 'socket'");
> +                error_append_hint(&local_err, GERR_INDEX_HINT, i);
> +                goto out;
> +            }
>              if (!ptr) {
>                  error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_SOCKET);
> +                           GLUSTER_OPT_PATH);
>                  error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                  goto out;
>              }
> @@ -684,7 +697,7 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
>                               "file.server.0.host=1.2.3.4,"
>                               "file.server.0.port=24007,"
>                               "file.server.1.transport=unix,"
> -                             "file.server.1.socket=/var/run/glusterd.socket ..."
> +                             "file.server.1.path=/var/run/glusterd.socket ..."
>                               "\n");
>              return ret;
>          }
> -- 
> 2.13.6
> 
