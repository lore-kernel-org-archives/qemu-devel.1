Received: from eggs.gnu.org ([2001:4830:134:3::10]:42918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dAhni-0006mZ-23
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dAhnh-0001Sk-9F
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:06:30 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dAhnh-0001Sd-52
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:06:29 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so24193221qke.2
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 12:06:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1494926884-10118-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24feaa40-93e3-600e-fa00-0d1e00117c41@twiddle.net>
Date: Tue, 16 May 2017 12:06:24 -0700
MIME-Version: 1.0
In-Reply-To: <1494926884-10118-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>, mmarek@suse.com, mbenes@suse.cz

On 05/16/2017 02:28 AM, Thomas Huth wrote:
> +void HELPER(testblock)(CPUS390XState *env, uint64_t addr)
> +{
> +    CPUState *cs = CPU(s390_env_get_cpu(env));
> +    int i;
> +
> +    addr = get_address(env, 0, 0, addr) & ~0xfffULL;
> +    for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
> +        stq_phys(cs->as, addr + i, 0);
> +    }
> +    env->cc_op = 0;
> +}

This needs several changes: check that the physical page does indeed exist, 
"low address protection", return the cc code.

> +DEF_HELPER_2(testblock, void, env, i64)

With cc returned, this becomes

   DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_RWG, i32, env, i64)


r~
