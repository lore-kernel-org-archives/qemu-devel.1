Received: from eggs.gnu.org ([2001:4830:134:3::10]:58407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gQC23-0001EX-ON
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gQC20-0002Ix-G7
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:02:07 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri, 23 Nov 2018 14:01:48 +0000
Message-ID: <916286cc-2067-6227-b08f-d1e227eb230e@virtuozzo.com>
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20181123074533.GC7812@andariel.pipo.sk>
In-Reply-To: <20181123074533.GC7812@andariel.pipo.sk>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B4C3DCA3D3FDD44D937965495281E6CD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Discrad blocks during
 block-stream operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

Dear Peter,

Thank you for your response.

The 'discard' option is useful when pulling a huge file. That will save=20
a disk

space significantly.

The 'commit' operation would be useful as well but it is harder to implemen=
t

due to concurrent writes of a guest. Which command to use, 'pull' or=20
'commit',

depends on an image to merge that can incur the performance issue.

Currently, the 'discard' option works for streaming into the active=20
layer only.

There is a serious trouble with the child's WRITE permission while streamin=
g

into an inactive layer. Once resolved, it will work right away with the=20
current

version. So, the existent child permission mechanism is a headache we kindl=
y

ask all of you to advise how to cope with it. Please refer to the=20
descriptions and

comments in the patch files for details.

Kindly,

Andrey Shinkevich



On 23.11.2018 10:45, Peter Krempa wrote:
> On Thu, Nov 22, 2018 at 21:48:02 +0300, Andrey Shinkevich wrote:
>> Hello everyone!
>>
>> The given feature discards blocks with copy-on-read operation while the
>> streaming process runs. Adding the 'discard' argument to the QMP block-s=
tream
>> command allows dropping a block in the backing chain after it has been c=
opied
>> to the active layer. That will elude the block duplication in the interm=
ediate
>> backing file. It saves the disk space while external snapshots are being
>> merged.
> So you specifically want to merge the snapshot by pulling rather than
> commiting? Do you have any specific reasons for that? I'm curious
> because I plan to finally finish external snapshots in libvirt.
>
> Allowing to pull into intermediate layers will be (or is?) very welcome
> by libvirt since I plan to do external snapshot deletion/merging and
> that will be greatly simplified by pulling.
>
> On the other hand libvirt will not be able to always use 'discard' as
> libvirt's API allows creating alternate histories for a VM and in such
> case when merging a snapshot at a branching point we'll need to pull it
> into multiple images. The 'discard' optimization can then be used only
> with the last branch.
>
> Libvirt's reasons for using 'block-stream' are mostly as it corresponds
> to the operations necessary for not messing up the relationship between
> the snapshot and which files on disk belong to it.
