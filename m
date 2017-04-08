Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwmzq-0004um-EF
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwmzn-0000kp-BA
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cwmzn-0000ke-4t
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:27 -0400
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
	<1491612336-31066-5-git-send-email-anthony.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6089f9a-a90a-33f7-1e62-9d941619b983@redhat.com>
Date: Sat, 8 Apr 2017 17:49:21 +0800
MIME-Version: 1.0
In-Reply-To: <1491612336-31066-5-git-send-email-anthony.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] pam: setup pc.bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>, qemu-devel@nongnu.org



On 08/04/2017 08:45, Anthony Xu wrote:
> -    if (!isapc_ram_fw) {
> -        memory_region_set_readonly(bios, true);
> +    if (PC_MACHINE(current_machine)->pam) {
> +        /* if PAM is disabled, set it as readwrite */
> +        if (!isapc_ram_fw) {
> +            memory_region_set_readonly(bios, true);
> +        }
>      }

I think this is wrong, the high copy should remain read-only or pflash
stops working when you remove PAM.

The comment only explains the "what" but not the "why" and the "why" is
not in the commit message.  See also here:

> +    if (PC_MACHINE(current_machine)->pam) {
> +        memory_region_add_subregion_overlap(rom_memory,
> +                                        0x100000 - isa_bios_size,
> +                                        isa_bios,
> +                                        1);
> +        if (!isapc_ram_fw) {
> +            memory_region_set_readonly(isa_bios, true);
> +        }
> +    } else {
> +        /* if PAM is disabed, add isa-bios to system memory region */
> +        memory_region_add_subregion_overlap(system_memory,
>                                          0x100000 - isa_bios_size,
>                                          isa_bios,
>                                          1);

Thanks,

Paolo
