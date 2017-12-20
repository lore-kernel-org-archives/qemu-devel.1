Received: from eggs.gnu.org ([2001:4830:134:3::10]:56841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgRU-0000jN-1J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgQT-0004Kb-Nc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:37:59 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRgQT-0004Jk-8x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:36:57 -0500
Received: by mail-ot0-x241.google.com with SMTP id d5so19955761oti.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 07:36:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bd78a6f5-f023-af5a-0d35-f3b29ae4e7a6@vivier.eu>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-3-michael.weiser@gmx.de>
	<bd78a6f5-f023-af5a-0d35-f3b29ae4e7a6@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 15:36:29 +0000
Message-ID: <CAFEAcA8D0n_PNJ-fqMq8KtZSBRdf2i=3cxcbwT1HSnFi9_MhpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add separate aarch64_be
 uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Michael Weiser <michael.weiser@gmx.de>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 20 December 2017 at 15:20, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 19/12/2017 =C3=A0 21:16, Michael Weiser a =C3=A9crit :
>> Make big-endian aarch64 systems identify as aarch64_be as expected by
>> big-endian userland and toolchains.
>>
>> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
>> ---
>>  linux-user/aarch64/target_syscall.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/ta=
rget_syscall.h
>> index 1b62953eeb..604ab99b14 100644
>> --- a/linux-user/aarch64/target_syscall.h
>> +++ b/linux-user/aarch64/target_syscall.h
>> @@ -8,7 +8,11 @@ struct target_pt_regs {
>>      uint64_t        pstate;
>>  };
>>
>> +#if defined(TARGET_WORDS_BIGENDIAN)
>> +#define UNAME_MACHINE "aarch64_be"
>> +#else
>>  #define UNAME_MACHINE "aarch64"
>> +#endif
>>  #define UNAME_MINIMUM_RELEASE "3.8.0"
>
> For aarch64_be, I think the minimum release should be 4.9.0
> (see kernel commit cfa88c79462d "arm64: Set UTS_MACHINE in the Makefile")

Isn't the thing that defines what we set the minimum-release
to glibc, not the kernel? That is, the reason we lie to the
guest about the kernel version for some architectures is because
the glibc for those archs insists on a minimum kernel version
which the host may not have. Unless aarch64_be glibc insists
on kernel 4.9.0 there's no need to tell the guest that.

thanks
-- PMM
