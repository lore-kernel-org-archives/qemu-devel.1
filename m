Received: from eggs.gnu.org ([2001:4830:134:3::10]:48317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJDu-0003LM-71
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJDq-0002h0-C1
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJJDq-0002gr-5O
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4EA7B1E4C
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 12:41:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-44-marcandre.lureau@redhat.com>
	<87h8zq1ikt.fsf@dusky.pond.sub.org>
	<156294090.32020319.1497003113601.JavaMail.zimbra@redhat.com>
	<1764775958.32020420.1497003321879.JavaMail.zimbra@redhat.com>
Date: Fri, 09 Jun 2017 14:40:57 +0200
In-Reply-To: <1764775958.32020420.1497003321879.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 9 Jun 2017
	06:15:21 -0400 (EDT)")
Message-ID: <87a85hl4fa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> >=20
>> > The title claims "move dump_qobject() from block/ to qobject/", but
>> > that's not what the patch does.  It *replaces* dump_qobject() by
>> > qobject_to_string().  The former dumps to a callback, the latter to a
>> > dynamic string buffer.
>> >=20
>> > Providing dump functionality in one way doesn't preclude the other way:
>> > given callback, one could define a callback that builds up a string
>> > buffer, and given buffer, one could (and you actually do) pass the
>> > buffer to a callback.  That's less efficient, though.
>> >=20
>> > Trading efficiency for ease-of-use should be okay here, but I'm cc'ing
>> > Max and Kevin to double-check.
>>=20
>> I believe convenience is more important than efficiency here. It's easy =
to
>> call qobject_to_string(foo) from gdb for example, with a callback, it's =
less
>> easy.
>>=20
>> (fprintf or monitor_fprintf will both build an internal buffer anyway,
>> efficiency is probably similar)

monitor_vprintf() formats to a dynamic buffer, which it passes to
monitor_puts().  monitor_puts() uses a line buffer.

fprintf() can be unbuffered, line-buffered, or fully buffered.

Converting everything to a string first is different: the string buffer
holds *everything* rather than just a line or some fixed size.

> Hmm, there are more allocations in qobject_to_string() though
