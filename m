Received: from eggs.gnu.org ([2001:4830:134:3::10]:57977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYW8-0004Os-T7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYW7-0003PW-Sc
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:25:52 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <188253dd-dc0f-17b8-8c0d-4a3d14a6a94f@redhat.com>
Date: Thu, 29 Jun 2017 14:25:32 +0200
MIME-Version: 1.0
In-Reply-To: <2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 3/4] util/oslib-win32: Fix up if
 conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-block@nongnu.org



On 28/06/2017 01:57, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7ec0f8e083..a015e1ac96 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -438,7 +438,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>          if (timeout == 0 && nhandles > 1) {
>              /* Remove the handle that fired */
>              int i;
> -            if (ready < nhandles - 1) {
> +            if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
>                  for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
>                      handles[i-1] = handles[i];
>                  }
> 

WAIT_OBJECT_0 is zero, but I agree it's better to add it.

However, the condition can be rewritten as ready - WAIT_OBJECT_0 + 1 <
nhandles, which is the same as the first iteration's "i < nhandles".  So
I'd just remove the "if" and "unindent" the for loop.

Paolo
