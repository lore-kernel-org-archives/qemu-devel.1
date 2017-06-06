Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEfk-0008KA-FQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEff-0004hx-Lh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:37:24 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:35142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEff-0004hr-HG
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:37:19 -0400
Received: by mail-yb0-x243.google.com with SMTP id p198so3980441yba.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:37:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
	<CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e340cdb9-3c97-8624-81d9-f7888f819a68@amsat.org>
Date: Tue, 6 Jun 2017 10:37:16 -0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP
 socket waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com
Cc: alistair23@gmail.com

On 06/06/2017 08:58 AM, Marc-André Lureau wrote:
> Hi
>
> On Mon, Jun 5, 2017 at 10:37 PM Alistair Francis <
> alistair.francis@xilinx.com> wrote:
>
>> When QEMU is waiting for a TCP socket connection it reports that message as
>> an error. This isn't an error though, so let's change the report to just
>> use qemu_log().
>>
>>
> I don't think this is a good idea, since stdout output my be mixed with
> console or other expected output.
>
> In fact, it used to be on stdout, and got moved to stderr:

This is somehow confusing. I don't think it is worth having another 
qemu_log_stderr() function rather than using error_report() but this 
very call might deserve a comment explaining this unusual use. What do 
you think?

>
> commit fdca2124adc293f84f2b7aaf0df43faa6b6bf420
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Mon Jun 24 08:39:49 2013 +0200
>
>     qemu-char: print notification to stderr
>
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>     Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>     Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> diff --git a/qemu-char.c b/qemu-char.c
> index e3b3224886..371f6308c5 100644
> --- a/qemu-char.c
> +++ b/qemu-char.c
> @@ -2666,8 +2666,8 @@ static CharDriverState *qemu_chr_open_socket_fd(int
> fd, bool do_nodelay,
>      }
>
>      if (is_listen && is_waitconnect) {
> -        printf("QEMU waiting for connection on: %s\n",
> -               chr->filename);
> +        fprintf(stderr, "QEMU waiting for connection on: %s\n",
> +                chr->filename);
>
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  chardev/char-socket.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index ccc499cfa1..a9884fa85b 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -27,6 +27,7 @@
>>  #include "io/channel-tls.h"
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>> +#include "qemu/log.h"
>>  #include "qapi/clone-visitor.h"
>>
>>  #include "chardev/char-io.h"
>> @@ -765,7 +766,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error
>> **errp)
>>       * in TLS and telnet cases, only wait for an accepted socket */
>>      while (!s->ioc) {
>>          if (s->is_listen) {
>> -            error_report("QEMU waiting for connection on: %s",
>> +            qemu_log("QEMU waiting for connection on: %s",
>>                           chr->filename);
>>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true,
>> NULL);
>>              tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
>> --
>> 2.11.0
>>
>>
>> --
> Marc-André Lureau
>
