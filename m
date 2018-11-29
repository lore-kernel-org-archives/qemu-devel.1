Received: from eggs.gnu.org ([2001:4830:134:3::10]:59259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSS9L-0001XK-51
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSS9I-0007Or-0H
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:38:59 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40047
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gSS9H-0007OG-OI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:38:55 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
	<be4173c3-353b-1bd7-b937-b0d39a7bba26@ilande.co.uk>
	<20181129190709.GB6064@roeck-us.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <400af659-af6a-24e4-4ce4-d66d6769cc6c@ilande.co.uk>
Date: Thu, 29 Nov 2018 19:38:47 +0000
MIME-Version: 1.0
In-Reply-To: <20181129190709.GB6064@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 29/11/2018 19:07, Guenter Roeck wrote:

>> I've now completed a boot test of all my SPARC32 OpenBIOS CDROM images with this
>> patch, and whilst it doesn't solve my NextSTEP issue, I don't see any obvious
>> regressions.
>>
>> Note that NetBSD SPARC32 tends to spit out the occasional "!TC on data xfer" message
>> to the console during periods of disk access, however that is something that has
>> always happened and isn't something new introduced by this patch.
>>
> 
> That may be because reading the interrupt status resets the TC bit.
> As mentioned above, I think it shouldn't do that. Just a wild guess, but
> it might be worth a try. Can you remove "s->rregs[ESP_RSTAT] &= ~STAT_TC;"
> from the ESP_RINTR case in esp_reg_read() and see what happens ?
> 
> [That may expose situations where STAT_TC _should_ be cleared but isn't,
>  so we may hit other problems when doing that.]

I've tried that, and over a number of boots it does seem to allow the boot to get
further: with this change I'd say around 95% of the time NextSTEP now gets past the
SCSI bus enumeration and hangs at the point where it tries to mount the root filesystem.

Interestingly enough even if I comment out that line I still see the "!TC on data
xfer" messages appearing on the NetBSD console...


ATB,

Mark.
