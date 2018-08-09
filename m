Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlUB-0002aE-AQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlU7-0002W8-4t
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:00:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlU6-0002Vn-VT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:00:15 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f9088ac-b871-f2de-0a7f-223a873d15d8@redhat.com>
Date: Thu, 9 Aug 2018 09:00:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/56] check-qjson: Cover escaped
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> escaped_string() first tests double quoted strings, then repeats a few
> tests with single quotes.  Repeat all of them: store the strings to
> test without quotes, and wrap them in either kind of quote for
> testing.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 94 ++++++++++++++++++++++++++-------------------
>   1 file changed, 55 insertions(+), 39 deletions(-)
> 

>       struct {
> -        const char *encoded;
> -        const char *decoded;
> +        /* Content of JSON string to parse with qobject_from_json() */
> +        const char *json_in;
> +        /* Expected parse output; to unparse with qobject_to_json() */
> +        const char *utf8_out;
>           int skip;

Instead of int skip (and why is that not a bool?), would it be better to 
have an optional const char *json_out?

> +    for (i = 0; test_cases[i].json_in; i++) {
> +        for (j = 0; j < 2; j++) {
> +            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
> +            g_assert_cmpstr(qstring_get_try_str(cstr),
> +                            ==, test_cases[i].utf8_out);
> +            if (test_cases[i].skip == 0) {
> +                jstr = to_json_str(cstr);
> +                g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
> +                g_free(jstr);

and here, write g_assert_cmpstr(jstr, ==, test_cases[i].json_out ?: 
test_cases[i].json_in)?  After all, the reason we're skipping is because 
there are some cases of multiple inputs that get canonicalized to 
constant output, such as " " vs. "\u0020", or "\\'" vs. "'".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
