Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWSQ1-0006ek-7c
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWSPx-0006RZ-ST
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:35:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cWSPx-0006RP-CM
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:35:37 -0500
Date: Wed, 25 Jan 2017 20:35:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170125202812-mutt-send-email-mst@kernel.org>
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
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
To: Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Jan 25, 2017 at 09:36:52AM -0800, Ben Warren wrote:
> Hi Laszlo,
>=20
>=20
>     On Jan 24, 2017, at 7:55 PM, Laszlo Ersek <lersek@redhat.com> wrote=
:
>=20
>     Hi Ben,
>=20
>     sorry about being late to reviewing this series. I hope I can now s=
pend
>     more time on it.
>=20
>     - Please do not try to address my comments immediately. It's very
>     possible (even likely) that Igor, MST and myself could have differe=
nt
>     opinions on things, so first please await agreement between your re=
viewers.
>=20
>=20
> Thanks for the very detailed review.  I=E2=80=99ll give it a couple of =
days and then
> start work on the suggested changes.
>=20
>=20
>     - I think you should have CC'd Igor and Michael directly. I'm addin=
g
>     them to this reply; hopefully that will be enough for them to monit=
or
>     this series.
>=20
>     - I'll likely be unable to review everything with 100% coverage; so
>     addressing (or sufficiently refuting) my comments might not guarant=
ee
>     that the next version will be merged at once.
>=20
>     With all that said:
>=20
>     On 01/25/17 02:43, ben@skyportsystems.com wrote:
>=20
>         From: Ben Warren <ben@skyportsystems.com>
>=20
>         This is initially used to patch a 64-bit address into the VM Ge=
neration
>         ID SSDT
>=20
>=20
>     (1) I think this commit message line is overlong; I think we wrap a=
t 74
>     chars or so. Not critical, but worth mentioning.
>=20
>=20
>=20
>         Signed-off-by: Ben Warren <ben@skyportsystems.com>
>         ---
>         hw/acpi/aml-build.c         | 28 ++++++++++++++++++++++++++++
>         include/hw/acpi/aml-build.h |  4 ++++
>         2 files changed, 32 insertions(+)
>=20
>         diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>         index b2a1e40..dc4edc2 100644
>         --- a/hw/acpi/aml-build.c
>         +++ b/hw/acpi/aml-build.c
>         @@ -285,6 +285,34 @@ build_append_named_dword(GArray *array, co=
nst char
>         *name_format, ...)
>             return offset;
>         }
>=20
>         +/*
>         + * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as=
 a
>         qword,
>         + * and return the offset to 0x00000000 for runtime patching.
>         + *
>         + * Warning: runtime patching is best avoided. Only use this as
>         + * a replacement for DataTableRegion (for guests that don't
>         + * support it).
>         + */

only one comment: QWords first appeared in ACPI 2.0 and
XP does not like them. Not strictly a blocker as people can
avoid using the feature, but nice to have.
Will either UEFI or seabios allocate
memory outside 4G range? If not you do not need a qword.




>=20
>     (2) Since we're adding a qword (8-byte integer), the hexadecimal
>     constant should have 16 nibbles: 0x0000000000000000. (After copying=
 the
>     comment from build_append_named_dword(), it should be actualized.)
>=20
>     (3) Normally the functions in this file that create AML operators c=
arry
>     a note about the ACPI spec version and exact location that defines =
the
>     operator. I see that commit f20354910893 ("acpi: add
>     build_append_named_dword, returning an offset in buffer", 2016-03-0=
1)
>     missed that too.
>=20
>     Unless this tradition has been willfully abandoned, I suggest that =
you
>     add the right reference here, and also (in retrospect) to
>     build_append_named_dword().
>=20
>=20
>         +int
>         +build_append_named_qword(GArray *array, const char *name_forma=
t, ...)
>         +{
>         +    int offset;
>         +    va_list ap;
>         +
>         +    build_append_byte(array, 0x08); /* NameOp */
>         +    va_start(ap, name_format);
>         +    build_append_namestringv(array, name_format, ap);
>         +    va_end(ap);
>         +
>         +    build_append_byte(array, 0x0E); /* QWordPrefix */
>         +
>         +    offset =3D array->len;
>         +    build_append_int_noprefix(array, 0x00000000, 8);
>=20
>=20
>     (4) I guess the constant should be updated here too, for consistenc=
y
>     with the comment.
>=20
>     The rest looks okay. (I didn't verify 0x0E =3D=3D QWordPrefix speci=
fically,
>     because an error there would break the functionality immediately, a=
nd
>     you'd notice.)
>=20
>     Thanks!
>     Laszlo
>=20
>=20
>         +    assert(array->len =3D=3D offset + 8);
>         +
>         +    return offset;
>         +}
>         +
>         static GPtrArray *alloc_list;
>=20
>         static Aml *aml_alloc(void)
>         diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-=
build.h
>         index 559326c..dbf63cf 100644
>         --- a/include/hw/acpi/aml-build.h
>         +++ b/include/hw/acpi/aml-build.h
>         @@ -385,6 +385,10 @@ int
>         build_append_named_dword(GArray *array, const char *name_format=
, ...)
>         GCC_FMT_ATTR(2, 3);
>=20
>         +int
>         +build_append_named_qword(GArray *array, const char *name_forma=
t, ...)
>         +GCC_FMT_ATTR(2, 3);
>         +
>         void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_=
t base,
>                                uint64_t len, int node, MemoryAffinityFl=
ags
>         flags);
>=20
>=20
> =E2=80=94Ben
>=20
