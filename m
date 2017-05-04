Received: from eggs.gnu.org ([2001:4830:134:3::10]:43005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GYF-0003jO-Nd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GYB-0004wI-P1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6GYB-0004vk-IT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:12:07 -0400
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
	<b365904f-21ae-85a7-a3a6-bbe21c62e35a@redhat.com>
	<000401d2c4c7$6d5b6d50$481247f0$@ru>
	<b44f8aa8-e42f-4b94-ccfa-d80adb60de35@redhat.com>
	<000801d2c4cd$3d3af720$b7b0e560$@ru>
	<58398574-88b5-3382-65e2-7208beccc09a@redhat.com>
	<000f01d2c4cf$7479f630$5d6de290$@ru>
	<c6f5e430-fa98-124f-146b-6c3de79448cd@redhat.com>
	<001101d2c4d2$bb44a4e0$31cdeea0$@ru>
	<e6c5885d-855b-288e-68c8-5665be284d78@redhat.com>
	<001201d2c4d6$c26bdd20$47439760$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf930126-426b-b208-8fcb-76adda3bd9f5@redhat.com>
Date: Thu, 4 May 2017 15:12:01 +0200
MIME-Version: 1.0
In-Reply-To: <001201d2c4d6$c26bdd20$47439760$@ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 06/10] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 04/05/2017 15:02, Pavel Dovgalyuk wrote:
>> Understood.  And what checkpoint will you be waiting for during drain,
>> causing a deadlock?
> Every checkpoint processes the queue, but none of them are invoked,
> because iothread (which invokes all the checkpoints) is waiting for the end of the drain.
> 
> And we cannot add a checkpoint into the drain, because then vmstop will
> affect the behavior of the guest.

But it does affect the behavior already when RR is off.  And it
shouldn't be a problem if it does in record mode (as long as the effect
can be replayed).

If RR cannot do drain reliably, not even in record mode, that is a huge
problem because a lot of block layer operations assume they can.

Paolo
