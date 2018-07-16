Received: from eggs.gnu.org ([2001:4830:134:3::10]:47034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fezZR-0007AV-W0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fezZR-0007s0-4M
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:13:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fezZQ-0007rX-Rq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:13:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id c4-v6so18403106wrs.12
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 02:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716091012.29510-1-armbru@redhat.com>
References: <20180716091012.29510-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Jul 2018 11:13:27 +0200
Message-ID: <CAJ+F1C+PPfy4LQNzFGm6YbMajK62xy04Ao3qBBTcdaOz350w2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: Fix tracepoint crash on JSON
 syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Mon, Jul 16, 2018 at 11:10 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> When tracepoint handle_qmp_command is enabled, we crash on JSON syntax
> errors.  Broken in commit 1cc37471525.  Fix by skipping the tracepoint
> on JSON syntax error.  Before the flawed commit, we skipped it by
> returning early.
>
> Fixes: CID 1394216
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor.c b/monitor.c
> index 7af1f18d13..be29634a00 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4224,7 +4224,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>          qdict_del(qdict, "id");
>      } /* else will fail qmp_dispatch() */
>
> -    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
> +    if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
>          QString *req_json =3D qobject_to_json(req);
>          trace_handle_qmp_command(mon, qstring_get_str(req_json));
>          qobject_unref(req_json);
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
