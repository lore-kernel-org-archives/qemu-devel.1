Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejl7r-0000hH-TY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejl7n-0002gW-Uj
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:16:27 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejl7n-0002gQ-PN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:16:23 -0500
Received: by mail-qt0-x243.google.com with SMTP id m11so5843443qtn.10
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 04:16:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
Date: Thu, 8 Feb 2018 09:15:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Daniel,

On 02/08/2018 07:57 AM, Daniel Henrique Barboza wrote:
> This patch adds a break in the switch() statement of complete(),
> value 0x42:
> 
>     case 0x42:              /* FT2 sets output freq with this, go figure */
>         qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
>                       " should\n");
>         break; <-------
>     case 0x41:

It seems this is an intentional fallthrough, I understand cmd 0x42 is
expected to do the same of 0x41 and _a bit more_ (see commit 85571bc7415).

> 
> The issue was found by Coverity (#1385841):
> 
>     CID 1385841:  Control flow issues  (MISSING_BREAK)
>     The case for value "66" is not terminated by a 'break' statement.
> 
> Fixes: 8ec660b80e ("hw/audio/sb16.c: change dolog() to qemu_log_mask()")
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> CC: John Arbuckle <programmingkidx@gmail.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/sb16.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 31de264ab7..b2fdcd8437 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -744,6 +744,7 @@ static void complete (SB16State *s)
>          case 0x42:              /* FT2 sets output freq with this, go figure */
>              qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
>                            " should\n");
> +            break;
>          case 0x41:
>              s->freq = dsp_get_hilo (s);
>              ldebug ("set freq %d\n", s->freq);
> 
