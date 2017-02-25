Received: from eggs.gnu.org ([2001:4830:134:3::10]:52651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chPsJ-0002xW-Mv
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 19:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chPsG-0004ZQ-HS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 19:06:11 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1chPsG-0004Yq-Bf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 19:06:08 -0500
Received: by mail-pg0-x241.google.com with SMTP id s67so4761938pgb.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:06:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170224134411.28882-1-mmarek@suse.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a634716c-c998-c422-6802-946a283f8837@twiddle.net>
Date: Sat, 25 Feb 2017 11:05:55 +1100
MIME-Version: 1.0
In-Reply-To: <20170224134411.28882-1-mmarek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

On 02/25/2017 12:44 AM, Michal Marek wrote:
> +DEF_HELPER_1(stfl, void, env)

DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)

since this touches no registers, and only writes to lomem which afaik cannot 
fault in kernel mode.

> +DEF_HELPER_3(stfle, i64, env, i64, i64)

Unfortunately, we are writing to cc_op, so we do have a TCG register write, so 
I guess this is the best we can do here.

> +static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +    uint8_t data[64];

S390FeatBitmap or S390FeatInit?  Or even a sizeof?
Hard coding 64 certainly doesn't seem right.

> +    memset(data, 0, sizeof(data));
> +    res = s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL, data);
> +    cpu_physical_memory_write(addr, data, MIN(res, len));

No, not physical memory, you need to write to virtual memory, at least for 
STFLE.  Which, as you'll recall can be used from user-mode.


r~
