Received: from eggs.gnu.org ([2001:4830:134:3::10]:55770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOv1W-0003pW-SP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 21:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOv1V-0000fe-Rq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 21:08:02 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-6-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <700d0412-5ff4-cb86-7896-d6bd943ea5dd@redhat.com>
Date: Fri, 1 Jun 2018 21:07:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180417153945.20737-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] atapi: call ide_set_irq before
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
Cc: qemu-block@nongnu.org



On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
> The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the

This one is benefit of the doubt for me.

(I still can't quite track down our usage of the nsector register for
this, it doesn't seem supported by cmd_packet in ATA8 ... It says that
Interrupt Reason is its own "field" but that doesn't help me know which
register it's supposed to be stored in... Oh, ATA7 says that Interrupt
Reason is stored in "Sector Count." (*sigh* -- How are you supposed to
tell that from the ATA8 doc? What part of the spec tells you how to
actually read out the "Interrupt Reason" field?))

(I am still not sure which spec says when we can interrupt in ATAPI,
either. I guess that's in SCSI somewhere, probably?)

> AHCI case ide_set_irq was actually called at the end of a mutual recursion.
> Move it early, with the side effect that ide_transfer_start becomes a tail
> call in ide_atapi_cmd_reply_end.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/atapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index c0509c8bf5..7168ff55a7 100644
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
> @@ -304,13 +305,12 @@ void ide_atapi_cmd_reply_end(IDEState *s)
>                  if (size > (s->cd_sector_size - s->io_buffer_index))
>                      size = (s->cd_sector_size - s->io_buffer_index);
>              }
> +            trace_ide_atapi_cmd_reply_end_new(s, s->status);
>              s->packet_transfer_size -= size;
>              s->elementary_transfer_size -= size;
>              s->io_buffer_index += size;
>              ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
>                                 size, ide_atapi_cmd_reply_end);
> -            ide_set_irq(s->bus);
> -            trace_ide_atapi_cmd_reply_end_new(s, s->status);
>          }
>      }
>  }
> 

BOD:

Acked-by: John Snow <jsnow@redhat.com>
