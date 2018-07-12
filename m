Received: from eggs.gnu.org ([2001:4830:134:3::10]:41313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcFL-0008BW-6Q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcFI-0000mN-0U
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:07:03 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcFH-0000mA-Qn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:06:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id t79-v6so15455890qke.4
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:06:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23870109-14b6-db8a-e5d8-ac55862ec339@amsat.org>
Date: Thu, 12 Jul 2018 11:06:54 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/20] qobject: New
 qobject_from_vjsonf_nofail(), qdict_from_vjsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> Every printf()-like function sooner or later needs its vprintf()-like
> buddy.  The next commit will need qobject_from_jsonf_nofail()'s buddy,
> and qdict_from_jsonf_nofail()'s buddy will be used later in this
> series.  Add both.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qjson.h |  4 ++++
>  qobject/qjson.c          | 44 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
> index dc509d51ae..0db121bef9 100644
> --- a/include/qapi/qmp/qjson.h
> +++ b/include/qapi/qmp/qjson.h
> @@ -18,8 +18,12 @@ QObject *qobject_from_json(const char *string, Error **errp);
>  QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
>      GCC_FMT_ATTR(1, 0);
>  
> +QObject *qobject_from_vjsonf_nofail(const char *string, va_list)

..., va_list ap)?

> +    GCC_FMT_ATTR(1, 0);
>  QObject *qobject_from_jsonf_nofail(const char *string, ...)
>      GCC_FMT_ATTR(1, 2);
> +QDict *qdict_from_vjsonf_nofail(const char *string, va_list ap)
> +    GCC_FMT_ATTR(1, 0);
>  QDict *qdict_from_jsonf_nofail(const char *string, ...)
>      GCC_FMT_ATTR(1, 2);
>  
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 4a9dcff343..2e450231ff 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -59,6 +59,25 @@ QObject *qobject_from_json(const char *string, Error **errp)
>      return qobject_from_jsonv(string, NULL, errp);
>  }
>  
> +/*
> + * Parse @string as JSON value with %-escapes interpolated.
> + * Abort on error.  Do not use with untrusted @string.
> + * Return the resulting QObject.  It is never null.
> + */
> +QObject *qobject_from_vjsonf_nofail(const char *string, va_list ap)
> +{
> +    va_list ap_copy;
> +    QObject *obj;
> +
> +    /* va_copy() is needed when va_list is an array type */
> +    va_copy(ap_copy, ap);
> +    obj = qobject_from_jsonv(string, &ap_copy, &error_abort);
> +    va_end(ap_copy);
> +
> +    assert(obj);
> +    return obj;
> +}
> +
>  /*
>   * Parse @string as JSON value with %-escapes interpolated.
>   * Abort on error.  Do not use with untrusted @string.
> @@ -70,13 +89,26 @@ QObject *qobject_from_jsonf_nofail(const char *string, ...)
>      va_list ap;
>  
>      va_start(ap, string);
> -    obj = qobject_from_jsonv(string, &ap, &error_abort);
> +    obj = qobject_from_vjsonf_nofail(string, ap);
>      va_end(ap);
>  
> -    assert(obj);
>      return obj;
>  }
>  
> +/*
> + * Parse @string as JSON object with %-escapes interpolated.
> + * Abort on error.  Do not use with untrusted @string.
> + * Return the resulting QDict.  It is never null.
> + */
> +QDict *qdict_from_vjsonf_nofail(const char *string, va_list ap)
> +{
> +    QDict *qdict;
> +
> +    qdict = qobject_to(QDict, qobject_from_vjsonf_nofail(string, ap));
> +    assert(qdict);
> +    return qdict;
> +}
> +
>  /*
>   * Parse @string as JSON object with %-escapes interpolated.
>   * Abort on error.  Do not use with untrusted @string.
> @@ -84,15 +116,13 @@ QObject *qobject_from_jsonf_nofail(const char *string, ...)
>   */
>  QDict *qdict_from_jsonf_nofail(const char *string, ...)
>  {
> -    QDict *obj;
> +    QDict *qdict;
>      va_list ap;
>  
>      va_start(ap, string);
> -    obj = qobject_to(QDict, qobject_from_jsonv(string, &ap, &error_abort));
> +    qdict = qdict_from_vjsonf_nofail(string, ap);
>      va_end(ap);
> -
> -    assert(obj);
> -    return obj;
> +    return qdict;
>  }
>  
>  typedef struct ToJsonIterState
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
