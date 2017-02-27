Received: from eggs.gnu.org ([2001:4830:134:3::10]:33571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciIg9-0004yn-Gs
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciIg8-0005Kf-NJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:37:17 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciIg8-0005KN-Ew
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:37:16 -0500
Received: by mail-wr0-x22f.google.com with SMTP id g10so49102045wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227081456.7131-1-shah.suramya@gmail.com>
References: <20170227081456.7131-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 10:36:54 +0000
Message-ID: <CAFEAcA9nZCfVyDUzbavnu0HYtfHp1WTK=euATBB9FHkvnC7hTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Removed support for depth!=32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 27 February 2017 at 08:14, Suramya Shah <shah.suramya@gmail.com> wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/display/sm501_template.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
> index f33e499..4e5801e 100644
> --- a/hw/display/sm501_template.h
> +++ b/hw/display/sm501_template.h
> @@ -22,13 +22,7 @@
>   * THE SOFTWARE.
>   */
>
> -#if DEPTH == 8
> -#define BPP 1
> -#define PIXEL_TYPE uint8_t
> -#elif DEPTH == 15 || DEPTH == 16
> -#define BPP 2
> -#define PIXEL_TYPE uint16_t
> -#elif DEPTH == 32
> +#if DEPTH == 32
>  #define BPP 4
>  #define PIXEL_TYPE uint32_t
>  #else

Hi there; thanks for this patch. How did you test it? It doesn't
compile for me:

In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/sm501.c:1177:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/sm501_template.h:29:2:
error: #error unsupport depth
 #error unsupport depth
  ^

This is because you've removed the code from this #ifdef
but you haven't also removed the code in sm501.c which is
currently trying to use it. (You also can expand out the
uses of PIXEL_NAME and PIXEL_TYPE used later in sm501_template.h
since they are now only ever defined to one thing, but not
doing that doesn't cause compilation failure.)


(Gerd: can you remind me of the reason why we can assume that
depth is always 32 here? IIRC it's because the UI layer always
uses 32 bit depth now but I couldn't convince myself of that
with a quick look through the ui code...)

thanks
-- PMM
