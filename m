Received: from eggs.gnu.org ([2001:4830:134:3::10]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2ybD-0005v9-4f
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2ybA-0001hU-Fz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:25:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d2ybA-0001gx-9J
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:25:36 -0400
Received: by mail-wr0-x241.google.com with SMTP id v42so16322652wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:25:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170425104338.31984-1-rth@twiddle.net>
	<87a87468d5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f7766e0-4935-9b2e-8388-ff8f04a43aaf@twiddle.net>
Date: Tue, 25 Apr 2017 13:25:32 +0200
MIME-Version: 1.0
In-Reply-To: <87a87468d5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>

On 04/25/2017 01:21 PM, Nikunj A Dadhania wrote:
> Richard Henderson <rth@twiddle.net> writes:
> 
>> Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
>> the output.  Even though this code is dead, it gets translated, and
>> without the initialization we encounter a tcg_error.
>>
>> Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> With this the tcg_error goes away.
> 
> But then powernv skiboot code [1] enters into infinite loop. Basically,
> in target/ppc/translate.c:gen_conditional_store(), setcond_tl will
> always fail, and CRF_EQ_BIT will never be set, the lock will never be
> taken.

The setcond_tl *shouldn't* always fail.  If that's the case, then we have 
another bug in the !parallel_cpus code path for gen_conditional_store.


r~
