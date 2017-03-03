Received: from eggs.gnu.org ([2001:4830:134:3::10]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpZu-0008VC-83
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpZt-0006RV-Hb
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:57:10 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpZt-0006R1-B9
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:57:09 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so18653515wma.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:57:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 15:56:47 +0000
Message-ID: <CAFEAcA8m2YF4=BOODUJLmAr+Y1JoN2NSh3J+9Yqc__Hh59NXWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>, Jann Horn <jannh@google.com>

On 3 March 2017 at 14:54, Eric Blake <eblake@redhat.com> wrote:
>> +                ret = -TARGET_EFAULT;
>> +                break;
>> +            }
>>              argp = alloca((argc + 1) * sizeof(void *));
>>              envp = alloca((envc + 1) * sizeof(void *));
>
> ...Uggh. You're using alloca() but allowing an allocation of way more
> than 4k.  That means a guest can cause corruption of the stack (or, with
> large enough arguments, even escape out of the stack) before you even
> get to the execve() call to even worry about E2BIG issues.

Yeah, linux-user is shot through with that kind of alloca() usage.

(It's not great, but it's not a security hole because we already
give the guest binary complete control to do anything it likes.
Worth fixing bugs if we run into them, though.)

thanks
-- PMM
