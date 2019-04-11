Received: from eggs.gnu.org ([209.51.188.92]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEbXX-0003uI-Vg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEbXW-00043p-V4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEbXW-0003rL-Ck
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F075F30B79E9
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:22:28 +0000 (UTC)
References: <20190411145256.8614-1-armbru@redhat.com>
	<20190411145256.8614-4-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0683b00f-1d17-137b-1273-ba063d0d9dba@redhat.com>
Date: Thu, 11 Apr 2019 17:22:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190411145256.8614-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 11/04/19 16:52, Markus Armbruster wrote:
> char_pty_open() prints a "char device redirected to PTY_NAME (label
> LABEL)" message to the current monitor or else to stderr.  No other
> ChardevClass::open() prints anything on success.  Drop the message.
>=20
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-pty.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b034332edd..a48d3e5d20 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
>      qemu_set_nonblock(master_fd);
> =20
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> -    error_printf("char device redirected to %s (label %s)\n",
> -                 pty_name, chr->label);
> =20
>      s =3D PTY_CHARDEV(chr);
>      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));

The reason for the message is that the char device is completely useless
until the user knows the /dev/pts/N path[1].  You can get it with "info
chardev" (aka query-chardev for QMP) but there's an interesting chicken
and egg problem if the pty is for your monitor...

Paolo

[1] once you know it, you can use the monitor's readline interface with
e.g. "socat STDIO,cfmakeraw FILE:/dev/pts/1"
