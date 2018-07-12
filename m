Received: from eggs.gnu.org ([2001:4830:134:3::10]:54649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdeQo-00026X-Ph
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdeQk-0001kV-Qn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:27:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fdeQk-0001jx-M1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52F0B81663FC
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 16:26:58 +0000 (UTC)
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-5-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb32f9bb-3725-22ab-1462-0abac3f76f4f@redhat.com>
Date: Thu, 12 Jul 2018 18:26:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/20] libqtest: Clean up how we read the
 QMP greeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 12.07.2018 13:12, Markus Armbruster wrote:
> qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
> receive the greeting, even though we have qtest_qmp_receive() since
> commit 66e0c7b187e.  Put it to use.
> 
> Bonus: gets rid of an empty format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-zero-length.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 071d7eb7b1..c2c08a890c 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -249,9 +249,11 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
>  QTestState *qtest_init(const char *extra_args)
>  {
>      QTestState *s = qtest_init_without_qmp_handshake(false, extra_args);
> +    QDict *greeting;
>  
>      /* Read the QMP greeting and then do the handshake */
> -    qtest_qmp_discard_response(s, "");
> +    greeting = qtest_qmp_receive(s);
> +    qobject_unref(greeting);
>      qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
>  
>      return s;

I wonder whether we should actually check the greeting for some expected
information? Anyway, that's something for later, and not related to your
patch.

Reviewed-by: Thomas Huth <thuth@redhat.com>
