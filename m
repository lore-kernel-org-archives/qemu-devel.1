Received: from eggs.gnu.org ([2001:4830:134:3::10]:45739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhVz-0000Y0-85
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhVv-0004U2-Uw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhVv-0004TM-N5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:15 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51121d8e-9e44-e027-a590-b69956531c8f@redhat.com>
Date: Fri, 17 Aug 2018 11:22:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/60] check-qjson: Cover escaped
 characters more thoroughly, part 1
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
> escaped_string() first tests double quoted strings, then repeats a few
> tests with single quotes.  Repeat all of them: store the strings to
> test without quotes, and wrap them in either kind of quote for
> testing.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 96 +++++++++++++++++++++++++++------------------
>   1 file changed, 57 insertions(+), 39 deletions(-)
> 
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 188f683317..2f1890929d 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -22,55 +22,73 @@
>   #include "qapi/qmp/qstring.h"
>   #include "qemu-common.h"
>   
> +static QString *from_json_str(const char *jstr, Error **errp, bool single)

Unusual to put Error **errp in the middle rather than last. Worth 
swapping 'single' to come before 'errp'?

>          int skip;

Pre-existing, but since you are touching this, is it worth making this bool?

> +    for (i = 0; test_cases[i].json_in; i++) {
> +        for (j = 0; j < 2; j++) {
> +            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);

Only one caller to adjust here (and maybe a couple more later in the 
series).

That's bike-shedding, so either way,
Reviewed-by: Eric Blake <eblake@redhat.com>

> +            g_assert_cmpstr(qstring_get_try_str(cstr),
> +                            ==, test_cases[i].utf8_out);
> +            if (test_cases[i].skip == 0) {
> +                jstr = to_json_str(cstr);
> +                g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
> +                g_free(jstr);
> +            }
> +            qobject_unref(cstr);
>           }
> -
> -        qobject_unref(str);
>       }
>   }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
