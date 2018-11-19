Received: from eggs.gnu.org ([2001:4830:134:3::10]:44798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOkT9-0007AT-Ix
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOkT8-0002pM-S4
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:24:07 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-3-berrange@redhat.com>
	<0d437d60-c422-b931-03a2-120e6c1912af@redhat.com>
	<20181119102326.GB19532@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d92111bb-3b5f-064d-6161-db0e6a50b7a7@redhat.com>
Date: Mon, 19 Nov 2018 08:24:00 -0600
MIME-Version: 1.0
In-Reply-To: <20181119102326.GB19532@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6 for-3.1] nbd: stop waiting for a NBD
 response with NBD_CMD_DISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/19/18 4:23 AM, Daniel P. Berrang=C3=A9 wrote:

>>> Simply setting the 'quit' flag after sending NBD_CMD_DISC is enough t=
o
>>> get the coroutine to stop waiting for a reply and thus supress the er=
ror
>>> message.
>>
>> Actually, it's not quite enough - once you actually start performing I=
/O,
>> enough coroutines are kicked off that the error still happens:
>=20
> Hmm, does the client not send requests synchronously  ? I expected that
> any other I/O operations would have already received their reply by the
> time we sent the DISC command.
>=20

During handshake phase (NBD_OPT_* messages), client sends requests=20
synchronously (at most one pending read, in response to the most recent=20
write). During transmission phase (NBD_CMD_* messages), the client is=20
allowed to send messages asynchronously.  However, the NBD protocol=20
recommends (but not requires) that the client never send NBD_CMD_DISC to=20
disconnect until AFTER the client has collected all responses to any=20
earlier in-flight messages. And if I'm reading the block/nbd-client.c=20
code correctly, in general we don't try to shutdown a client while there=20
are any pending commands with unread replies, except when we are=20
shutting down due to detecting a protocol error (at which point we are=20
already out of sync with the server and waiting for replies is not going=20
to be helpful).


>> But I want to do more testing to make sure I'm not missing out on repo=
rting
>> an actual error if I add that.
>=20
> Yes, I'd be a little concerned about missing reporting of an error from
> a command other than NBD_CMD_DISC if we did this.

But it looks like your approach of making the qio code behave more=20
nicely is a smarter cleanup than my idea, so I'm willing to ditch my=20
code in favor of yours.  Testing your approach now :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
