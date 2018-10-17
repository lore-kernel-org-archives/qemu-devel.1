Received: from eggs.gnu.org ([2001:4830:134:3::10]:50809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gCqYh-0004Ku-Eg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gCqYg-0004N3-Kc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:28:39 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<f2f93b39-107c-ba70-5915-0b24c25cf58d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <64a02752-ae0d-fd03-39af-85416822e266@redhat.com>
Date: Wed, 17 Oct 2018 14:28:10 -0400
MIME-Version: 1.0
In-Reply-To: <f2f93b39-107c-ba70-5915-0b24c25cf58d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/6] dirty-bitmaps: fix QMP command
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/17/2018 02:24 PM, Eric Blake wrote:
> On 10/2/18 6:02 PM, John Snow wrote:
>> based on: jsnow/bitmaps staging branch
>>
>> This series builds on a previous standalone patch and adjusts
>> the permission for all (or most) of the QMP bitmap commands.
>>
>> V4:
>> =C2=A0 - Replace "in-use" with "in use"
>> =C2=A0 - Replace "user_modifiable" version with "user_locked"
>> =C2=A0 - Remove more usages of frozen-and-or-locked in NBD.
>>
>> John Snow (6):
>> =C2=A0=C2=A0 block/dirty-bitmaps: add user_locked status checker
>> =C2=A0=C2=A0 block/dirty-bitmaps: fix merge permissions
>> =C2=A0=C2=A0 block/dirty-bitmaps: allow clear on disabled bitmaps
>> =C2=A0=C2=A0 block/dirty-bitmaps: prohibit enable/disable on locked/fr=
ozen bitmaps
>> =C2=A0=C2=A0 block/backup: prohibit backup from using in use bitmaps
>> =C2=A0=C2=A0 nbd: forbid use of frozen bitmaps
>=20
> Just now noticing that our docs are slightly out of sync with these
> changes:
>=20
> # @DirtyBitmapStatus:
> #
> # An enumeration of possible states that a dirty bitmap can report to
> the user.
> #
> # @frozen: The bitmap is currently in-use by a backup operation or bloc=
k
> job,
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and is immutabl=
e.
> #
> # @disabled: The bitmap is currently in-use by an internal operation an=
d is
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rea=
d-only. It can still be deleted.
>=20
> This state is also reachable when using x-block-dirty-bitmap-disable,
> which is not an internal operation.=C2=A0 We probably also ought to doc=
ument
> that this state is a prereq to x-nbd-server-add-bitmap, since...
>=20
> #
> # @active: The bitmap is actively monitoring for new writes, and can be
> cleared,
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deleted, or use=
d for backup operations.
>=20
> ...active is not valid for that usage.
>=20
> #
> # @locked: The bitmap is currently in-use by some operation and can not=
 be
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cleared, delete=
d, or used for backup operations. (Since 2.12)
>=20
>=20

Ah, you're right. The rationale on disabled there is a bit wrong. I
think active is still correct, but the pull workflow has some extra
criteria.

I'll give a shot at touching this up.

--js
