Received: from eggs.gnu.org ([2001:4830:134:3::10]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cv126-0001r3-7w
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cv122-0008N4-E7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:24:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36603
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cv122-0008Mn-6Y
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:24:26 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
Date: Mon, 3 Apr 2017 13:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <1491221026.17505.39.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 03/04/17 13:03, Gerd Hoffmann wrote:

>   Hi,
> 
>> I checked the branch, is bitmap_copy_and_clear_atomic correct when you
>> have partial updates?  Maybe you need to handle partial updates of the
>> first and last word?
> 
> Should not be a problem.  We might clear some more bits, but these are
> outsize the visible area so they should cause visible corruption (and if
> the visible area changes the display code needs to do a full refresh
> anyway).

Right. Also is there a reason that
cpu_physical_memory_snapshot_and_clear_dirty() uses BITS_PER_LEVEL when
calculating the alignment used for the first/last addresses? I would
have thought you can remove the align variable and use:

    ram_addr_t first = QEMU_ALIGN_DOWN(start, TARGET_PAGE_SIZE);
    ram_addr_t last  = QEMU_ALIGN_UP(start + length, TARGET_PAGE_SIZE);

Otherwise you end up expanding the range of your last address
considerably beyond the next page alignment. And also in the main page
loop why is BITS_PER_LEVEL used? I see that several of the internal
bitmap routines appear to use BITS_PER_LONG for compressing into the
bitmap which might be more appropriate?


ATB,

Mark.
