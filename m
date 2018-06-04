Received: from eggs.gnu.org ([2001:4830:134:3::10]:33369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fPqzB-0000x8-Cu
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fPqz6-0002G5-IG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:29 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fPqz6-0002FN-8q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:24 -0400
Received: by mail-wr0-x244.google.com with SMTP id w7-v6so32463957wrn.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:01:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604080630.10946-1-peterx@redhat.com>
References: <20180604080630.10946-1-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Jun 2018 17:01:21 +0200
Message-ID: <CAJ+F1CLkDdMSQ6cyMNv8Gwf1AtdgfKV9Zz-F+ZT=FUVTERuevg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Jun 4, 2018 at 10:06 AM, Peter Xu <peterx@redhat.com> wrote:
> Previously we cleanup the queues when we got CLOSED event.  It was used
> to make sure we won't leftover replies/events of a old client to a new
> client.  Now this patch postpones that until OPENED.
>
> In most cases, it does not really matter much since either way will make
> sure that the new client won't receive unexpected old events/responses.
> However there can be a very rare race condition with the old way when we
> use QMP with stdio and pipelines (which is quite common in iotests).
> The problem is that, we can easily have something like this in scripts:
>
>   cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands
>
> In most cases, a QMP session will be based on a bidirectional
> channel (read/write to a TCP port, for example), so IN and OUT are
> sharing some fundamentally same thing.  However that's untrue for pipes
> above - the IN is the "cat" program, while the "OUT" is directed to the
> "filter_commands" which is actually another process.
>
> Now when we received the CLOSED event, we cleanup the queues (including
> the QMP response queue).  That means, if we kill/stop the "cat" process
> faster than the filter_commands process, the filter_commands process is
> possible to miss some responses/events that should belong to it.
>
> In practise, I encountered a very strange SHUTDOWN event missing when
> running test with iotest 087.  Without this patch, iotest 078 will have
> ~10% chance to miss the SHUTDOWN event and fail when with Out-Of-Band
> enabled:
>
> 087 8s ... - output mismatch (see 087.out.bad)
> --- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18:44:=
22.378982462 +0800
> +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-06-0=
1 18:53:44.267840928 +0800
> @@ -8,7 +8,6 @@
>  {"return": {}}
>  {"error": {"class": "GenericError", "desc": "'node-name' must be specifi=
ed for the root node"}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
>
>  =3D=3D=3D Duplicate ID =3D=3D=3D
> @@ -53,7 +52,6 @@
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
>
> This patch fixes the problem.
>
> Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor.c b/monitor.c
> index 46814af533..6f26108108 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4354,6 +4354,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>
>      switch (event) {
>      case CHR_EVENT_OPENED:
> +        monitor_qmp_cleanup_queues(mon);
>          mon->qmp.commands =3D &qmp_cap_negotiation_commands;
>          monitor_qmp_caps_reset(mon);
>          data =3D get_qmp_greeting(mon);
> @@ -4362,7 +4363,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>          mon_refcount++;
>          break;
>      case CHR_EVENT_CLOSED:
> -        monitor_qmp_cleanup_queues(mon);
>          json_message_parser_destroy(&mon->qmp.parser);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
>          mon_refcount--;
> --
> 2.17.0
>
>

Drawback, we will not clean up pending commands until next client.

Perhaps we could have something more specific to the stdio case (untested):


diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index ebfe54ec70..04a20bc2ed 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -90,4 +90,12 @@ qio_channel_file_new_path(const char *path,
                           mode_t mode,
                           Error **errp);

+/**
+ * qio_channel_file_is_opened:
+ *
+ * Returns: true if the associated file descriptor is valid & opened.
+ */
+bool
+qio_channel_file_is_opened(QIOChannelFile *ioc);
+
 #endif /* QIO_CHANNEL_FILE_H */
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 2c9b2ce567..bf9803b4c9 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -59,7 +59,10 @@ static gboolean fd_chr_read(QIOChannel *chan,
GIOCondition cond, void *opaque)
         chan, (gchar *)buf, len, NULL);
     if (ret =3D=3D 0) {
         remove_fd_in_watch(chr);
-        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        if (!qio_channel_file_is_opened(s->ioc_out)) {
+            /* only send close event if both in & out channels are closed =
*/
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        }
         return FALSE;
     }
     if (ret > 0) {
diff --git a/io/channel-file.c b/io/channel-file.c
index db948abc3e..1a02f99abf 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -63,6 +63,12 @@ qio_channel_file_new_path(const char *path,
     return ioc;
 }

+bool
+qio_channel_file_is_opened(QIOChannelFile *ioc)
+{
+    errno =3D 0;
+    return ioc->fd !=3D -1 && (fcntl(ioc->fd, F_GETFD) !=3D -1 || errno !=
=3D EBADF);
+}

 static void qio_channel_file_init(Object *obj)
 {

--=20
Marc-Andr=C3=A9 Lureau
