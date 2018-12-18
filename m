Received: from eggs.gnu.org ([2001:4830:134:3::10]:34955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZLEy-00059q-JG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZLDM-0003kp-0X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:39:36 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZLDL-0003RP-PA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:39:35 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so7903589wmh.0
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 11:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-15-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-15-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Dec 2018 23:39:19 +0400
Message-ID: <CAJ+F1C+1fpOq5zjHd3OWHd6xsn=reRGqWds9=pZ4JzbYDc=oDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/15] qmp: Deprecate query-events
 in favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Dec 18, 2018 at 10:30 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> query-events doesn't reflect compile-time configuration.  Instead of
> fixing that, deprecate the command in favor of query-qmp-schema.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  monitor.c            | 5 +++++
>  qapi/misc.json       | 7 +++++--
>  qemu-deprecated.texi | 5 +++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 967abebcaf..202989fe17 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1099,6 +1099,11 @@ CommandInfoList *qmp_query_commands(Error **errp)
>
>  EventInfoList *qmp_query_events(Error **errp)
>  {
> +    /*
> +     * TODO This deprecated command is the only user of
> +     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,
> +     * they should go, too.
> +     */
>      EventInfoList *info, *ev_list =3D NULL;
>      QAPIEvent e;
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c981008bac..91d5bf6a8a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -318,12 +318,15 @@
>  ##
>  # @query-events:
>  #
> -# Return a list of supported QMP events by this server
> +# Return information on QMP events.
>  #
> -# Returns: A list of @EventInfo for all supported events
> +# Returns: A list of @EventInfo.
>  #
>  # Since: 1.2.0
>  #
> +# Note: This command is deprecated, because its output doesn't reflect
> +# compile-time configuration.  Use query-qmp-schema instead.
> +#
>  # Example:
>  #
>  # -> { "execute": "query-events" }
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index e362d37225..110dfd7a59 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -106,6 +106,11 @@ The ``query-cpus'' command is replaced by the ``quer=
y-cpus-fast'' command.
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.
>
> +@subsection query-events
> +
> +The ``query-events'' command has been superseded by the more powerful
> +and accurate ``query-qmp-schema'' command.
> +
>  @section System emulator human monitor commands
>
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
