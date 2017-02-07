Received: from eggs.gnu.org ([2001:4830:134:3::10]:60210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb6Ba-000713-MO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb6BX-0007Vp-Lb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:51:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cb6BX-0007Va-FB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:51:55 -0500
Date: Tue, 7 Feb 2017 14:51:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170207145151.42fb0cc6@nial.brq.redhat.com>
In-Reply-To: <e531606c10f3c40dbc10d0fa4a4a5d806d7946d9.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<e531606c10f3c40dbc10d0fa4a4a5d806d7946d9.1486285434.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/10] ACPI: Add a function for building
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
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Sun,  5 Feb 2017 01:11:56 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> This is initially used to patch a 64-bit address into
> the VM Generation ID SSDT
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
...
> +int
> +build_append_named_qword(GArray *array, const char *name_format, ...)
it ain't used anywhere, I'd just drop this patch.

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
> +    build_append_int_noprefix(array, 0x0000000000000000, 8);
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
