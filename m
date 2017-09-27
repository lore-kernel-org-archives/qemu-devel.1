Received: from eggs.gnu.org ([2001:4830:134:3::10]:56265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxHMK-00060z-Nc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxHMF-00016P-W3
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:47:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxHMF-00015G-PN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:46:55 -0400
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-4-david@redhat.com>
	<6d86db3a-33ef-e155-2f96-76cf15dd1220@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d535e6d-6e22-dc7f-2ce8-b2a542935f58@redhat.com>
Date: Wed, 27 Sep 2017 20:46:51 +0200
MIME-Version: 1.0
In-Reply-To: <6d86db3a-33ef-e155-2f96-76cf15dd1220@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] s390x/tcg: make STFL store into
 the lowcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 27.09.2017 19:52, Richard Henderson wrote:
> On 09/27/2017 10:00 AM, David Hildenbrand wrote:
>> Using virtual memory access is wrong and will soon include low-address
>> protection checks, which is to be bypassed for STFL.
>>
>> This was originally part of a bigger STFL(E) refactoring.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h      | 2 +-
>>  target/s390x/misc_helper.c | 7 ++++++-
>>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Need to sort this patch first, so that the series is bisectable.

Right, this should become #2.

> 
>>  DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
>>  DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
>> -DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
>>  DEF_HELPER_2(stfle, i32, env, i64)
>>  DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
>>  DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
>> @@ -153,6 +152,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
>>  DEF_HELPER_1(per_check_exception, void, env)
>>  DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
>> +DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
>>  
> 
> Why?  Otherwise,

struct LowCore is only available for !CONFIG_USER_ONLY. Therefore I also
have to move the helper declaration into !CONFIG_USER_ONLY.

Thanks!

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David
