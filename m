Received: from eggs.gnu.org ([2001:4830:134:3::10]:48770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eQrfw-0002Jd-OO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eQrfr-0007hZ-Ok
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:25:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eQrfr-0006Tq-FH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:25:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBI9OQKR042758
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:24:29 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exasfrncq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:24:29 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 04:24:26 -0500
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 14:54:20 +0530
MIME-Version: 1.0
In-Reply-To: <b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
Content-Language: en-US
Message-Id: <225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org



On 12/15/2017 02:48 PM, Max Reitz wrote:
> On 2017-12-13 05:50, seeteena wrote:
>> Hi David,
>>
>> While creating snapshots when tag name '0' used in the very first and =
followed by tag name '1' then snapshot created with tag name '0' is getti=
ng erased.
>> A snapshot is identified by a name computed either from an id, which i=
s basically a numerical counter starting at 1 for qcow2, or from a tag, w=
hich is a string (provided
>> by the user or automatically computed).
>>
>> (qemu) savevm 0
>>
>> This creates a snapshot with tag '0' and id '1'.
> That's something someone has complained about already, as far as I
> remember, and this is indeed an issue.
>
>>> (qemu) savevm 1
>> This deletes snapshot with name '1' (ie, with id '1') and creates snap=
shot with tag '1' and id '1'.
> I think this is the issue, not info snapshots.
>
>>  From the output of 'info snapshots' id '1' is not seen for tag '0' in=
stead seeing an empty field.
>>
>> ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>> --        0                      338M 2017-10-16 13:44:35   00:02:07.4=
91
>>
>> If an ID shown as '1' in the above then user can understand the above =
documented stuff i.e "If there is already a snapshot with the same tag or=
 ID, it is replaced".
>> The '--' in ID field is annoying.
> Maybe, but this patch is wrong still.  Commit 3a1ee711904 says exactly =
why:
>
>> The patch uses snapshot name instead of snapshot id to determine wheth=
er a
>> snapshot is fully available and uses '--' instead of snapshot id in ou=
tput
>> because the snapshot id is not guaranteed to be the same on all images.
> info snapshots first shows a list of snapshots that are present on all
> disks.  However, those are matched by name and not by ID, so the ID is
> not necessarily the same.
>
> Therefore, we can only print it if it is.  Sure, we can do that, but
> your patch is missing that check.
 =C2=A0As you referred I had checked Commit 3a1ee711904. Does it mean tha=
t we=20
need to add the check option for ID as well along with name to get the=20
list of snapshots that are present on all disks with my patch ?
so info snapshots shows list of snapshots that are present on all disks=20
that matched either by ID or name.

like
if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) =3D=3D 0) ||=20
(bdrv_all_find_snapshot(sn_tab[i].id_str, &bs1) =3D=3D 0)


>
> Example:
>
> $ qemu-img create -f qcow2 foo.qcow2 64M
> Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img create -f qcow2 bar.qcow2 64M
> Formatting 'bar.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img snapshot -c common_snapshot foo.qcow2
> $ qemu-img snapshot -c bar_snapshot bar.qcow2
> $ qemu-img snapshot -c common_snapshot bar.qcow2
> $ qemu-system-x86_64 -hda foo.qcow2 -hdb bar.qcow2 -monitor stdio
> $ qemu-img snapshot -l foo.qcow2
> Snapshot list:
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> 1         common_snapshot           0 2017-12-15 10:09:17   00:00:00.00=
0
> $ qemu-img snapshot -l bar.qcow2
> Snapshot list:
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> 1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.00=
0
> 2         common_snapshot           0 2017-12-15 10:09:28   00:00:00.00=
0
> QEMU 2.9.1 monitor - type 'help' for more information
> (qemu) info snapshots
> List of snapshots present on all disks:
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> --        common_snapshot           0 2017-12-15 10:09:17   00:00:00.00=
0
>
> List of partial (non-loadable) snapshots on 'ide0-hd1':
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> 1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.00=
0
>
> With your patch:
>
> (qemu) info snapshots
> List of snapshots present on all disks:
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> 1         common_snapshot           0 2017-12-15 10:09:17   00:00:00.00=
0
>
> List of partial (non-loadable) snapshots on 'ide0-hd1':
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> 1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.00=
0
>
> Max
>
