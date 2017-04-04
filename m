Received: from eggs.gnu.org ([2001:4830:134:3::10]:38585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvIqT-0000xH-Sj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvIqP-0003Za-Uy
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:25:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:39538
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvIqP-0003Xb-Mz
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:25:37 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
	<b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
	<1491223335.17505.48.camel@redhat.com>
	<81c92413-024a-5448-1160-b24ca944e88e@ilande.co.uk>
	<1491286370.1455.22.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ea81937e-e4c0-1930-840f-320c4d538d2d@ilande.co.uk>
Date: Tue, 4 Apr 2017 08:25:03 +0100
MIME-Version: 1.0
In-Reply-To: <1491286370.1455.22.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 04/04/17 07:12, Gerd Hoffmann wrote:

>   Hi,
> 
>> -    unsigned long align = 1 << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
>> +    unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
> 
>> There were 2 issues here: without the UL suffix on align I was getting
>> incorrect first/last addresses since the high bits of align weren't
>> being cleared,
> 
> Ah, thanks, I'll add that.
> 
>> and then offset appeared to be shifted twice.
> 
> Yep, noticed that too meanwhile, fixed in the branch pushed half an hour
> ago.  I've dropped the other shift though ;)

Confirmed!

The only minor nit I've noticed is that commit 322aef7 "cg3: fix up size
parameter for memory_region_get_dirty()" isn't quite right now that the
asserts() in cpu_physical_memory_snapshot_get_dirty() have now been
fixed - the size should now be "width" rather than "width - 1".

Other than that, I've just given it a quick spin across my SPARC CG3/TCX
and PPC VGA images and it looks good here :)


ATB,

Mark.
