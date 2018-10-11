Received: from eggs.gnu.org ([2001:4830:134:3::10]:36604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAZjj-0004sV-LR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAZjg-0001mr-BV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAZjf-0001gL-VT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:06:36 -0400
Date: Thu, 11 Oct 2018 13:06:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181011120613.GI2483@work-vm>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<20180921122954.GD2842@work-vm>
	<355a1147-c0d0-88fc-7b68-4391bab25c54@gmail.com>
	<87zhvnqb0s.fsf@dusky.pond.sub.org>
	<20181010075612.GG2052@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181010075612.GG2052@andariel.pipo.sk>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH v2 0/3] HMP/snapshot changes - do
 not use ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, kwolf@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, muriloo@linux.ibm.com

* Peter Krempa (pkrempa@redhat.com) wrote:
> On Tue, Oct 09, 2018 at 19:34:43 +0200, Markus Armbruster wrote:
> > Cc: libvir-list for review of the compatibility argument below.
> >=20
> > Daniel Henrique Barboza <danielhb413@gmail.com> writes:
> >=20
> > > Hey David,
> > >
> > > On 9/21/18 9:29 AM, Dr. David Alan Gilbert wrote:
> > >> * Daniel Henrique Barboza (danielhb413@gmail.com) wrote:
> > >>> changes in v2:
> > >>> - removed the "RFC" marker;
> > >>> - added a new patch (patch 2) that removes
> > >>> bdrv_snapshot_delete_by_id_or_name from the code;
> > >>> - made changes in patch 1 as suggested by Murilo;
> > >>> - previous patch set link:
> > >>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.ht=
ml
> > >>>
> > >>>
> > >>> It is not uncommon to see bugs being opened by testers that attem=
pt to
> > >>> create VM snapshots using HMP. It turns out that "0" and "1" are =
quite
> > >>> common snapshot names and they trigger a lot of bugs. I gave an e=
xample
> > >>> in the commit message of patch 1, but to sum up here: QEMU treats=
 the
> > >>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'nam=
e'. It
> > >>> is documented as such, but this can lead to strange situations.
> > >>>
> > >>> Given that it is strange for an API to consider a parameter to be=
 2 fields
> > >>> at the same time, and inadvently treating them as one or the othe=
r, and
> > >>> that removing the ID field is too drastic, my idea here is to kee=
p the
> > >>> ID field for internal control, but do not let the user set it.
> > >>>
> > >>> I guess there's room for discussion about considering this change=
 an API
