Received: from eggs.gnu.org ([209.51.188.92]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gzUHg-0004p6-G9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gzUHf-00033V-KX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:36:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gzUHf-00032y-Co
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:36:07 -0500
Received: by mail-wr1-x442.google.com with SMTP id o17so23790272wrw.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20190225102433.22401-1-peter.maydell@linaro.org>
	<20190225102433.22401-8-peter.maydell@linaro.org>
In-Reply-To: <20190225102433.22401-8-peter.maydell@linaro.org>
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 28 Feb 2019 17:35:54 -0500
Message-ID: <CAKyx-3No8BYeijyDrUHLOJsL7bRM-N-SuJLOkKk3r=8cRWuVug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 7/7] ui/cocoa: Perform UI operations
 only on the main thread
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

> The OSX Mojave release is more picky about enforcing the Cocoa API
> restriction that only the main thread may perform UI calls. To
> accommodate this we need to restructure the Cocoa code:
>  * the special OSX main() creates a second thread and uses
>    that to call the vl.c qemu_main(); the original main
>    thread goes into the OSX event loop
>  * the refresh, switch and update callbacks asynchronously
>    tell the main thread to do the necessary work
>  * the refresh callback no longer does the "get events from the
>    UI event queue and handle them" loop, since we now use
>    the stock OSX event loop. Instead our NSApplication sendEvent
>    method will either deal with them or pass them on to OSX
>
> All these things have to be changed in one commit, to avoid
> breaking bisection.
>
> Note that since we use dispatch_get_main_queue(), this bumps
> our minimum version requirement to OSX 10.10 Yosemite (released
> in 2014, unsupported by Apple since 2017).
>
> I think eliminating support for Macintosh operating systems older than
10.10 is a mistake. These operating systems may be old but are far from
useless. They are fully capable of handling QEMU. I do believe that fixing
support for Mac OS 10.14 and maintaining support for older versions of Mac
OS is possible. Calling methods and functions on the main thread can be
done using performSelectorOnMainThread.

Thank you.
