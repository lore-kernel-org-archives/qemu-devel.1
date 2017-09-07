Received: from eggs.gnu.org ([2001:4830:134:3::10]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwS7-0000dP-Sh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwRy-0006Gx-Dl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpwRy-0006GJ-4z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:02:30 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-14-david@redhat.com>
	<f59a2e64-d1fb-2db7-0241-4fe76dbe9d95@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <47e0ae34-a012-366f-334c-9a2050eaf496@redhat.com>
Date: Thu, 7 Sep 2017 15:02:26 +0200
MIME-Version: 1.0
In-Reply-To: <f59a2e64-d1fb-2db7-0241-4fe76dbe9d95@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/19] target/s390x: use "core-id" for
 cpu number/address/id handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com


>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>> index 4b0db7b7bd..b8963f2fe2 100644
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -3822,10 +3822,7 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
>>  static ExitStatus op_stap(DisasContext *s, DisasOps *o)
>>  {
>>      check_privileged(s);
>> -    /* ??? Surely cpu address != cpu number.  In any case the previous
>> -       version of this stored more than the required half-word, so it
>> -       is unlikely this has ever been tested.  */
>> -    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
>> +    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
>>      return NO_EXIT;
>>  }
>>
> 
> Are you sure it's OK to remove this blurb in its entirety?  You are
> certainly collapsing the various CPU identifiers, but you aren't
> changing the size of the store from when this blurb was put in
> (411fea3d) So, "the previous version of this stored more than the
> required half-word" seems to be still relevant -- Unless you've gone
> ahead and tested it out?

z13 PoP (10-132):

"The CPU address by which this CPU is identified in a
multiprocessing configuration is stored at the half-
word location designated by the second-operand
address."

As far as I understand this comment, 411fea3d fixed the store to only be
the required half-word, no?

The previous version stored 32bit:
  tcg_gen_qemu_st32(tmp2, tmp, get_mem_index(s));

Now we have:
C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16, stap, 0)

which, due to m1_16, will use wout_m1_16
  tcg_gen_qemu_st16(o->out, o->addr1, get_mem_index(s));

So what's left is the confusion about num vs address. But core-id is
certainly the CPU number, which is t be stored. There is no such thing
as CPU number.

So I think this comment can now safely be dropped.

We have a kvm-unit-test for STAP, but we only check if anything has been
stored, not if "too much" has been stored. But I am not sure if we want
such checks, as the number of tests will explode. Usually, if it would
be broken, other things would then go wrong in our unit tests. I will
have a look.

> 
> Outside of that nit, I like the changes.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> 


-- 

Thanks,

David
