Received: from eggs.gnu.org ([2001:4830:134:3::10]:36829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyRiy-0000Bw-T4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 20:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyRiy-0005D6-2W
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 20:35:28 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-5-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2464c1eb-2ada-7105-3029-2ff28dc5bfa0@redhat.com>
Date: Tue, 20 Mar 2018 20:35:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180223152640.11459-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] atapi: call ide_set_irq before
 ide_transfer_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org



On 02/23/2018 10:26 AM, Paolo Bonzini wrote:
> The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the
> AHCI case ide_set_irq was actually called at the end of a mutual recursion.
> Move it early, with the side effect that ide_transfer_start becomes a tail
> call in ide_atapi_cmd_reply_end.
> 

Do you know in which spec it specifies that we should interrupt?

Seems okay, but I wanted to double check the wording in the spec (was
looking in scsi MMC and ATA8) and couldn't find it quickly.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/atapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index c0509c8bf5..be99a929cf 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -287,6 +287,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
>          } else {
>              /* a new transfer is needed */
>              s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
> +            ide_set_irq(s->bus);
>              byte_count_limit = atapi_byte_count_limit(s);
>              trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
>              size = s->packet_transfer_size;
> @@ -307,10 +308,9 @@ void ide_atapi_cmd_reply_end(IDEState *s)
>              s->packet_transfer_size -= size;
>              s->elementary_transfer_size -= size;
>              s->io_buffer_index += size;
> +            trace_ide_atapi_cmd_reply_end_new(s, s->status);
>              ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
>                                 size, ide_atapi_cmd_reply_end);
> -            ide_set_irq(s->bus);
> -            trace_ide_atapi_cmd_reply_end_new(s, s->status);
>          }
>      }
>  }
> 
