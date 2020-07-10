Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9F92067D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rpet70EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9F92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoT0-00057K-4Y
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtoSB-0003vX-37
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42699
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtoS9-0005UU-72
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594369936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hPFEgYcHEfaBBhufqYzcY3v1s2Bm7XA5ly8lDCZTSq8=;
 b=Rpet70EKavpI+KQHyTdtgiGeDmznlt2rVAbtc0VlCBNthuhc7bWfJ7P6NykMNjvst/ZMlS
 ckQpMhS7Cmd2eDW36TlhIQygJ3aZ6Z3Cor7EWbgzXPfKtMABFq5XIMf0rUMEqAIx0li14m
 LYMBXPi6Jtnu4MhpGVyXnnvYqahD1eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-sEzmHw0tPrSC5Wz4SC3Heg-1; Fri, 10 Jul 2020 04:32:12 -0400
X-MC-Unique: sEzmHw0tPrSC5Wz4SC3Heg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 438321083;
 Fri, 10 Jul 2020 08:32:11 +0000 (UTC)
Received: from [10.36.114.41] (ovpn-114-41.ams2.redhat.com [10.36.114.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 540256FEE7;
 Fri, 10 Jul 2020 08:32:06 +0000 (UTC)
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
To: Cornelia Huck <cohuck@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-3-david@redhat.com>
 <20200709123741.28a1e3b2.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <520dafce-917f-9a88-a3ee-c7d614ac113f@redhat.com>
Date: Fri, 10 Jul 2020 10:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709123741.28a1e3b2.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.07.20 12:37, Cornelia Huck wrote:
> On Wed,  8 Jul 2020 20:51:32 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's implement the "storage configuration" part of diag260. This diag
>> is found under z/VM, to indicate usable chunks of memory tot he guest OS.
>> As I don't have access to documentation, I have no clue what the actual
>> error cases are, and which other stuff we could eventually query using this
>> interface. Somebody with access to documentation should fix this. This
>> implementation seems to work with Linux guests just fine.
>>
>> The Linux kernel supports diag260 to query the available memory since
>> v4.20. Older kernels / kvm-unit-tests will later fail to run in such a VM
>> (with maxmem being defined and bigger than the memory size, e.g., "-m
>>  2G,maxmem=4G"), just as if support for SCLP storage information is not
>> implemented. They will fail to detect the actual initial memory size.
>>
>> This interface allows us to expose the maximum ramsize via sclp
>> and the initial ramsize via diag260 - without having to mess with the
>> memory increment size and having to align the initial memory size to it.
>>
>> This is a preparation for memory device support. We'll unlock the
>> implementation with a new QEMU machine that supports memory devices.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/diag.c        | 57 ++++++++++++++++++++++++++++++++++++++
>>  target/s390x/internal.h    |  2 ++
>>  target/s390x/kvm.c         | 11 ++++++++
>>  target/s390x/misc_helper.c |  6 ++++
>>  target/s390x/translate.c   |  4 +++
>>  5 files changed, 80 insertions(+)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 1a48429564..c3b1e24b2c 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -23,6 +23,63 @@
>>  #include "hw/s390x/pv.h"
>>  #include "kvm_s390x.h"
>>  
>> +void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>> +{
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    const ram_addr_t initial_ram_size = ms->ram_size;
>> +    const uint64_t subcode = env->regs[r3];
>> +    S390CPU *cpu = env_archcpu(env);
>> +    ram_addr_t addr, length;
>> +    uint64_t tmp;
>> +
>> +    /* TODO: Unlock with new QEMU machine. */
>> +    if (false) {
>> +        s390_program_interrupt(env, PGM_OPERATION, ra);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * There also seems to be subcode "0xc", which stores the size of the
>> +     * first chunk and the total size to r1/r2. It's only used by very old
>> +     * Linux, so don't implement it.
> 
> FWIW,
> https://www-01.ibm.com/servers/resourcelink/svc0302a.nsf/pages/zVMV7R1sc246272/$file/hcpb4_v7r1.pdf
> seems to list the available subcodes. Anything but 0xc and 0x10 is for
> 24/31 bit only, so we can safely ignore them. Not sure what we want to
> do with 0xc: it is supposed to "Return the highest addressable byte of
> virtual storage in the host-primary address space, including named
> saved systems and saved segments", so returning the end of the address
> space should be easy enough, but not very useful.
> 
>> +     */
>> +    if ((r1 & 1) || subcode != 0x10) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +        return;
>> +    }
>> +    addr = env->regs[r1];
>> +    length = env->regs[r1 + 1];
>> +
>> +    /* FIXME: Somebody with documentation should fix this. */
> 
> Doc mentioned above says for specification exception:
> 
> "For subcode X'10':
> • Rx is not an even-numbered register.
> • The address contained in Rx is not on a quadword boundary.
> • The length contained in Rx+1 is not a positive multiple of 16."
> 
>> +    if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length, 16)) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +        return;
>> +    }
>> +
>> +    /* FIXME: Somebody with documentation should fix this. */
>> +    if (!length) {
> 
> Probably specification exception as well?
> 
>> +        setcc(cpu, 3);
>> +        return;
>> +    }
>> +
>> +    /* FIXME: Somebody with documentation should fix this. */
> 
> For access exception:
> 
> "For subcode X'10', an error occurred trying to store the extent
> information into the guest's output area."
> 
>> +    if (!address_space_access_valid(&address_space_memory, addr, length, true,
>> +                                    MEMTXATTRS_UNSPECIFIED)) {
>> +        s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +        return;
>> +    }
>> +
>> +    /* Indicate our initial memory ([0 .. ram_size - 1]) */
>> +    tmp = cpu_to_be64(0);
>> +    cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
>> +    tmp = cpu_to_be64(initial_ram_size - 1);
>> +    cpu_physical_memory_write(addr + sizeof(tmp), &tmp, sizeof(tmp));
>> +
>> +    /* Exactly one entry was stored. */
>> +    env->regs[r3] = 1;
>> +    setcc(cpu, 0);
>> +}
>> +
>>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>>  {
>>      uint64_t func = env->regs[r1];
> 
> (...)
> 
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index 58dbc023eb..d7274eb320 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -116,6 +116,12 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>>      uint64_t r;
>>  
>>      switch (num) {
>> +    case 0x260:
>> +        qemu_mutex_lock_iothread();
>> +        handle_diag_260(env, r1, r3, GETPC());
>> +        qemu_mutex_unlock_iothread();
>> +        r = 0;
>> +        break;
>>      case 0x500:
>>          /* KVM hypercall */
>>          qemu_mutex_lock_iothread();
> 
> Looking at the doc referenced above, it seems that we treat every diag
> call as privileged under tcg; but it seems that 0x44 isn't? (Unrelated
> to your patch; maybe I'm misreading.)

That's also a BUG in kvm then?

int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
{
...
	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
...
}

-- 
Thanks,

David / dhildenb


