Received: from eggs.gnu.org ([2001:4830:134:3::10]:39714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWYF3-0001Lp-2S
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 19:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWYEz-0002N9-3N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 19:48:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWYEy-0002N3-RI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 19:48:41 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
Date: Thu, 26 Jan 2017 01:48:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170125202812-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 01/25/17 19:35, Michael S. Tsirkin wrote:
> On Wed, Jan 25, 2017 at 09:36:52AM -0800, Ben Warren wrote:
>> Hi Laszlo,
>>
>>
>>     On Jan 24, 2017, at 7:55 PM, Laszlo Ersek <lersek@redhat.com> wrot=
e:
>>
>>     Hi Ben,
>>
>>     sorry about being late to reviewing this series. I hope I can now =
spend
>>     more time on it.
>>
>>     - Please do not try to address my comments immediately. It's very
>>     possible (even likely) that Igor, MST and myself could have differ=
ent
>>     opinions on things, so first please await agreement between your r=
eviewers.
>>
>>
>> Thanks for the very detailed review.  I=E2=80=99ll give it a couple of=
 days and then
>> start work on the suggested changes.
>>
>>
>>     - I think you should have CC'd Igor and Michael directly. I'm addi=
ng
>>     them to this reply; hopefully that will be enough for them to moni=
tor
>>     this series.
>>
>>     - I'll likely be unable to review everything with 100% coverage; s=
o
>>     addressing (or sufficiently refuting) my comments might not guaran=
tee
>>     that the next version will be merged at once.
>>
>>     With all that said:
>>
>>     On 01/25/17 02:43, ben@skyportsystems.com wrote:
>>
>>         From: Ben Warren <ben@skyportsystems.com>
>>
>>         This is initially used to patch a 64-bit address into the VM G=
eneration
>>         ID SSDT
>>
>>
>>     (1) I think this commit message line is overlong; I think we wrap =
at 74
>>     chars or so. Not critical, but worth mentioning.
>>
>>
>>
>>         Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>         ---
>>         hw/acpi/aml-build.c         | 28 ++++++++++++++++++++++++++++
>>         include/hw/acpi/aml-build.h |  4 ++++
>>         2 files changed, 32 insertions(+)
>>
>>         diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>>         index b2a1e40..dc4edc2 100644
>>         --- a/hw/acpi/aml-build.c
>>         +++ b/hw/acpi/aml-build.c
>>         @@ -285,6 +285,34 @@ build_append_named_dword(GArray *array, c=
onst char
>>         *name_format, ...)
>>             return offset;
>>         }
>>
>>         +/*
>>         + * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded a=
s a
>>         qword,
>>         + * and return the offset to 0x00000000 for runtime patching.
>>         + *
>>         + * Warning: runtime patching is best avoided. Only use this a=
s
>>         + * a replacement for DataTableRegion (for guests that don't
>>         + * support it).
>>         + */
>=20
> only one comment: QWords first appeared in ACPI 2.0 and
> XP does not like them. Not strictly a blocker as people can
> avoid using the feature, but nice to have.

Does XP have a driver for VMGENID?

If not, then I'd prefer to stick with the qword VGIA.

> Will either UEFI or seabios allocate
> memory outside 4G range? If not you do not need a qword.

Good point (assuming XP has a driver for VMGENID).

OVMF keeps all such allocations (i.e., for COMMAND_ALLOCATE and the
upcoming COMMAND_ALLOCATE_RETURN_ADDR) under 4GB, so as far as OVMF is
concerned, using a dword for the VGIA named object should be fine.
Accordingly, a 4-byte wide ADD_POINTER command should be used for
patching VGIA.

Considering the fw_cfg file that receives the address, and
COMMAND_ALLOCATE_RETURN_ADDR more generally, I'd still prefer if those
stayed 8-byte wide, regardless of XP's support for VMGENID.


Hm... It looks like VMGENID *can* be consumed on Windows XP SP3, as long
as "Hyper-V integration services" are installed:

