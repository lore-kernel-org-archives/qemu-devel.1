Received: from eggs.gnu.org ([2001:4830:134:3::10]:45036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1eS3jB-00050l-S1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1eS3j9-0003Ed-9L
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:29:49 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1eS3j9-0003D4-2z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:29:47 -0500
Received: by mail-pl0-x241.google.com with SMTP id z5so11230483plo.10
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 08:29:46 -0800 (PST)
Date: Thu, 21 Dec 2017 08:29:44 -0800 (PST)
In-Reply-To: <CAFEAcA-+9wWhyVwt7=-tdGe22U1XKAq1PfQ4tNRQx0yMjPx3yg@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-61bd7107-4935-45a9-a1fe-165c46a053d0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu

On Thu, 21 Dec 2017 06:01:25 PST (-0800), peter.maydell@linaro.org wrote:
> On 20 December 2017 at 00:29, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> +#if defined(TARGET_NR_renameat2) && defined(__NR_renameat2)
>> +    case TARGET_NR_renameat2:
>> +        {
>> +            void *p2;
>> +            p  = lock_user_string(arg2);
>> +            p2 = lock_user_string(arg4);
>> +            if (!p || !p2)
>> +                ret = -TARGET_EFAULT;
>> +            else
>> +                ret = get_errno(syscall(__NR_renameat2, arg1, p, arg3, p2, arg5));
>> +            unlock_user(p2, arg4, 0);
>> +            unlock_user(p, arg2, 0);
>> +        }
>> +        break;
>> +#endif
>
> Should we have code to handle using plain renameat for flags==0
> calls? renameat2() only arrived in 3.15 kernels, so as it stands
> this patch will work on a smaller set of hosts than it might.

That sound sane: there isn't even a glibc wrapper for renameat2, so I assume 
most calls will be with flags==0.  Do you want me to re-spin the patch, or can 
you take it from here?
