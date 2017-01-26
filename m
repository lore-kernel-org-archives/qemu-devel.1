Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWlqZ-00087g-Ux
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWlqU-00085Q-NC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:20:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cWlqU-00085H-Dl
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:20:18 -0500
Date: Thu, 26 Jan 2017 17:20:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170126165015-mutt-send-email-mst@kernel.org>
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Thu, Jan 26, 2017 at 01:48:37AM +0100, Laszlo Ersek wrote:
> On 01/25/17 19:35, Michael S. Tsirkin wrote:
> > On Wed, Jan 25, 2017 at 09:36:52AM -0800, Ben Warren wrote:
> >> Hi Laszlo,
> >>
> >>
> >>     On Jan 24, 2017, at 7:55 PM, Laszlo Ersek <lersek@redhat.com> wr=
ote:
> >>
> >>     Hi Ben,
> >>
> >>     sorry about being late to reviewing this series. I hope I can no=
w spend
> >>     more time on it.
> >>
> >>     - Please do not try to address my comments immediately. It's ver=
y
> >>     possible (even likely) that Igor, MST and myself could have diff=
erent
> >>     opinions on things, so first please await agreement between your=
 reviewers.
> >>
> >>
> >> Thanks for the very detailed review.  I=E2=80=99ll give it a couple =
of days and then
> >> start work on the suggested changes.
> >>
> >>
> >>     - I think you should have CC'd Igor and Michael directly. I'm ad=
ding
> >>     them to this reply; hopefully that will be enough for them to mo=
nitor
> >>     this series.
> >>
> >>     - I'll likely be unable to review everything with 100% coverage;=
 so
> >>     addressing (or sufficiently refuting) my comments might not guar=
antee
> >>     that the next version will be merged at once.
> >>
> >>     With all that said:
> >>
> >>     On 01/25/17 02:43, ben@skyportsystems.com wrote:
> >>
> >>         From: Ben Warren <ben@skyportsystems.com>
> >>
> >>         This is initially used to patch a 64-bit address into the VM=
 Generation
> >>         ID SSDT
> >>
> >>
> >>     (1) I think this commit message line is overlong; I think we wra=
p at 74
> >>     chars or so. Not critical, but worth mentioning.
> >>
> >>
> >>
> >>         Signed-off-by: Ben Warren <ben@skyportsystems.com>
> >>         ---
> >>         hw/acpi/aml-build.c         | 28 +++++++++++++++++++++++++++=
+
> >>         include/hw/acpi/aml-build.h |  4 ++++
> >>         2 files changed, 32 insertions(+)
> >>
> >>         diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> >>         index b2a1e40..dc4edc2 100644
> >>         --- a/hw/acpi/aml-build.c
> >>         +++ b/hw/acpi/aml-build.c
> >>         @@ -285,6 +285,34 @@ build_append_named_dword(GArray *array,=
 const char
> >>         *name_format, ...)
> >>             return offset;
> >>         }
> >>
> >>         +/*
> >>         + * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded=
 as a
> >>         qword,
> >>         + * and return the offset to 0x00000000 for runtime patching=
.
> >>         + *
> >>         + * Warning: runtime patching is best avoided. Only use this=
 as
> >>         + * a replacement for DataTableRegion (for guests that don't
> >>         + * support it).
> >>         + */
> >=20
> > only one comment: QWords first appeared in ACPI 2.0 and
> > XP does not like them. Not strictly a blocker as people can
> > avoid using the feature, but nice to have.
>=20
> Does XP have a driver for VMGENID?
>=20
> If not, then I'd prefer to stick with the qword VGIA.

Not sure but in any case even if it won't be able to use it we also
don't want it to crash.

> > Will either UEFI or seabios allocate
> > memory outside 4G range? If not you do not need a qword.
>=20
> Good point (assuming XP has a driver for VMGENID).
>=20
> OVMF keeps all such allocations (i.e., for COMMAND_ALLOCATE and the
> upcoming COMMAND_ALLOCATE_RETURN_ADDR) under 4GB, so as far as OVMF is
> concerned, using a dword for the VGIA named object should be fine.
> Accordingly, a 4-byte wide ADD_POINTER command should be used for
> patching VGIA.
>=20
> Considering the fw_cfg file that receives the address, and
> COMMAND_ALLOCATE_RETURN_ADDR more generally, I'd still prefer if those
> stayed 8-byte wide, regardless of XP's support for VMGENID.
>=20
>=20
> Hm... It looks like VMGENID *can* be consumed on Windows XP SP3, as lon=
g
> as "Hyper-V integration services" are installed:
>=20
> https://msdn.microsoft.com/en-us/library/jj643357(v=3Dvs.85).aspx
>=20
>     The virtual machine must be running a guest operating system that
>     has support for the virtual machine generation identifier.
>     Currently, these are the following.
>     The following operating systems have native support for the virtual
>     machine generation identifier.
>       [...]
>=20
>     The following operating can be used as the guest operating system
>     if the Hyper-V integration services from Windows 8 or Windows
>     Server 2012 are installed.
>=20
>       [...]
>       * Windows XP with Service Pack 3 (SP3)
>=20
> Additionally, under
> <https://technet.microsoft.com/en-us/library/dn792027(v=3Dws.11).aspx>:
>=20
>     Supported Windows client guest operating systems
>=20
>     Windows XP with       [...] Install the integration  [...]
>     Service Pack 3 (SP3)        services after you set
>                                 up the operating system
>                                 in the virtual machine.
>=20
> This seems to be consistent with the VMGENID spec requirement that the
> ADDR method return a package of two 32-bit integers, not a single 64-bi=
t
> one.
>=20
> So, I agree with using a dword for VGIA (and a matching 4-byte wide
> ADD_POINTER command).
>=20
> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.


