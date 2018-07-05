Received: from eggs.gnu.org ([2001:4830:134:3::10]:44712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2Y0-0001WA-7z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2Xv-0003Dj-A9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:35:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb2Xv-0003C6-4j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:35:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-8-marcandre.lureau@redhat.com>
Date: Thu, 05 Jul 2018 13:35:33 +0200
In-Reply-To: <20180326150916.9602-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 26 Mar 2018 17:08:45 +0200")
Message-ID: <87o9fl9apm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/38] json-parser: always set an error
 if return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Let's make json_parser_parse_err() suck less, and simplify caller
> error handling.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c             | 4 ----
>  qobject/json-parser.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 5889a32231..e9d0c4d172 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4053,10 +4053,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      QMPRequest *req_obj;
>=20=20
>      req =3D json_parser_parse_err(tokens, NULL, &err);
> -    if (!req && !err) {
> -        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
> -        error_setg(&err, QERR_JSON_PARSING);
> -    }
>      if (err) {
>          goto err;
>      }
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 769b960c9f..c39cd8e4d7 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -591,7 +591,12 @@ QObject *json_parser_parse_err(GQueue *tokens, va_li=
st *ap, Error **errp)
>=20=20
>      result =3D parse_value(ctxt, ap);
>=20=20
> -    error_propagate(errp, ctxt->err);
> +    if (!result && !ctxt->err) {
> +        /* TODO: improve error reporting */
> +        error_setg(errp, "Failed to parse JSON");
> +    } else {
> +        error_propagate(errp, ctxt->err);
> +    }
>=20=20
>      parser_context_free(ctxt);

I'd be tempted to put more colorful language in that comment ;)

You update just one caller.  Let's review the other ones:

* qga/main.c process_event()

    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err));
    if (err || !qdict) {
        qobject_unref(qdict);
        qdict =3D qdict_new();
        if (!err) {
            g_warning("failed to parse event: unknown error");
            error_setg(&err, QERR_JSON_PARSING);
        } else {
            g_warning("failed to parse event: %s", error_get_pretty(err));
        }
        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
        error_free(err);
    }

  The if (!err) conditional is now dead.  Please drop it.

* qobject/json-parser.c json_parser_parse()

  Ignores the error.  Okay.

* qobject/qjson.c qobject_from_jsonv() via parse_json()

  - qobject_from_json()

    ~ block.c parse_json_filename()

        options_obj =3D qobject_from_json(filename, errp);
        if (!options_obj) {
            /* Work around qobject_from_json() lossage TODO fix that */
            if (errp && !*errp) {
                error_setg(errp, "Could not parse the JSON options");
                return NULL;
            }
            error_prepend(errp, "Could not parse the JSON options: ");
            return NULL;
        }

      The work-around is now dead.  Please drop it.

    ~ More callers, please review them.

  - qobject_from_jsonf()

        va_start(ap, string);
        obj =3D qobject_from_jsonv(string, &ap, &error_abort);
        va_end(ap);

        assert(obj !=3D NULL);

    Now dies in error_handle_fatal() instead of the assertion.  Okay.

  - tests/libqtest.c qmp_fd_sendv()

    Passes &error_abort, does nothing when qobject_from_jsonv() returns
    null.  Your fix makes this catch invalid JSON instead of silently
    ignoring it.  Good, but please mention it in the commit message.

  - tests/test-qobject-input-visitor.c
    visitor_input_test_init_internal()

    Like qobject_from_jsonf().  Okay.
