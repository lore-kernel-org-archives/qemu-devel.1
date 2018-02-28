Received: from eggs.gnu.org ([2001:4830:134:3::10]:47122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6OB-0003qS-9c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6OA-0003Ao-BI
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:23:39 -0500
Date: Wed, 28 Feb 2018 19:23:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228182326.GM4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
	<a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 27.02.2018 um 22:57 hat John Snow geschrieben:
>=20
>=20
> On 02/27/2018 03:16 PM, Eric Blake wrote:
> > On 02/23/2018 05:51 PM, John Snow wrote:
> >> Expose the "manual" property via QAPI for the backup-related jobs.
> >> As of this commit, this allows the management API to request the
> >> "concluded" and "dismiss" semantics for backup jobs.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >> =A0 blockdev.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 19 ++++++++++++++++--=
-
> >> =A0 qapi/block-core.json | 32 ++++++++++++++++++++++++++------
> >> =A0 2 files changed, 42 insertions(+), 9 deletions(-)
> >>
> >=20
> >> +++ b/qapi/block-core.json
> >> @@ -1177,6 +1177,16 @@
> >> =A0 # @job-id: identifier for the newly-created block job. If
> >> =A0 #=A0=A0=A0=A0=A0=A0=A0=A0=A0 omitted, the device name will be us=
ed. (Since 2.7)
> >> =A0 #
> >> +# @manual: True to use an expanded, more explicit job control flow.
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 Jobs may transition from a running sta=
te to a pending state,
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 where they must be instructed to compl=
ete manually via
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 block-job-finalize.
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 Jobs belonging to a transaction must e=
ither all or all not
> >> use this
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 setting. Once a transaction reaches a =
pending state,
> >> issuing the
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 finalize command to any one job in the=
 transaction is
> >> sufficient
> >> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0 to finalize the entire transaction.
> >=20
> > The previous commit message talked about mixed-manual transactions, b=
ut
> > this seems to imply it is not possible.=A0 I'm fine if we don't suppo=
rt
> > mixed-manual transactions, but wonder if it means any changes to the
> > series.
> >=20
> > Otherwise looks reasonable from the UI point of view.
> >=20
>=20
> More seriously, this documentation I wrote doesn't address the totality
> of the expanded flow. I omitted dismiss here by accident as well. This
> is at best a partial definition of the 'manual' property.
>=20
> I'd like to use _this_ patch to ask the question: "What should the
> proper noun for the QEMU 2.12+ Expanded Block Job Management Flow
> Mechanism be?"
>=20
> I'm not too sure, but "Manual mode" leaves a lot to be desired.

I still think that the best way to expose it is like this:

    # both default to true
    '*auto-finalize': 'bool',
    '*auto-dismiss': 'bool',

These options would be very easy to describe because they just invoke
the functionality of a specific QMP command automatically as soon as it
becomes available for the job.

But given how often I already said that and people still don't consider
it as an option, this doesn't appear to have been very convincing. So
whatever... *shrug*

Kevin
