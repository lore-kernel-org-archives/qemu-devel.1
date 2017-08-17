Received: from eggs.gnu.org ([2001:4830:134:3::10]:54034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJQx-0002nx-6j
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJQs-0008RP-9K
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diJQs-0008RC-2k
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D13617DD0A
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:57:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-23-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 13:57:39 +0200
In-Reply-To: <20170727154126.11339-23-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 27 Jul 2017
	17:41:22 +0200")
Message-ID: <87inhmflu4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/26] qapi: make rtc-reset-reinjection
 depend on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json |  3 ++-
>  monitor.c        | 10 ----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 2f4528c769..2361c13fc8 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -6270,7 +6270,8 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'rtc-reset-reinjection' }
> +{ 'command': 'rtc-reset-reinjection',
> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_I386)'] }

Aha, here' you use the list syntax.

And your strategy to keep things compiling also becomes clear: you wrap
uses of poisoned symbols like TARGET_I386 in #if defined(NEED_CPU_H).

Not exactly elegant, but looks workable.  But you need to explain this
solution in commit messages [PATCH 21, I guess] and document it in
qapi-code-gen.txt.  *Unless* we can find a better one.

>=20=20
>  # Rocker ethernet network switch
>  { 'include': 'qapi/rocker.json' }
> diff --git a/monitor.c b/monitor.c
> index 383c84d162..f3dafafa22 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
>   */
>  static void qmp_unregister_commands_hack(void)
>  {
> -#ifndef TARGET_I386
> -    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
> -#endif
>  #ifndef TARGET_S390X
>      qmp_unregister_command(&qmp_commands, "dump-skeys");
>  #endif
> @@ -4151,13 +4148,6 @@ QemuOptsList qemu_mon_opts =3D {
>      },
>  };
>=20=20
> -#ifndef TARGET_I386
> -void qmp_rtc_reset_reinjection(Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
> -}
> -#endif
> -
>  #ifndef TARGET_S390X
>  void qmp_dump_skeys(const char *filename, Error **errp)
>  {
