Received: from eggs.gnu.org ([2001:4830:134:3::10]:55753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cm21O-0006Tq-JV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cm21J-00074D-RU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:38:38 -0500
References: <20170309165120.960B540827A6@vostest4.mno.stratus.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d51be41e-8c1c-fdad-315a-aea2a8825862@redhat.com>
Date: Thu, 9 Mar 2017 18:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170309165120.960B540827A6@vostest4.mno.stratus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] SGABIOS: fix wrong video
 attrs for int 10h, ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: herbierobinson <Herbie.Robinson@stratus.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 07/03/2017 02:30, herbierobinson wrote:
> Fix Bug #1670509: wrong video attrs for int 10h, ah==13h
> The subroutine set_cursor_position is trashing %bx.
> Unfortunately, %bl contains the video attribute for write_string.
> 
> The fix saves %bx in the function prolog and restores it in
> the epilog.  Also, remove save and restore in set_current_cursor,
> because set_cursor_position does it.
> 
> Signed-off-by: herbierobinson <Herbie.Robinson@stratus.com>
> ---
>  sgabios.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sgabios.S b/sgabios.S
> index 275d063..da5acc2 100644
> --- a/sgabios.S
> +++ b/sgabios.S
> @@ -1728,6 +1728,7 @@ write_string_tail:
>  
>  set_cursor_position:
>    pushw %ax
> +  pushw %bx
>    pushw %ds
>    pushw $BDA_SEG
>    popw %ds                             /* ds = 0x40 */
> @@ -1738,6 +1739,7 @@ set_cursor_position:
>    movw %ax, %bx                        /* bx = cursor save offset */
>    movw %dx, (%bx)                      /* save new cursor value */
>    popw %ds
> +  popw %bx
>    popw %ax
>    ret
>  
> @@ -1752,12 +1754,10 @@ set_cursor_position:
>  
>  set_current_cursor:
>    pushw %ds
> -  pushw %bx
>    pushw $BDA_SEG
>    popw %ds                             /* ds = 0x40 */
>    movb BDA_ACTIVE_PAGE, %bh

Well, we are trashing %bh here, I think the push/pop %bx is needed.
[comment says "all registers preserved except flags"]

>    call set_cursor_position
> -  popw %bx
>    popw %ds
>    ret
>  
> 
