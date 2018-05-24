Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLsg5-0005GG-6p
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLsfz-0004bl-FM
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLsfz-0004bS-AA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:15 -0400
References: <1527172175-129517-1-git-send-email-mst@redhat.com>
	<6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
	<20180524175709-mutt-send-email-mst@kernel.org>
	<681ace2f-f827-0e00-af77-f39dc2f7ccc1@redhat.com>
	<20180524185033-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3578bdc5-594d-a938-e0a4-e080f504ee7c@redhat.com>
Date: Thu, 24 May 2018 18:01:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180524185033-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>

On 24.05.2018 17:51, Michael S. Tsirkin wrote:
> On Thu, May 24, 2018 at 05:46:05PM +0200, Thomas Huth wrote:
>> On 24.05.2018 17:00, Michael S. Tsirkin wrote:
>>> On Thu, May 24, 2018 at 04:45:31PM +0200, Thomas Huth wrote:
>>>> On 24.05.2018 16:30, Michael S. Tsirkin wrote:
>>>>> Right now tests report OK status if QEMU crashes during cleanup.
>>>>> Let's catch that case and fail the test.
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>  tests/libqtest.c | 9 ++++++++-
>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>>>>> index 43fb97e..f869854 100644
>>>>> --- a/tests/libqtest.c
>>>>> +++ b/tests/libqtest.c
>>>>> @@ -103,8 +103,15 @@ static int socket_accept(int sock)
>>>>>  static void kill_qemu(QTestState *s)
>>>>>  {
>>>>>      if (s->qemu_pid !=3D -1) {
>>>>> +        int wstatus =3D 0;
>>>>> +        pid_t pid;
>>>>> +
>>>>>          kill(s->qemu_pid, SIGTERM);
>>>>> -        waitpid(s->qemu_pid, NULL, 0);
>>>>> +        pid =3D waitpid(s->qemu_pid, &wstatus, 0);
>>>>> +
>>>>> +        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
>>>>> +            assert(!WCOREDUMP(wstatus));
>>>>> +        }
>>>>>      }
>>>>>  }
>>>>
>>>> That's basically a good idea ... but I've already seen yet another i=
ssue
>>>> in the past already: QEMU sometimes simply hangs in an endless loop
>>>> during clean up and never terminates. I think we should detect that
>>>> situation, too. So instead of killing QEMU at the end of the testing=
, I think we should
>>>> rather try to terminate it with the QMP "quit" command. If QEMU does=
 not
>>>> terminate with an exit code of 0, then the test should be flagged a
>>>> failed (and only if QEMU did not terminate at all, it should be kill=
ed
>>>> with SIGKILL).
>>>>
>>>>  Thomas
>>>
>>> Fine but can we agree to do this as a patch on top? And do you have
>>> the time to implement this?
>>
>> Fine for me if we do that later. And no, I currently don't have time t=
o
>> work on this (but I've got it on my TODO list somewhere, so I hope I
>> won't forget about it later...).
>>
>>> I'm seeing patches that cause crash on cleanup, it's not a theoretica=
l
>>> problem for me, so I'd like this one to go in first.
>>
>> Ok, so here are the two problems that I remember:
>>
>> 1)
>>
>> git checkout 17bd9597be45b96ae00716b0ae01a4d11bbee1ab~1
>> make -j4 subdir-nios2-softmmu
>> nios2-softmmu/qemu-system-nios2 -monitor stdio
>>
>> =3D=3D> You can neither "quit" from the HMP prompt, nor kill QEMU with
>> SIGTERM, you've got to use SIGKILL instead.
>>
>> Ok, libqtest likely would not have reported success in this case, too,
>> we just did not notice since there is no libqtest in place that tests
>> the nios2 machine in TCG mode. Anyway, it would be nice if qtest would
>> properly detect the situation and report an error instead of just
>> hanging in waitpid().
>=20
> That's a tall order, it assumes we can define a reasonable
> time during which QEMU should exit.

Yeah, thinking about this again, and considering the problems that we've
seen with overloaded test machines in the past, it's probably not worth
the effort to find a reasonable timeout here.

And since the problem with an endless loop won't go unnoticed (I
originally thought SIGTERM would kill QEMU, so that endless loops would
not be noticed here - I was just not aware of the signal handler that we
have here in QEMU), let's simply forget about that idea with QMP "quit"
+ timeout + SIGKILL and continue with your patch instead.

 Thomas


>> 2)
>>
>> git checkout b39b61e410022f96ceb53d4381d25cba5126ac44~1
>> make -j4 subdir-ppc-softmmu
>> ppc-softmmu/qemu-system-ppc -M 40p -monitor stdio
>>
>> =3D=3D=3D> QEMU asserts here with both, HMP "quit" and SIGTERM. This w=
as the
>> problem where libqtest did not report an error though it should have
>> reported one. So QEMU was not hanging in an endless loop here, but cor=
e
>> dumped ... Sorry, I apparently mixed this up in my mind with the first
>> case. That means we should be fine here with your patch.
>>
>>  Thomas
