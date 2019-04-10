Received: from eggs.gnu.org ([209.51.188.92]:38207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEDjM-0001jb-Hf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 09:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEDjK-0004wf-Sp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 09:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEDjK-0004vh-GR
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 09:57:34 -0400
Date: Wed, 10 Apr 2019 14:57:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190410135725.GE2980@work-vm>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>, armbru@redhat.com, berrange@redhat.com
Cc: Juan Quintela <quintela@redhat.com>, yc-core@yandex-team.ru, qemu-devel@nongnu.org

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Currently such case is possible for incoming:
> QMP: add-fd (fdset = 0, fd of some file):
>     adds fd to fdset 0 and returns QEMU's fd (e.g. 33)
> QMP: migrate-incoming (uri = "fd:33"): fd is stored in QIOChannel *ioc
> ...
> Incoming migration completes and unrefs ioc -> close(33)
> QMP: remove-fd (fdset = 0, fd = 33):
>     removes fd from fdset 0 and qemu_close() -> close(33) => double close

Well spotted! That would very rarely cause a problem, but is a race.

> For outgoing migration the case is the same but getfd instead of add-fd.
> Fix it by duping client's fd.
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

Note your patch hit a problem building on windows; I don't think we have
a qemu_dup for windows.

However, I think this problem is wider than just migration.
For example, I see that dump.c also uses monitor_get_fd, and it's
dump_cleanup also does a close on the fd. So I guess it hits the same
problem?
Also, qmp.c in qmp_add_client does a close on the fd in some error cases
(I've not followed the normal case).

So perhaps all the users of monitor_get_fd are hitting this problem.

Should we be doing the dup in monitor_get_fd?

Dave


> ---
>  migration/fd.c         | 39 +++++++++++++++++++++++++++++++--------
>  migration/trace-events |  4 ++--
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index a7c13df4ad..c9ff07ac41 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "channel.h"
>  #include "fd.h"
>  #include "migration.h"
> @@ -26,15 +27,27 @@
>  void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
>  {
>      QIOChannel *ioc;
> -    int fd = monitor_get_fd(cur_mon, fdname, errp);
> +    int fd, dup_fd;
> +
> +    fd = monitor_get_fd(cur_mon, fdname, errp);
>      if (fd == -1) {
>          return;
>      }
>  
> -    trace_migration_fd_outgoing(fd);
> -    ioc = qio_channel_new_fd(fd, errp);
> +    /* fd is previously created by qmp command 'getfd',
> +     * so client is responsible to close it. Dup it to save original value from
> +     * QIOChannel's destructor */
> +    dup_fd = qemu_dup(fd);
> +    if (dup_fd == -1) {
> +        error_setg(errp, "Cannot dup fd %s: %s (%d)", fdname, strerror(errno),
> +                   errno);
> +        return;
> +    }
> +
> +    trace_migration_fd_outgoing(fd, dup_fd);
> +    ioc = qio_channel_new_fd(dup_fd, errp);
>      if (!ioc) {
> -        close(fd);
> +        close(dup_fd);
>          return;
>      }
>  
> @@ -55,14 +68,24 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>  void fd_start_incoming_migration(const char *infd, Error **errp)
>  {
>      QIOChannel *ioc;
> -    int fd;
> +    int fd, dup_fd;
>  
>      fd = strtol(infd, NULL, 0);
> -    trace_migration_fd_incoming(fd);
>  
> -    ioc = qio_channel_new_fd(fd, errp);
> +    /* fd is previously created by qmp command 'add-fd' or something else,
> +     * so client is responsible to close it. Dup it to save original value from
> +     * QIOChannel's destructor */
> +    dup_fd = qemu_dup(fd);
> +    if (dup_fd == -1) {
> +        error_setg(errp, "Cannot dup fd %d: %s (%d)", fd, strerror(errno),
> +                   errno);
> +        return;
> +    }
> +
> +    trace_migration_fd_incoming(fd, dup_fd);
> +    ioc = qio_channel_new_fd(dup_fd, errp);
>      if (!ioc) {
> -        close(fd);
> +        close(dup_fd);
>          return;
>      }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index de2e136e57..d2d30a6b3c 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -258,8 +258,8 @@ migration_exec_outgoing(const char *cmd) "cmd=%s"
>  migration_exec_incoming(const char *cmd) "cmd=%s"
>  
>  # fd.c
> -migration_fd_outgoing(int fd) "fd=%d"
> -migration_fd_incoming(int fd) "fd=%d"
> +migration_fd_outgoing(int fd, int dup_fd) "fd=%d dup_fd=%d"
> +migration_fd_incoming(int fd, int dup_fd) "fd=%d dup_fd=%d"
>  
>  # socket.c
>  migration_socket_incoming_accepted(void) ""
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
