Received: from eggs.gnu.org ([2001:4830:134:3::10]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dumb5-00022s-Gh
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dumb2-0000WV-7E
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:31:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55446 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dumb2-0000Sh-0D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:31:52 -0400
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
	<CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
	<CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
	<cf804325-c982-c07d-b88c-5d069252f76f@bitwagon.com>
	<CAFEAcA8XU004=Tiv2mTgxVFoToZYL_UshmJjbeJ9v2dP7V0rMw@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <ef3336f8-6eee-c775-3f1e-472e2cae735d@suse.de>
Date: Wed, 20 Sep 2017 23:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XU004=Tiv2mTgxVFoToZYL_UshmJjbeJ9v2dP7V0rMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, John Reiser <jreiser@bitwagon.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 20.09.17 20:04, Peter Maydell wrote:
> On 20 September 2017 at 18:05, John Reiser <jreiser@bitwagon.com> wrote:
>> Yes, the SEGV occurs on the store, "long" before the re-written
>> instruction ever is executed
> 
> OK, I've identified the immediate cause for this SEGV.
> 
> (1) when the guest initially mmap()s at 0xf7000000 and
> above we pass that through to the host as an mmap rwx
> (2) later, the guest wants to execute from some part
> of this region; QEMU marks those pages as non-writable
> so that we can catch guest writes and invalidate our
> translated code cache (we then mark the page writable
> and resume the guest code). This is a host page at a time,
> so it covers the memory we're trying to modify
> (3) when the translated guest code writes to the memory,
> we get a host SIGSEGV, which is expected. Unfortunately
> we then fail to recognize it as a case of a guest
> write to a page that QEMU marked non-writeable.
> (4) The reason we don't recognize the address is that
> our test for "is this valid" (h2g_valid()) checks that the
> guest address is within the chunk of the host address
> space that we've carved out for the guest, and the
> amount of space we carve out for that is 0xf7000000.
> So guest execution above that won't work properly
> (really we should probably fail the mmap() rather than
> letting it succeed but misbehave).
> 
> I don't really know why we use 0xf7000000 as our
> reserved_va value here, though. Alex, you added that
> years ago, can you remember why you used that value?

IIRC I wanted to map the full 32 bits of address space possibly in use 
by a 32bit application, but leave some room for something, but I don't 
remember what that something was :)


Alex
