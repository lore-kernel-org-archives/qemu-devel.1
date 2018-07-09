Received: from eggs.gnu.org ([2001:4830:134:3::10]:55679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fcfMj-0006l2-1M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fcfMe-0008Le-Tf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:14:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fcfMe-0008L2-JQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:14:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w69NE3Ls105129
	for <qemu-devel@nongnu.org>; Mon, 9 Jul 2018 19:14:38 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k4c3natgm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 19:14:38 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 9 Jul 2018 19:14:36 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKPgXcGQGqfwAw132jKq5UaFhaPR8PnfGf4NiXgYGoo7FwR5Cw@mail.gmail.com>
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-2-sameeh@daynix.com>
	<5e9b9ca6-b493-d10b-be98-9b9eb480c685@redhat.com>
	<CAKPgXcGQGqfwAw132jKq5UaFhaPR8PnfGf4NiXgYGoo7FwR5Cw@mail.gmail.com>
Date: Mon, 09 Jul 2018 17:58:45 -0500
Message-Id: <153117712510.13022.10479965239208861799@sif>
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
 fsinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Markus Armbruster <armbru@redhat.com>

Quoting Sameeh Jubran (2018-06-28 18:33:58)
> =

> =

> On Fri, Jun 29, 2018 at 12:44 AM, Eric Blake <eblake@redhat.com> wrote:
> =

>     On 06/26/2018 10:10 AM, Sameeh Jubran wrote:
> =

>         From: Sameeh Jubran <sjubran@redhat.com>
> =

>         The fsinfo command is currently implemented for Windows only and =
it's
>         disk
>         parameter can be enabled by adding the define "CONFIG_QGA_NTDDSCS=
I" to
>         the qga
>         code. When enabled and executed the qemu-ga crashed with the foll=
owing
>         message:
> =

>         ------------------------------------------------
>         File qapi/qapi-visit-core.c, Line 49
> =

>         Expression: !(v->type & VISITOR_OUTPUT) || *obj)
>         ------------------------------------------------
> =

>         After some digging, turns out that the GuestPCIAddress is null an=
d the
>         qapi visitor doesn't like that, so we can always allocate it inst=
ead
>         and
>         initiate all it's members to -1.
> =

> =

>     Adding Markus for a qapi back-compat question.
> =

>     Is faking an invalid address better than making the output optional
>     instead?
> =

> =

>         +++ b/qga/commands-win32.c
>         @@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char *g=
uid,
>         Error **errp)
>         =C2=A0 =C2=A0 =C2=A0 char *buffer =3D NULL;
>         =C2=A0 =C2=A0 =C2=A0 GuestPCIAddress *pci =3D NULL;
>         =C2=A0 =C2=A0 =C2=A0 char *name =3D g_strdup(&guid[4]);
>         +=C2=A0 =C2=A0 pci =3D g_malloc0(sizeof(*pci));
>         +=C2=A0 =C2=A0 pci->domain =3D -1;
>         +=C2=A0 =C2=A0 pci->slot =3D -1;
>         +=C2=A0 =C2=A0 pci->function =3D -1;
>         +=C2=A0 =C2=A0 pci->bus =3D -1;
> =

> =

>     Right now, we have:
> =

>     ##
>     # @GuestDiskAddress:
>     #
>     # @pci-controller: controller's PCI address
>     # @bus-type: bus type
>     # @bus: bus id
>     # @target: target id
>     # @unit: unit id
>     #
>     # Since: 2.2
>     ##
>     { 'struct': 'GuestDiskAddress',
>     =C2=A0 'data': {'pci-controller': 'GuestPCIAddress',
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'bus-type': 'GuestDiskBusTyp=
e',
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'bus': 'int', 'target': 'int=
', 'unit': 'int'} }
> =

>     and the problem you ran into is that under certain conditions, we hav=
e no
>     idea what to populate in GuestPCIAddress.=C2=A0 Your patch populates =
garbage
>     instead; but I'm wondering if it would be better to instead mark
>     pci-controller as optional, where code that CAN populate it would set
>     has_pci_controller=3Dtrue, and the code that crashed will now work by=
 leaving
>     the struct NULL (and has_pci_controller=3Dfalse).=C2=A0 But that remo=
ves output
>     that the client may expect to be present, hence, this is a back-compat
>     question of the best way to approach this.
> =

> Since all of the fields are ints, I believe that "-1" is very informative=
 even
> though I don't like this approach but it does preserve backward compatibi=
lity=C2=A0
> as you've already clarified.
> =

> I don't want to assume anything but this bug has been laying around for q=
uite a
> while and no one complained, moreover,=C2=A0=C2=A0the disk option is not =
enabled by
> default in upstream code so I don't think that backward compatibility is
> actually disturbed but then again this is just an assumption.
> =

> One more thing to consider is the second patch of this series which actua=
lly
> was the root cause of why we didn't allocate the " GuestDiskAddress" stru=
ct
> which is some registry keys being absent for the specific device which wo=
uld
> leave us with two options:
> 1. Don not return anything for all of the fields (leave it null)
> 2. Return partial information
> I think that the second option is preferable for obvious reasons.
> =

> I am not that familiar with schema files, but it is possible to make int =
fields
> optional too?
> =

> I can live with either approaches, maintainers, it's your call :)

IMO both approaches potentially break clients, but making the field
optional in this case would be likely to trigger a segfault for any code
that relies on GuestPCIAddress being populated, whereas -1 would likely
just propagate through the stack as a signed integer as the schema calls
for. Lack of -1/undefined handling further up the stack could still
cause breakage but the severity seems lesser. I'm inclined to go this
route for 2.13. If there are no objections I plan to include this in a
pull for 2.13-rc1.

> =

> Thanks for the review!
> =

>    =

>     --
>     Eric Blake, Principal Software Engineer
>     Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3266
>     Virtualization:=C2=A0 qemu.org | libvirt.org
> =

> =

> =

> =

> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.
