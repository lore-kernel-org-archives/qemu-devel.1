Received: from eggs.gnu.org ([2001:4830:134:3::10]:46115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71AP-0000rD-Kb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71AL-0008Uy-P0
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:35:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g71AL-0008UN-H0
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:35:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so3997549wrt.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 09:35:24 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-15-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <055b86a6-66ad-6486-d1ec-0ba4f7913c65@redhat.com>
Date: Mon, 1 Oct 2018 18:35:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-15-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/15] gdbstub: add multiprocess
 extension support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 01/10/2018 13:57, Luc Michel wrote:
> Add multiprocess extension support by enabling multiprocess mode when
> the peer requests it, and by replying that we actually support it in the
> qSupported reply packet.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  gdbstub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 51cc11981e..89f6803533 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1692,15 +1692,19 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>              put_packet(s, "OK");
>              break;
>          }
>  #endif /* !CONFIG_USER_ONLY */
>          if (is_query_packet(p, "Supported", ':')) {
> +            if (strstr(p, "multiprocess+")) {
> +                s->multiprocess = true;
> +            }
>              snprintf(buf, sizeof(buf), "PacketSize=%x", MAX_PACKET_LENGTH);
>              cc = CPU_GET_CLASS(first_cpu);
>              if (cc->gdb_core_xml_file != NULL) {
>                  pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
>              }

Maybe move altogether:

               if (strstr(p, "multiprocess+")) {
                   s->multiprocess = true;
               }

> +            pstrcat(buf, sizeof(buf), ";multiprocess+");

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>              put_packet(s, buf);
>              break;
>          }
>          if (strncmp(p, "Xfer:features:read:", 19) == 0) {
>              const char *xml;
> 
