Received: from eggs.gnu.org ([2001:4830:134:3::10]:42906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chj8K-0003zR-Ld
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 15:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chj8H-00018N-Iy
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 15:40:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:51605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.com>) id 1chj8H-00017n-Cj
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 15:39:57 -0500
References: <20170224134411.28882-1-mmarek@suse.com>
	<a634716c-c998-c422-6802-946a283f8837@twiddle.net>
From: Michal Marek <mmarek@suse.com>
Message-ID: <a76250b9-ec10-1444-03aa-00ffb8c17fda@suse.com>
Date: Sat, 25 Feb 2017 21:39:51 +0100
MIME-Version: 1.0
In-Reply-To: <a634716c-c998-c422-6802-946a283f8837@twiddle.net>
Content-Type: text/plain; charset=windows-1252
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
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

Dne 25.2.2017 v 01:05 Richard Henderson napsal(a):
> On 02/25/2017 12:44 AM, Michal Marek wrote:
>> +DEF_HELPER_1(stfl, void, env)
> 
> DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
> 
> since this touches no registers, and only writes to lomem which afaik
> cannot fault in kernel mode.

OK.


>> +static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    uint8_t data[64];
> 
> S390FeatBitmap or S390FeatInit?  Or even a sizeof?
> Hard coding 64 certainly doesn't seem right.

I will change it to something more sensible.


>> +    memset(data, 0, sizeof(data));
>> +    res = s390_fill_feat_block(cpu->model->features,
>> S390_FEAT_TYPE_STFL, data);
>> +    cpu_physical_memory_write(addr, data, MIN(res, len));
> 
> No, not physical memory, you need to write to virtual memory, at least
> for STFLE.  Which, as you'll recall can be used from user-mode.

Oh, I did not realize that STFLE is not a privileged instruction.

Thanks for the review!

Michal
