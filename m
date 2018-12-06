Received: from eggs.gnu.org ([2001:4830:134:3::10]:37705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV00x-0003B3-Og
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV00s-0000y9-Sf
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:12:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV00s-0000wf-Hf
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:12:46 -0500
References: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
	<1544049083-16087-3-git-send-email-liam.merwick@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf336582-e8d6-1bdc-f9b2-99264f5920fe@redhat.com>
Date: Thu, 6 Dec 2018 21:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <1544049083-16087-3-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC qboot 2/3] pvh: use x86/HVM direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, maran.wilson@oracle.com

On 05/12/18 23:31, Liam Merwick wrote:
> -static inline uint32_t ldl_p(void *p)
> +inline uint32_t ldl_p(void *p)
>  {
>  	uint32_t val;
>  	memcpy(&val, p, 4);
> diff --git a/main.c b/main.c

Can you make instead a header (memaccess.h?) with all of lduw_p, ldl_p,
stw_p, stl_p?

> 
> +
> +struct hvm_start_info start_info = {0};

Please put this declaration in linuxboot.c instead.

> 
> +#define RSDP_FILE "etc/acpi/rsdp"
> +
>  void extract_acpi(void)
>  {
>  	int id = fw_cfg_file_id("etc/table-loader");
> @@ -138,6 +143,10 @@ void extract_acpi(void)
>  		struct loader_cmd *s = &script[i];
>  		switch(script[i].cmd) {
>  		case CMD_ALLOC:
> +			if (strcmp(s->alloc.file, RSDP_FILE) == 0) {
> +				start_info.rsdp_paddr =
> +				    (uintptr_t)id_to_addr(id);
> +			}


Please instead do a memcmp with "RSD PTR" in do_alloc, and also only do
it if zone is ALLOC_FSEG.

Thanks,

Paolo
