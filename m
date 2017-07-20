Received: from eggs.gnu.org ([2001:4830:134:3::10]:60253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY8JF-0002J6-Uv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY8JF-0005K4-4T
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dY8JE-0005Jp-Up
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D218385A07
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 10:03:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-5-eblake@redhat.com>
Date: Thu, 20 Jul 2017 12:03:50 +0200
In-Reply-To: <20170714190827.4083-5-eblake@redhat.com> (Eric Blake's message
	of "Fri, 14 Jul 2017 14:08:26 -0500")
Message-ID: <87a83zmnll.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] qtest: Avoid passing raw strings
 through hmp()
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

> The next patch will add __attribute__((__format__)) to hmp(), which
> in turn causes gcc to warn about non-literal format strings.  Rather
> than risk an arbitrary string containing % being mis-handled, always
> pass variable strings along with a %s format.

More importantly (for me), "%s" makes correctness locally obvious.
Before the patch, I have to prove the argument can't contain '%'.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/test-hmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index d77b3c8..0af0664 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -80,7 +80,7 @@ static void test_commands(void)
>          if (verbose) {
>              fprintf(stderr, "\t%s\n", hmp_cmds[i]);
>          }
> -        response = hmp(hmp_cmds[i]);
> +        response = hmp("%s", hmp_cmds[i]);
>          g_free(response);
>      }
>
> @@ -103,7 +103,7 @@ static void test_info_commands(void)
>          if (verbose) {
>              fprintf(stderr, "\t%s\n", info);
>          }
> -        resp = hmp(info);
> +        resp = hmp("%s", info);
>          g_free(resp);
>          /* And move forward to the next line */
>          info = strchr(endp + 1, '\n');

Reviewed-by: Markus Armbruster <armbru@redhat.com>
