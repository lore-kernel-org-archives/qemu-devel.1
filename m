Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d7jzq-0002CP-Qr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d7jzp-0000ij-Ug
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:50:46 -0400
References: <20170506124314.23354-1-aurelien@aurel32.net>
	<20170506124314.23354-3-aurelien@aurel32.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <1c384b57-daba-3a4b-5905-d10c7901653b@redhat.com>
Date: Mon, 8 May 2017 10:50:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170506124314.23354-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ide: export rotational qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 05/06/2017 08:43 AM, Aurelien Jarno wrote:
> Export the rotational qdev property in the IDENTIFY request.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  hw/ide/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64d3a..1aa76b0d90 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -191,6 +191,9 @@ static void ide_identify(IDEState *s)
>      if (dev && dev->conf.discard_granularity) {
>          put_le16(p + 169, 1); /* TRIM support */
>      }
> +    if (dev && !dev->conf.rotational) {
> +        put_le16(p + 217, 1); /* non-rotating device */
> +    }
>  
>      ide_identify_size(s);
>      s->identify_set = 1;
> 

7.16.7.80 Word 217: Nominal media rotation rate
Word 217 is a copy of Nominal Media Rotation Rate (see A.11.5.4).

*flips page like it's a choose-your-own-adventure book*

OK, so 0x0001 just means "Non-rotational." I guess it probably does not
matter that our default is "Rate not reported."

Looks like there's no relevant bits for packet identify data either, so:

Acked-by: John Snow <jsnow@redhat.com>


A question about the series as a whole, though: if by default rotational
is set to false, we will newly be setting this bit in IDENTIFY data with
identical CLI invocations. Why is that OK?
