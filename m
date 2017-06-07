Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dIWqD-0008FZ-05
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dIWq9-0000tV-6Z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dIWq9-0000tO-09
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83CF64DD7C
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:01:19 +0000 (UTC)
References: <20170530212614.18343-1-lersek@redhat.com>
	<1496814770.5126.1.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d8802612-0b11-776f-b209-53bbdaf67515@redhat.com>
Date: Wed, 7 Jun 2017 11:01:12 +0200
MIME-Version: 1.0
In-Reply-To: <1496814770.5126.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 06/07/17 07:52, Gerd Hoffmann wrote:
>   Hi,
> 
> Patch looks sane overall.
> 
>> Invent a new, QEMU-specific register in the config space of the DRAM
>> Controller, at offset 0x50, in order to allow guest firmware to query
>> the
>> TSEG (SMRAM) size.
> 
> Hmm, 0x50 appears to be the only unused config space register in the
> specs.

I did find more holes, in "Table 5-1. DRAM Controller Register Address
Map (D0:F0)", in "Document Number: 316966-002". The hole at 0x50 is just
the one with the lowest config space offset (after the standard PCI
device header). The others are:

- 0x58-0x59 (word)
- 0x9c (byte)
- 0x9f (byte)
- 0xb2-0xc7 (eight words)
- 0xce-0xdb (seven words)
- 0xeb-0xff (fifteen bytes, but this range appears to come after the
             capability list, so I felt it would be unsafe to use)

> I suspect in reality it isn't unused but undocumented.  I don't
> have a better idea though, and in practice it probably isn't much of a
> problem.

Thanks for confirming. Then I'll set out to write the OVMF-side patches
for this. Once I have it all working, I'm going to send out the QEMU
change as a real patch.

Thanks!
Laszlo
