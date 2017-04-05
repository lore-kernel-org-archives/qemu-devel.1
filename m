Received: from eggs.gnu.org ([2001:4830:134:3::10]:52161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvsFD-0004hb-M4
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvsF8-0008Eq-L5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvsF8-0008Eh-Cb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:13:30 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
	<d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
	<20170404145348.GD4536@noname.str.redhat.com>
	<b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
	<20170405110131.GA5161@noname.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1556fcc9-50ab-7458-74fe-41756f1dd451@redhat.com>
Date: Wed, 5 Apr 2017 23:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170405110131.GA5161@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>



On 05/04/2017 13:01, Kevin Wolf wrote:
> Am 04.04.2017 um 17:09 hat Paolo Bonzini geschrieben:
>> On 04/04/2017 16:53, Kevin Wolf wrote:
>>>> The big question is how this fits into release management.  We have
>>>> another important regression from the op blocker work and only a wee=
k
>>>> to go before the last rc.  Are we going to delay 2.9 arbitrarily?  A=
re
>>>> we going to shorten the 2.10 development period correspondingly?  (I
>>>> vote yes and yes, FWIW).
>>> Which is the other regression?
>>
>> The assertion failure for snapshot_blkdev with iothreads.
>=20
> Ah, right, I keep forgetting that this started appearing with the op
> blocker series because the failure mode is completely different, so it
> seems to have been a latent bug somewhere else that was uncovered by it=
.
>=20
> If we're sure that the change of the order in bdrv_append() is what
> caused the bug to appear, we can just undo that for 2.9, at the cost of
> a messed up graph in the error case when bdrv_set_backing_hd() fails
> (because we have no way to undo bdrv_replace_node()).

I don't know if that is enough to fix all of the issues, but the bug is
easy to reproduce.

The issue is the lack of understanding of what node movement does to
quiesce_counter.  The invariant is that children cannot have a lower
quiesce_counter than parents, I think (paths in the graph can only join
in the children direction, right?).  Is it checked, and are there
violations already?  Maybe we need a get_quiesce_counter method in
BdrvChildRole, to cover BlockBackend's quiesce_counter?  Then we can use
that information to adjust the quiesce_counter when nodes move in the gra=
ph.

The block layer has good tests, but as the internal logic grows more
complex we should probably have more C level tests.  I'm constantly
impressed by the amount of tricky cases that test-replication.c catches
in the block job code.

Paolo
