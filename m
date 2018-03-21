Received: from eggs.gnu.org ([2001:4830:134:3::10]:58804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eynDk-0007p0-Gn
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 19:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eynDj-00010M-Ff
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 19:32:40 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eynDj-0000zi-8I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 19:32:39 -0400
Received: by mail-wm0-x236.google.com with SMTP id 139so12889722wmn.2
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 16:32:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3e0a2365-a90e-3798-2c73-70ef2df67977@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+3f9RAC86YxRuvGWbX1tegA01iaY760yLOB2W5OyHaNA@mail.gmail.com>
	<20180321200933.GB3466@work-vm>
	<3e0a2365-a90e-3798-2c73-70ef2df67977@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Mar 2018 00:32:36 +0100
Message-ID: <CAJ+F1C+mcAxMVGXzYhbOoh932rKkEue22rk0ApqMHuOqbDDNGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Mar 21, 2018 at 9:33 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/21/2018 03:09 PM, Dr. David Alan Gilbert wrote:
>
>>>>
>>>> So the parsing job and the dispatching job is isolated now.  It gives =
us
>>>> a chance in following up patches to totally move the parser outside.
>>>>
>>>> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH is
>>>> used for all the monitors.
>>>>
>
>>>> +
>>>> +    /*
>>>> +     * If OOB is not enabled on current monitor, we'll emulate the ol=
d
>>>> +     * behavior that we won't process current monitor any more until
>>>> +     * it is responded.  This helps make sure that as long as OOB is
>>>> +     * not enabled, the server will never drop any command.
>>>> +     */
>>>> +    if (!qmp_oob_enabled(mon)) {
>>>> +        monitor_suspend(mon);
>>>> +        req_obj->need_resume =3D true;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Put the request to the end of queue so that requests will be
>>>> +     * handled in time order.  Ownership for req_obj, req, id,
>>>
>>>
>>> I think the order is not respected if subsequent messages have errors
>>> (in either json parsing, dispatch_check_obj, oob_check). So if I
>>> enable oob, and queue a few command, then send a bad command/message,
>>> I won't be able to tell for which command.
>>
>>
>> Doesn't OOB insist on having an ID field with the command?
>
>
> OOB insists on an id field - but there is the situation that SOME errors
> occur even before the id field has been encountered (for example, if you
> send non-JSON, the parser gets all confused - it has to emit SOME error, =
but
> that error can't refer to an id because it wasn't able to parse one yet).=
  A
> well-formed client will never do this, but we MUST be robust even in the
> face of a malicious client (or even a well-intentioned client but a noisy
> communication medium that manages to corrupt bytes). I'm not sure if the
> testsuite adequately covers what happens in this scenario.  Peter?

I think a solution would be to queue the error reply (the reply only)
instead of replying directly.

Another problem I see with the current solution is that pending
commands are not discarded when a new client connects. So I suppose a
new client can receive replies for commands it didn't make, with id
namespace that may conflict with its own. breaking ordering etc. A
possible solution is to mark the pending request to not send the reply
somehow?


--=20
Marc-Andr=C3=A9 Lureau
