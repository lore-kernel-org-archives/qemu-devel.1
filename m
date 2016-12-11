Received: from eggs.gnu.org ([2001:4830:134:3::10]:60150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuoE-0005f1-JQ
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuoB-0006m6-4B
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cFuoA-0006ls-SG
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:28:15 -0500
Date: Sun, 11 Dec 2016 05:28:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161211052355-mutt-send-email-mst@kernel.org>
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Dec 06, 2016 at 06:15:34PM -0800, Ben Warren wrote:
> Hi Michael,
>=20
> I=E2=80=99m well on my way to implementing this, but I am really new to=
 the QEMU code base and am struggling with some concepts.  Please see bel=
ow:
> > On Oct 5, 2016, at 6:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >=20
> > On Tue, Oct 04, 2016 at 03:51:40PM -0700, Ed Swierk wrote:
> >> On Thu, Sep 15, 2016 at 5:36 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> >>> On Thu, Sep 15, 2016 at 05:23:28PM -0700, Ed Swierk wrote:
> >>>> I'm wondering what it will take to finish up work on vmgenid.
> >>>>=20
> >>>> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg05599.htm=
l
> >>>=20
> >>> We have ACPI_BUILD_TPMLOG_FILE in tree now and I think it could be
> >>> allocated in a similar way.
> >>> Integrate patch "fw-cfg: support writeable blobs" to communicate th=
e
> >>> allocated address back to QEMU.
> >>=20
> >> Starting with Igor's last version at
> >> https://github.com/imammedo/qemu/commits/vmgen_wip , it's not clear =
to
> >> me which changes need to be ported, which changes are obsoleted by
> >> your new fw-cfg stuff and/or upstream churn in ACPI, device
> >> properties, etc. In particular ACPI is still a total mystery to me,
> >> though passing a single address from guest to host can't be that har=
d,
> >> can it?
> >>=20
> >> Any clues would be appreciated.
> >>=20
> >> --Ed
> >=20
> > It might be best to just re-start from the beginning.
> > So the idea is that ACPI should be about supplying the address
> > to guest. To supply address to host we'll use fw cfg.
> > This would be new I think:
> >=20
> > - add support for writeable fw cfg blobs
> patch applied
> > - add linker/loader command to write address of a blob into
> >  such a fw cfg file
> > - add a new file used for vm gen id, use loader command above
> >  to pass the address of a blob allocated for it to host
> I don=E2=80=99t really understand the meaning of =E2=80=9Cfile=E2=80=9D=
 in this context.  It seems to be a way of specifying individual fw_cfg e=
ntries without explicitly giving an index, but is not something that is v=
isible in either the host or guest file system.  Is this about right?  In=
 my code I=E2=80=99m using =E2=80=9C/etc/vmgenid=E2=80=9D

yes

> As for the blob, I=E2=80=99m thinking this is where my main problem is.=
  The =E2=80=98fw_cfg_add_*()=E2=80=99 functions take a data pointer but =
doesn=E2=80=99t seem to copy the data anywhere.  We pass essentially a po=
inter via ACPI to the guest, so what it points to needs to be in an acces=
sible region.  I don=E2=80=99t get how to define the blob contents.  Ther=
e are command-line =E2=80=98fw-cfg=E2=80=99 options where you can specify=
 a file, but it=E2=80=99s not clear to me how to use them.  Maybe I reser=
ve some IO memory or something?

Not sure I understand the question. fw cfg device will make
memory accessible to guest. Put the guest physical address there.
the address needs to be calculated by linker.



> > - whenever vm gen id changes, update file, if we have address
> >  of blob update that as well
> Will do that once I understand the other parts
> > - use linker to patch address of blob into acpi as well
> >  it needs to be in a separate ssdt at top level
> >  otherwise it's hard to figure out the offset.
> I have this going into a separate SSDT and can decode it using iasl on =
the guest:
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> [root@playground ~]# cat SSDT.dsl=20
> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20150717-64
>  * Copyright (c) 2000 - 2015 Intel Corporation
>  *=20
>  * Disassembling to symbolic ASL+ operators
>  *
>  * Disassembly of SSDT, Tue Dec  6 16:35:14 2016
>  *
>  * Original Table Header:
>  *     Signature        "SSDT"
>  *     Length           0x0000007C (124)
>  *     Revision         0x01
>  *     Checksum         0x29
>  *     OEM ID           "BOCHS "
>  *     OEM Table ID     "VMGENID"
>  *     OEM Revision     0x00000001 (1)
>  *     Compiler ID      "BXPC"
>  *     Compiler Version 0x00000001 (1)
>  */
> DefinitionBlock ("SSDT.aml", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001=
)
> {
>     Scope (_SB)
>     {
>         Device (VGEN)
>         {
>             Name (_HID, "QEMU0003")  // _HID: Hardware ID
>             Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
>             Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
>             Name (ADDR, Package (0x02)
>             {
>                 0xE7AAD010,=20
>                 0x559F
>             })
>         }
>     }
> }
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> The address you see is the address of the host memory where I have the =
GUID stored, so is obviously incorrect.
>=20
> >=20
> > This can be reused from one of the previus versions:
> > - command line, interrupts and commands to update vm gen id
> >=20
> I have these all applied and can set/get the GUID via the QMP shell, an=
d can pass GUID via QEMU command line.  As for parsing the input, I have =
it modeled as a device right on the sysbus.  Is this how it should be don=
e, or would I pass the GUID in via the =E2=80=98fw_cfg=E2=80=99 command-l=
ine options, or something else?  It=E2=80=99s a bit problematic as-is bec=
ause it depends on machine types that allow dynamic-sysbus.
> > I can help with acpi if all the rest is clear.
> >=20
>=20
>=20
> > --=20
> > MST
> >=20
> >=20
> Sorry for being so dense - I think once I get the main concepts the res=
t of this should be straightforward.  I=E2=80=99m happy to post a patch o=
f the current work if that would help.  Thanks in advance for your help.
>=20
> =E2=80=94Ben
