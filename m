Received: from eggs.gnu.org ([2001:4830:134:3::10]:58925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQfDI-0007Jo-M4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQfDH-0001C2-1Y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:39:24 -0400
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606173140-mutt-send-email-mst@kernel.org>
	<60c9b327-6503-0950-0720-3ccbb4637ad4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0de83ab1-070e-f12a-def4-404868d05a80@redhat.com>
Date: Wed, 6 Jun 2018 15:39:12 -0500
MIME-Version: 1.0
In-Reply-To: <60c9b327-6503-0950-0720-3ccbb4637ad4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

On 06/06/2018 09:57 AM, Eric Blake wrote:
> On 06/06/2018 09:43 AM, Michael S. Tsirkin wrote:
>> On Wed, Jun 06, 2018 at 01:02:53PM +0200, Max Reitz wrote:
>>> Yeah, but why make qcow2 that format?=C2=A0 That's what I completely =
fail to
>>> understand.
>>
>> Because why not? It's cheap to add it there and is much easier
>> than teaching people about a new container format.
>=20
> tar is not a new container format, but it is a new format to various=20
> toolchains - that said, if we popularize tar as the format for includin=
g=20
> a config file alongside a qcow2 image, it's not that hard to fix the=20
> stack to start passing that file around as the new preferred file type.

On a completely different front, 'qcow2' as a file format comes with=20
some psychological baggage.  If someone was using it 8 years ago, before=20
we did coroutine optimizations, it was noticeably slower than raw, and=20
relatively easier to get into a corrupted image condition that resulted=20
in data loss.  Just one VM lost, and it leaves a sour taste in your=20
mouth, where you are unwilling to trust that file format (even though=20
the file format was not necessarily the cause of the corruption).=20
Marketing-wise, we failed with our improvements ('qcow2v3' is so much=20
more of a mouthful than 'qcow3'), and it took years to flip the defaults=20
from v2 as the default to v3 as the default (moreso in downstream=20
distros than upstream), in part because we couldn't convince people of=20
the improvements they would be gaining by moving to v3.  Historically,=20
there's also 'qed' which was promised as a way to fix some of the poor=20
performance of qcow2, but which ended up not being any better than our=20
actual qcow2v3 improvements, so no one ended up switching to that. So,=20
to some extent, various high-level consumers still have the notion that=20
'raw' files are better/safer/faster than 'qcow2' files because of an=20
anecdote from years ago, even if we have since fixed the speed parity=20
and added locking to eliminate careless data loss.

If we DO add a new tar-file block driver to qemu, that could serve as a=20
marketing opportunity to convince people that the new format has all of=20
the features that you can't get from just a raw file, and does not=20
suffer from the slowness or data corruption they were worried about in=20
qcow2.  Thus, even if our new format is just a thin wrapper around a=20
config file plus the existing qcow2v3 we already know and love, the mere=20
fact that it is a new format may get people to move away from raw images=20
in situations where just the name 'qcow2' is unable to do so, at which=20
point we can help them take advantage of the features made possible by=20
qcow2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
