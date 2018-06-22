Received: from eggs.gnu.org ([2001:4830:134:3::10]:55698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWQ1f-0001Aw-6E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWQ1c-0002f1-28
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:39:11 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWQ1b-0002es-KO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:39:07 -0400
Received: by mail-pg0-x242.google.com with SMTP id d2-v6so3261011pga.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:39:07 -0700 (PDT)
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-14-richard.henderson@linaro.org>
	<CAFEAcA9p63Fq+jjRpfwuXsubdVG-M9fjpdVx8JKRRyMgPOQfKA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74febb77-65cc-51be-3369-5fed6c1edc4c@linaro.org>
Date: Fri, 22 Jun 2018 10:39:03 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9p63Fq+jjRpfwuXsubdVG-M9fjpdVx8JKRRyMgPOQfKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/19] linux-user: Split out close, open,
 openat, read, write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 06/22/2018 03:38 AM, Peter Maydell wrote:
>> +SYSCALL_IMPL(close)
>> +{
>> +    fd_trans_unregister(arg1);
>> +    return get_errno(close(arg1));
>> +}
>> +SYSCALL_DEF(close, ARG_DEC);
> 
> If in future we wanted to extend the set of information
> we had for each syscall in the SyscallDef struct, I guess
> we'd add parameters to the SYSCALL_DEF macro (or have
> more variant macros)? I can't offhand think of something I'd
> want to use that for, so it's a bit of an abstract question
> for the moment.

Yes, I imagine we'd extend the SYSCALL_DEF macro(s) in that case.

Another thought I've had is to define variant SYSCALL_IMPL<N> macros that would
allow us to put names to arguments, and help make the implementations clearer.
E.g.

SYSCALL_IMPL1(close, fd)
{
    fd_trans_unregister(fd);
    return get_errno(close(fd));
}


r~
