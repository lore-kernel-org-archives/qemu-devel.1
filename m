Received: from eggs.gnu.org ([2001:4830:134:3::10]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnjA-0007Vz-9i
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnj9-0000Va-6z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:28:04 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
	<a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c012d3a-eb03-1645-78c5-e237b0adc6c1@redhat.com>
Date: Tue, 27 Feb 2018 16:27:37 -0600
MIME-Version: 1.0
In-Reply-To: <a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 19/21] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/27/2018 03:57 PM, John Snow wrote:
>=20
>=20
> On 02/27/2018 03:16 PM, Eric Blake wrote:
>> On 02/23/2018 05:51 PM, John Snow wrote:
>>> Expose the "manual" property via QAPI for the backup-related jobs.
>>> As of this commit, this allows the management API to request the
>>> "concluded" and "dismiss" semantics for backup jobs.

>>> +# @manual: True to use an expanded, more explicit job control flow.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jobs may tra=
nsition from a running state to a pending state,
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where they m=
ust be instructed to complete manually via
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block-job-fi=
nalize.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jobs belongi=
ng to a transaction must either all or all not
>>> use this
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setting. Onc=
e a transaction reaches a pending state,
>>> issuing the
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finalize com=
mand to any one job in the transaction is
>>> sufficient
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to finalize =
the entire transaction.
>>
>> The previous commit message talked about mixed-manual transactions, bu=
t
>> this seems to imply it is not possible.=C2=A0 I'm fine if we don't sup=
port
>> mixed-manual transactions, but wonder if it means any changes to the
>> series.
>>
>> Otherwise looks reasonable from the UI point of view.
>>
>=20
> More seriously, this documentation I wrote doesn't address the totality
> of the expanded flow. I omitted dismiss here by accident as well. This
> is at best a partial definition of the 'manual' property.
>=20
> I'd like to use _this_ patch to ask the question: "What should the
> proper noun for the QEMU 2.12+ Expanded Block Job Management Flow
> Mechanism be?"

"Manual" actually doesn't sound too bad; I could also see "Explicit job=20
flow", as in, "within a transaction, all jobs should have the same=20
setting for the choice of Explicit Job Flow" (but then the name 'manual'=20
would have to be changed to match).  The idea of a central document,=20
that gets referred to from multiple spots in the QAPI docs, rather than=20
duplicating information throughout the QAPI docs, is reasonable.

>=20
> I'm not too sure, but "Manual mode" leaves a lot to be desired.
>=20
> I keep calling it something like "2.12+ Job Management" but that's not
> really descriptive.

That, and if someone ever backports the enhanced state machine to a 2.11=20
branch, it becomes a misnomer.

> I conceptualize the feature as the addition of a
> purposefully more "needy" and less automatic completion mechanism, henc=
e
> the "manual"
>=20
> Anyway, I'd like to figure out a good "documentation name" for it so I
> can point all instances of the creation property (for drive-backup,
> drive-mirror, and everyone else) to a central location that explains th=
e
> STM and what exactly the differences between manual=3Don/off are. I'd t=
hen
> like to expose this property via query and link the documentation there
> to this description, too.

"Explicit" and "Manual" are the two best options coming to me as I type=20
this email.

>=20
> It'd be nice-- under the same arguments that prompted 'dismiss'-- to sa=
y
> that if a client crashes it can reconnect and discover what kind of
> attention certain jobs will need by asking for the manual property back=
.
>=20
> --js
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
