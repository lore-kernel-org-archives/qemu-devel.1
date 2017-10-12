Received: from eggs.gnu.org ([2001:4830:134:3::10]:60430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2gkS-0007yq-Ps
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2gkS-0003pO-5M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:54:16 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:49654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2gkR-0003na-U6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:54:16 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b189so14788598wmd.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 09:54:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
	<b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:53:54 +0100
Message-ID: <CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, pgndev <pgnet.dev@gmail.com>

On 12 October 2017 at 17:49, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 12/10/2017 =C3=A0 17:30, Peter Maydell a =C3=A9crit :
>> +#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
>> +typedef abi_long target_kernel_daddr_t;
>> +#else
>> +typedef abi_int target_kernel_daddr_t;
>> +#endif
>
> Perhaps you can add these ones into include/exec/user/abitypes.h ?

I don't think they belong there -- that file is for basic
CPU ABI dependent types, not things which are just part of
the kernel interface.

>> +struct target_mtget {
>> +    abi_long mt_type;
>> +    abi_long mt_resid;
>> +    abi_long mt_dsreg;
>> +    abi_long mt_gstat;
>> +    abi_long mt_erreg;
>> +    target_kernel_daddr_t mt_fileno;
>> +    target_kernel_daddr_t mt_blkno;
>> +};
>
> I think you need to update STRUCT(mtget, ...) in
> linux-user/syscall_types.h to reflect the size difference for MIPS and
> SPARC.

I thought about that but I wasn't feeling too enthusiastic
due to not having a test case... I suppose it's better to
change them both though.

thanks
-- PMM
