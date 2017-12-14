Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePTNF-0003ZE-9O
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePTN9-0005I8-Ed
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:29 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePTN9-0005Go-7M
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:23 -0500
Received: by mail-ot0-x242.google.com with SMTP id 103so4859939otj.12
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 05:16:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3fb76985-d02d-262f-491c-384680a13f3b@redhat.com>
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
	<1512669755-8409-3-git-send-email-thuth@redhat.com>
	<CAFEAcA9gz0cNkPvZhkLYfYQ+ST01POwuptfXkKixSu_x=s9C+g@mail.gmail.com>
	<3fb76985-d02d-262f-491c-384680a13f3b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 13:16:01 +0000
Message-ID: <CAFEAcA8D87rdcO6qVqfgS2G3N0fBzuj1uUsCRXcCv3m1KR6eyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] net: Remove the deprecated
 -tftp, -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 14 December 2017 at 12:28, Thomas Huth <thuth@redhat.com> wrote:
> On 11.12.2017 23:04, Peter Maydell wrote:
>> The deprecation message says:
>>                error_report("The -redir option is deprecated. "
>>                             "Please use '-netdev user,hostfwd=...' instead.");
>>
>> How does this work for systems which have embedded ethernet
>> devices and can't use -netdev ?
>
> Of course it should work the same way as you currently can configure all
> embedded ethernet devices:
>
>  -net nic -net user,hostfwd=...

Mmm, but the deprecation message doesn't say that.

> By the way, I think our documentation is really lacking some proper
> description how to deal with on-board devices ...
>
>> This is one reason I haven't bothered to update my scripts yet
>
> -redir is likely not doing what you expect as soon as you are using two
> or more (embedded or non-embedded) NICs on a machine, so you really
> should not use that option anymore.

Two NICs on a machine is an obscure special case, though.
Almost all setups will have just the one NIC.

>> The message also doesn't point out that if you were previously
>> using -net + -redir you need to switch to -device + -netdev,
>> since -net + -netdev doesn't work AFAIK.
>
> I haven't tried, but I think you can also use:
>
>  -netdev user,id=u1,hostfwd=... -net nic,netdev=u1
>
> Or did you run into problems here?

Nope. I just ignored the whole thing because the deprecation
message didn't give me enough help and didn't actually stop
anything working, and I knew that what the message did
say was definitely wrong for my command line. I suspect I'm
not an entirely atypical user here...

I think what we need to do to be able to actually remove
this code is:
 (1) make sure our documentation is clear and simple about
how to move from an old command line to a new one
(with examples, and covering all the conditions, not
just the "let's assume everything's a PC with a
pluggable PCI network card" case)
 (2) make the deprecation warning be specific, and
cover all the cases, and probably refer to a documentation
URL
 (3) make -redir in versions where we've removed the
functionality print a message that specifically says
"this option has been removed and is replaced by $FOO;
see $URL for how to update your command line" (ie not
just "-redir: unknown option", but retain the deprecation
warning text for a bit).

(Sorry if this feels like unexpectedly raising the bar
for deprecation&removal -- I should probably have
raised the issue earlier, but it was only your
patch doing the removal that reminded me.)

thanks
-- PMM
