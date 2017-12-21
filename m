Received: from eggs.gnu.org ([2001:4830:134:3::10]:52994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS1Q4-0005yV-8L
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS1Pu-0000Ig-L4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:01:56 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS1Pu-0000Hm-Em
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:01:46 -0500
Received: by mail-ot0-x241.google.com with SMTP id q5so188277oth.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:01:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220002941.14560-1-palmer@dabbelt.com>
References: <20171220002941.14560-1-palmer@dabbelt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 14:01:25 +0000
Message-ID: <CAFEAcA-+9wWhyVwt7=-tdGe22U1XKAq1PfQ4tNRQx0yMjPx3yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement renameat2 when
 defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 20 December 2017 at 00:29, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> +#if defined(TARGET_NR_renameat2) && defined(__NR_renameat2)
> +    case TARGET_NR_renameat2:
> +        {
> +            void *p2;
> +            p  = lock_user_string(arg2);
> +            p2 = lock_user_string(arg4);
> +            if (!p || !p2)
> +                ret = -TARGET_EFAULT;
> +            else
> +                ret = get_errno(syscall(__NR_renameat2, arg1, p, arg3, p2, arg5));
> +            unlock_user(p2, arg4, 0);
> +            unlock_user(p, arg2, 0);
> +        }
> +        break;
> +#endif

Should we have code to handle using plain renameat for flags==0
calls? renameat2() only arrived in 3.15 kernels, so as it stands
this patch will work on a smaller set of hosts than it might.

thanks
-- PMM
