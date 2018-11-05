Received: from eggs.gnu.org ([2001:4830:134:3::10]:34674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJhGo-0004TO-NO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJhGW-0007HO-Jf
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:58:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJhGW-0007Dp-01
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:58:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so8591139wmh.3
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:58:11 -0800 (PST)
References: <20181104180657.7471-1-lbloch@janustech.com>
	<20181104180657.7471-2-lbloch@janustech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b53c025-cee0-9f3d-428a-375698a9ac7e@redhat.com>
Date: Mon, 5 Nov 2018 16:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181104180657.7471-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Add a comment to explain
 the origin of sizes' lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Hi Leonid,

On 4/11/18 19:07, Leonid Bloch wrote:
> The lookup table for power-of-two sizes was added in commit 540b8492618eb
> for the purpose of having convenient shortcuts for these sizes in cases
> when the literal number has to be present at compile time, and
> expressions as '(1 * KiB)' can not be used. One such case is the
> stringification of sizes. Beyond that, it is convenient to use these
> shortcuts for all power-of-two sizes, even if they don't have to be
> literal numbers.
> 
> Despite its convenience, this table introduced 55 lines of "dumb" code,
> the purpose and origin of which are obscure without reading the message
> of the commit which introduced it. This patch fixes that by adding a
> comment to the code itself with a brief explanation for the reasoning
> behind this table. This comment includes the short AWK script that
> generated the table, so that anyone who's interested could make sure
> that the values in it are correct (otherwise these values look as if
> they were typed manually).
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   include/qemu/units.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/qemu/units.h b/include/qemu/units.h
> index 68a7758650..1c959d182e 100644
> --- a/include/qemu/units.h
> +++ b/include/qemu/units.h
> @@ -17,6 +17,24 @@
>   #define PiB     (INT64_C(1) << 50)
>   #define EiB     (INT64_C(1) << 60)
>   
> +/*
> + * The following lookup table is intended to be used when a literal string of
> + * the number of bytes is required (for example if it needs to be stringified).
> + * It can also be used for generic shortcuts of power-of-two sizes.

^ ok

v this part is not useful in the tree IMHO.

> + * This table is generated using the AWK script below:
> + *
> + *  BEGIN {
> + *      suffix="KMGTPE";
> + *      for(i=10; i<64; i++) {
> + *          val=2**i;
> + *          s=substr(suffix, int(i/10), 1);
> + *          n=2**(i%10);
> + *          pad=21-int(log(n)/log(10));
> + *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
> + *      }
> + *  }
> + */

If it is generated and the stringified are also generated, why not 
generate this once via the ./configure, since it is used by machines and 
not by humans?

> +
>   #define S_1KiB                  1024
>   #define S_2KiB                  2048
>   #define S_4KiB                  4096
> 

Thanks,

Phil.
