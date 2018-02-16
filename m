Received: from eggs.gnu.org ([2001:4830:134:3::10]:44693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emdTI-0005pF-4i
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emdTE-0005O1-6S
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:42:28 -0500
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75373e6d-ceb5-f1e5-a535-34871837ca51@redhat.com>
Date: Fri, 16 Feb 2018 11:42:02 +0100
MIME-Version: 1.0
In-Reply-To: <1518735273-16089-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 01/12] s390-ccw: refactor
 boot map table code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 15.02.2018 23:54, Collin L. Walling wrote:
> Some ECKD bootmap code was using structs designed for SCSI.
> Even though this works, it confuses readability. Add a new
> BootMapTable struct to assist with readability in bootmap
> entry code. Also:
> 
> - replace ScsiMbr in ECKD code with appropriate structs
> - fix read_block messages to reflect BootMapTable
> - fixup ipl_scsi to use BootMapTable (referred to as Program Table)
> - defined value for maximum table entries
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 60 +++++++++++++++++++++-------------------------
>  pc-bios/s390-ccw/bootmap.h | 14 +++++++++--
>  2 files changed, 39 insertions(+), 35 deletions(-)
[...]
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index cf99a4c..850b655 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -53,6 +53,15 @@ typedef union BootMapPointer {
>      ExtEckdBlockPtr xeckd;
>  } __attribute__ ((packed)) BootMapPointer;
>  
> +#define MAX_TABLE_ENTRIES  30
> +
> +/* aka Program Table */
> +typedef struct BootMapTable {
> +    uint8_t magic[4];
> +    uint8_t reserved[12];
> +    BootMapPointer entry[];
> +} __attribute__ ((packed)) BootMapTable;
> +
>  typedef struct ComponentEntry {
>      ScsiBlockPtr data;
>      uint8_t pad[7];
> @@ -69,8 +78,9 @@ typedef struct ComponentHeader {
>  typedef struct ScsiMbr {
>      uint8_t magic[4];
>      uint32_t version_id;
> -    uint8_t reserved[8];
> -    ScsiBlockPtr blockptr[];
> +    uint8_t reserved1[8];
> +    ScsiBlockPtr pt;   /* block pointer to program table */
> +    uint8_t reserved2[120];

Did you want to pad the struct to 512 bytes here? If so, I think that
should have been "uint32_t" instead of "uint8_t" or "480" instead of "120" ?

>  } __attribute__ ((packed)) ScsiMbr;
>  
>  #define ZIPL_MAGIC              "zIPL"
> 

 Thomas
