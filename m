Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cv0Ui-0001v4-Gu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cv0Uh-0007Un-Fo
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cv0Uh-0007Ub-9h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:49:59 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
Date: Mon, 3 Apr 2017 13:49:38 +0200
MIME-Version: 1.0
In-Reply-To: <1490881315.28523.11.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org



On 30/03/2017 15:41, Gerd Hoffmann wrote:
>   Hi,
> 
>> Excellent! I can help out with converting and/or testing the SPARC
>> devices (cg3/tcx) if required.
> 
> Sure, test results and patches are very welcome.
> 
> I've touched dirty bitmap code for the first time, so I've sent out this
> rfc for early feedback at the approach taken before going out converting
> more display drivers.  Seems nobody found patch #2 horrible so far, I
> take that as good sign that we can go on with this draft API.
> 
>> Out of interest, from your work do you have a rough estimate as to how
>> this affects guest performance? For example benchmarks with Jan's
>> original commit to reduce the locking vs. Alex's current workaround vs.
>> with this patchset applied?
> 
> I expect this improves performance with mttcg because the locking goes
> away, which allows more concurrency, probably more visible with more
> guest cores.  Didn't benchmark it though.

I checked the branch, is bitmap_copy_and_clear_atomic correct when you
have partial updates?  Maybe you need to handle partial updates of the
first and last word?  Also, the first and last bit should optionally be
left untouched, for example:

first y: 20
last y: 99
stride: 320
bytes read: 6400..31999
snapshotted pages: 4096..32767 (copying all of word 0 would do)
cleared dirty bits: 8192..28671 (only bits 1..14 must be zeroed)

Thanks,

Paolo