> > >>> change or not. It doesn't affect users of HMP and it doesn't affe=
ct Libvirt,
> > >>> but simplifying the meaning of the parameters of savevm/loadvm/de=
lvm.
> > >> Can you clarify a couple of things:
> > >>    a) What is it about libvirt's use that means it's OK ? Does it =
never
> > >> use numeric tags?
> > >
> > > I am glad you asked because my understanding in how Libvirt was dea=
ling
> > > with snapshots was wrong, and I just looked into it further to answ=
er your
> > > question. Luckily, this series fixes the situation for Libvirt as w=
ell.
> > >
> > > I was misled by the fact that Libvirt does not show the same sympto=
ms
> > > we see in
> > > QEMU of this problem, but the bug is there. Here's a quick test wit=
h
> > > Libvirt with
> > > "0" and "1" as snapshot names, considering a VM named with no snaps=
hots,
> > > using QEMU 2.12 and Libvirt 4.0.0:
> > >
> > > - create the "0" snapshot:
> > >
> > > $ sudo virsh snapshot-create-as --name 0 dhb
> > > Domain snapshot 0 created
> > >
> > > $ sudo virsh snapshot-list dhb
> > > Name Creation Time State
> > > ------------------------------------------------------------
> > > 0 2018-09-24 15:47:56 -0400 running
> > >
> > > $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> > > List of snapshots present on all disks:
> > > ID TAG VM SIZE DATE VM CLOCK
> > > --=A0=A0=A0 0=A0 405M 2018-09-24 15:47:56 00:04:20.867
> > >
> > >
> > > - created the "1" snapshot. Here, Libvirt shows both snapshots with
> > > snapshot-list,
> > > but the snapshot was erased inside QEMU:
> > >
> > > $ sudo virsh snapshot-create-as --name 1 dhb
> > > Domain snapshot 1 created
> > > $
> > > $ sudo virsh snapshot-list dhb
> > > Name Creation Time State
> > > ------------------------------------------------------------
> > > 0 2018-09-24 15:47:56 -0400 running
> > > 1 2018-09-24 15:50:09 -0400 running
> > >
> > > $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> > > List of snapshots present on all disks:
> > > ID TAG VM SIZE DATE VM CLOCK
> > > --=A0=A0=A0 1=A0 404M 2018-09-24 15:50:10 00:05:36.226
> > >
> > >
> > > This is where I stopped checking out Libvirt at first, concluding
> > > wrongly that it
> > > was immune to the bug.
> > >
> > > Libvirt does not throw an error when trying to apply snapshot 0. In
> > > fact, it acts
> > > like everything went fine:
> > >
> > > $ sudo virsh snapshot-revert dhb 0
> > >
> > > $ echo $?
> > > 0
> >=20
> > Is that a libvirt bug?
>=20
> Probably yes. The error handling from HMP sucks and can't really be
> fixed in all cases. This is for the handler which calls "loadvm":
>=20
>     if (strstr(reply, "No block device supports snapshots") !=3D NULL) =
{
>         virReportError(VIR_ERR_OPERATION_INVALID, "%s",
>                        _("this domain does not have a device to load sn=
apshots"));
>         goto cleanup;
>     } else if (strstr(reply, "Could not find snapshot") !=3D NULL) {
>         virReportError(VIR_ERR_OPERATION_INVALID,
>                        _("the snapshot '%s' does not exist, and was not=
 loaded"),
>                        name);
>         goto cleanup;
>     } else if (strstr(reply, "Snapshots not supported on device") !=3D =
NULL) {
>         virReportError(VIR_ERR_OPERATION_INVALID, "%s", reply);
>         goto cleanup;
>     } else if (strstr(reply, "Could not open VM state file") !=3D NULL)=
 {
>         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
>         goto cleanup;
>     } else if (strstr(reply, "Error") !=3D NULL
>              && strstr(reply, "while loading VM state") !=3D NULL) {
>         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
>         goto cleanup;
>     } else if (strstr(reply, "Error") !=3D NULL
>              && strstr(reply, "while activating snapshot on") !=3D NULL=
) {
>         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
>         goto cleanup;
>     }
>=20
> If the above does not match the reported error, we report success. The
> same problem can happen with any of the 5 [1] HMP command handlers we
> still have.
>=20
> Note that a similar abomination is also for the code which calls
> "savevm".

Would the following small qemu change make life a little safer:

diff --git a/hmp.c b/hmp.c
index 576253a01f..0729a8c7ed 100644
--- a/hmp.c
+++ b/hmp.c
@@ -62,7 +62,7 @@ static void hmp_handle_error(Monitor *mon, Error **errp=
)
 {
     assert(errp);
     if (*errp) {
-        error_report_err(*errp);
+        error_reportf_err(*errp, "Error: ");
     }
 }

changing:

No block device supports snapshots


to:

Error: No block device supports snapshots

so you could check for Error: at the start and know that you've hit some
unknown error?

Dave


> [1] We technically have 6 HMP handlers, but "cpu_set" is not used if yo=
y
> have a QEMU younger than 3 years. Soon also "drive_add" and "drive_del"
> will be replaced, so we'll be stuck with the 3 internal snapshot ones.
> >=20
> > > Reverting back to snapshot "1" works as intended, restoring the VM
> > > state when it
> > > was created.
> > >
> > >
> > > (perhaps this is something we should let Libvirt be aware of ...)
>=20
> The error message from qemu which was wrongly ignored by qemu can be
> found in the libvirtd debug log. It would be helpful if you could
> provide it.
>=20
> > >
> > >
> > >
> > > This series fixes this behavior because the snapshot 0 isn't erased
> > > from QEMU, allowing
> > > Libvirt to successfully restore it.
> > >
> > >
> > >>    b) After this series are you always guaranteed to be able to fi=
x
> > >> any existing oddly named snapshots?
> > >
> > > The oddly named snapshots that already exists can be affected by th=
e
> > > semantic
> > > change in loadvm and delvm, in a way that the user can't load/del
> > > using the snap
> > > ID, just the tag. Aside from that, I don't see any side effects wit=
h
> > > existing
> > > snapshots and this patch series.
> >=20
> > Do all snapshots have a tag that is unique within their image?  Even
> > snapshots created by old versions of QEMU?
>=20
> I remember there was a discussion which regarded problems with
> collisions between the name and the ID of the snapshot when dealing wit=
h
> loadvm/delvm commands but I can't seem to find it currently. Note that
> libvirt plainly issues loadvm/delvm $SNAPSHOTNAME. If the name is
> numeric it might clash. Similarly for inactive vms via qemu-img.


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
