Received: from eggs.gnu.org ([2001:4830:134:3::10]:41459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcG4-0000BH-Vp
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcG1-0001DC-SG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:07:48 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:41571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcG1-0001Cw-Nq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:07:45 -0400
Received: by mail-qt0-x233.google.com with SMTP id e19-v6so9947064qtp.8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:07:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf17a832-040c-0581-d1d0-26edb3ba456d@amsat.org>
Date: Thu, 12 Jul 2018 11:07:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/20] libqtest: Simplify qmp_fd_vsend() a
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqtest.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index c2c08a890c..3bfb062fcb 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -488,24 +488,20 @@ QDict *qtest_qmp_receive(QTestState *s)
>   */
>  void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
>  {
> -    va_list ap_copy;
>      QObject *qobj;
>  
> -    /* qobject_from_jsonv() silently eats leading 0xff as invalid
> -     * JSON, but we want to test sending them over the wire to force
> -     * resyncs */
> +    /*
> +     * qobject_from_vjsonf_nofail() chokes on leading 0xff as invalid
> +     * JSON, but tests/test-qga.c needs to send that to test QGA
> +     * synchronization
> +     */
>      if (*fmt == '\377') {
>          socket_send(fd, fmt, 1);
>          fmt++;
>      }
>  
> -    /* Going through qobject ensures we escape strings properly.
> -     * This seemingly unnecessary copy is required in case va_list
> -     * is an array type.
> -     */
> -    va_copy(ap_copy, ap);
> -    qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
> -    va_end(ap_copy);
> +    /* Going through qobject ensures we escape strings properly */
> +    qobj = qobject_from_vjsonf_nofail(fmt, ap);
>  
>      /* No need to send anything for an empty QObject.  */
>      if (qobj) {
> 
