Received: from eggs.gnu.org ([2001:4830:134:3::10]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f47pC-0000p4-6w
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f47p9-0008Pl-2w
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:33:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f47p8-0008PQ-Pg
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:33:19 -0400
References: <20180405134702.5020-1-jcmvbkbc@gmail.com>
	<6b21a387-7ebd-c738-e1c4-b65645f11fed@vivier.eu>
	<CAMo8Bf+9h2vSMcQQftkh0DDLNJbHV_beGARSn2RaB_MjkRMtFg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <31415928-bff1-7c2b-ec01-a56d708a7002@vivier.eu>
Date: Thu, 5 Apr 2018 18:33:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+9h2vSMcQQftkh0DDLNJbHV_beGARSn2RaB_MjkRMtFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

Le 05/04/2018 à 18:27, Max Filippov a écrit :
> On Thu, Apr 5, 2018 at 8:52 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>> Why don't you try to de-construct then re-construct the offset?
> 
> It would require 128-bit arithmetic on 64-bit host.
> 
>> Kernel commit
>>   601cc11d054a "Make non-compat preadv/pwritev use native register size"
>> is interesting.
>>
>> static inline abi_llong target_pos_from_hilo(abi_ulong high,
>>                                              abi_ulong low)
>> {
>> #define TARGET_HALF_LONG_BITS (TARGET_LONG_BITS / 2)
>>    return (((abi_llong)high << TARGET_HALF_LONG_BITS) <<
>>                              TARGET_HALF_LONG_BITS) | low;
>> }
>>
>> #define HOST_HALF_LONG_BITS (HOST_LONG_BITS / 2)
>>
>>  abi_llong pos = target_pos_from_hilo(arg4, arg5);
>>  ret = get_errno(safe_preadv(arg1, vec, arg3,
>>           pos,
>>           (pos >> HOST_HALF_LONG_BITS) >> HOST_HALF_LONG_BITS));
>>
>> It looks simpler, but perhaps I miss something
>> (it's just cut&paste, I don't pretend to understand that code...)?
> 
> If we decide that host unsigned long long is wide enough to represent
> meaningful file positions then this function may be simplified to
> something like
> 
> unsigned long long off = (unsigned long long)tlow |
> ((unsigned long long)thigh << (TARGET_LONG_BITS / 2)) << (TARGET_LONG_BITS / 2);
> *hlow = (unsigned long)off;
> *hhigh = (unsigned long)((off >> (HOST_LONG_BITS / 2)) >> (HOST_LONG_BITS / 2));
> 
> There's also a bug that the target may specify an offset not representable
> on the host, that will get truncated and point to a different location in the
> file, possibly resulting in data corruption.

I don't think it can happen, because "long long" is always 64bit, so it
fits in two 32bit (long is 32bit on 32bit, 64bit on 64bit).

Thanks,
Laurent
