Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db8dS-0007pX-Cg
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db8dO-0000Z6-CY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db8dO-0000YT-6x
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:01:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725143923.11241-1-den@openvz.org>
Date: Fri, 28 Jul 2017 19:01:00 +0200
In-Reply-To: <20170725143923.11241-1-den@openvz.org> (Denis V. Lunev's message
	of "Tue, 25 Jul 2017 17:39:23 +0300")
Message-ID: <87iniclcmr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr .
	David Alan Gilbert" <dgilbert@redhat.com>

"Denis V. Lunev" <den@openvz.org> writes:

> Calculate req_json only if trace_handle_qmp_command enabled.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
> Changes from v1:
> - written in the explicit for, as discussed in the mailing list
>
>  monitor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index d8ac20f6ca..2bfeb9bbcc 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3822,7 +3822,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>      QDict *qdict =3D NULL;
>      Monitor *mon =3D cur_mon;
>      Error *err =3D NULL;
> -    QString *req_json;
>=20=20
>      req =3D json_parser_parse_err(tokens, NULL, &err);
>      if (!req && !err) {
> @@ -3840,9 +3839,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>          qdict_del(qdict, "id");
>      } /* else will fail qmp_dispatch() */
>=20=20
> -    req_json =3D qobject_to_json(req);
> -    trace_handle_qmp_command(mon, qstring_get_str(req_json));
> -    qobject_decref(QOBJECT(req_json));
> +    if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
> +        QString *req_json =3D qobject_to_json(req);
> +        trace_handle_qmp_command(mon, qstring_get_str(req_json));
> +        qobject_decref(QOBJECT(req_json));
> +    }
>=20=20
>      rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);

Conflicts with Eric's commit 8a4613a, but I can resolve that in my tree.

The commit message is too terse.  "Improve tracing" makes me think of
more informative traces, but that's not the case.  What exactly is
improved here?
