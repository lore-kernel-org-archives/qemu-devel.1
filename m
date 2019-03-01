Received: from eggs.gnu.org ([209.51.188.92]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzelJ-0000FV-UD
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzelI-0000gT-Qj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:47:25 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzelH-0000ex-Vl
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:47:24 -0500
Received: by mail-oi1-x242.google.com with SMTP id e7so18999351oia.8
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20190225102433.22401-1-peter.maydell@linaro.org>
	<20190225102433.22401-2-peter.maydell@linaro.org>
	<CAKyx-3PZyhNN64O2MQP20MT6Xv2A3yLUsTCD6D08s+NtWMeTXg@mail.gmail.com>
In-Reply-To: <CAKyx-3PZyhNN64O2MQP20MT6Xv2A3yLUsTCD6D08s+NtWMeTXg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 09:47:09 +0000
Message-ID: <CAFEAcA_uKj+DTxtTcmFyO+OFibxTFccFBfSbZAAZDL2aGH9-Pg@mail.gmail.com>
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
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Roman Bolshakov <r.bolshakv@yadro.com>, BALATON Zoltan <balaton@eik.bme.hu>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Thu, 28 Feb 2019 at 21:53, G 3 <programmingkidx@gmail.com> wrote:
> On Mon, Feb 25, 2019 at 5:24 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>> +// Utility function to run specified code block with iothread lock held
>> +typedef void (^CodeBlock)(void);
>
>
> Please don't use blocks. It would lock Mac OS X users into having to use CLang. GCC does not support this non-standard extension.
>
> C function pointers and Objective-C's selectors could work in place of blocks.

Clang is the standard toolchain for this OS. We have such
little developer resource for OSX that I don't think we
can reasonably support two toolchains here. Besides,
we need blocks to use dispatch_async(), which is a much
simpler way to achieve what we're trying to do than
the 10.6 compatible approach.

Similarly, I am not prepared to continue to support 10.6
at this point:
 * 10.6's last release was over seven years ago
 * Apple stopped supporting it four years ago
 * there have been multiple OSX releases since then
 * attempting to maintain support for 10.6 would make the
   code less readable and maintainable for newer OSes
   we do care about
 * we do not have either the user base or the developer
   base on OSX to justify maintaining support for this
   ancient OS version
 * it would be out of line with our overall host OS
   support policy, which targets only the last LTS
   version or two of distros and OSes

I'm sorry if this is inconvenient to you personally, but
I don't think it makes any sense as a project to try to
support this any longer.

thanks
-- PMM
