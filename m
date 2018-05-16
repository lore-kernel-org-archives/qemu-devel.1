Received: from eggs.gnu.org ([2001:4830:134:3::10]:39999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ4nl-00052o-UC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ4ni-00049K-Ni
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:21:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fJ4ni-000473-Hx
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72787401EF09
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 22:21:31 +0000 (UTC)
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-9-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f80806c-3685-f679-c5af-1ca7a9b0052b@redhat.com>
Date: Wed, 16 May 2018 17:21:30 -0500
MIME-Version: 1.0
In-Reply-To: <1525423069-61903-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 08/11] tests: extend qmp test with
 preconfig checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 05/04/2018 03:37 AM, Igor Mammedov wrote:
> Add permission checks for commands at 'preconfig' stage.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +++ b/tests/qmp-test.c
> @@ -392,6 +392,49 @@ static void add_query_tests(QmpSchema *schema)
>       }
>   }
>   
> +static bool qmp_rsp_is_err(QDict *rsp)
> +{
> +    QDict *error = qdict_get_qdict(rsp, "error");
> +    QDECREF(rsp);
> +    return !!error;

At first glance, I was worried that this was a use-after-free; but as 
you are not actually dereferencing error, but merely checking whether 
the pointer was non-NULL (which works even if the pointer has gone stale 
in the meantime due to the QDECREF), you are okay.

> +}
> +
> +static void test_qmp_preconfig(void)
> +{
> +    QDict *rsp, *ret;
> +    QTestState *qs = qtest_startf("%s --preconfig", common_args);
> +
> +    /* preconfig state */
> +    /* enabled commands, no error expected  */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
> +
> +    /* forbidden commands, expected error */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
> +
> +    /* check that query-status returns preconfig state */
> +    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
> +    ret = qdict_get_qdict(rsp, "return");
> +    g_assert(ret);
> +    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "preconfig");
> +    QDECREF(rsp);
> +
> +    /* exit preconfig state */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    /* check that query-status returns running state */
> +    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
> +    ret = qdict_get_qdict(rsp, "return");
> +    g_assert(ret);
> +    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "running");
> +    QDECREF(rsp);
> +
> +    /* enabled commands, no error expected  */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));

It would also be worth testing that a second exit-preconfig fails, now 
that you are no longer in preconfig state.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
