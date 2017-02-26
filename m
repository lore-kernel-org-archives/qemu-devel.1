Received: from eggs.gnu.org ([2001:4830:134:3::10]:55869)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ci5dF-00043I-Lb
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ci5dB-0004Ak-OS
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:41:25 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51264 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ci5dB-00049P-FY
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:41:21 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
Date: Sun, 26 Feb 2017 21:41:17 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E0A3205-E866-44C3-86C5-7B3B4F9923B4@kamp.de>
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
	<c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
	<2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
	<b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
	<589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>


> Am 24.02.2017 um 22:44 schrieb Eric Blake <eblake@redhat.com>:
>=20
> On 02/24/2017 03:31 PM, John Snow wrote:
>>>=20
>>> But the Backup Server could instead connect to the NAS directly =
avoiding
>>> load on the frontent LAN
>>> and the Qemu Node.
>>>=20
>>=20
>> In a live backup I don't see how you will be removing QEMU from the =
data
>> transfer loop. QEMU is the only process that knows what the correct =
view
>> of the image is, and needs to facilitate.
>>=20
>> It's not safe to copy the blocks directly without QEMU's mediation.
>=20
> Although we may already have enough tools in place to help achieve =
that:
> create a temporary qcow2 wrapper around the primary image via external
> snapshot, so that the primary image is now read-only in qemu; then use
> whatever block-status mechanism (whether the NBD block status =
extension,
> or directly reading from a persistent bitmap) to facilitate whatever
> more efficient offline transfer of just the relevant portions of that
> main file, then live block-commit to get qemu to start writing to the
> file again.
>=20
> In other words, any time your algorithm wants to cause an I/O freeze =
to
> a particular file, the solution is to add a qcow2 external snapshot
> followed by a live commit.
>=20
> So tweaking the proposal a few mails ago:
>=20
> fsfreeze (optional)
> create qcow2 snapshot wrapper as a write lock (via QMP)
> fsthaw - now with no risk of violating guest timing constraints
> dirtymap =3D find all blocks that are dirty since last backup (via =
named
> bitmap/NBD block status)
> foreach block in dirtymap {
>               copy to backup via external software
> }
> live commit image (via QMP)
>=20
> The window where guest I/O is frozen is small (the freeze/snapshot
> create/thaw steps can be done in less than a second), while the window
> where you are extracting incremental backup data is longer (during =
that
> time, guest I/O is happening into a wrapper qcow2 file).

The live-snapshot/live-commit stuff could indeed help in my scenario. If =
I understand correctly this is
something that already works today, correct? If I have taken a =
live-snapshot, is live-migration and
stop/start of the VM still possible? What about live-migration and =
start/stop during live-commit?
I don=E2=80=99t talk about the dirty bitmap tracking I understand that =
persistence and live-migration support
is still in the works, I=E2=80=99m just interested in the =
snapshot/commit part.

Thanks
Peter=
