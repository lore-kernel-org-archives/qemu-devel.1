Received: from eggs.gnu.org ([2001:4830:134:3::10]:59169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0A3J-0004LY-83
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0A3E-0005bA-Kj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:39:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g0A3E-0005ai-4o
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:39:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id k5-v6so3084891wre.10
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 11:39:44 -0700 (PDT)
References: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
	<618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
Date: Wed, 12 Sep 2018 19:39:41 +0100
Message-ID: <87ftyeblw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix breakpoints in nios2 user-mode
 emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org, marex@denx.de, crwulff@gmail.com


Richard Henderson <richard.henderson@linaro.org> writes:

> On 09/11/2018 02:29 PM, Sandra Loosemore wrote:
>> Without this patch, QEMU exits immediately when it execution stops at
>> a breakpoint, instead of reporting it to GDB.
>>
>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>> ---
>>  linux-user/nios2/cpu_loop.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
>> index dac7a06..a5ae37f 100644
>> --- a/linux-user/nios2/cpu_loop.c
>> +++ b/linux-user/nios2/cpu_loop.c
>> @@ -71,6 +71,9 @@ void cpu_loop(CPUNios2State *env)
>>                  gdbsig =3D TARGET_SIGTRAP;
>>                  break;
>>              }
>> +        case EXCP_DEBUG:
>> +            gdbsig =3D TARGET_SIGTRAP;
>> +            break;
>
> This really isn't complete.  You set gdbsig from odd places instead of us=
ing
> queue_signal; you fail to honor the return value from gdb_handlesig.
>
> But I suppose those should be separate patches, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

At least the cpu_loops have been separated now.. I guess the next step
is to audit each one for common features? There do seem to be some magic
numbers in the nios loop which I find concerning.

>
>
> r~


--
Alex Benn=C3=A9e
