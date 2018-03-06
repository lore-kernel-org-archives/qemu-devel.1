Received: from eggs.gnu.org ([2001:4830:134:3::10]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7gd-0004z5-Pq
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7ga-0000yR-Do
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:11:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36150
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1et7ga-0000xk-3Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:11:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2688vps049379
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 03:10:58 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghppq9a10-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:10:58 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Mar 2018 08:10:56 -0000
References: <1520317081-5341-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Mar 2018 09:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <1520317081-5341-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <56c10a06-e6ef-0d02-b9e9-342ed95bdfe7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: Move string arrays
 from bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>



On 03/06/2018 07:18 AM, Thomas Huth wrote:
> bootmap.h can currently only be included once - otherwise the linker
> complains about multiple definitions of the "magic" strings. It's a
> bad style to define string arrays in header files, so let's better
> move these to the bootmap.c file instead where they are used.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  v2:
>  - Removed duplicated vol_desc_magic (copy-n-paste error)
> 
>  pc-bios/s390-ccw/bootmap.c | 20 ++++++++++++++++++++
>  pc-bios/s390-ccw/bootmap.h | 19 -------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 29bfd8c..fc2a9fe 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -37,6 +37,26 @@ typedef struct ResetInfo {
> 
>  static ResetInfo save;
> 
> +const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
> +                                  "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> +
> +/*
> + * Match two CCWs located after PSW and eight filler bytes.
> + * From libmagic and arch/s390/kernel/head.S.
> + */
> +const uint8_t linux_s390_magic[] = "\x02\x00\x00\x18\x60\x00\x00\x50\x02\x00"
> +                                   "\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40"
> +                                   "\x40\x40\x40\x40";
> +
> +static inline bool is_iso_vd_valid(IsoVolDesc *vd)
> +{
> +    const uint8_t vol_desc_magic[] = "CD001";
> +
> +    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
> +           vd->version == 0x1 &&
> +           vd->type <= VOL_DESC_TYPE_PARTITION;
> +}
> +
>  static void jump_to_IPL_2(void)
>  {
>      ResetInfo *current = 0;
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index c636626..07eb600 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -375,9 +375,6 @@ static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
>                 "Failed to read boot image!");
>  }
> 
> -const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
> -                                  "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> -
>  #define ISO9660_MAX_DIR_DEPTH 8
> 
>  typedef struct IsoDirHdr {
> @@ -430,20 +427,12 @@ typedef struct IsoVolDesc {
>      } vd;
>  } __attribute__((packed)) IsoVolDesc;
> 
> -const uint8_t vol_desc_magic[] = "CD001";
>  #define VOL_DESC_TYPE_BOOT 0
>  #define VOL_DESC_TYPE_PRIMARY 1
>  #define VOL_DESC_TYPE_SUPPLEMENT 2
>  #define VOL_DESC_TYPE_PARTITION 3
>  #define VOL_DESC_TERMINATOR 255
> 
> -static inline bool is_iso_vd_valid(IsoVolDesc *vd)
> -{
> -    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
> -           vd->version == 0x1 &&
> -           vd->type <= VOL_DESC_TYPE_PARTITION;
> -}
> -
>  typedef struct IsoBcValid {
>      uint8_t platform_id;
>      uint16_t reserved;
> @@ -468,14 +457,6 @@ typedef struct IsoBcHdr {
>      uint8_t id[28];
>  } __attribute__((packed)) IsoBcHdr;
> 
> -/*
> - * Match two CCWs located after PSW and eight filler bytes.
> - * From libmagic and arch/s390/kernel/head.S.
> - */
> -const uint8_t linux_s390_magic[] = "\x02\x00\x00\x18\x60\x00\x00\x50\x02\x00"
> -                                   "\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40"
> -                                   "\x40\x40\x40\x40";
> -
>  typedef struct IsoBcEntry {
>      uint8_t id;
>      union {
> 
