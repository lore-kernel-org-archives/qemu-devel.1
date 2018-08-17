Received: from eggs.gnu.org ([2001:4830:134:3::10]:52544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjGd-0006sV-Jk
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjGZ-0003OZ-Em
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:14:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqjGZ-0003OR-8v
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:14:31 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-60-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbb30b9e-37f9-8ec0-0631-8689d07a7625@redhat.com>
Date: Fri, 17 Aug 2018 13:14:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-60-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 59/60] json: Improve safety of
 qobject_from_jsonf_nofail() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> The JSON parser optionally supports interpolation.  This is used to
> build QObjects by parsing string templates.  The templates are C
> literals, so parse errors (such as invalid interpolation
> specifications) are actually programming errors.  Consequently, the
> functions providing parsing with interpolation
> (qobject_from_jsonf_nofail(), qobject_from_vjsonf_nofail(),
> qdict_from_jsonf_nofail(), qdict_from_vjsonf_nofail()) pass
> &error_abort to the parser.
> 

> Avoid undefined behavior by catching the programming error at run
> time: have the parser recognize and reject '%' in JSON strings.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -205,7 +206,14 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
>                   parse_error(ctxt, token, "invalid escape sequence in string");
>                   goto out;
>               }
> -        } else {
> +            break;
> +        case '%':
> +            if (ctxt->ap) {
> +                parse_error(ctxt, token, "can't interpolate into string");

Do we want to abort() here, to match the fact that all our other 
interpolation functions abort on programmer errors?

> +++ b/tests/check-qjson.c
> @@ -1037,16 +1037,13 @@ static void interpolation_unknown(void)
>   
>   static void interpolation_string(void)
>   {
> -    QLitObject decoded = QLIT_QLIST(((QLitObject[]){
> -            QLIT_QSTR("%s"),
> -            QLIT_QSTR("eins"),
> -            {}}));
> -    QObject *qobj;
> -
> -    /* Dangerous misfeature: % is silently ignored in strings */
> -    qobj = qobject_from_jsonf_nofail("['%s', %s]", "eins", "zwei");
> -    g_assert(qlit_equal_qobject(&decoded, qobj));
> -    qobject_unref(qobj);
> +    if (g_test_subprocess()) {
> +        qobject_from_jsonf_nofail("['%s', %s]", "eins", "zwei");
> +    }
> +    g_test_trap_subprocess(NULL, 0, 0);
> +    g_test_trap_assert_failed();
> +    g_test_trap_assert_stderr("*Unexpected error*"
> +                              "can't interpolate into string*");

Oh, we still abort, but later on in the caller function.

Okay, looks like reasonable handling.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
