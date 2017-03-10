Received: from eggs.gnu.org ([2001:4830:134:3::10]:41347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cmFMK-00067C-5e
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cmFMG-0001XZ-8r
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:53:08 -0500
References: <20170309190313.DFE5240827A6@vostest4.mno.stratus.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4b953df8-8d34-f243-ca90-9f16723a87a3@redhat.com>
Date: Fri, 10 Mar 2017 08:53:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170309190313.DFE5240827A6@vostest4.mno.stratus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] SGABIOS: fix wrong video
 attrs for int 10h, ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herbie Robinson <Herbie.Robinson@stratus.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 09/03/2017 19:48, Herbie Robinson wrote:
> Fix Bug #1670509: wrong video attrs for int 10h, ah==13h
> The subroutine set_cursor_position is trashing %bx.
> Unfortunately, %bl contains the video attribute for write_string.
> 
> The fix saves %bx in the function prolog and restores it in
> the epilog.  Also, remove save and restore in set_current_cursor,
> because set_cursor_position does it.
> 
> Signed-off-by: Herbie Robinson <Herbie.Robinson@stratus.com>
> ---
> Removed incorrect code deletions from set_current_cursor.

You should update the commit message too.

Laurent
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
