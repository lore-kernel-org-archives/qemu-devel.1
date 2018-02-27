Received: from eggs.gnu.org ([2001:4830:134:3::10]:39679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqnFU-0006ps-5v
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqnFS-0004hX-Ti
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:57:24 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
Date: Tue, 27 Feb 2018 16:57:01 -0500
MIME-Version: 1.0
In-Reply-To: <2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 03:16 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> Expose the "manual" property via QAPI for the backup-related jobs.
>> As of this commit, this allows the management API to request the
>> "concluded" and "dismiss" semantics for backup jobs.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 ++++++++++++++++---
>> =C2=A0 qapi/block-core.json | 32 ++++++++++++++++++++++++++------
>> =C2=A0 2 files changed, 42 insertions(+), 9 deletions(-)
>>
>=20
>> +++ b/qapi/block-core.json
>> @@ -1177,6 +1177,16 @@
>> =C2=A0 # @job-id: identifier for the newly-created block job. If
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 omitted=
, the device name will be used. (Since 2.7)
>> =C2=A0 #
>> +# @manual: True to use an expanded, more explicit job control flow.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jobs may tran=
sition from a running state to a pending state,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where they mu=
st be instructed to complete manually via
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block-job-fin=
alize.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jobs belongin=
g to a transaction must either all or all not
>> use this
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setting. Once=
 a transaction reaches a pending state,
>> issuing the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finalize comm=
and to any one job in the transaction is
>> sufficient
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to finalize t=
he entire transaction.
>=20
> The previous commit message talked about mixed-manual transactions, but
> this seems to imply it is not possible.=C2=A0 I'm fine if we don't supp=
ort
> mixed-manual transactions, but wonder if it means any changes to the
> series.
>=20
> Otherwise looks reasonable from the UI point of view.
>=20

More seriously, this documentation I wrote doesn't address the totality
of the expanded flow. I omitted dismiss here by accident as well. This
is at best a partial definition of the 'manual' property.

I'd like to use _this_ patch to ask the question: "What should the
proper noun for the QEMU 2.12+ Expanded Block Job Management Flow
Mechanism be?"

I'm not too sure, but "Manual mode" leaves a lot to be desired.

I keep calling it something like "2.12+ Job Management" but that's not
really descriptive. I conceptualize the feature as the addition of a
purposefully more "needy" and less automatic completion mechanism, hence
the "manual"

Anyway, I'd like to figure out a good "documentation name" for it so I
can point all instances of the creation property (for drive-backup,
drive-mirror, and everyone else) to a central location that explains the
STM and what exactly the differences between manual=3Don/off are. I'd the=
n
like to expose this property via query and link the documentation there
to this description, too.

It'd be nice-- under the same arguments that prompted 'dismiss'-- to say
that if a client crashes it can reconnect and discover what kind of
attention certain jobs will need by asking for the manual property back.

--js
