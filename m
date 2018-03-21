Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydH6-0007ia-JW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydH1-0005NC-UT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:55:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eydH1-0005Mf-Ph
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:55:23 -0400
References: <20180321065506.21091-1-peterx@redhat.com>
	<20180321065506.21091-4-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <820c6c94-2b95-0d02-a104-3d70ee76ea37@redhat.com>
Date: Wed, 21 Mar 2018 07:55:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180321065506.21091-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] tests: more strict command batching
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

On 03/21/2018 01:55 AM, Peter Xu wrote:
> Add "id" fields to the commands, and check that the command returns are
> in order.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qmp-test.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

> +++ b/tests/qmp-test.c
> @@ -83,6 +83,7 @@ static void test_qmp_protocol(void)
>       const QListEntry *entry;
>       QString *qstr;
>       int i;
> +    char buf[128];

Eww, we shouldn't need this.

>   
>       qts = qtest_init_without_qmp_handshake(common_args);
>   
> @@ -150,7 +151,10 @@ static void test_qmp_protocol(void)
>        * best-effort test.
>        */
>       for (i = 0; i < 16; i++) {
> -        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
> +        snprintf(buf, sizeof(buf) - 1, "{ 'execute': 'query-version', "
> +                 "'id': %d }", i);
> +        buf[sizeof(buf) - 1] = '\0';
> +        qtest_async_qmp(qts, buf);

snprintf() of JSON strings is prone to failures especially when the JSON 
string is reinterpreted as a printf argument in qtest_async_qmp.  Better 
is to let qtest_async_qmp() directly do the formatting, as in:

qtest_async_qmp(qts, "{ 'execute':'query-version', 'id':%d}", i);

And then I was right - you don't need buf.

Otherwise the addition is good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
