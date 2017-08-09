Received: from eggs.gnu.org ([2001:4830:134:3::10]:59276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfTOO-0007zq-T0
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfTOL-0005Lr-NR
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfTOL-0005Le-FY
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5371A1024B5
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 15:59:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-20-eblake@redhat.com>
Date: Wed, 09 Aug 2017 17:59:25 +0200
In-Reply-To: <20170804012551.2714-20-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:48 -0500")
Message-ID: <87o9ron34y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 19/22] libqtest: Add qmp_args_dict()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> Leaving interpolation into JSON to qobject_from_jsonf() is more
> robust than building QMP input manually; however, we have a few
> places where code is already creating a QDict to interpolate
> individual arguments, which cannot be reproduced with the
> qobject_from_jsonf() parser.  Expose a public wrapper
> qmp_args_dict() for the internal helper qmp_args_dict_async()
> that we needed earlier for qmp_args(), and fix a test to use
> the new helper.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               | 9 +++++++++
>  tests/libqtest.c               | 6 ++++++
>  tests/device-introspect-test.c | 3 +--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 86ca7fa581..193adf1eb9 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -499,6 +499,15 @@ QDict *qmp_cmd(const char *cmd);
>  void qmp_cmd_async(const char *cmd);
>
>  /**
> + * qmp_args_dict:
> + * @cmd: QMP command to send to QEMU.
> + * @args: Arguments for the command; will have reference count reduced.
> + *
> + * Sends a QMP message to QEMU and returns the response.
> + */
> +QDict *qmp_args_dict(const char *cmd, QDict *args);
> +
> +/**
>   * qmp_args:
>   * @cmd: QMP command to send to QEMU.
>   * @fmt...: Arguments for the command; formats arguments through
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 49786cf2d7..5012ecf929 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -875,6 +875,12 @@ static void qmp_args_dict_async(const char *cmd, QDict *args)
>      qtest_qmp_send(global_qtest, "{'execute':%s, 'arguments':%p}", cmd, args);
>  }
>
> +QDict *qmp_args_dict(const char *cmd, QDict *args)
> +{
> +    qmp_args_dict_async(cmd, args);
> +    return qtest_qmp_receive(global_qtest);
> +}
> +
>  QDict *qmp_args(const char *cmd, const char *fmt, ...)
>  {
>      va_list ap;
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
> index e1fcd3b6c6..d2de4a5fc0 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -36,8 +36,7 @@ static QList *qom_list_types(const char *implements, bool abstract)
>      if (implements) {
>          qdict_put_str(args, "implements", implements);
>      }
> -    resp = qmp("{'execute': 'qom-list-types',"
> -               " 'arguments': %p }", args);
> +    resp = qmp_args_dict("qom-list-types", args);
>      g_assert(qdict_haskey(resp, "return"));
>      ret = qdict_get_qlist(resp, "return");
>      QINCREF(ret);

If we had five of these, the helper would be worth its keep.
