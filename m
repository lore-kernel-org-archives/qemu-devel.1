Received: from eggs.gnu.org ([2001:4830:134:3::10]:59980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHTpW-0001by-IU
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHTpR-00021e-Jv
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:08:38 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHTpR-000218-CE
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:08:33 -0500
Received: by mail-wm0-x243.google.com with SMTP id v186so9689315wma.2
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:08:33 -0800 (PST)
References: <20171122084157.11480-1-quintela@redhat.com>
	<4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
	<CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
Date: Wed, 22 Nov 2017 13:08:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 11/22/2017 01:03 PM, Peter Maydell wrote:
> On 22 November 2017 at 12:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 11/22/2017 09:41 AM, Juan Quintela wrote:
>>> This commit started use tb_unlock() and tlb_set_dirty() on non TCG
>>> code.  Add the function as stubs.
>>>
>>> commit 27266271977c5a30f2f7d493e042be1897827bdd
>>> Author: Peter Maydell <peter.maydell@linaro.org>
>>> Date:   Mon Nov 20 18:08:27 2017 +0000
>>>
>>>     exec.c: Factor out before/after actions for notdirty memory writes
>>>     ....
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>  accel/stubs/tcg-stub.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> Hmm.  An alternate solution is
>>
>>
>> diff --git a/exec.c b/exec.c
>> index 03238a3449..ac902da89d 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2378,6 +2378,7 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
>>  /* Called within RCU critical section. */
>>  void memory_notdirty_write_complete(NotDirtyInfo *ndi)
>>  {
>> +    assert(tcg_enabled());
>>      if (ndi->locked) {
>>          tb_unlock();
>>      }
>>
>>
>> so that the rest of the function is compiled away.
>>
>> Thus my confusion about how Peter was adding any references to these functions
>> -- he split half the function such that half is now not protected by an assert.
> 
> Wow, I totally do not expect "assert(tcg_enabled())" to mean
> "we rely on the compiler to be able to determine that this
> code is dead" (and in general I'm not a fan of the compilation
> relying on the compiler determining that code is dead).

We do this all of the time for more regular tests that are obviously
compile-time.  I am a really big fan of this, because it makes sure that the
(usually 32-bit) else branch continues to compile.

It's just that with --disable-tcg, tcg_enabled() expands to the less-obviously
constant false.


r~
