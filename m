Received: from eggs.gnu.org ([2001:4830:134:3::10]:52515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyw2m-0007sv-Oz
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyw2j-00089m-Nj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:57:56 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyw2j-00089B-Gz
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:57:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id 139so14596723wmn.2
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 01:57:53 -0700 (PDT)
References: <20180309132922.24211-1-pbonzini@redhat.com>
	<20180309132922.24211-5-pbonzini@redhat.com>
	<20180322012937.GB16453@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f939e5d-ad2f-62a3-9e2f-22f6bd17bc94@redhat.com>
Date: Thu, 22 Mar 2018 09:57:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180322012937.GB16453@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] membarrier: add --enable-membarrier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 22/03/2018 02:29, Emilio G. Cota wrote:
> It is indeed hard to see a large impact on performance given the
> large size of our critical sections. But hey, rcu_read_unlock
> goes down from 0.24% to 0.08% of execution time when booting
> aarch64 linux!

I expect something a little better than 0.15% from virtio, especially
once I re-enable MemoryRegionCache in 2.13.

>> +    int main(void) {
>> +        syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);
>> +        syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);
>> +    }
> 
> I think we should also check here that MEMBARRIER_CMD_SHARED is
> actually supported;

Checking run-time constraints at compile-time is a bit pointless.  My
idea was to add a third mode where the choice is done at run-time, but
that wouldn't have made 2.12.

Paolo
