Received: from eggs.gnu.org ([2001:4830:134:3::10]:43728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gAaCW-00050M-0X
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gAaCU-0002Wr-Q0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gAaCU-0002WD-Gq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:36:22 -0400
Date: Thu, 11 Oct 2018 14:35:41 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181011123541.GJ2052@andariel.pipo.sk>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<20180921122954.GD2842@work-vm>
	<355a1147-c0d0-88fc-7b68-4391bab25c54@gmail.com>
	<87zhvnqb0s.fsf@dusky.pond.sub.org>
	<20181010075612.GG2052@andariel.pipo.sk>
	<20181011120613.GI2483@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline
In-Reply-To: <20181011120613.GI2483@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, kwolf@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, muriloo@linux.ibm.com


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 13:06:14 +0100, Dr. David Alan Gilbert wrote:
> * Peter Krempa (pkrempa@redhat.com) wrote:
> > On Tue, Oct 09, 2018 at 19:34:43 +0200, Markus Armbruster wrote:
> > > Cc: libvir-list for review of the compatibility argument below.
> > >=20
> > > Daniel Henrique Barboza <danielhb413@gmail.com> writes:
> > >=20
> > > > Hey David,
> > > >
> > > > On 9/21/18 9:29 AM, Dr. David Alan Gilbert wrote:
> > > >> * Daniel Henrique Barboza (danielhb413@gmail.com) wrote:
> > > >>> changes in v2:
> > > >>> - removed the "RFC" marker;
> > > >>> - added a new patch (patch 2) that removes
> > > >>> bdrv_snapshot_delete_by_id_or_name from the code;
> > > >>> - made changes in patch 1 as suggested by Murilo;
> > > >>> - previous patch set link:
> > > >>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.ht=
ml
> > > >>>
> > > >>>
> > > >>> It is not uncommon to see bugs being opened by testers that attem=
pt to
> > > >>> create VM snapshots using HMP. It turns out that "0" and "1" are =
quite
> > > >>> common snapshot names and they trigger a lot of bugs. I gave an e=
xample
> > > >>> in the commit message of patch 1, but to sum up here: QEMU treats=
 the
> > > >>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'nam=
e'. It
> > > >>> is documented as such, but this can lead to strange situations.
> > > >>>
> > > >>> Given that it is strange for an API to consider a parameter to be=
 2 fields
> > > >>> at the same time, and inadvently treating them as one or the othe=
r, and
> > > >>> that removing the ID field is too drastic, my idea here is to kee=
p the
> > > >>> ID field for internal control, but do not let the user set it.
> > > >>>
> > > >>> I guess there's room for discussion about considering this change=
 an API
> > > >>> change or not. It doesn't affect users of HMP and it doesn't affe=
ct Libvirt,
> > > >>> but simplifying the meaning of the parameters of savevm/loadvm/de=
lvm.
> > > >> Can you clarify a couple of things:
> > > >>    a) What is it about libvirt's use that means it's OK ? Does it =
never
> > > >> use numeric tags?
> > > >
> > > > I am glad you asked because my understanding in how Libvirt was dea=
ling
> > > > with snapshots was wrong, and I just looked into it further to answ=
er your
> > > > question. Luckily, this series fixes the situation for Libvirt as w=
ell.
> > > >
> > > > I was misled by the fact that Libvirt does not show the same sympto=
ms
> > > > we see in
> > > > QEMU of this problem, but the bug is there. Here's a quick test with
> > > > Libvirt with
> > > > "0" and "1" as snapshot names, considering a VM named with no snaps=
hots,
> > > > using QEMU 2.12 and Libvirt 4.0.0:
> > > >
> > > > - create the "0" snapshot:
> > > >
> > > > $ sudo virsh snapshot-create-as --name 0 dhb
> > > > Domain snapshot 0 created
> > > >
> > > > $ sudo virsh snapshot-list dhb
> > > > Name Creation Time State
> > > > ------------------------------------------------------------
> > > > 0 2018-09-24 15:47:56 -0400 running
> > > >
> > > > $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> > > > List of snapshots present on all disks:
> > > > ID TAG VM SIZE DATE VM CLOCK
> > > > --=A0=A0=A0 0=A0 405M 2018-09-24 15:47:56 00:04:20.867
> > > >
> > > >
> > > > - created the "1" snapshot. Here, Libvirt shows both snapshots with
> > > > snapshot-list,
> > > > but the snapshot was erased inside QEMU:
> > > >
> > > > $ sudo virsh snapshot-create-as --name 1 dhb
> > > > Domain snapshot 1 created
> > > > $
> > > > $ sudo virsh snapshot-list dhb
> > > > Name Creation Time State
> > > > ------------------------------------------------------------
> > > > 0 2018-09-24 15:47:56 -0400 running
> > > > 1 2018-09-24 15:50:09 -0400 running
> > > >
> > > > $ sudo virsh qemu-monitor-command dhb --hmp info snapshots
> > > > List of snapshots present on all disks:
> > > > ID TAG VM SIZE DATE VM CLOCK
> > > > --=A0=A0=A0 1=A0 404M 2018-09-24 15:50:10 00:05:36.226
> > > >
> > > >
> > > > This is where I stopped checking out Libvirt at first, concluding
> > > > wrongly that it
> > > > was immune to the bug.
> > > >
> > > > Libvirt does not throw an error when trying to apply snapshot 0. In
> > > > fact, it acts
> > > > like everything went fine:
> > > >
> > > > $ sudo virsh snapshot-revert dhb 0
> > > >
> > > > $ echo $?
> > > > 0
> > >=20
> > > Is that a libvirt bug?
> >=20
> > Probably yes. The error handling from HMP sucks and can't really be
> > fixed in all cases. This is for the handler which calls "loadvm":
> >=20
> >     if (strstr(reply, "No block device supports snapshots") !=3D NULL) {
> >         virReportError(VIR_ERR_OPERATION_INVALID, "%s",
> >                        _("this domain does not have a device to load sn=
apshots"));
> >         goto cleanup;
> >     } else if (strstr(reply, "Could not find snapshot") !=3D NULL) {
> >         virReportError(VIR_ERR_OPERATION_INVALID,
> >                        _("the snapshot '%s' does not exist, and was not=
 loaded"),
> >                        name);
> >         goto cleanup;
> >     } else if (strstr(reply, "Snapshots not supported on device") !=3D =
NULL) {
> >         virReportError(VIR_ERR_OPERATION_INVALID, "%s", reply);
> >         goto cleanup;
> >     } else if (strstr(reply, "Could not open VM state file") !=3D NULL)=
 {
> >         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
> >         goto cleanup;
> >     } else if (strstr(reply, "Error") !=3D NULL
> >              && strstr(reply, "while loading VM state") !=3D NULL) {
> >         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
> >         goto cleanup;
> >     } else if (strstr(reply, "Error") !=3D NULL
> >              && strstr(reply, "while activating snapshot on") !=3D NULL=
) {
> >         virReportError(VIR_ERR_OPERATION_FAILED, "%s", reply);
> >         goto cleanup;
> >     }
> >=20
> > If the above does not match the reported error, we report success. The
> > same problem can happen with any of the 5 [1] HMP command handlers we
> > still have.
> >=20
> > Note that a similar abomination is also for the code which calls
> > "savevm".
>=20
> Would the following small qemu change make life a little safer:
>=20
> diff --git a/hmp.c b/hmp.c
> index 576253a01f..0729a8c7ed 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -62,7 +62,7 @@ static void hmp_handle_error(Monitor *mon, Error **errp)
>  {
>      assert(errp);
>      if (*errp) {
> -        error_report_err(*errp);
> +        error_reportf_err(*errp, "Error: ");
>      }
>  }
>=20
> changing:
>=20
> No block device supports snapshots
>=20
>=20
> to:
>=20
> Error: No block device supports snapshots
>=20
> so you could check for Error: at the start and know that you've hit some
> unknown error?

That certainly would help, provided that the message is not localized in
any way. I'd be very glad to see it also for 'savevm' and 'delvm'.

It's a shame that drive_add and drive_del don't have that either, but
they will soon become unused.

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlu/Q5oACgkQHGwCByjY
1GrJSw//SGm9AxMoom4UU8yjKOe4UmO+ltyWqyi/XwB30EJM45Ta+KBHzRGRIEtZ
gT7uNPAkkNsIeV6s9ZJoi5qM+Zj+cvv8ilsPRYliAjTzncUzBawlOEdQYk2Bwpcr
YCd40ReC7WjpxdQh1yOA/diJXNnM819EoQnlG4ZTqqQedmdqBEg7/I6LCjkHz4uH
lnryQDClKcX4BDhBb5JwivwAvkltXq+qVEWbFBv8u6G31qw0uAywQ9zHzgVYbRuU
w3bmWC3vYGsw0r37+Dc+Txp0zDmRQrpRlfw7xmc5VmCZ6EPJteweDlHnHPqnq2q7
XTxx0X/Xu1EMGo2ZsdFMBAeZvWsmdx4w8C39osn1Ezd+h7ANqrZea1ROZkkCC2g5
ZgTKFf/GQ16cgWtsJJjdDP0S6+zG8pLfWrWAJYoRmf56+4sf9vMrtFC1/l3LAysj
0qzTvaAQPWnF1BOH9roGQEc5TxSQGVmYOUGxrdOdsQ5G+L4O/RAsCAVPRBlROxfS
3wmiLSK6Aj7jTgnZynqOAlswfiw9Dl9JxEIEpbA4KSBZap9XEPQAZtYRMUNk3MFX
tvJsoq4LTwnVAXW9zlCRy2RfOP2oH54mv8cEE+u7ya8gNog9b8Ts988VZ6L1+i94
pEXJKPC9JqSSkYlxNxOwYXGUugm2TJFdNGk0B1g/dIYdeZd1xXo=
=aivD
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
