Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhpR-0005be-Ld
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhpQ-0002JS-O0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:08:57 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFhpQ-0002JM-H9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:08:56 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g76so1415098wrd.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 07:08:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d2b71d89-8741-48f6-dea1-8bed1ebc1f21@redhat.com>
References: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
	<d2b71d89-8741-48f6-dea1-8bed1ebc1f21@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 15:08:34 +0100
Message-ID: <CAFEAcA_3qebN4QRDv+qpHJwjtgQr8B+VpPjGkPZGzASo8dgtBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 31 March 2017 at 15:10, Eric Blake <eblake@redhat.com> wrote:
> On 03/31/2017 08:51 AM, Peter Maydell wrote:
>> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
>> about the return value was changed to no longer use it. Drop the
>> now-useless return value and make the function return void.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Coverity complains (CID 1372464) about main_loop() calling
>> main_loop_wait() and ignoring its return value. I suspect
>> this change will just displace that to within main_loop_wait()
>> itself since the underlying issue there is "the ppoll() that
>> gets called to poll fds can return an error code, but what
>> do we do if it does?". Suggestions on that point welcome.
>
> At one point, there was a suggestion to introduce an ignore_value()
> macro that ignores values that the compiler/coverity would otherwise
> complain about, in contexts where we really are okay ignoring the value.
>  If making main_loop_wait() return void shifts where Coverity blames,
> then ignore_value(ppoll()) seems like it might help.

Mmm, but my question really is "is ignoring the error code
from the syscall the correct thing to do?"... though I'm
not sure what else we would want to do (log a warning?
abort?).

thanks
-- PMM
