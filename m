Received: from eggs.gnu.org ([2001:4830:134:3::10]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQYub-0007Fl-S7
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQYuY-0004bp-NA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:18:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQYuY-0004ba-Hh
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:18:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D1B5C04B31F
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 12:18:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
Date: Mon, 09 Jan 2017 13:18:47 +0100
In-Reply-To: <20170105135957.12003-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 5 Jan 2017 14:59:57 +0100")
Message-ID: <87zij0mno8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] error: report hints on stderr when no
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Report the error hint when running from the command line and reaching an

Not just any hint, only the ones printed with error_printf_unless_qmp().

> error, ex:
>
> $ qemu-system-x86_64 -m 1Z
> qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
> You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and=
 terabytes.

The last line is due to this patch.

Suggest to rephrase the commit message:

    error: Report certain hints on stderr when no monitor

    Hints printed with error_printf_unless_qmp() are suppressed outside
    monitor context.  Reproducer:

        $ qemu-system-x86_64 -m 1Z
        qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size

    Print to stderr instead.  The reproducer now additionally prints:

        You may use k, M, G or T suffixes for kilobytes, megabytes, gigabyt=
es and terabytes.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/monitor.c b/monitor.c
> index a82f547488..e5cc11b5a5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt, va_l=
ist ap)
>  {
>      if (cur_mon && !monitor_cur_is_qmp()) {
>          monitor_vprintf(cur_mon, fmt, ap);
> +    } else if (!cur_mon) {
> +        vfprintf(stderr, fmt, ap);
>      }
>  }

Preferably with an improved commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
