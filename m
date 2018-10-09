Received: from eggs.gnu.org ([2001:4830:134:3::10]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9vuI-0000HH-V6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9vuD-0001TV-Pc
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9vuD-0001TJ-HO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:34:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<20180921122954.GD2842@work-vm>
	<355a1147-c0d0-88fc-7b68-4391bab25c54@gmail.com>
Date: Tue, 09 Oct 2018 19:34:43 +0200
In-Reply-To: <355a1147-c0d0-88fc-7b68-4391bab25c54@gmail.com> (Daniel Henrique
	Barboza's message of "Mon, 24 Sep 2018 17:48:41 -0300")
Message-ID: <87zhvnqb0s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kwolf@redhat.com, muriloo@linux.ibm.com, qemu-devel@nongnu.org, mreitz@redhat.com, libvir-list@redhat.com

Cc: libvir-list for review of the compatibility argument below.

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> Hey David,
>
> On 9/21/18 9:29 AM, Dr. David Alan Gilbert wrote:
>> * Daniel Henrique Barboza (danielhb413@gmail.com) wrote:
>>> changes in v2:
>>> - removed the "RFC" marker;
>>> - added a new patch (patch 2) that removes
>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>> - made changes in patch 1 as suggested by Murilo;
>>> - previous patch set link:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>>>
>>>
>>> It is not uncommon to see bugs being opened by testers that attempt to
>>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
>>> common snapshot names and they trigger a lot of bugs. I gave an example
>>> in the commit message of patch 1, but to sum up here: QEMU treats the
>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
>>> is documented as such, but this can lead to strange situations.
>>>
>>> Given that it is strange for an API to consider a parameter to be 2 fie=
lds
>>> at the same time, and inadvently treating them as one or the other, and
>>> that removing the ID field is too drastic, my idea here is to keep the
>>> ID field for internal control, but do not let the user set it.
>>>
>>> I guess there's room for discussion about considering this change an API
>>> change or not. It doesn't affect users of HMP and it doesn't affect Lib=
virt,
>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>> Can you clarify a couple of things:
>>    a) What is it about libvirt's use that means it's OK ? Does it never
>> use numeric tags?
>
> I am glad you asked because my understanding in how Libvirt was dealing
> with snapshots was wrong, and I just looked into it further to answer your
> question. Luckily, this series fixes the situation for Libvirt as well.
>
> I was misled by the fact that Libvirt does not show the same symptoms
> we see in
> QEMU of this problem, but the bug is there. Here's a quick test with
> Libvirt with
> "0" and "1" as snapshot names, considering a VM named with no snapshots,
> using QEMU 2.12 and Libvirt 4.0.0:
>
> - create the "0" snapshot:
>
> $ sudo virsh snapshot-create-as --name 0 dhb
> Domain snapshot 0 created
>
> $ sudo virsh snapshot-list dhb
> Name Creation Time State
> ------------------------------------------------------------
> 0 2018-09-24 15:47:56 -0400 running
>
> $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> List of snapshots present on all disks:
> ID TAG VM SIZE DATE VM CLOCK
> --=C2=A0=C2=A0=C2=A0 0=C2=A0 405M 2018-09-24 15:47:56 00:04:20.867
>
>
> - created the "1" snapshot. Here, Libvirt shows both snapshots with
> snapshot-list,
> but the snapshot was erased inside QEMU:
>
> $ sudo virsh snapshot-create-as --name 1 dhb
> Domain snapshot 1 created
> $
> $ sudo virsh snapshot-list dhb
> Name Creation Time State
> ------------------------------------------------------------
> 0 2018-09-24 15:47:56 -0400 running
> 1 2018-09-24 15:50:09 -0400 running
>
> $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> List of snapshots present on all disks:
> ID TAG VM SIZE DATE VM CLOCK
> --=C2=A0=C2=A0=C2=A0 1=C2=A0 404M 2018-09-24 15:50:10 00:05:36.226
>
>
> This is where I stopped checking out Libvirt at first, concluding
> wrongly that it
> was immune to the bug.
>
> Libvirt does not throw an error when trying to apply snapshot 0. In
> fact, it acts
> like everything went fine:
>
> $ sudo virsh snapshot-revert dhb 0
>
> $ echo $?
> 0

Is that a libvirt bug?

> Reverting back to snapshot "1" works as intended, restoring the VM
> state when it
> was created.
>
>
> (perhaps this is something we should let Libvirt be aware of ...)
>
>
>
> This series fixes this behavior because the snapshot 0 isn't erased
> from QEMU, allowing
> Libvirt to successfully restore it.
>
>
>>    b) After this series are you always guaranteed to be able to fix
>> any existing oddly named snapshots?
>
> The oddly named snapshots that already exists can be affected by the
> semantic
> change in loadvm and delvm, in a way that the user can't load/del
> using the snap
> ID, just the tag. Aside from that, I don't see any side effects with
> existing
> snapshots and this patch series.

Do all snapshots have a tag that is unique within their image?  Even
snapshots created by old versions of QEMU?
