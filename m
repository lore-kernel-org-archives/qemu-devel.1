Received: from eggs.gnu.org ([2001:4830:134:3::10]:42831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4BH-0007ll-3r
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4BC-0004bS-4Y
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:12:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ei4BB-0004ZT-Rn
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:12:54 -0500
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-11-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9dd954df-35d1-5f27-0be5-5ecc572529f0@redhat.com>
Date: Sat, 3 Feb 2018 21:12:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 10/15] hw/sd: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

On 02.02.2018 19:37, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.

I think you could pretty much ditch the original patch description since
nothing gets converted to error_report here anymore...

> Some of the prints in hw/sd/sd.c were manually converted to using
> DPRINTF() instead.

... and just use the above sentence (in a maybe slightly adapted way).

> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> 
> Conversions that aren't followed by exit() dropped, because they might
> be inappropriate.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/sd/sd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 35347a5bbc..73e405a04f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1564,9 +1564,10 @@ send_response:
>      if (rsplen) {
>          int i;
>          DPRINTF("Response:");
> -        for (i = 0; i < rsplen; i++)
> -            fprintf(stderr, " %02x", response[i]);
> -        fprintf(stderr, " state %d\n", sd->state);
> +        for (i = 0; i < rsplen; i++) {
> +            DPRINTF(" %02x", response[i]);
> +        }
> +        DPRINTF(" state %d\n", sd->state);
>      } else {
>          DPRINTF("No response %d\n", sd->state);
>      }
> 

With the patch description updated:

Reviewed-by: Thomas Huth <thuth@redhat.com>
