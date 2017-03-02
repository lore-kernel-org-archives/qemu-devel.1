Received: from eggs.gnu.org ([2001:4830:134:3::10]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXfs-0001aS-38
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXfr-0005ud-AX
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:50:08 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjXfr-0005tr-3x
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:50:07 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so1130919wmd.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 12:50:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703022115320.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<869a8c5b526be9eb1316c9e7c7442bdd1c88c4b2.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9zswu1H-66avnAxWdq8QvCWpi1NTbcaGqDE=c=OOHcAw@mail.gmail.com>
	<alpine.BSF.2.20.1703022115320.83701@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 20:49:45 +0000
Message-ID: <CAFEAcA9PDjSN7pKVde9raHZH3ExWdSNWN82ST4AJLPahWNcKNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 13/14] sm501: Add reset function and
 vmstate descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 2 March 2017 at 20:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Thu, 2 Mar 2017, Peter Maydell wrote:
>>
>> Don't use qemu_register_reset(). Set the appropriate dc->reset
>> function pointers instead.
>
>
> Any reason for that? This way I could save two more boilerplate functions
> because I could define reset function once, otherwise I'd need two versions
> taking sysbus and pci states just to extract the SM501State function and
> call this function. Do you still think I should do that instead?

qemu_register_reset is a pre-QOM method for doing reset;
the standard QOM way of saying "my device has some reset
behaviour" is to set its reset method pointer.
Code calling qemu_register_reset() is generally either (a) doing
something kind of weird or (b) old device code that hasn't yet
been converted to QOM.

> So should it be 4 patches: reset for pci, reset for sysbus, vmstate for pci,
> vmstate for sysbus or 2 patches: reset for both, vmstate for both?

I think I'd go with 2 patches, since the two are going to
share the bulk of the implementation in each case.

thanks
-- PMM
