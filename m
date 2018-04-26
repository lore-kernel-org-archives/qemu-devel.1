Received: from eggs.gnu.org ([2001:4830:134:3::10]:59978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBlsQ-0003aq-P2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBlsN-00047V-Lc
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:44:18 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBlsN-00047J-Ee
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:44:15 -0400
Received: by mail-wm0-x232.google.com with SMTP id i3so15051700wmf.3
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 11:44:15 -0700 (PDT)
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
	<87604ekl0c.fsf@linaro.org>
	<2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
Date: Thu, 26 Apr 2018 19:44:12 +0100
Message-ID: <874ljxlseb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> On 26.04.2018 18:09, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 25.04.2018 17:33, Alex Benn=C3=A9e wrote:
>>>> People following old instructions for QEMU get the message "No machine
>>>> specified, and there is no default" and run -machine help to pick a
>>>> new machine. Lay people might consider the null-machine to be such a
>>>> basic starting point but they won't get far. This leads to confusion,
>>>> see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.
>>>>
>>>> I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YOU
>>>> WANT" seemed less helpful though.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  hw/core/null-machine.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>>> index cde4d3eb57..72f0815045 100644
>>>> --- a/hw/core/null-machine.c
>>>> +++ b/hw/core/null-machine.c
>>>> @@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch)
>>>>
>>>>  static void machine_none_machine_init(MachineClass *mc)
>>>>  {
>>>> -    mc->desc =3D "empty machine";
>>>> +    mc->desc =3D "empty machine (for probing/QMP)";
>>>
>>> Actually, with certain CPUs, you can really use the "none" machine as a
>>> pure instruction set testing system. For example, on m68k, there used to
>>> be an explicit "dummy" machine for this job, and we removed it in favour
>>> of the "none" machine:
>>>
>>> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D22f2dbe7eaf3e12e3=
8c9c210
>>
>> Ahh OK. Do you know what other CPUs can be used in this way?
>
> I think it should be possible with at least all the boards that have a
> "sim" machine, e.g. xtensa, mips, moxie and openrisc.
>
>>> So I'd rather not add such wording. We should rather fix those segfaults
>>> instead (QEMU should never segfault - in case a device can not be used
>>> with the "none" machine, there rather should be an error message instea=
d).
>>
>> Hmm the ARM world is complicated by peripherals that are on-chip but not
>> part of the "CPU". I wonder if this is a edge case for our modelling?
>> Should for example -cpu cortex-m3 imply additional peripherals and how
>> do we handle that in the -m none case?
>
> I don't think it makes sense to instantiate e.g. an interrupt controller
> with the "none" machine automatically ... so the raw cortex-m3 core
> should either be usable without that, too, or there just should be an
> error message instead of a crash when the additional hardware is not
> available

Well I think this is where out abstraction breaks down. The cortex-m3 is
an ARMv7 core but with a bunch of stuff also on the SoC, including an
IRQ controller and MPU. However these devices are instantiated as part
of the machine model.

> - since it's not that urgent that the raw cortex-m3 core is
> usable with the none machine, is it?

No although it would theoretically be possible to use a cortex-m3 on
it's own with nothing else but some RAM and some buffers for it's serial
ports. Currently -cpu cortex-m3 will fail hard if not instantiated with
a m3 aware machine model.

--
Alex Benn=C3=A9e
