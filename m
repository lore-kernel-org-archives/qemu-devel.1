Received: from eggs.gnu.org ([2001:4830:134:3::10]:59891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI74G-0000Er-R5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI74D-0007Pc-K3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:34:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fI74D-0007P2-Fw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:34:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1446725643-82458-1-git-send-email-pbonzini@redhat.com>
	<1446725643-82458-3-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xPCQpXYPPbfizzXZ-7OzUXGUN4dyqrbM3_Vy27coDKw@mail.gmail.com>
	<8a22efa3-94a0-5ffa-17df-45702601624d@redhat.com>
Date: Mon, 14 May 2018 08:34:39 +0200
In-Reply-To: <8a22efa3-94a0-5ffa-17df-45702601624d@redhat.com> (Paolo
	Bonzini's message of "Fri, 11 May 2018 11:51:00 +0200")
Message-ID: <87bmdi3fuo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 02/18] replay: internal functions for replay
 log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/05/2018 11:27, Peter Maydell wrote:
>>> +uint8_t replay_get_byte(void)
>>> +{
>>> +    uint8_t byte = 0;
>>> +    if (replay_file) {
>>> +        byte = getc(replay_file);
>>> +    }
>>> +    return byte;
>>> +}
>> Coverity (CID 1390576) points out that this function isn't checking
>> the error return from getc(). That means we could incorrectly return
>> 255 from here and then the return value from replay_get_dword would
>> be 0xffffffff, which is unfortunate if the place that's using
>> that uses it as a loop boundary.
>
> Thanks!  Pavel can you check it?  How is error checking done in general
> for record/replay, should QEMU exit immediately?
>
>> Incidentally, is it worth adding something to our coverity model
>> to tell coverity that data from replay_get_byte() is not tainted?
>
> Good idea.  Something like
>
> uint8_t replay_get_byte(void)
> {
>      uint8_t byte;
>      if (!replay_file) {
>          return 0;
>      }
>      return byte;
> }
>
> should do.

Care to submit a patch?
