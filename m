Received: from eggs.gnu.org ([2001:4830:134:3::10]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiE0-0005x0-Sx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiDw-00069b-5u
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:11:56 -0500
References: <1520317081-5341-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <383b6582-4953-4256-f4fa-abe0fe4a0e6b@redhat.com>
Date: Wed, 7 Mar 2018 17:11:34 -0600
MIME-Version: 1.0
In-Reply-To: <1520317081-5341-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 03/06/2018 12:18 AM, Thomas Huth wrote:
> bootmap.h can currently only be included once - otherwise the linker
> complains about multiple definitions of the "magic" strings.

My first thought when reading that was "Huh? bootmap.h has a proper[*] 
double-inclusion header guard, and therefore a second #include 
"bootmap.h" is a no-op - so how can including the header more than once 
cause a linker complaint?"

[*] Well, proper if you overlook the fact that the name 
_PC_BIOS_S390_CCW_BOOTMAP_H starts with a leading underscore followed by 
uppercase, and is therefore violating namespace safety rules, as it 
could collide with a symbol reserved for the implementation

> It's a
> bad style to define string arrays in header files, so let's better
> move these to the bootmap.c file instead where they are used.

But I finally figured out what you really meant: if more than one .c 
file each include the header (and not my initial reading of a single .c 
file including the header more than once), then since the header was 
declaring non-static top-level variables, that does indeed cause linker 
errors.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2:
>   - Removed duplicated vol_desc_magic (copy-n-paste error)
> 
>   pc-bios/s390-ccw/bootmap.c | 20 ++++++++++++++++++++
>   pc-bios/s390-ccw/bootmap.h | 19 -------------------
>   2 files changed, 20 insertions(+), 19 deletions(-)

Your change is fine (moving the declaration into the one .c file that 
needs them), so no need to change this, but...

> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -375,9 +375,6 @@ static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
>                  "Failed to read boot image!");
>   }
>   
> -const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
> -                                  "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";

...would adding 'static' here also solved the linker error (at the risk 
of possibly causing a compiler warning/error about unused variable)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
