Received: from eggs.gnu.org ([2001:4830:134:3::10]:60667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn86c-0000sG-G5
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn86b-0006xz-8x
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:57:22 -0400
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-22-kwolf@redhat.com>
	<fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28f44beb-e19b-3e26-254a-4678eacf30c2@redhat.com>
Date: Tue, 7 Aug 2018 14:57:13 -0500
MIME-Version: 1.0
In-Reply-To: <fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd
 and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 08/06/2018 05:04 PM, Eric Blake wrote:
> On 06/18/2018 11:44 AM, Kevin Wolf wrote:
>> From: Greg Kurz <groug@kaod.org>
>>
>> Removing a drive with drive_del while it is being used to run an I/O
>> intensive workload can cause QEMU to crash.
>>
> ...

>=20
> Test 83 sets up a client that intentionally disconnects at critical=20
> points in the NBD protocol exchange, to ensure that the server reacts=20
> sanely.

Rather, nbd-fault-injector.py is a server that disconnects at critical=20
points, and the test is of client reaction.

>=C2=A0 I suspect that somewhere in the NBD code, the server detects=20
> the disconnect and was somehow calling into blk_remove_bs() (although I=
=20
> could not quickly find the backtrace); and that prior to this patch, th=
e=20
> 'Connection closed' message resulted from other NBD coroutines getting =
a=20
> shot at the (now-closed) connection, while after this patch, the=20
> additional blk_drain() somehow tweaks things in a way that prevents the=
=20
> other NBD coroutines from printing a message.=C2=A0 If so, then the cha=
nge in=20
> 83 reference output is probably intentional, and we should update it.

It seems like this condition is racy, and that the race is more likely=20
to be lost prior to this patch than after. It's a question of whether=20
the client has time to start a request to the server prior to the server=20
hanging up, as the message is generated during=20
nbd_co_do_receive_one_chunk.  Here's a demonstration of the fact that=20
things are racy:

$ git revert f45280cbf
$ make
$ cd tests/qemu-iotests
$ cat fault.txt
[inject-error "a"]
event=3Dneg2
when=3Dafter
$ python nbd-fault-injector.py localhost:10809 ./fault.txt &
Listening on 127.0.0.1:10809
$ ../../qemu-io -f raw nbd://localhost:10809 -c 'r 0 512'
Closing connection on rule match inject-error "a"
Connection closed
read failed: Input/output error
$ python nbd-fault-injector.py localhost:10809 ./fault.txt &
Listening on 127.0.0.1:10809
$ ../../qemu-io -f raw nbd://localhost:10809
Closing connection on rule match inject-error "a"
qemu-io> r 0 512
read failed: Input/output error
qemu-io> q

So, depending on whether the read command is kicked off quickly (via -c)=20
or slowly (via typing into qemu-io) determines whether the message appear=
s.

What's more, in commit f140e300, we specifically called out in the=20
commit message that maybe it was better to trace when we detect=20
connection closed rather than log it to stdout, and in all cases in that=20
commit, the additional 'Connection closed' messages do not add any=20
information to the error message already displayed by the rest of the cod=
e.

I don't know how much the proposed NBD reconnect code will change things=20
in 3.1.  Meanwhile, we've missed any chance for 3.0 to fix test 83.

>=20
> But I'm having a hard time convincing myself that this is the case,=20
> particularly since I'm not even sure how to easily debug the assumption=
s=20
> I made above.
>=20
> Since I'm very weak on the whole notion of what blk_drain() vs.=20
> blk_remove_bs() is really supposed to be doing, and could easily be=20
> persuaded that the change in output is a regression instead of a fix.

At this point, I don't think we have a regression, just merely a bad=20
iotests reference output. The extra blk_drain() merely adds more time=20
before the NBD code can send out its first request, and thus makes it=20
more likely that the fault injector has closed the connection before the=20
read request is issued rather than after (the message only appears when=20
read beats the race), but the NBD code shouldn't be printing the error=20
message in the first place, and 083 needs to be tweaked to remove the=20
noisy lines added in f140e300 (not just the three lines that are=20
reliably different due to this patch, but all other such lines due to=20
strategic server drops at other points in the NBD protocol).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
