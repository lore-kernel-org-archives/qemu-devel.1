Received: from eggs.gnu.org ([2001:4830:134:3::10]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyJn9-0004ck-2I
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyJn1-0006Jh-Tz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:07:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyJn1-0006JL-QG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:07:07 -0400
References: <20180320093135.26422-1-fl@n621.de>
	<d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
	<20180320160243.GZ4530@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8982638a-c7c0-3da8-4d69-96e5b45fbdfa@redhat.com>
Date: Tue, 20 Mar 2018 11:07:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180320160243.GZ4530@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Florian Larysch <fl@n621.de>, qemu-devel@nongnu.org, sw@weilnetz.de

On 03/20/2018 11:02 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 20, 2018 at 09:50:19AM -0500, Eric Blake wrote:
>> On 03/20/2018 04:31 AM, Florian Larysch wrote:
>>> qemu_create_pidfile does not truncate the pidfile when it creates it,
>>> but rather overwrites its contents with the new pid. This works fine =
as
>>> long as the length of the pid doesn't decrease, but this might happen=
 in
>>> case of wraparounds, causing pidfiles to contain trailing garbage whi=
ch
>>> breaks operations such as 'kill $(cat pidfile)'.
>>
>> Ouch.  Good analysis.
>>
>> However, I have to wonder if we have the opposite problem - when the f=
ile
>> exists (truncated) but has not yet been written, how often do we have =
a race
>> where someone can see the empty file?
>>

>> This part is right, if we don't care about the race with someone readi=
ng an
>> empty file.
>=20
> No, it is unsafe - we rely on lockf() to get the mutual exclusion.

Oh, right, because we aren't using O_EXCL.

> If a QEMU is running with pidfile locked, and its pid written into
> it, then a 2nd QEMU comes along it will truncate the pidfile owned
> by the original QEMU because the truncation happens before it has
> tried to acquire the lock. The 2nd QEMU will still exit, but the
> original QEMU's pid has now been lost.
>=20
> We must call ftruncate() after lockf(), but before writing the new
> pid into the file. That ensures there is no window in which it is
> possible to see the new & old pids mixed together.

So the window of time where the file can be empty still exists, but it=20
must be AFTER the lockf() (and the window where reading the file content=20
can see the wrong pid is longer - from the open until the ftruncate -=20
but at least the wrong data is limited to a previous pid or the empty=20
string, rather than a completely random wrong value from squashing=20
together two unrelated pids).

We'll need a v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
