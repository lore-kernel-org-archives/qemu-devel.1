Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1cjOM8-0006Or-Na
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1cjOM4-0006GT-SM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:53:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:49516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.com>) id 1cjOM4-0006FK-MX
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:53:04 -0500
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
From: Michal Marek <mmarek@suse.com>
Message-ID: <175599de-8f4f-8d22-d36e-6fb250ec49f4@suse.com>
Date: Thu, 2 Mar 2017 11:53:01 +0100
MIME-Version: 1.0
In-Reply-To: <41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

Dne 28.2.2017 v 23:11 Richard Henderson napsal(a):
> On 02/27/2017 09:18 PM, Michal Marek wrote:
>> +static int do_stfle(CPUS390XState *env, uint64_t addr, uint32_t ar,
>> int len)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    /* 256 doublewords as per STFLE documentation */
>> +    uint8_t data[256 * 8] = { 0 };
>> +    int res;
>> +
>> +    res = s390_fill_feat_block(cpu->model->features,
>> S390_FEAT_TYPE_STFL, data);
>> +    res = ROUND_UP(res, 8);
>> +    s390_cpu_virt_mem_write(cpu, addr, ar, data, MIN(res, len));
> 
> This does not do what you think it does.  Or indeed, I suspect what the
> original author thinks it does.  I suspect it works for KVM only, and no
> one has actually tried the non-KVM code path.
> 
> Primarily, it does not raise an exception for error.  Secondarily, I
> have no idea what the "AR" argument is supposed to be, or how that's
> supposed to interact with the rest of the virtual memory system.
> 
> Your writes need to look a lot more like fast_memmove in mem_helper.c,
> except that of course only the destination needs translation.
> 
> Of course, in practice we could reduce this to just one cpu_stl_data for
> STFL and one or two cpu_stq_data for STFLE.  So a full fast_memmove loop
> is overkill.
> 
> As it happens, this reminds me that I wrote a version of this several
> years ago but never submitted it upstream.  I'll dig it out.

So, does it make sense for me to post a v5 again not using
s390_cpu_virt_mem_write(), or are you going to refresh your stfle
implementation?

Thanks,
Michal
