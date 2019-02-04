Received: from eggs.gnu.org ([209.51.188.92]:54546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqeKX-0008MR-7k
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqeKO-00066O-M6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:30:30 -0500
References: <20190131143759.3122-1-david@redhat.com>
	<a34065d4-b06e-2157-e89d-be30adf87ed0@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4c7fd460-2b5c-b109-cbc7-6d2bb242df99@redhat.com>
Date: Mon, 4 Feb 2019 14:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <a34065d4-b06e-2157-e89d-be30adf87ed0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04.02.19 14:27, Richard Henderson wrote:
> On 1/31/19 2:37 PM, David Hildenbrand wrote:
>> As floating point registers overlay some vector registers and we want
>> to make use of the general tcg_gvec infrastructure that assumes vectors
>> are not stored in globals but in memory, don't model flaoting point
>> registers as globals anymore. This is than similar to how arm handles
>> it.
>>
>> Reading/writing a floating point register means reading/writing memory now.
>>
>> Break up ugly in2_x2() handling that modifies both, in1 and in2 into
>> in1_x2l and in2_x2h. This makes things more readable. Also, in1_x1() is
>> ugly as it touches out/out2, get rid of that and use prep_x1() instead.
>>
>> As we are no longer able to use the original global variables for
>> out/out2, we have to use new temporary variables and write from them to
>> the target registers using wout_ helpers.
>>
>> E.g. an instruction that reads and writes x1 will use
>> - prep_x1 to get the values into out/out2
>> - wout_x1 to write the values from out/out2
>> This special handling is needed for x1 as it is often used along with
>> other inputs, so in1/in2 is already used.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/insn-data.def | 150 ++++++++++++++++++-------------------
>>  target/s390x/translate.c   | 133 +++++++++++++++++++-------------
>>  2 files changed, 158 insertions(+), 125 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

I'll probably switch naming of in1_x2l and in2_x2h to

in1_x2h and in2_x2l (will double check, but I guess this is the right
thing to do - high double word always comes first, e.g. in memory).

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
