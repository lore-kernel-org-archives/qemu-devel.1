Received: from eggs.gnu.org ([2001:4830:134:3::10]:44616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHQu-00061W-0H
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHQq-0000Ik-1o
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:46:56 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epHQp-0000H3-6N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:46:51 -0500
Received: by mail-pg0-x244.google.com with SMTP id y26so3624577pgv.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:46:51 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-27-richard.henderson@linaro.org>
	<CAFEAcA8UWBemOXvu7-Dt5CMv7VHSTNp4fGSKPnnHT2UfNryOHw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3956498-6020-7c30-d97e-841c280cc40a@linaro.org>
Date: Fri, 23 Feb 2018 09:46:47 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UWBemOXvu7-Dt5CMv7VHSTNp4fGSKPnnHT2UfNryOHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 26/67] target/arm: Implement
 SVE Permute - Extract Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 06:24 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper-sve.h    |  2 ++
>>  target/arm/sve_helper.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-sve.c | 29 +++++++++++++++++
>>  target/arm/sve.decode      |  9 +++++-
>>  4 files changed, 120 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
>> index 79493ab647..94f4356ce9 100644
>> --- a/target/arm/helper-sve.h
>> +++ b/target/arm/helper-sve.h
>> @@ -414,6 +414,8 @@ DEF_HELPER_FLAGS_4(sve_cpy_z_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>>  DEF_HELPER_FLAGS_4(sve_cpy_z_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>>  DEF_HELPER_FLAGS_4(sve_cpy_z_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>>
>> +DEF_HELPER_FLAGS_4(sve_ext, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>> +
>>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index 6a95d1ec48..fb3f54300b 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -1469,3 +1469,84 @@ void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
>>          d[i] = (pg[H1(i)] & 1 ? val : 0);
>>      }
>>  }
>> +
>> +/* Big-endian hosts need to frob the byte indicies.  If the copy
>> + * happens to be 8-byte aligned, then no frobbing necessary.
>> + */
> 
> Have you run risu tests with a big endian host?

Some, early on.  It's probably time to do it again.

Running those tests was why I dropped the ZIP/UZP/TRN patches from the host
vector support patch set.  Supporting those endian agnostic is incompatible
with our "pdp-endian-like" storage of vectors for ARM -- we would have to put
the vectors in full host-endian order for that.

In the meantime, the frobbing within helpers does work.


r~
