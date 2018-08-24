Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftKm3-0007bP-1z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftKly-0004Yx-6e
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:41:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ftKlx-0004XQ-TH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FE697DAC2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 22:41:41 +0000 (UTC)
References: <20180816083701.3932-1-armbru@redhat.com>
	<20180816083701.3932-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <caf8057a-b3cf-30c7-f7b0-a8b7fc41cc22@redhat.com>
Date: Fri, 24 Aug 2018 17:41:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180816083701.3932-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/25] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/16/2018 03:36 AM, Markus Armbruster wrote:
> When you build QMP input manually like this
> 
>      cmd = g_strdup_printf("{ 'execute': 'migrate',"
>                            "'arguments': { 'uri': '%s' } }",
>                            uri);
>      rsp = qmp(cmd);
>      g_free(cmd);
> 
> you're responsible for escaping the interpolated values for JSON.  Not
> done here, and therefore works only for sufficiently nice @uri.  For
> instance, if @uri contained a single "'", qobject_from_vjsonf_nofail()
> would abort.  A sufficiently nasty @uri could even inject unwanted
> members into the arguments object.
> 
> Leaving interpolation into JSON to qmp() is more robust:
> 
>      rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
> 
> It's also more concise.
> 
> Clean up the simple cases where we interpolate exactly a JSON value.
> 
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 

> +++ b/tests/test-qga.c

> @@ -446,10 +443,10 @@ static void test_qga_file_ops(gconstpointer fix)
>   
>       enc = g_base64_encode(helloworld, sizeof(helloworld));
>       /* write */
> -    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
> -                          " 'arguments': { 'handle': %" PRId64 ","
> -                          " 'buf-b64': '%s' } }", id, enc);
> -    ret = qmp_fd(fixture->fd, cmd);
> +    ret = qmp_fd(fixture->fd,
> +                 "{'execute': 'guest-file-write',"
> +                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s } }",
> +                 id, enc);

This is a temporary regression of commit 1792d7d0, which affects test 
execution on Mac (with its weird %qd expansion for PRId64). 
Fortunately, you later fix it in commit 41, so I won't be upset if the 
pull request goes through without a v2 that avoids 'git bisect' breaking 
on Mac.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
