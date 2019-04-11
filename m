Received: from eggs.gnu.org ([209.51.188.92]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEblT-0007s2-5p
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEblP-0006tP-De
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEblM-0006s6-Kq
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:37:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DC02C033499
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:37:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
	<20190411145256.8614-4-armbru@redhat.com>
	<0683b00f-1d17-137b-1273-ba063d0d9dba@redhat.com>
Date: Thu, 11 Apr 2019 17:37:11 +0200
In-Reply-To: <0683b00f-1d17-137b-1273-ba063d0d9dba@redhat.com> (Paolo
	Bonzini's message of "Thu, 11 Apr 2019 17:22:20 +0200")
Message-ID: <87tvf4v9i0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/04/19 16:52, Markus Armbruster wrote:
>> char_pty_open() prints a "char device redirected to PTY_NAME (label
>> LABEL)" message to the current monitor or else to stderr.  No other
>> ChardevClass::open() prints anything on success.  Drop the message.
>>=20
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  chardev/char-pty.c | 2 --
>>  1 file changed, 2 deletions(-)
>>=20
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index b034332edd..a48d3e5d20 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
>>      qemu_set_nonblock(master_fd);
>>=20=20
>>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
>> -    error_printf("char device redirected to %s (label %s)\n",
>> -                 pty_name, chr->label);
>>=20=20
>>      s =3D PTY_CHARDEV(chr);
>>      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
>
> The reason for the message is that the char device is completely useless
> until the user knows the /dev/pts/N path[1].  You can get it with "info
> chardev" (aka query-chardev for QMP) but there's an interesting chicken
> and egg problem if the pty is for your monitor...
>
> Paolo

During review of v1, I wrote:

    If we should decide the message is still useful enough to be worth
    keeping, I could direct it to stdout instead of dropping it.

No clear conclusion emerged, so I did nothing for v2.  If we conclude to
keep the message now, I'll gladly do that.

> [1] once you know it, you can use the monitor's readline interface with
> e.g. "socat STDIO,cfmakeraw FILE:/dev/pts/1"

There's also

    $ socat UNIX:/path/to/socket READLINE,history=3D$HOME/.hmp_history,prom=
pt=3D'(qemu) '

Lacks completion.  But then our very own reimplementation of readline
lacks any number of other features.
