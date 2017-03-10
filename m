Received: from eggs.gnu.org ([2001:4830:134:3::10]:34496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cmPvs-0004M0-Sy
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cmPvp-0004Eu-OV
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:10:32 -0500
References: <1489161295-23864-1-git-send-email-Herbie.Robinson@stratus.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d43aec18-8b5c-0929-c4ea-3b643baf784d@redhat.com>
Date: Fri, 10 Mar 2017 20:10:24 +0100
MIME-Version: 1.0
In-Reply-To: <1489161295-23864-1-git-send-email-Herbie.Robinson@stratus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] SGABIOS: fix wrong video attrs for int
 10h, ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herbie Robinson <Herbie.Robinson@stratus.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 10/03/2017 16:54, Herbie Robinson wrote:
> Fix Bug #1670509: wrong video attrs for int 10h, ah==13h
> The subroutine set_cursor_position is trashing %bx.
> Unfortunately, %bl contains the video attribute for write_string.
> 
> The fix saves %bx in the function prolog and restores it in
> the epilog. 
> 
> Signed-off-by: Herbie Robinson <Herbie.Robinson@stratus.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


> ---
> Removed incorrect code deletions from set_current_cursor.
> Removed explanation of same from the commit message.
> 
> BTW, I didn't see any test cases for this code, but if they exist
> and somebody points me at them, I should be able to generate a 
> very small qcow2 file that demonstrates the problem.
> 
>  sgabios.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sgabios.S b/sgabios.S
> index 275d063..96c4e23 100644
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
> 
