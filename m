Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUoN-0000ik-Oe
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUoM-0000cx-JL
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:48:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-9-git-send-email-armbru@redhat.com>
	<a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
	<f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
	<7165e65d-c9bb-78b6-b286-956f55e2e5da@redhat.com>
Date: Thu, 30 Mar 2017 09:47:54 +0200
In-Reply-To: <7165e65d-c9bb-78b6-b286-956f55e2e5da@redhat.com> (Max Reitz's
	message of "Wed, 29 Mar 2017 22:35:41 +0200")
Message-ID: <87h92bdx3p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-2.9 8/8] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Max Reitz <mreitz@redhat.com> writes:

> On 29.03.2017 22:32, Eric Blake wrote:
>> On 03/29/2017 02:59 PM, Max Reitz wrote:
>>> On 29.03.2017 18:45, Markus Armbruster wrote:
>>>> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
>>>> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
>>>> the QemuOpts parameters for the server address are named.  Fix that.
>>>> While there, rename BlockdevOptionsSheepdog member addr to server, for
>>>> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
>>>> BlockdevOptionsNbd.
>>>>
>>>> Commit 831acdc's example becomes
>>>>
>>>>     --drive driver=3Dsheepdog,server.host=3Dfido,vdi=3Ddolly
>>>>
>>>> instead of
>>>>
>>>>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  block/sheepdog.c     | 18 +++++++++---------
>>>>  qapi/block-core.json |  4 ++--
>>>>  2 files changed, 11 insertions(+), 11 deletions(-)
>>>
>>> OK, so let me get this straight: Before this patch, @addr was advertised
>>> as a runtime parameter that actually wasn't supported at all? (Because I
>>> can't see any place in block/sheepdog.c where it would be parsed.)

Correct.  I messed it up.

>> Both commits mentioned in the commit message are new to 2.9, so we
>> aren't breaking any back-compat, but are avoiding cementing in a mistake.
>>=20
>> Before this patch, @addr was the QMP spelling (inconsistent with all the
>> others, where ssh, gluster, and nbd spelled it @server); and because it
>> was NOT mentioned in the sheepdog.c QemuOpts code, it was impossible to
>> parse it through -drive.  Which means we have a needless difference
>> between -drive and -blockdev-add.

The difference being that -drive actually worked %-}

>> After this patch, it is spelled @server for both -drive and
>> -blockdev-add, and QMP is consistent (both with the QemuOpts code, and
>> with the other network storage drivers).
>
> Yes, right, which is why I agree that in principle this patch is
> necessary for 2.9.
>
>>> This patch now renames @addr to @server and instead of actually parsing
>>> the option, it just removes the so-far convenience[1] options @host,
>>> @port, and @path and just fetches the from @server?
>>=20
>> But the convenience options have not been released, so fixing them now
>> is the right way to go.
>
> Right. My main point was that @server still isn't actually parsed.
>
>>> If that is true, I can't say I like it the least. I guess it works for
>>> 2.9, but there should be a FIXME somewhere in this patch.
>>=20
>> A fixme to what? Unlike patch 7/8 which has to deal with legacy -drive
>> code, here, we have nothing released to break.
>
> A FIXME for parsing @server.

I'm not sure I understand what you mean by "parsing @server".  Care to
suggest a wording and a place for the FIXME comment?

I agree this code will need an update when we wean our internal
interfaces off SocketAddress.

>>> Also, if you set any of server.* in bdrv_parse_filename(), you also have
>>> to set server.type. It's a SocketAddressFlat, .type is a required field.
>>> I know it's just for internal use, but that doesn't change the fact that
>>> it's an invalid SocketAddressFlat object without.

Well, it's a flat QDict, not a SocketAddressFlat.  Is its "server.type"
member unset when nobody's looking?

Permit me to digress.  The block layer's QAPI/QDict/QemuOpts m=C3=A9nage =
=C3=A0
trois is disgusting.  I understand how we got there, but that doesn't
make it less ugly.

Anyway, I'm willing to make bdrv_parse_filename() set "server.type".

Would you like me to require -drive server.type=3D when not using the
pseudo-filename, for consistency with other backends?

>> That part's true. Also, you can't set server.host and server.path at the
>> same time (compare to nbd_process_legacy_socket_options taking pains to
>> make sure that a valid QAPI object is constructed).

sd_open() rejects attempts to set both server.host and server.path.

>>> Max
>>>
>>>
>>> [1] Originally there were apparently introduced for
>>> bdrv_parse_filename() -- but of course you can just use them in -drive
>>> directly...
>>=20
>> There's a difference between the psuedo-file '-drive sheepdog:...'
>> (where you can use them directly, and that doesn't change in this
>> patch), and the structured '-drive driver=3Dsheepdog,...' (which didn't
>> exist before 831acdc, and which we want to match to our QMP).
>>=20
>> I'm in favor of this patch, but think you found a real issue with not
>> constructing a valid qapi object.
>
> I agree that this patch is pretty much OK (and definitely necessary) for
> 2.9, what I'm asking for is some form of acknowledgment that we want to
> actually make @server a valid SocketAddressFlat object and parse it as
> such in 2.10.
