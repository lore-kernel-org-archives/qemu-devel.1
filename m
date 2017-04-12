Received: from eggs.gnu.org ([2001:4830:134:3::10]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyJKf-0003zb-1o
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyJKY-0002k4-VB
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:33:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyJKY-0002jw-Lj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:33:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
	<70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
	<87vaq97mxf.fsf@dusky.pond.sub.org>
	<480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com>
Date: Wed, 12 Apr 2017 16:33:07 +0200
In-Reply-To: <480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com> (Eric Blake's
	message of "Wed, 12 Apr 2017 09:03:54 -0500")
Message-ID: <87zifl3dcs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

Eric Blake <eblake@redhat.com> writes:

> On 04/12/2017 08:52 AM, Markus Armbruster wrote:
>>>> In other words, these three signals are polite requests to terminate
>>>> QEMU.
>>>>
>>>> Stefan, are there equivalent requests under Windows?  I guess there
>>>> might be one at least for SIGINT, namely whatever happens when you hit
>>>> ^C on the console.
>>>
>>> Mingw has SIGINT (C99 requires it), and that's presumably what happens
>>> for ^C,...
>>>
>>>>
>>>> Could we arrange to run qemu_system_killed() then?
>>>
>>> ...but I don't know why it is not currently wired up to call
>>> qemu_system_killed(), nor do I have enough Windows programming expertise
>>> to try and write such a patch. But I think that is an orthogonal
>>> improvement.  On the other hand, mingw has a definition for SIGTERM (but
>>> I'm not sure how it gets triggered) and no definition at all for SIGHUP
>>> (as evidenced by the #ifdef'fery in the patch to get it to compile under
>>> docker targetting mingw).
>> 
>> If all we need is distingishing host- and guest-initiated shutdown, then
>> detecting the latter reliably lets us stay away from OS-specific stuff.
>> Can we do that?
>
> I'll simplify what I can; I still can't guarantee that mingw will be
> setting the bool correctly in all cases, but setting a bool is easier
> than trying to set a signal name.
>
>>> There are other reasons too: a guest can request shutdown immediately
>>> before the host sends SIGINT. Based on when things are processed, you
>>> could see either the guest or the host as the initiator.  And the race
>>> is not entirely implausible - when trying to shut down a guest, libvirt
>>> first tries to inform the guest to initiate things (whether by interrupt
>>> or guest agent), but after a given amount of time, assumes the guest is
>>> unresponsive and resorts to a signal to qemu. A heavily loaded guest
>>> that takes its time in responding could easily overlap with the timeout
>>> resorting to a host-side action.
>> 
>> This race doesn't worry me.  If both host and guest have initiated a
>> shutdown, then reporting whichever of the two finishes first seems fair.
>
> So maybe I just tone down the docs and not even mention it.

Works for me.

>> Additional ways to terminate QEMU: HMP and QMP command "quit", and the
>> various GUI controls such "close SDL window".
>
> Good points. I have no idea what exit path those take (if they
> raise(SIGINT) internally, it's quite easy - but if they go through some
> other exit path, then I'll need to wire in something else).

Chasing down all host-initiated terminations looks like a fool's errand
to me.  But if we can reliably detect guest-initiated, we don't have to,
do we?