https://msdn.microsoft.com/en-us/library/jj643357(v=3Dvs.85).aspx

    The virtual machine must be running a guest operating system that
    has support for the virtual machine generation identifier.
    Currently, these are the following.
    The following operating systems have native support for the virtual
    machine generation identifier.
      [...]

    The following operating can be used as the guest operating system
    if the Hyper-V integration services from Windows 8 or Windows
    Server 2012 are installed.

      [...]
      * Windows XP with Service Pack 3 (SP3)

Additionally, under
<https://technet.microsoft.com/en-us/library/dn792027(v=3Dws.11).aspx>:

    Supported Windows client guest operating systems

    Windows XP with       [...] Install the integration  [...]
    Service Pack 3 (SP3)        services after you set
                                up the operating system
                                in the virtual machine.

This seems to be consistent with the VMGENID spec requirement that the
ADDR method return a package of two 32-bit integers, not a single 64-bit
one.

So, I agree with using a dword for VGIA (and a matching 4-byte wide
ADD_POINTER command).

But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
In the future we might introduce more allocation hints (for the "zone"
field) that would enable the firmware to allocate from the full 64-bit
address space.

NB, I didn't check SeaBIOS (should be easy for Ben); AFAIR it only uses
16-bit and 32-bit modes.

Thanks!
Laszlo

>=20
>=20
>=20
>=20
>>
>>     (2) Since we're adding a qword (8-byte integer), the hexadecimal
>>     constant should have 16 nibbles: 0x0000000000000000. (After copyin=
g the
>>     comment from build_append_named_dword(), it should be actualized.)
>>
>>     (3) Normally the functions in this file that create AML operators =
carry
>>     a note about the ACPI spec version and exact location that defines=
 the
>>     operator. I see that commit f20354910893 ("acpi: add
>>     build_append_named_dword, returning an offset in buffer", 2016-03-=
01)
>>     missed that too.
>>
>>     Unless this tradition has been willfully abandoned, I suggest that=
 you
>>     add the right reference here, and also (in retrospect) to
>>     build_append_named_dword().
>>
>>
>>         +int
>>         +build_append_named_qword(GArray *array, const char *name_form=
at, ...)
>>         +{
>>         +    int offset;
>>         +    va_list ap;
>>         +
>>         +    build_append_byte(array, 0x08); /* NameOp */
>>         +    va_start(ap, name_format);
>>         +    build_append_namestringv(array, name_format, ap);
>>         +    va_end(ap);
>>         +
>>         +    build_append_byte(array, 0x0E); /* QWordPrefix */
>>         +
>>         +    offset =3D array->len;
>>         +    build_append_int_noprefix(array, 0x00000000, 8);
>>
>>
>>     (4) I guess the constant should be updated here too, for consisten=
cy
>>     with the comment.
>>
>>     The rest looks okay. (I didn't verify 0x0E =3D=3D QWordPrefix spec=
ifically,
>>     because an error there would break the functionality immediately, =
and
>>     you'd notice.)
>>
>>     Thanks!
>>     Laszlo
>>
>>
>>         +    assert(array->len =3D=3D offset + 8);
>>         +
>>         +    return offset;
>>         +}
>>         +
>>         static GPtrArray *alloc_list;
>>
>>         static Aml *aml_alloc(void)
>>         diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml=
-build.h
>>         index 559326c..dbf63cf 100644
>>         --- a/include/hw/acpi/aml-build.h
>>         +++ b/include/hw/acpi/aml-build.h
>>         @@ -385,6 +385,10 @@ int
>>         build_append_named_dword(GArray *array, const char *name_forma=
t, ...)
>>         GCC_FMT_ATTR(2, 3);
>>
>>         +int
>>         +build_append_named_qword(GArray *array, const char *name_form=
at, ...)
>>         +GCC_FMT_ATTR(2, 3);
>>         +
>>         void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64=
_t base,
>>                                uint64_t len, int node, MemoryAffinityF=
lags
>>         flags);
>>
>>
>> =E2=80=94Ben
>>
>=20
>=20
