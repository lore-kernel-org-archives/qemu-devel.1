Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlD8-0004zS-9k
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlD5-0007rd-Lr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:42:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlD5-0007rG-Ev
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:42:39 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36518ac8-f022-c54d-2e57-6a709b3678ce@redhat.com>
Date: Thu, 9 Aug 2018 08:42:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/56] qmp-test: Cover syntax and lexical
 errors
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/libqtest.c | 17 +++++++++++++++++
>   tests/libqtest.h | 11 +++++++++++
>   tests/qmp-test.c | 39 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
> 

> +    /* lexical error: impossible byte outside string */
> +    qtest_qmp_send_raw(qts, "{\xFF");

\xff is an impossible byte inside a string as well; plus it has special 
meaning to at least QMP for commanding a parser reset. Is a better byte 
more appropriate (maybe \x7f), either in replacement to \xff or as an 
additional test?

> +    resp = qtest_qmp_receive(qts);
> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
> +    qobject_unref(resp);
> +    g_assert(recovered(qts));
> +
> +    /* lexical error: impossible byte in string */
> +    qtest_qmp_send_raw(qts, "{'bad \xFF");

Same question about \xff being special as the parser reset command, so 
should we test a different byte instead/as well?

> +    resp = qtest_qmp_receive(qts);
> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
> +    qobject_unref(resp);
> +    g_assert(recovered(qts));
> +
> +    /* lexical error: interpolation */
> +    qtest_qmp_send_raw(qts, "%%p\n");
> +    resp = qtest_qmp_receive(qts);
> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
> +    qobject_unref(resp);
> +    g_assert(recovered(qts));
> +
>       /* Not even a dictionary */
>       resp = qtest_qmp(qts, "null");
>       g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
