Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuQ0-0005tB-5B
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuPv-0002dn-32
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:09:08 -0500
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuPu-0002d0-UI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:09:03 -0500
Received: by mail-qt0-x22a.google.com with SMTP id 33so13159918qtv.1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:09:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-9-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b727c525-2ce0-8542-a990-e90543f62ad7@amsat.org>
Date: Fri, 15 Dec 2017 15:08:50 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/13] tests: fix migration-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> Direct leak of 12 byte(s) in 2 object(s) allocated from:
>     #0 0x7f50d403c850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f50d1ddf98f in vasprintf (/lib64/libc.so.6+0x8098f)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3257..799e24ebc6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
>                                      const char *value)
>  {
>      QDict *rsp, *rsp_return;
> -    const char *result;
> +    char *result;
>  
>      rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
>      rsp_return = qdict_get_qdict(rsp, "return");
>      result = g_strdup_printf("%" PRId64,
>                               qdict_get_try_int(rsp_return,  parameter, -1));
>      g_assert_cmpstr(result, ==, value);
> +    g_free(result);
>      QDECREF(rsp);
>  }
>  
> 
