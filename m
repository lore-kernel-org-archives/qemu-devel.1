Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cjpdI-000384-3V
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cjpdH-0007TU-Bt
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:00:40 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:33957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1cjpdH-0007Sp-5x
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:00:39 -0500
Received: by mail-io0-x22f.google.com with SMTP id 90so77409425ios.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:00:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8m2YF4=BOODUJLmAr+Y1JoN2NSh3J+9Yqc__Hh59NXWA@mail.gmail.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
	<CAFEAcA8m2YF4=BOODUJLmAr+Y1JoN2NSh3J+9Yqc__Hh59NXWA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Mar 2017 17:00:14 +0100
Message-ID: <CAG48ez3tR7dJJsDHA4cEawOSn4HxZghOAt2-Xk9sNVdSHb77tA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>

On Fri, Mar 3, 2017 at 4:56 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 March 2017 at 14:54, Eric Blake <eblake@redhat.com> wrote:
>>> +                ret = -TARGET_EFAULT;
>>> +                break;
>>> +            }
>>>              argp = alloca((argc + 1) * sizeof(void *));
>>>              envp = alloca((envc + 1) * sizeof(void *));
>>
>> ...Uggh. You're using alloca() but allowing an allocation of way more
>> than 4k.  That means a guest can cause corruption of the stack (or, with
>> large enough arguments, even escape out of the stack) before you even
>> get to the execve() call to even worry about E2BIG issues.
>
> Yeah, linux-user is shot through with that kind of alloca() usage.
>
> (It's not great, but it's not a security hole because we already
> give the guest binary complete control to do anything it likes.
> Worth fixing bugs if we run into them, though.)

It could be a security hole if a benign guest userspace process decides to
allow a remote client to specify a bunch of environment variables or so.
E.g. HTTP servers with CGI support pass HTTP headers on as
environment variables whose names start with "HTTP_"; however, since
HTTP servers usually limit the request size, this isn't actually exploitable
in that case. But there could theoretically be similar scenarios.
