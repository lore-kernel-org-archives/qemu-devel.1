Received: from eggs.gnu.org ([2001:4830:134:3::10]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfWW-0006O3-UV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfWT-00080W-RB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:31:48 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYfWT-0007yt-LD
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:31:45 -0400
Received: by mail-pg0-x242.google.com with SMTP id s4so6235963pgr.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:31:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <46195c32-3583-38c0-0e63-f3ce707a3412@twiddle.net>
Date: Fri, 21 Jul 2017 11:31:37 -1000
MIME-Version: 1.0
In-Reply-To: <1500616763-26560-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 35/43] tcg: allocate optimizer temps
 with tcg_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/20/2017 07:59 PM, Emilio G. Cota wrote:
> Groundwork for supporting multiple TCG contexts.
> 
> While at it, also allocate temps_used directly as a bitmap of the
> required size, instead of using a bitmap of TCG_MAX_TEMPS via
> TCGTempSet.
> 
> Performance-wise we lose about 1.12% in a translation-heavy workload
> such as booting+shutting down debian-arm:
> 
> Performance counter stats for 'taskset -c 0 arm-softmmu/qemu-system-arm \
> 	-machine type=virt -nographic -smp 1 -m 4096 \
> 	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
> 	-device virtio-net-device,netdev=unet \
> 	-drive file=die-on-boot.qcow2,id=myblock,index=0,if=none \
> 	-device virtio-blk-device,drive=myblock \
> 	-kernel kernel.img -append console=ttyAMA0 root=/dev/vda1 \
> 	-name arm,debug-threads=on -smp 1' (10 runs):
> 
>               exec time (s)  Relative slowdown wrt original (%)
> ---------------------------------------------------------------
>   original     20.213321616                                  0.
>   tcg_malloc   20.441130078                           1.1270214
>   TCGContext   20.477846517                           1.3086662
>   g_malloc     20.780527895                           2.8061013
> 
> The other two alternatives shown in the table are:
> - TCGContext: embed temps[TCG_MAX_TEMPS] and TCGTempSet used_temps
>    in TCGContext. This is simple enough but it isn't faster than using
>    tcg_malloc; moreover, it wastes memory.
> - g_malloc: allocate/deallocate both temps and used_temps every time
>    tcg_optimize is executed.
> 
> Suggested-by: Richard Henderson<rth@twiddle.net>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/optimize.c | 306 ++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 161 insertions(+), 145 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>

r~
