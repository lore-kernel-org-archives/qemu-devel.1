Received: from eggs.gnu.org ([2001:4830:134:3::10]:44322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUcE6-0008Bi-1W
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUcE2-00017o-OX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:39:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cUcE2-000170-IO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:39:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so7970925wmd.2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:39:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170118160315.GS30347@stefanha-x1.localdomain>
	<08705645-17e8-1ffa-4199-c962f7198ab3@redhat.com>
	<20170119170128.GD27032@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0969c169-772e-d213-675a-30aee616f8a8@redhat.com>
Date: Fri, 20 Jan 2017 17:39:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170119170128.GD27032@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/16] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org



On 19/01/2017 18:01, Stefan Hajnoczi wrote:
>>> This is a big and somewhat risky change.  Have you run any performance
>>> benchmarks?
>>
>> Not recently; I ran them a year ago and there was no measurable difference.
> 
> Good, please re-run for the final version.

Done, went better than expected. :)

base
4k-1 null   READ: io=6646.8MB, aggrb=226852KB/s, minb=226852KB/s, maxb=226852KB/s, mint=30000msec, maxt=30000msec
4k-1 nvme   READ: io=3086.4MB, aggrb=105342KB/s, minb=105342KB/s, maxb=105342KB/s, mint=30001msec, maxt=30001msec
4k-32 nvme  READ: io=14246MB, aggrb=486241KB/s, minb=486241KB/s, maxb=486241KB/s, mint=30001msec, maxt=30001msec

patched:
4k-1 null   READ: io=7044.5MB, aggrb=240436KB/s, minb=240436KB/s, maxb=240436KB/s, mint=30000msec, maxt=30000msec
4k-1 nvme   READ: io=3463.3MB, aggrb=118208KB/s, minb=118208KB/s, maxb=118208KB/s, mint=30001msec, maxt=30001msec
4k-32 nvme  READ: io=15217MB, aggrb=519378KB/s, minb=519378KB/s, maxb=519378KB/s, mint=30001msec, maxt=30001msec

null is null-co://, nvme is a fast (180kIOPS on bare-metal) NVMe SSD.

So it seems to be some 5-10% faster.  No idea why so I would not give too
much importance on the numbers, but at least it's not worse.

Paolo
