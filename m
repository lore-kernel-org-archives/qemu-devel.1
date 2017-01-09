Received: from eggs.gnu.org ([2001:4830:134:3::10]:55272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZmK-0000mm-B9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZmH-0001dJ-34
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:14:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQZmG-0001cd-Ta
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:14:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
	<87zij0mno8.fsf@dusky.pond.sub.org>
	<CAJ+F1CJzGCZt4pHmwOaDXMTg6V2t12Vt4WEcq2p+xbTZ9kCBdA@mail.gmail.com>
Date: Mon, 09 Jan 2017 14:14:18 +0100
In-Reply-To: <CAJ+F1CJzGCZt4pHmwOaDXMTg6V2t12Vt4WEcq2p+xbTZ9kCBdA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 09 Jan 2017
	12:32:19 +0000")
Message-ID: <87y3ykided.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Jan 9, 2017 at 1:23 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Report the error hint when running from the command line and reaching =
an
>>
>> Not just any hint, only the ones printed with error_printf_unless_qmp().
>>
>> > error, ex:
>> >
>> > $ qemu-system-x86_64 -m 1Z
>> > qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
>> > You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes
>> and terabytes.
>>
>> The last line is due to this patch.
>>
>> Suggest to rephrase the commit message:
>>
>>     error: Report certain hints on stderr when no monitor
>>
>>     Hints printed with error_printf_unless_qmp() are suppressed outside
>>     monitor context.  Reproducer:
>>
>>         $ qemu-system-x86_64 -m 1Z
>>         qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
>>
>>     Print to stderr instead.  The reproducer now additionally prints:
>>
>>         You may use k, M, G or T suffixes for kilobytes, megabytes,
>> gigabytes and terabytes.
>>
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  monitor.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/monitor.c b/monitor.c
>> > index a82f547488..e5cc11b5a5 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt,
>> va_list ap)
>> >  {
>> >      if (cur_mon && !monitor_cur_is_qmp()) {
>> >          monitor_vprintf(cur_mon, fmt, ap);
>> > +    } else if (!cur_mon) {
>> > +        vfprintf(stderr, fmt, ap);
>> >      }
>> >  }
>>
>> Preferably with an improved commit message:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Markus, as maintainer of monitor.c, could you take the patch with the
> commit message modified?

Yes.  It's in my error-next branch now.
