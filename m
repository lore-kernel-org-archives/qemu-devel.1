Received: from eggs.gnu.org ([2001:4830:134:3::10]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePcso-0007rs-Dl
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePcsn-0007X6-L5
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:25:42 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKPvAL3+LAqMBtUOc=0igkSwg4Jmf+Q0ySL7C+oech7AMw@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-5-f4bug@amsat.org>
	<CAKmqyKPvAL3+LAqMBtUOc=0igkSwg4Jmf+Q0ySL7C+oech7AMw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 20:25:38 -0300
Message-ID: <CAAdtpL6pT0GD+xkV5P+-J=SGr8_kTrNVBxc207g4mRuojrGe3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/14] sdhci: use deposit64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

>> @@ -1123,12 +1123,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>          MASKED_WRITE(s->admaerr, mask, value);
>>          break;
>>      case SDHC_ADMASYSADDR:
>> -        s->admasysaddr = (s->admasysaddr & (0xFFFFFFFF00000000ULL |
>> -                (uint64_t)mask)) | (uint64_t)value;
>> +        s->admasysaddr = deposit64(s->admasysaddr, 32, 0, value);
>
> This doesn't look right.
>
> Originally we were masking admasysaddr with (mask and
> 0xFFFFFFFF00000000). Then ORing in the value.
>
> Now we are depositing value into a bit field that starts at bit 32 and
> has 0 length. I don't see how value will be deposited at all with a 0
> length.

good catch :) I'll respin with:

    case SDHC_ADMASYSADDR:
        s->admasysaddr = deposit64(s->admasysaddr, 0, 32, value)
        break;
    case SDHC_ADMASYSADDR + 4:
        s->admasysaddr = deposit64(s->admasysaddr, 32, 32, value);
        break;

>>          break;
>>      case SDHC_ADMASYSADDR + 4:
>> -        s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
>> -                ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
>> +        s->admasysaddr = deposit64(s->admasysaddr, 0, 32, value);
>>          break;
>>      case SDHC_FEAER:
>>          s->acmd12errsts |= value;
