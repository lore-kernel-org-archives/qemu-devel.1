Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkWW-0006dJ-MH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkWQ-0001o9-Pq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:03:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evkWQ-0001nd-GV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:03:22 -0400
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-9-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <43445338-11f4-bba8-9ce7-9621d54644ce@vivier.eu>
Date: Tue, 13 Mar 2018 15:02:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-9-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/10] linux-user: init_guest_space: Don't
 try to align if we'll reject it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
> From: Luke Shumaker <lukeshu@parabola.nu>
> 
> If the ensure-alignment code gets triggered, then the
> "if (host_start && real_start != current_start)" check will always trigger,
> so save 2 syscalls and put that check first.
> 
> Note that we can't just switch to using MAP_FIXED for that check, because
> then we couldn't differentiate between a failure because "there isn't
> enough space" and "there isn't enough space *here*".
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 5c0ad65611..1b7583d659 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1871,6 +1871,11 @@ unsigned long init_guest_space(unsigned long host_start,
>              return (unsigned long)-1;
>          }
>  
> +        /* Check to see if the address is valid.  */
> +        if (host_start && real_start != current_start) {
> +            goto try_again;
> +        }
> +
>          /* Ensure the address is properly aligned.  */
>          if (real_start & ~qemu_host_page_mask) {
>              /* Ideally, we adjust like
> @@ -1905,11 +1910,6 @@ unsigned long init_guest_space(unsigned long host_start,
>              aligned_start = real_start;
>          }
>  
> -        /* Check to see if the address is valid.  */
> -        if (host_start && aligned_start != current_start) {
> -            goto try_again;
> -        }
> -
>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>          /* On 32-bit ARM, we need to also be able to map the commpage.  */
>          int valid = init_guest_commpage(aligned_start - guest_start,
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
