Received: from eggs.gnu.org ([2001:4830:134:3::10]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eleHa-0000HO-18
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eleHV-00032Z-Pg
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:22:18 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:52710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eleHV-00032C-JN
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:22:13 -0500
Received: by mail-it0-x243.google.com with SMTP id o13so11992772ito.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 09:22:13 -0800 (PST)
References: <20180128221510.13722-1-richard.henderson@linaro.org>
	<CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
	<18af5519-95cd-f00e-1915-75183e94eb38@twiddle.net>
	<aff1a8c0-4e99-b52e-f933-fdc900bd91fd@redhat.com>
	<CAFEAcA-xRtcaRA6_ApZ2Ohfpz0ZCED1y3SyLpGCOWThPFpUr_Q@mail.gmail.com>
	<CAFEAcA_NXwhfJjJnihZdCHAL7A-ZntuNDgrpPkQQDycuMOkdgw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d1c9458-0ab9-cb9e-aee4-9e70f16c9c03@linaro.org>
Date: Tue, 13 Feb 2018 09:22:06 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NXwhfJjJnihZdCHAL7A-ZntuNDgrpPkQQDycuMOkdgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 02/13/2018 08:50 AM, Peter Maydell wrote:
> On 13 February 2018 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>> OTOH, maybe we should just go ahead without weird games with dup2 and
>> see whether any real code gets confused...
> 
> Here's some real-world code that would break with this patch
> as it stands, though dup2 games wouldn't be the fix in this case:
>  https://github.com/xinetd-org/xinetd/blob/master/xinetd/init.c#L79
> 
> (it iterates through all fds above 2 closing them, and we don't
> protect against the guest being able to perform syscalls on
> interp_dirfd)

Hmm.  I suppose we could maintain a fd_set of valid guest fd's, and check every
guest operation vs that set.  Or special-case interp_dirfd with EBADF.

Thoughts before I attempt either?


r~
