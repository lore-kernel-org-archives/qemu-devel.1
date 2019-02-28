Received: from eggs.gnu.org ([209.51.188.92]:35513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gzTcu-0002j8-DR
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 16:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gzTct-0002Us-Em
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 16:54:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gzTct-0002U3-5M
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 16:53:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id q187so10728632wme.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 13:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20190225102433.22401-1-peter.maydell@linaro.org>
	<20190225102433.22401-2-peter.maydell@linaro.org>
In-Reply-To: <20190225102433.22401-2-peter.maydell@linaro.org>
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 28 Feb 2019 16:53:45 -0500
Message-ID: <CAKyx-3PZyhNN64O2MQP20MT6Xv2A3yLUsTCD6D08s+NtWMeTXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/7] ui/cocoa: Ensure we have the
 iothread lock when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, patches@linaro.org, Roman Bolshakov <r.bolshakv@yadro.com>, BALATON Zoltan <balaton@eik.bme.hu>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Mon, Feb 25, 2019 at 5:24 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> The Cocoa UI should run on the main thread; this is enforced
> in OSX Mojave. In order to be able to run on the main thread,
> we need to make sure we hold the iothread lock whenever we
> call into various QEMU UI midlayer functions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Roman Bolshakov <r.bolshakv@yadro.com>
> Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
> Message-id: 20190214102816.3393-2-peter.maydell@linaro.org
> ---
> Changes since v2: add with_iothread_lock wrap to the
> qmp_stop()/qmp_cont() calls
> ---
>  ui/cocoa.m | 91 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index e2567d6946..f1171c4865 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -129,6 +129,21 @@
>  NSTextField *pauseLabel;
>  NSArray * supportedImageFileTypes;
>
> +// Utility function to run specified code block with iothread lock held
> +typedef void (^CodeBlock)(void);
>

Please don't use blocks. It would lock Mac OS X users into having to use
CLang. GCC does not support this non-standard extension.

C function pointers and Objective-C's selectors could work in place of
blocks.

Thank you.
