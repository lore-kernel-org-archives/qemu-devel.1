Received: from eggs.gnu.org ([2001:4830:134:3::10]:38692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyPbF-0005q7-Ri
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyPbF-0003jq-2A
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:19:21 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-4-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5e659013-eb37-219b-d5e3-c4c93548a368@redhat.com>
Date: Tue, 20 Mar 2018 18:19:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180223152640.11459-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] ide: do not set s->end_transfer_func
 to ide_transfer_cancel
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
> There is code checking s->end_transfer_func and it was not taught
> about ide_transfer_cancel.  We can just use ide_transfer_stop because
> s->end_transfer_func is only ever called in the DRQ phase: after
> ide_transfer_cancel, the value of s->end_transfer_func is only used
> as a marker and never used to actually invoke the function.
> 

I think you're right, but I think it's also pretty non-obvious to a
reader that a callback might be used in this way.

"John, it's your component dude, why don't you fix that?"

Err, I'm afraid of disturbing the delicate balance of spaghetti code.

*cough*

Anyway, a little comment explaining that we don't actually *expect* that
callback to actually get called would probably answer a question or two
before they arise.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index c4710a6f55..447d9624df 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -553,10 +553,9 @@ static void ide_cmd_done(IDEState *s)
>      }
>  }
>  
> -static void ide_transfer_halt(IDEState *s,
> -                              void(*end_transfer_func)(IDEState *))
> +static void ide_transfer_halt(IDEState *s)
>  {
> -    s->end_transfer_func = end_transfer_func;
> +    s->end_transfer_func = ide_transfer_stop;
>      s->data_ptr = s->io_buffer;
>      s->data_end = s->io_buffer;
>      s->status &= ~DRQ_STAT;
> @@ -564,7 +563,7 @@ static void ide_transfer_halt(IDEState *s,
>  
>  void ide_transfer_stop(IDEState *s)
>  {
> -    ide_transfer_halt(s, ide_transfer_stop);
> +    ide_transfer_halt(s);
>      if (s->bus->dma->ops->end_transfer) {
>          s->bus->dma->ops->end_transfer(s->bus->dma);
>      }
> @@ -573,7 +572,7 @@ void ide_transfer_stop(IDEState *s)
>  
>  static void ide_transfer_cancel(IDEState *s)
>  {
> -    ide_transfer_halt(s, ide_transfer_cancel);
> +    ide_transfer_halt(s);
>  }
>  
>  int64_t ide_get_sector(IDEState *s)
> 

"LGTM"
