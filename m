Received: from eggs.gnu.org ([209.51.188.92]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH94O-0007d7-CD
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH8wC-0002DT-Ud
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:26:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH8wC-0002D4-KI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:26:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3376909wmd.0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:26:56 -0700 (PDT)
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78da03ed-2b9f-2357-6f28-44115d8b2955@redhat.com>
Date: Thu, 18 Apr 2019 17:26:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190418145355.21100-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] gdbstub: Reject invalid RLE repeat
 counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 4/18/19 4:53 PM, Markus Armbruster wrote:
> "Debugging with GDB / Appendix E GDB Remote Serial Protocol /
> Overview" specifies "The printable characters '#' and '$' or with a
> numeric value greater than 126 must not be used."  gdb_read_byte()
> only rejects values < 32.  This is wrong.  Impact depends on the caller:
> 
> * gdb_handlesig() passes a char.  Incorrectly accepts '#', '$' and
>   '\127'.
> 
> * gdb_chr_receive() passes an uint8_t.  Additionally accepts
>   characters with the most-significant bit set.
> 
> Correct the validity check to match the specification.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index d54abd17cc..a6dce1b027 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2064,7 +2064,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>              }
>              break;
>          case RS_GETLINE_RLE:
> -            if (ch < ' ') {

Can you add a comment referring to the ""Debugging with GDB / Appendix E
GDB Remote Serial Protocol / Overview" here?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            if (ch < ' ' || ch == '#' || ch == '$' || ch > 126) {
>                  /* invalid RLE count encoding */
>                  trace_gdbstub_err_invalid_repeat((uint8_t)ch);
>                  s->state = RS_GETLINE;
> 