What is COMMAND_ALLOCATE_RETURN_ADDR? I'm only familiar with
COMMAND_ALLOCATE. If we want to allow this stuff in high 64 bit, as you
correctly say we will need a new zone to allocate 64 bit memory.
As for XP support - might it be reasonable to require that
these machines have less than 4G RAM at boot?


> In the future we might introduce more allocation hints (for the "zone"
> field) that would enable the firmware to allocate from the full 64-bit
> address space.

The difficulty with new commands always was compatibility with old
firmware. I guess now that we have writeable fw cfg we will be
able to support negotiation cleanly.

Should we start now?

> NB, I didn't check SeaBIOS (should be easy for Ben); AFAIR it only uses
> 16-bit and 32-bit modes.
>=20
> Thanks!
> Laszlo

Right.

> >=20
> >=20
> >=20
> >=20
> >>
> >>     (2) Since we're adding a qword (8-byte integer), the hexadecimal
> >>     constant should have 16 nibbles: 0x0000000000000000. (After copy=
ing the
> >>     comment from build_append_named_dword(), it should be actualized=
.)
> >>
> >>     (3) Normally the functions in this file that create AML operator=
s carry
> >>     a note about the ACPI spec version and exact location that defin=
es the
> >>     operator. I see that commit f20354910893 ("acpi: add
> >>     build_append_named_dword, returning an offset in buffer", 2016-0=
3-01)
> >>     missed that too.
> >>
> >>     Unless this tradition has been willfully abandoned, I suggest th=
at you
> >>     add the right reference here, and also (in retrospect) to
> >>     build_append_named_dword().
> >>
> >>
> >>         +int
> >>         +build_append_named_qword(GArray *array, const char *name_fo=
rmat, ...)
> >>         +{
> >>         +    int offset;
> >>         +    va_list ap;
> >>         +
> >>         +    build_append_byte(array, 0x08); /* NameOp */
> >>         +    va_start(ap, name_format);
> >>         +    build_append_namestringv(array, name_format, ap);
> >>         +    va_end(ap);
> >>         +
> >>         +    build_append_byte(array, 0x0E); /* QWordPrefix */
> >>         +
> >>         +    offset =3D array->len;
> >>         +    build_append_int_noprefix(array, 0x00000000, 8);
> >>
> >>
> >>     (4) I guess the constant should be updated here too, for consist=
ency
> >>     with the comment.
> >>
> >>     The rest looks okay. (I didn't verify 0x0E =3D=3D QWordPrefix sp=
ecifically,
> >>     because an error there would break the functionality immediately=
, and
> >>     you'd notice.)
> >>
> >>     Thanks!
> >>     Laszlo
> >>
> >>
> >>         +    assert(array->len =3D=3D offset + 8);
> >>         +
> >>         +    return offset;
> >>         +}
> >>         +
> >>         static GPtrArray *alloc_list;
> >>
> >>         static Aml *aml_alloc(void)
> >>         diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/a=
ml-build.h
> >>         index 559326c..dbf63cf 100644
> >>         --- a/include/hw/acpi/aml-build.h
> >>         +++ b/include/hw/acpi/aml-build.h
> >>         @@ -385,6 +385,10 @@ int
> >>         build_append_named_dword(GArray *array, const char *name_for=
mat, ...)
> >>         GCC_FMT_ATTR(2, 3);
> >>
> >>         +int
> >>         +build_append_named_qword(GArray *array, const char *name_fo=
rmat, ...)
> >>         +GCC_FMT_ATTR(2, 3);
> >>         +
> >>         void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint=
64_t base,
> >>                                uint64_t len, int node, MemoryAffinit=
yFlags
> >>         flags);
> >>
> >>
> >> =E2=80=94Ben
> >>
> >=20
> >=20
