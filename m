Received: from eggs.gnu.org ([2001:4830:134:3::10]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNNp-00086P-Q0
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNNl-0000J0-TD
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:10:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gaNNl-0000G4-Jw
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:10:37 -0500
Date: Fri, 21 Dec 2018 11:10:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181221110913-mutt-send-email-mst@kernel.org>
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-5-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544063533-10139-5-git-send-email-lizhijian@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/4] i386: allow to load initrd
 below 4G for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, Dec 06, 2018 at 10:32:13AM +0800, Li Zhijian wrote:
> a new field xloadflags was added to recent x86 linux, and BIT 1:
> XLF_CAN_BE_LOADED_ABOVE_4G is used to tell bootload that where initrd can be
> loaded safely.
> 
> Current QEMU/BIOS always loads initrd below below_4g_mem_size which is always
> less than 4G, so here limiting initrd_max to 4G - 1 simply is enough if
> this bit is set.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> ---
> V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3b10726..baa99c0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -904,7 +904,15 @@ static void load_linux(PCMachineState *pcms,
>  #endif
>  
>      /* highest address for loading the initrd */
> -    if (protocol >= 0x203) {
> +    if (protocol >= 0x20c &&
> +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        /*
> +         * Although kernel allows initrd loading to above 4G,
> +         * it just makes it as large as possible while still staying below 4G
> +         * since current BIOS always loads initrd below pcms->below_4g_mem_size
> +         */
> +        initrd_max = UINT32_MAX;
> +    } else if (protocol >= 0x203) {
>          initrd_max = ldl_p(header+0x22c);
>      } else {
>          initrd_max = 0x37ffffff;


I still have trouble understanding the above.
Anyone else wants to comment / help rephrase the comment
and commit log so it's readable?

> -- 
> 2.7.4
