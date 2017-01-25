Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWEgQ-0006FH-MN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWEgL-0002Uf-Qn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:55:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWEgL-0002UY-Dq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:55:37 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <827795cf-5399-7092-267e-e912141931f3@redhat.com>
Date: Wed, 25 Jan 2017 04:55:32 +0100
MIME-Version: 1.0
In-Reply-To: <dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Ben,

sorry about being late to reviewing this series. I hope I can now spend
more time on it.

- Please do not try to address my comments immediately. It's very
possible (even likely) that Igor, MST and myself could have different
opinions on things, so first please await agreement between your reviewers.

- I think you should have CC'd Igor and Michael directly. I'm adding
them to this reply; hopefully that will be enough for them to monitor
this series.

- I'll likely be unable to review everything with 100% coverage; so
addressing (or sufficiently refuting) my comments might not guarantee
that the next version will be merged at once.

With all that said:

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This is initially used to patch a 64-bit address into the VM Generation ID SSDT

(1) I think this commit message line is overlong; I think we wrap at 74
chars or so. Not critical, but worth mentioning.

> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/acpi/aml-build.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/acpi/aml-build.h |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index b2a1e40..dc4edc2 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -285,6 +285,34 @@ build_append_named_dword(GArray *array, const char *name_format, ...)
>      return offset;
>  }
>  
> +/*
> + * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a qword,
> + * and return the offset to 0x00000000 for runtime patching.
> + *
> + * Warning: runtime patching is best avoided. Only use this as
> + * a replacement for DataTableRegion (for guests that don't
> + * support it).
> + */

(2) Since we're adding a qword (8-byte integer), the hexadecimal
constant should have 16 nibbles: 0x0000000000000000. (After copying the
comment from build_append_named_dword(), it should be actualized.)

(3) Normally the functions in this file that create AML operators carry
a note about the ACPI spec version and exact location that defines the
operator. I see that commit f20354910893 ("acpi: add
build_append_named_dword, returning an offset in buffer", 2016-03-01)
missed that too.

Unless this tradition has been willfully abandoned, I suggest that you
add the right reference here, and also (in retrospect) to
build_append_named_dword().

> +int
> +build_append_named_qword(GArray *array, const char *name_format, ...)
> +{
> +    int offset;
> +    va_list ap;
> +
> +    build_append_byte(array, 0x08); /* NameOp */
> +    va_start(ap, name_format);
> +    build_append_namestringv(array, name_format, ap);
> +    va_end(ap);
> +
> +    build_append_byte(array, 0x0E); /* QWordPrefix */
> +
> +    offset = array->len;
> +    build_append_int_noprefix(array, 0x00000000, 8);

(4) I guess the constant should be updated here too, for consistency
with the comment.

The rest looks okay. (I didn't verify 0x0E == QWordPrefix specifically,
because an error there would break the functionality immediately, and
you'd notice.)

Thanks!
Laszlo

> +    assert(array->len == offset + 8);
> +
> +    return offset;
> +}
> +
>  static GPtrArray *alloc_list;
>  
>  static Aml *aml_alloc(void)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 559326c..dbf63cf 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -385,6 +385,10 @@ int
>  build_append_named_dword(GArray *array, const char *name_format, ...)
>  GCC_FMT_ATTR(2, 3);
>  
> +int
> +build_append_named_qword(GArray *array, const char *name_format, ...)
> +GCC_FMT_ATTR(2, 3);
> +
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  
> 
