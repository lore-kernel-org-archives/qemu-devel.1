Received: from eggs.gnu.org ([2001:4830:134:3::10]:45705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marek.vasut@gmail.com>) id 1cbvts-0008Au-SY
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marek.vasut@gmail.com>) id 1cbvto-0003hH-IR
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:05:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marek.vasut@gmail.com>)
	id 1cbvto-0003gE-Al
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:05:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so4682125wmu.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 13:05:02 -0800 (PST)
References: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
	<028b23eb-64a0-9e29-0940-629f0d33a364@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBFA6@ORSMSX112.amr.corp.intel.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <092cd595-21b8-9d00-9d19-bc5f3ac0c06c@gmail.com>
Date: Thu, 9 Feb 2017 22:04:59 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FBFA6@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bystricky, Juro" <juro.bystricky@intel.com>, Marek Vasut <marex@denx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, "crwulff@gmail.com" <crwulff@gmail.com>

On 02/09/2017 09:53 PM, Bystricky, Juro wrote:
> 
> 
>> On 02/09/2017 07:52 PM, Juro Bystricky wrote:
>>> JTAG UART core eliminates the need for a separate RS-232 serial
>>> connection to a host PC for character I/O.
>>
>> And how does this describe the content of this patch ? This patch adds a
>> model of JTAG UART , it doesn't eliminate anything ...
>>
> 
> The commit message explicitly says:
> "Add Altera JTAG UART emulation."
> 
> But I will amend the message with more details.

The commit message is totally misleading though.

>>> Hardware emulation based on:
>>> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
>>> (Please see "Register Map" on page 65)
>>>
>>> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
>>> ---
>>
>> Changelog is missing ...
> 
> I modelled this patch based on other nios2 patches, none of them contained 
> Changelog. So please elaborate.

It's common courtesy to avoid wasting reviewers time by adding a
changelog between patch versions.

>>> +    /*
>>> +     * FIFO size can be set from 8 to 32,768 bytes.
>>> +     * Only powers of two are allowed.
>>> +     */
>>> +    fifo_size_ok = false;
>>> +    for (size = 8; size <= 32768; size *= 2) {
>>> +        if (size == fifo_size) {
>>> +            fifo_size_ok = true;
>>> +            break;
>>> +        }
>>> +    }
>>
>> Isn't that like
>>
>> if (size < 8 || size > 32768 || (size & ~(1 << ffs(size))))
>>   error()
>>
> 
> possibly, however ffs is rejected by checkpatch as non-portable
> libc call. 

Doesn't it suggest to use ctz32() ?
https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg03661.html

>>> +#define DEFAULT_FIFO_SIZE 64
>>
>> This is still not QOM property , why ?
>>
> 
> Not sure what you mean, the code has:
> 
> DEFINE_PROP_UINT32("fifo-size", AlteraJUARTState, rx_fifo_size, DEFAULT_FIFO_SIZE),

Ah ok, I missed that (and that should've been part of the changelog for
example ... )

-- 
Best regards,
Marek Vasut
