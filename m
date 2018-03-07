Received: from eggs.gnu.org ([2001:4830:134:3::10]:37589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTLk-0000in-1S
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTLg-00007Q-2Z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:18:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1etTLf-00006N-Tl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:18:52 -0500
Date: Wed, 7 Mar 2018 12:48:31 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <1513877118-3149-2-git-send-email-jack.schwartz@oracle.com>
Message-ID: <nycvar.YSQ.7.76.1803071247440.20163@wniryva>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<1513877118-3149-2-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH QEMU v1 1/4] multiboot: bss_end_addr can be
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

+-- On Thu, 21 Dec 2017, Jack Schwartz wrote --+
| The multiboot spec (https://www.gnu.org/software/grub/manual/multiboot/),
| section 3.1.3, allows for bss_end_addr to be zero.
| 
| A zero bss_end_addr signifies there is no .bss section.
| 
| Suggested-by: Daniel Kiper <daniel.kiper@oracle.com>
| Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
| Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
| ---
|  hw/i386/multiboot.c | 18 ++++++++++--------
|  1 file changed, 10 insertions(+), 8 deletions(-)
| 
| diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
| index c7b70c9..ff2733d 100644
| --- a/hw/i386/multiboot.c
| +++ b/hw/i386/multiboot.c
| @@ -233,12 +233,6 @@ int load_multiboot(FWCfgState *fw_cfg,
|          mh_entry_addr = ldl_p(header+i+28);
|  
|          if (mh_load_end_addr) {
| -            if (mh_bss_end_addr < mh_load_addr) {
| -                fprintf(stderr, "invalid mh_bss_end_addr address\n");
| -                exit(1);
| -            }
| -            mb_kernel_size = mh_bss_end_addr - mh_load_addr;
| -
|              if (mh_load_end_addr < mh_load_addr) {
|                  fprintf(stderr, "invalid mh_load_end_addr address\n");
|                  exit(1);
| @@ -249,8 +243,16 @@ int load_multiboot(FWCfgState *fw_cfg,
|                  fprintf(stderr, "invalid kernel_file_size\n");
|                  exit(1);
|              }
| -            mb_kernel_size = kernel_file_size - mb_kernel_text_offset;
| -            mb_load_size = mb_kernel_size;
| +            mb_load_size = kernel_file_size - mb_kernel_text_offset;
| +        }
| +        if (mh_bss_end_addr) {
| +            if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
| +                fprintf(stderr, "invalid mh_bss_end_addr address\n");
| +                exit(1);
| +            }
| +            mb_kernel_size = mh_bss_end_addr - mh_load_addr;
| +        } else {
| +            mb_kernel_size = mb_load_size;
|          }
|  
|          /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.

Looks good.
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
