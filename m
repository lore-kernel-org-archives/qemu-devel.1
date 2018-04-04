Received: from eggs.gnu.org ([2001:4830:134:3::10]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3fEL-0008Nd-1H
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3fEK-0000J7-66
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:01:25 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:50240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f3fEJ-0000Iy-VH
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:01:24 -0400
Received: by mail-wm0-x234.google.com with SMTP id t67so19604998wmt.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:01:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180404093422.GH4467@stefanha-x1.localdomain>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180404093422.GH4467@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Apr 2018 12:01:22 +0200
Message-ID: <CAJ+F1CKcEJYH5Ucx1b2qD5T9rRhRJ9kTvJCUj+nAGeAm3K9kiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/38] RFC: monitor: add asynchronous
 command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Wed, Apr 4, 2018 at 11:34 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> On Mon, Mar 26, 2018 at 05:08:38PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> One of initial design goals of QMP was to have "asynchronous command
>> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
>> goal was not fully achieved, and some broken bits left were removed
>> progressively until commit 65207c59d that removed async command
>> support.
>>
>> Yet there are clear benefits allowing the command handler to re-enter
>> the main loop if the command cannot be handled synchronously, or if it
>> is long-lasting. This is currently not possible and make some bugs
>> such as rhbz#1230527 difficult to solve.  Furthermore, many QMP
>> commands do IO and could be considered 'slow' and blocking the main
>> loop today. The unwritten solution so far is to use a pair of
>> command+event. But this approach has a number of issues, in particular
>> to fix existing commands, and inadequacy since the event is
>> broadcasted and may thus have command 'id' conflict, beside being
>> rather inefficient and incorrect.
>
> This paragraph implies changing the command+event QMP idiom but none of
> the patches touch docs/interop/qmp-spec.txt.  So I guess this new
> revision doesn't modify the QMP protocol anymore and this paragraph is
> outdated?  This revision simply implements async command handlers but
> QMP clients see no protocol change?

Yes, that version of the patch series doesn't provide asynchronous
protocol. The protocol is unchanged. With asynchronous handler, you
don't have to use the cmd+event idiom, unless you want some kind of
asynchronous protocol, with concurrent commands/events - you may still
use oob anyway. I think having a better asynchronous protocol has
merits that would simplify the commands/events&oob situation, but this
is left for another series, when there will be clearer benefits.

> For more complex commands a coroutine would be cleaner than hand-written
> async code.  The handler would look something like:
>
>   QDict * coroutine_fn (*co_cmd)(Monitor *mon,
>                                  const QDict *qdict,
>                                  Error **errp)
>
> The monitor invokes it from coroutine context.  The coroutine just needs
> to return a QDict or set errp - no explicit QmpReturn API is needed.

Right, that would be nice. It should probably be built on top of the
non-coroutine version.

--=20
Marc-Andr=C3=A9 Lureau
