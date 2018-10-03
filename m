Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7c1U-0007lj-Ks
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7c1O-0000DR-LK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:56:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1g7c1M-0000Bn-2W
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:56:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id n1-v6so4964171wrt.10
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 00:56:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181002212921.30982-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fd72593-6aeb-9ca5-1621-07a832cc3f8d@redhat.com>
Date: Wed, 3 Oct 2018 09:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181002212921.30982-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 02/10/2018 23:29, Emilio G. Cota wrote:
> This series introduces a per-TLB lock. This removes existing UB
> (e.g. memset racing with cmpxchg on another thread while flushing),
> and in my opinion makes the TLB code simpler to understand.
> 
> I had a bit of trouble finding the best place to initialize the
> mutex, since it has to be called before tlb_flush, and tlb_flush
> is called quite early during cpu initialization. I settled on
> cpu_exec_realizefn, since then cpu->env_ptr has been set
> but tlb_flush hasn't yet been called.
> 
> Perf-wise this change does have a small impact (~2% slowdown for
> the aarch64 bootup+shutdown test; 1.2% comes from using atomic_read
> consistently), but I think this is a fair price for avoiding UB.

The UB is unlikely to be an issue in practice, but I like the
simplicity.  In retrospect it was premature optimization.

Paolo
