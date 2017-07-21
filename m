Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYKa-0005yk-Mn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYKZ-0002XY-VB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYKZ-0002W6-PG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3498E46213
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:50:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170720214008.28494-1-eblake@redhat.com>
	<20170720214008.28494-4-eblake@redhat.com>
Date: Fri, 21 Jul 2017 15:50:55 +0200
In-Reply-To: <20170720214008.28494-4-eblake@redhat.com> (Eric Blake's message
	of "Thu, 20 Jul 2017 16:40:07 -0500")
Message-ID: <87shhpj3uo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qtest: Avoid passing raw strings
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

It did in v1, but no more.  Intentional?

> in turn causes gcc to warn about non-literal format strings.  Rather
> than risk an arbitrary string containing % being mis-handled, always
> pass variable strings along with a %s format.  It also makes it
> easier to prove correctness locally, rather than auditing all the
> source strings.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-hmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index d77b3c8710..0af066487c 100644
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
