Received: from eggs.gnu.org ([209.51.188.92]:59368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEYrv-000371-E0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEYru-0000TC-1B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:31:51 -0400
Received: from forwardcorp1p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b6:217]:44054)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEYrt-0000H5-0j
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:31:49 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190411120421.GP3641@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
MIME-Version: 1.0
Date: Thu, 11 Apr 2019 15:31:43 +0300
Message-Id: <219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>

11.04.2019, 15:04, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> On Wed, Apr 10, 2019 at 12:26:52PM +0300, Yury Kotov wrote:
>> =C2=A0Currently such case is possible for incoming:
>> =C2=A0QMP: add-fd (fdset =3D 0, fd of some file):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adds fd to fdset 0 and returns QEMU's fd=
 (e.g. 33)
>> =C2=A0QMP: migrate-incoming (uri =3D "fd:33"): fd is stored in QIOChan=
nel *ioc
>> =C2=A0...
>> =C2=A0Incoming migration completes and unrefs ioc -> close(33)
>> =C2=A0QMP: remove-fd (fdset =3D 0, fd =3D 33):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0removes fd from fdset 0 and qemu_close()=
 -> close(33) =3D> double close
>
> IMHO this is user error.
>
> You've given the FD to QEMU and told it to use it for migration.
>
> Once you've done that you should not be calling remove-fd.
>
> remove-fd should only be used in some error code path. ie if you
> have called add-fd, and then some failure means you've decided you
> can't invoke 'migrate-incoming'. Now you should call "remove-fd".
>
> AFAIK, we have never documented that 'add-fd' must be paired
> with 'remove-fd'.
>
> IOW, I think this "fix" is in fact not a fix - it is instead
> changing the semantics of when "remove-fd" should be used.
>

I think it might be user's error but fd is still in cur_mon->fds (in getf=
d case)
or in mon_fdsets (in add-fd case). So if fd is still exists in the lists =
why
user can't close/remove it?

So, there are 2 valid options:
1) fd is still valid after migration (dup)
2) fd is closed but also removed from the appropriate list

Regards,
Yury

>> =C2=A0For outgoing migration the case is the same but getfd instead of=
 add-fd.
>> =C2=A0Fix it by duping client's fd.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0migration/fd.c | 39 +++++++++++++++++++++++++++++++-------=
-
>> =C2=A0=C2=A0migration/trace-events | 4 ++--
>> =C2=A0=C2=A02 files changed, 33 insertions(+), 10 deletions(-)
>>
>> =C2=A0diff --git a/migration/fd.c b/migration/fd.c
>> =C2=A0index a7c13df4ad..c9ff07ac41 100644
>> =C2=A0--- a/migration/fd.c
>> =C2=A0+++ b/migration/fd.c
>> =C2=A0@@ -15,6 +15,7 @@
>> =C2=A0=C2=A0=C2=A0*/
>>
>> =C2=A0=C2=A0#include "qemu/osdep.h"
>> =C2=A0+#include "qapi/error.h"
>> =C2=A0=C2=A0#include "channel.h"
>> =C2=A0=C2=A0#include "fd.h"
>> =C2=A0=C2=A0#include "migration.h"
>> =C2=A0@@ -26,15 +27,27 @@
>> =C2=A0=C2=A0void fd_start_outgoing_migration(MigrationState *s, const =
char *fdname, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc;
>> =C2=A0- int fd =3D monitor_get_fd(cur_mon, fdname, errp);
>> =C2=A0+ int fd, dup_fd;
>> =C2=A0+
>> =C2=A0+ fd =3D monitor_get_fd(cur_mon, fdname, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fd =3D=3D -1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0- trace_migration_fd_outgoing(fd);
>> =C2=A0- ioc =3D qio_channel_new_fd(fd, errp);
>> =C2=A0+ /* fd is previously created by qmp command 'getfd',
>> =C2=A0+ * so client is responsible to close it. Dup it to save origina=
l value from
>> =C2=A0+ * QIOChannel's destructor */
>> =C2=A0+ dup_fd =3D qemu_dup(fd);
>> =C2=A0+ if (dup_fd =3D=3D -1) {
>> =C2=A0+ error_setg(errp, "Cannot dup fd %s: %s (%d)", fdname, strerror=
(errno),
>> =C2=A0+ errno);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ trace_migration_fd_outgoing(fd, dup_fd);
>> =C2=A0+ ioc =3D qio_channel_new_fd(dup_fd, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ioc) {
>> =C2=A0- close(fd);
>> =C2=A0+ close(dup_fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -55,14 +68,24 @@ static gboolean fd_accept_incoming_migration=
(QIOChannel *ioc,
>> =C2=A0=C2=A0void fd_start_incoming_migration(const char *infd, Error *=
*errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc;
>> =C2=A0- int fd;
>> =C2=A0+ int fd, dup_fd;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D strtol(infd, NULL, 0);
>> =C2=A0- trace_migration_fd_incoming(fd);
>>
>> =C2=A0- ioc =3D qio_channel_new_fd(fd, errp);
>> =C2=A0+ /* fd is previously created by qmp command 'add-fd' or somethi=
ng else,
>> =C2=A0+ * so client is responsible to close it. Dup it to save origina=
l value from
>> =C2=A0+ * QIOChannel's destructor */
>> =C2=A0+ dup_fd =3D qemu_dup(fd);
>> =C2=A0+ if (dup_fd =3D=3D -1) {
>> =C2=A0+ error_setg(errp, "Cannot dup fd %d: %s (%d)", fd, strerror(err=
no),
>> =C2=A0+ errno);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ trace_migration_fd_incoming(fd, dup_fd);
>> =C2=A0+ ioc =3D qio_channel_new_fd(dup_fd, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ioc) {
>> =C2=A0- close(fd);
>> =C2=A0+ close(dup_fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0diff --git a/migration/trace-events b/migration/trace-events
>> =C2=A0index de2e136e57..d2d30a6b3c 100644
>> =C2=A0--- a/migration/trace-events
>> =C2=A0+++ b/migration/trace-events
>> =C2=A0@@ -258,8 +258,8 @@ migration_exec_outgoing(const char *cmd) "cm=
d=3D%s"
>> =C2=A0=C2=A0migration_exec_incoming(const char *cmd) "cmd=3D%s"
>>
>> =C2=A0=C2=A0# fd.c
>> =C2=A0-migration_fd_outgoing(int fd) "fd=3D%d"
>> =C2=A0-migration_fd_incoming(int fd) "fd=3D%d"
>> =C2=A0+migration_fd_outgoing(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
>> =C2=A0+migration_fd_incoming(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
>>
>> =C2=A0=C2=A0# socket.c
>> =C2=A0=C2=A0migration_socket_incoming_accepted(void) ""
>> =C2=A0--
>> =C2=A02.21.0
>
> Regards,
> Daniel
> --
> |: https://berrange.com -o- https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org -o- https://fstop138.berrange.com :|
> |: https://entangle-photo.org -o- https://www.instagram.com/dberrange :=
|
