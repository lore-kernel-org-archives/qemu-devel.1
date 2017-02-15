Received: from eggs.gnu.org ([2001:4830:134:3::10]:40371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce3yY-00038i-No
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce3yT-0001uz-IF
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:06:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ce3yT-0001uh-7f
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:06:41 -0500
Date: Wed, 15 Feb 2017 20:06:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170215200506-mutt-send-email-mst@kernel.org>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<5216BB96-2CB8-4E83-8950-40E44EE5264D@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5216BB96-2CB8-4E83-8950-40E44EE5264D@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Wed, Feb 15, 2017 at 09:54:08AM -0800, Ben Warren wrote:
>=20
>     On Feb 15, 2017, at 9:43 AM, Igor Mammedov <imammedo@redhat.com> wr=
ote:
>=20
>     On Wed, 15 Feb 2017 18:39:06 +0200
>     "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>=20
>         On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Mammedov wrote:
>=20
>             On Wed, 15 Feb 2017 17:30:00 +0200
>             "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>=20
>                 On Wed, Feb 15, 2017 at 04:22:25PM +0100, Igor Mammedov=
 wrote:
>                 =20
>=20
>                     On Wed, 15 Feb 2017 15:13:20 +0100
>                     Laszlo Ersek <lersek@redhat.com> wrote:
>=20
>=20
>                         Commenting under Igor's reply for simplicity
>=20
>                         On 02/15/17 11:57, Igor Mammedov wrote:   =20
>=20
>                             On Tue, 14 Feb 2017 22:15:43 -0800
>                             ben@skyportsystems.com wrote:
>=20
>=20
>                                 From: Ben Warren <ben@skyportsystems.co=
m>
>=20
>                                 This is similar to the existing 'add po=
inter'
>                                 functionality, but instead
>                                 of instructing the guest (BIOS or UEFI)=
 to
>                                 patch memory, it instructs
>                                 the guest to write the pointer back to =
QEMU via
>                                 a writeable fw_cfg file.
>=20
>                                 Signed-off-by: Ben Warren <
>                                 ben@skyportsystems.com>
>                                 ---
>                                 hw/acpi/bios-linker-loader.c         | =
58
>                                 ++++++++++++++++++++++++++++++++++--
>                                 include/hw/acpi/bios-linker-loader.h | =
 6 ++++
>                                 2 files changed, 61 insertions(+), 3 de=
letions
>                                 (-)
>=20
>                                 diff --git a/hw/acpi/bios-linker-loader=
.c b/hw/
>                                 acpi/bios-linker-loader.c
>                                 index d963ebe..5030cf1 100644
>                                 --- a/hw/acpi/bios-linker-loader.c
>                                 +++ b/hw/acpi/bios-linker-loader.c
>                                 @@ -78,6 +78,19 @@ struct BiosLinkerLoa=
derEntry
>                                 {
>                                             uint32_t length;
>                                         } cksum;
>=20
>                                 +        /*
>                                 +         * COMMAND_WRITE_POINTER - wri=
te the
>                                 fw_cfg file (originating from
>                                 +         * @dest_file) at @wr_pointer.=
offset,
>                                 by adding a pointer to the table
>                                 +         * originating from @src_file.=
 1,2,4
>                                 or 8 byte unsigned
>                                 +         * addition is used depending =
on
>                                 @wr_pointer.size.
>                                 +         */     =20
>=20
>=20
>                         The words "adding" and "addition" are causing c=
onfusion
>                         here.
>=20
>                         In all of the previous discussion, *addition* w=
as out
>                         of scope from
>                         WRITE_POINTER. Again, the firmware is specifica=
lly not
>                         required to
>                         *read* any part of the fw_cfg blob identified b=
y
>                         "dest_file".
>=20
>                         WRITE_POINTER instructs the firmware to return =
the
>                         allocation address of
>                         the downloaded "src_file" to QEMU. Any necessar=
y
>                         runtime subscripting
>                         within "src_file" is to be handled by QEMU code
>                         dynamically.
>=20
>                         For example, consider that "src_file" has *seve=
ral*
>                         fields that QEMU
>                         wants to massage; in that case, indexing within=
 QEMU
>                         code with field
>                         offsets is simply unavoidable.   =20
>=20
>                     what I don't like here is that this indexing would =
be
>                     rather fragile
>                     and has to be done in different parts of QEMU /devi=
ce, AML
>                     /.
>=20
>                     I'd prefer this helper function to have the same
>                     @src_offset
>                     behavior as ADD_POINTER where patched address could=
 point
>                     to
>                     any part of src_file i.e. not just beginning.   =20
>=20
>=20
>=20
>=20
>                        /*
>                         * COMMAND_ADD_POINTER - patch the table (origin=
ating
>                 from
>                         * @dest_file) at @pointer.offset, by adding a p=
ointer
>                 to the table
>                         * originating from @src_file. 1,2,4 or 8 byte u=
nsigned
>                         * addition is used depending on @pointer.size.
>                         */
>=20
>                 so the way ADD works is
>                 read at offset
>                 add table address
>                 write result at offset
>=20
>                 in other words it is always beginning of table that is =
added. =20
>=20
>             more exactly it's, read at=20
>              src_offset =3D *(dst_blob_ptr+dst_offset)
>              *(dst_blob+dst_offset) =3D src_blob_ptr + src_offset
>=20
>=20
>                 Would the following be acceptable?
>=20
>=20
>                         * COMMAND_WRITE_POINTER - update the fw_cfg fil=
e
>                 (originating from
>                         * @dest_file) at @wr_pointer.offset, by writing=
 a
>                 pointer to the table
>                         * originating from @src_file. 1,2,4 or 8 byte u=
nsigned
>                 value
>                         * is written depending on @wr_pointer.size. =20
>=20
>             it looses 'adding' part of ADD_POINTER command which handle=
s
>             src_offset,
>             however implementing adding part looks a bit complicated
>             as patched blob (dst) is not in guest memory but in QEMU an=
d
>             on reset *(dst_blob+dst_offset) should be reset to src_offs=
et.
>             Considering dst file could be device specific memory (field=
/blob/
>             whatever)
>             it could be hard to track/notice proper reset behavior.
>=20
>             So now I'm not sure if src_offset is worth adding. =20
>=20
>=20
>         Right. Let's just do this math in QEMU if we have to.
>=20
>     Math complicates QEMU code though and not only QMEMU but AML code a=
s well.
>     Considering that we are adding a new command and don't have to keep
>     any sort of compatibility we can pass src_offset as part
>     of command instead of hiding it inside of dst_file.
>     Something like this:
>=20
>            /*
>             * COMMAND_WRITE_POINTER - write the fw_cfg file (originatin=
g from
>             * @dest_file) at @wr_pointer.offset, by writing a pointer t=
o
>     @src_offset
>             * within the table originating from @src_file. 1,2,4 or 8 b=
yte
>     unsigned
>             * addition is used depending on @wr_pointer.size.
>             */
>            struct {
>                 char dest_file[BIOS_LINKER_LOADER_FILESZ];
>                 char src_file[BIOS_LINKER_LOADER_FILESZ];
>     -            uint32_t offset;
>     +            uint32_t dst_offset;
>     +            uint32_t src_offset;
>                 uint8_t size;
>            } wr_pointer;
>=20
>=20
> OK, this is easy enough to do and maybe we=E2=80=99ll have a use case i=
n the future.
>  I=E2=80=99ll make this change in v7


So if you do, you want to set it to VMGENID_GUID_OFFSET.

>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>                         (1) So, the above looks correct, but please rep=
lace
>                         "adding" with
>                         "storing", and "unsigned addition" with "store"=
.
>=20
>                         Side point: the case for ADD_POINTER is differe=
nt;
>                         there we patch
>                         several individual ACPI objects. The fact that =
I
>                         requested explicit
>                         addition within the ADDR method, as opposed to
>                         pre-setting VGIA to a
>                         nonzero offset, is an *incidental* limitation (=
coming
>                         from the OVMF ACPI
>                         SDT header probe suppressor), and we'll likely =
fix that
>                         up later, with
>                         ALLOCATE command hints or something like that. =
However,
>                         in
>                         WRITE_POINTER, asking for the exact allocation =
address
>                         of "src_file" is
>                         an *inherent* characteristic.
>=20
>                         For reference, this is the command's descriptio=
n from
>                         the (not as yet
>                         posted) OVMF series:
>=20
>                         // QemuLoaderCmdWritePointer: the bytes at
>                         // [PointerOffset..PointerOffset+PointerSize) i=
n the
>                         writeable fw_cfg
>                         // file PointerFile are to receive the absolute=
 address
>                         of PointeeFile,
>                         // as allocated and downloaded by the firmware.=
 Store
>                         the base address
>                         // of where PointeeFile's contents have been pl=
aced
>                         (when
>                         // QemuLoaderCmdAllocate has been executed for
>                         PointeeFile) to this
>                         // portion of PointerFile.
>                         //
>                         // This command is similar to QemuLoaderCmdAddP=
ointer;
>                         the difference is
>                         // that the "pointer to patch" does not exist i=
n
>                         guest-physical address
>                         // space, only in "fw_cfg file space". In addit=
ion, the
>                         "pointer to
>                         // patch" is not initialized by QEMU with a pos=
sibly
>                         nonzero offset
>                         // value: the base address of the memory alloca=
ted for
>                         downloading
>                         // PointeeFile shall not increment the pointer,=
 but
>                         overwrite it.
>=20
>                         In the last SeaBIOS patch series, namely
>=20
>                         [SeaBIOS] [PATCH v3 2/2] QEMU fw_cfg: Add comma=
nd to
>                         write back address
>                                                 of file
>=20
>                         function romfile_loader_write_pointer() impleme=
nted
>                         just that plain
>                         store (not an addition), and that was exactly r=
ight.
>=20
>                         Continuing:
>=20
>=20
>                                 +        struct {
>                                 +            char dest_file
>                                 [BIOS_LINKER_LOADER_FILESZ];
>                                 +            char src_file
>                                 [BIOS_LINKER_LOADER_FILESZ];
>                                 +            uint32_t offset;
>                                 +            uint8_t size;
>                                 +        } wr_pointer;
>                                 +
>                                         /* padding */
>                                         char pad[124];
>                                     };
>                                 @@ -85,9 +98,10 @@ struct BiosLinkerLoa=
derEntry
>                                 {
>                                 typedef struct BiosLinkerLoaderEntry
>                                 BiosLinkerLoaderEntry;
>=20
>                                 enum {
>                                 -    BIOS_LINKER_LOADER_COMMAND_ALLOCAT=
E     =3D
>                                 0x1,
>                                 -    BIOS_LINKER_LOADER_COMMAND_ADD_POI=
NTER  =3D
>                                 0x2,
>                                 -    BIOS_LINKER_LOADER_COMMAND_ADD_CHE=
CKSUM =3D
>                                 0x3,
>                                 +    BIOS_LINKER_LOADER_COMMAND_ALLOCAT=
E
>                                          =3D 0x1,
>                                 +    BIOS_LINKER_LOADER_COMMAND_ADD_POI=
NTER
>                                       =3D 0x2,
>                                 +    BIOS_LINKER_LOADER_COMMAND_ADD_CHE=
CKSUM
>                                      =3D 0x3,
>                                 +    BIOS_LINKER_LOADER_COMMAND_WRITE_P=
OINTER
>                                     =3D 0x4,
>                                 };
>=20
>                                 enum {
>                                 @@ -278,3 +292,41 @@ void
>                                 bios_linker_loader_add_pointer(BIOSLink=
er
>                                 *linker,
>=20
>                                     g_array_append_vals(linker->cmd_blo=
b, &
>                                 entry, sizeof entry);
>                                 }
>                                 +
>                                 +/*
>                                 + * bios_linker_loader_write_pointer: a=
sk guest
>                                 to write a pointer to the
>                                 + * source file into the destination fi=
le, and
>                                 write it back to QEMU via
>                                 + * fw_cfg DMA.
>                                 + *
>                                 + * @linker: linker object instance
>                                 + * @dest_file: destination file that m=
ust be
>                                 written
>                                 + * @dst_patched_offset: location withi=
n
>                                 destination file blob to be patched
>                                 + *                      with the point=
er to
>                                 @src_file, in bytes
>                                 + * @dst_patched_offset_size: size of t=
he
>                                 pointer to be patched
>                                 + *                      at @dst_patche=
d_offset
>                                 in @dest_file blob, in bytes
>                                 + * @src_file: source file who's addres=
s must
>                                 be taken
>                                 + */
>                                 +void bios_linker_loader_write_pointer
>                                 (BIOSLinker *linker,
>                                 +                                    co=
nst char
>                                 *dest_file,
>                                 +                                    ui=
nt32_t
>                                 dst_patched_offset,
>                                 +                                    ui=
nt8_t
>                                 dst_patched_size,
>                                 +                                    co=
nst char
>                                 *src_file)     =20
>=20
>                             API is missing "src_offset" even though it'=
s not
>                             used in this series,
>                             a patch on top to fix it up is ok for me as=
 far as
>                             Seabios/OVMF
>                             counterpart can handle src_offset correctly=
 from
>                             starters.     =20
>=20
>=20
>                         According to the above, it is the right thing n=
ot to
>                         add "src_offset"
>                         here. The documentation on the command is sligh=
tly
>                         incorrect (and causes
>                         confusion), but the helper function's signature=
 and
>                         comments are okay.
>=20
>=20
>=20
>=20
>                                 +{
>                                 +    BiosLinkerLoaderEntry entry;
>                                 +    const BiosLinkerFileEntry *source_=
file =3D
>                                 +        bios_linker_find_file(linker,
>                                 src_file);
>                                 +
>                                 +    assert(source_file);     =20
>=20
>=20
>                         I wish we kept the following asserts from
>                         bios_linker_loader_add_pointer():
>=20
>                            assert(dst_patched_offset < dst_file->blob->=
len);
>                            assert(dst_patched_offset + dst_patched_size=
 <=3D
>                         dst_file->blob->len);
>=20
>                         Namely, just because the dst_file is never supp=
osed to
>                         be downloaded by
>                         the firmware, it still remains a requirement th=
at the
>                         "dst file offset
>                         range" that is to be rewritten *do fall* within=
 the dst
>                         file.
>=20
>                         Nonetheless, this is not critical. (OVMF at lea=
st
>                         verifies it anyway.)
>=20
>                         Summary (from my side anyway): I feel that the
>                         documentation of the new
>                         command is very important. Please fix it up as
>                         suggested under (1), in
>                         v7. Regarding the asserts, I'll let you decide.
>=20
>                         With the documentation fixed up:
>=20
>                         Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
>                         (If you don't wish to post a v7, I'm also compl=
etely
>                         fine if Michael or
>                         someone else fixes up the docs as proposed in (=
1),
>                         before committing the
>                         patch.)
>=20
>                         Thanks!
>                         Laszlo
>=20
>=20
>                                 +    memset(&entry, 0, sizeof entry);
>                                 +    strncpy(entry.wr_pointer.dest_file=
,
>                                 dest_file,
>                                 +            sizeof entry.wr_pointer.de=
st_file
>                                 - 1);
>                                 +    strncpy(entry.wr_pointer.src_file,
>                                 src_file,
>                                 +            sizeof entry.wr_pointer.sr=
c_file -
>                                 1);
>                                 +    entry.command =3D cpu_to_le32
>                                 (BIOS_LINKER_LOADER_COMMAND_WRITE_POINT=
ER);
>                                 +    entry.wr_pointer.offset =3D cpu_to=
_le32
>                                 (dst_patched_offset);
>                                 +    entry.wr_pointer.size =3D dst_patc=
hed_size;
>                                 +    assert(dst_patched_size =3D=3D 1 |=
|
>                                 dst_patched_size =3D=3D 2 ||
>                                 +           dst_patched_size =3D=3D 4 |=
|
>                                 dst_patched_size =3D=3D 8);
>                                 +
>                                 +    g_array_append_vals(linker->cmd_bl=
ob, &
>                                 entry, sizeof entry);
>                                 +}
>                                 diff --git a/include/hw/acpi/
>                                 bios-linker-loader.h b/include/hw/acpi/
>                                 bios-linker-loader.h
>                                 index fa1e5d1..f9ba5d6 100644
>                                 --- a/include/hw/acpi/bios-linker-loade=
r.h
>                                 +++ b/include/hw/acpi/bios-linker-loade=
r.h
>                                 @@ -26,5 +26,11 @@ void
>                                 bios_linker_loader_add_pointer(BIOSLink=
er
>                                 *linker,
>                                                                     con=
st char
>                                 *src_file,
>                                                                     uin=
t32_t
>                                 src_offset);
>=20
>                                 +void bios_linker_loader_write_pointer
>                                 (BIOSLinker *linker,
>                                 +                                      =
const
>                                 char *dest_file,
>                                 +                                      =
uint32_t
>                                 dst_patched_offset,
>                                 +                                      =
uint8_t
>                                 dst_patched_size,
>                                 +                                      =
const
>                                 char *src_file);
>                                 +
>                                 void bios_linker_loader_cleanup(BIOSLin=
ker
>                                 *linker);
>                                 #endif     =20
>=20
>=20
