Received: from eggs.gnu.org ([2001:4830:134:3::10]:45323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAb7T-0005CQ-0Q
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAb7S-0005gt-0S
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:30:43 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:48906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eAb7R-0005fW-S0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:30:41 -0400
Received: by mail-ua0-x243.google.com with SMTP id z4so1806976uaz.5
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 05:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f2457db3-b654-4956-165c-ef0962d9e923@redhat.com>
References: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
	<CAJ+F1CJs7WtU+xYfMViYer9vfRAq3SAMQiEjPRRCGnTUBbsgGQ@mail.gmail.com>
	<f2457db3-b654-4956-165c-ef0962d9e923@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 3 Nov 2017 13:30:40 +0100
Message-ID: <CAJ+F1CKUBp11zoy-sW6kO61q-tt=GhF1avz+4z5kOSgJTrgrzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: vmcoreinfo in
 error_whitelist for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi Thomas

On Fri, Nov 3, 2017 at 1:01 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 03.11.2017 12:49, Marc-Andr=C3=A9 Lureau wrote:
>> Hi Daniel
>>
>> On Fri, Oct 27, 2017 at 8:17 PM, Daniel Henrique Barboza
>> <danielhb@linux.vnet.ibm.com> wrote:
>>> The device vmcoreinfo depends on the fw_cfg device to work, a device
>>> that isn't available in most ppc64 machines. This makes device-crash-te=
st
>>> spams the following error when running with qemu-system-ppc64:
>>>
>>> "INFO: log: qemu-system-ppc64: -device vmcoreinfo: vmcoreinfo device
>>> requires fw_cfg with DMA"
>>>
>>> To fix it, this patch adds the following ppc64 machines into the
>>> error_whitelist for the vmcoreinfo device:
>>>
>>> - pseries.*
>>> - 40p
>>> - bamboo
>>> - g3beige
>>> - mac99
>>> - mpc8544ds
>>> - powernv
>>> - ppce500
>>> - prep
>>> - virtex-ml507
>>>
>>> After this patch, the only ppc64 machine that reports error on the
>>> vmcoreinfo device is the 'none' type.
>>>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>> ---
>>>  scripts/device-crash-test | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
>>> index 043b24a4aa..fb8a43d679 100755
>>> --- a/scripts/device-crash-test
>>> +++ b/scripts/device-crash-test
>>> @@ -163,6 +163,18 @@ ERROR_WHITELIST =3D [
>>>      # "spapr-cpu-core needs a pseries machine"
>>>      {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expecte=
d':True},
>>>
>>> +    # vmcoreinfo requires a fw_cfg device and will fail in these ppc64=
 machines
>>> +    {'machine':'pseries.*', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'40p', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'bamboo', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'g3beige', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'mac99', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'mpc8544ds', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'powernv', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'ppce500', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'prep', 'device':'vmcoreinfo', 'expected':True},
>>> +    {'machine':'virtex-ml507', 'device':'vmcoreinfo', 'expected':True}=
,
>>
>> You could try to make it fit on one line with
>> r"(pseries.*|40p|bamboo|...)". Declaring a ppc64_machines before would
>> probably help too.
>>
>> Any idea for an alternative vmcoreinfo device approach on ppc64?
>
> It's not only about ppc64 - this problem exists also on most other
> targets, e.g.:
>
> $ m68k-softmmu/qemu-system-m68k -M none -device vmcoreinfo
> qemu-system-m68k: -device vmcoreinfo: vmcoreinfo device requires fw_cfg
> with DMA
>
> So for the device-crash-test script, I think it would make more sense to
> add a generic, machine-independent entry for this.
>
> Additionally, I think it's also a bad idea to blindly add this
> vmcoreinfo device to all targets! We should only add it to the targets
> that actually feature the fw_cfg device with DMA, so we need a proper
> CONFIG_xxx switch for this. Marc-Andr=C3=A9 or Daniel, do you have time t=
o
> work on such a patch? Otherwise, I can have a look at this, too.

Ah the DMA interface is only available on x86 & arm virt apparently. I
thought it would be more widely available.

I can add a CONFIG_FW_CFG_DMA, set by x86)64-softmuu & arm-softmmu,
and make vmcoreinfo depend on it. Would that be good enough?




--=20
Marc-Andr=C3=A9 Lureau
