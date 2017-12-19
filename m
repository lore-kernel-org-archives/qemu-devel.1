Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eRFCB-0004Q9-JO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eRFCA-0000Da-Mc
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:32:23 -0500
References: <20171218224616.21030-1-david@redhat.com>
	<20171218224616.21030-2-david@redhat.com>
	<4ea93c11-adf5-ca1c-b49b-e80d82bf3945@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <588a1a23-843c-c7e0-b174-8deb84b41b80@redhat.com>
Date: Tue, 19 Dec 2017 11:32:16 +0100
MIME-Version: 1.0
In-Reply-To: <4ea93c11-adf5-ca1c-b49b-e80d82bf3945@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/2] s390x/tcg: implement
 TEST PROTECTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 19.12.2017 09:20, Thomas Huth wrote:
> On 18.12.2017 23:46, David Hildenbrand wrote:
>> Linux uses TEST PROTECTION to sense for available memory locations.
>>
>> Let's implement what we can for now (just as for the other instructions,
>> excluding AR mode and special protection mechanisms).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h     |  2 +-
>>  target/s390x/mem_helper.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>  target/s390x/translate.c  |  2 +-
>>  3 files changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 2f17b62d3d..26c1b07b44 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -137,7 +137,7 @@ DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_WG, i32, env, i64)
>> -DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
>> +DEF_HELPER_FLAGS_3(tprot, TCG_CALL_NO_RWG, i32, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>> index 2625d843b3..359e446c6f 100644
>> --- a/target/s390x/mem_helper.c
>> +++ b/target/s390x/mem_helper.c
>> @@ -1717,9 +1717,46 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>>      return 0;
>>  }
>>  
>> -uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
>> +uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t a1, uint64_t a2)
>>  {
>> -    /* XXX implement */
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    /*
>> +     * TODO: we currently don't handle all access protection types
>> +     * (including access-list and key-controlled) as well as AR mode.
>> +     */
> 
> Maybe add some "if (a2 & 0xf0) qemu_log_mask(LOG_UNIMPL, ...)" so that
> we've got a chance to detect such conditions later?
> 

In general I would agree, however as such acess-list + storage key stuff
is missing literally all over the place, I don't think it is very helpful.

Once (if ever) we implement it, we will have to go through the whole PoP
either way and fixup all functions.

Thanks!

-- 

Thanks,

David / dhildenb
