Received: from eggs.gnu.org ([209.51.188.92]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhiE-0005lu-1Y
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhiD-0006I5-A9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:19:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grhiD-0006I1-6O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:19:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so11444185qtb.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-17-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-17-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 12:19:10 +0100
Message-ID: <CAMxuvaxV3dugCXy6L+pPHXqVMozYC020zsL=MxH+gRVECY7q2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/17] qmp: Deprecate query-events in
 favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi
On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> query-events doesn't reflect compile-time configuration.  Instead of
> fixing that, deprecate the command in favor of query-qmp-schema.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

sounds good to me (regardless on when the command is actually removed,
depending on libvirt needs).

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  monitor.c            | 5 +++++
>  qapi/misc.json       | 7 +++++--
>  qemu-deprecated.texi | 5 +++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index eeec289aae..9f27621ed1 100644
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
> index 82f9147353..98f59f828a 100644
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
> index 9cc20b365c..3288e102d6 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -103,6 +103,11 @@ Use ``device_add'' for hotplugging vCPUs instead of =
``cpu-add''.  See
>  documentation of ``query-hotpluggable-cpus'' for additional
>  details.
>
> +@subsection query-events (since 4.0)
> +
> +The ``query-events'' command has been superseded by the more powerful
> +and accurate ``query-qmp-schema'' command.
> +
>  @section Human Monitor Protocol (HMP) commands
>
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
> --
> 2.17.2
>
