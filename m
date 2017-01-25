Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWO7h-0007IS-HC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWO7d-0002GE-VV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:00:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWO7d-0002Fy-Pf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:00:25 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<b9ead8f0965c42f78e73e17e461ef7f476ae4318.1485308342.git.ben@skyportsystems.com>
	<be3cd2b4-9a33-5c2c-902a-8a5967518348@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09603363-b148-ec6c-8cca-74758af722ff@redhat.com>
Date: Wed, 25 Jan 2017 15:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <be3cd2b4-9a33-5c2c-902a-8a5967518348@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org

On 01/25/17 11:04, Laszlo Ersek wrote:

> (7) The blob constructed in this function, as a GArray, should be the
> exact same object that is later linked into fw_cfg, via acpi_setup() -->
> vmgenid_add_fw_cfg().
> 
> Currently, the blob is allocated here under the variable "guid", and
> passed to bios_linker_loader_alloc_ret_addr(). That results in the
> creation of a new BiosLinkerFileEntry object, with the "blob" field
> being set to "guid".
> 
> However, in vmgenid_add_fw_cfg(), the VmGenIdState.guid.data field is
> linked into fw_cfg. This is incorrect, those objects are independent,
> but they should be the same.
> 
> Here's how to implement it:
> 
> * Add the field
> 
>     GArray *vmgenid
> 
>   to the "AcpiBuildTables" structure in "include/hw/acpi/aml-build.h",
>   under the "tcpalog" field.
> 
> * Extend the acpi_build_tables_init() and acpi_build_tables_cleanup()
>   functions in "hw/acpi/aml-build.c", so that the new field is
>   initialized and released.

In acpi_build_tables_cleanup(), the line you need is

    g_array_free(tables->vmgenid, mfre);

similarly to "tcpalog".

> 
> * In the acpi_build() function, pass "tables->vmgenid" to
>   vmgenid_build_acpi(). This will require the a new parameter for the
>   latter function.
> 
> * In vmgenid_build_acpi(), construct the blob as described under (5)
>   and (6).
> 
> * In the acpi_setup() function, pass "tables.vmgenid" to
>   vmgenid_add_fw_cfg(). (Again, new function parameter is necessary.)
> 
> * In vmgenid_add_fw_cfg(), link "tables.vmgenid->data" into fw_cfg, not
>   VmGenIdState.guid.data.

Thanks
Laszlo
