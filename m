Received: from eggs.gnu.org ([209.51.188.92]:59084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxGNM-00022N-7H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxGNK-0004Cc-7m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:20:48 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:37240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxGNI-00049C-8B
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:20:44 -0500
Date: Fri, 22 Feb 2019 22:20:39 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222192039.37fbm3aelhtesq3e@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-6-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-6-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] ui/cocoa: Don't call NSApp
 sendEvent directly from handleEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Thu, Feb 14, 2019 at 10:28:14AM +0000, Peter Maydell wrote:
> Currently the handleEvent method will directly call the NSApp
> sendEvent method for any events that we want to let OSX deal
> with. When we rearrange the event handling code, the way that
> we say "let OSX have this event" is going to change. Prepare
> for that by refactoring so that handleEvent returns a flag
> indicating whether it consumed the event.
> 
> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New patch in v2
> ---
>  ui/cocoa.m | 49 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 15 deletions(-)
> 
> @@ -1749,7 +1766,9 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
>          event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
>                          inMode: NSDefaultRunLoopMode dequeue:YES];
>          if (event != nil) {
> -            [cocoaView handleEvent:event];
> +            if (![cocoaView handleEvent:event]) {
> +                [NSApp sendEvent:event];
> +            }
>          }
>      } while(event != nil);
>      [pool release];
> -- 
> 2.17.2 (Apple Git-113)
> 

I like the patch. It makes clear that cocoa_refresh performs the work
of [NSApp run].

Besides the trailing whitespace issue,

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
