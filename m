Received: from eggs.gnu.org ([2001:4830:134:3::10]:43018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKg1r-0007jl-Eu
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKfxr-0002mK-KX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:47:02 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKfxr-0002lj-Dr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:46:59 -0500
Received: by mail-yw1-f45.google.com with SMTP id v199-v6so7729207ywg.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 00:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20180924092120.GA30163@caravaggio>
	<7c2b477e-bdac-c887-2510-82fe04acdcfe@redhat.com>
	<87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<20180926141518.GB9073@caravaggio>
	<3743752b-2670-1d89-2088-1e67122f5dcd@redhat.com>
In-Reply-To: <3743752b-2670-1d89-2088-1e67122f5dcd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 8 Nov 2018 09:46:44 +0100
Message-ID: <CAAdtpL5WwF0x_cJt3=20WiJ5E2LJ-XfDCB8EOuzhEJkZsXszsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Le 26 sept. 2018 6:58 PM, "Paolo Bonzini" <pbonzini@redhat.com> a =C3=A9cri=
t :

On 26/09/2018 16:15, Samuel Ortiz wrote:
> On Wed, Sep 26, 2018 at 03:36:07PM +0200, Paolo Bonzini wrote:
>> On 26/09/2018 10:32, Peter Maydell wrote:
>>> On 25 September 2018 at 10:26, Paolo Bonzini <pbonzini@redhat.com>
wrote:
>>>> However, the Kconfig language is a good idea.  The idea is that
>>>> dependencies can be expressed:
>>>>
>>>> - as "select" whenever a board requires a device, or whenever a device
>>>> requires generic subsystem code in order to implement a controller for
>>>> that subsystem (e.g.: PC selects MC146818RTC, VIRTIO_SCSI selects SCSI=
)
>>>>
>>>> - as "depends on" whenever a device requires a bus (e.g.: SERIAL_PCI
>>>> depends on ISA)
>>>>
>>>> Putting the two things together, AHCI depends on PCI but it selects
IDE.
>>>
>>> Could you clarify the distinction you're making here between
>>> these two kinds of dependency and what the top level user
>>> interface would be? I'm getting confused about why we need
>>> two -- I have a vague impression it depends on what the
>>> top level thing the user is selecting enablement of is,
>>> but maybe not ?
>>
>> Yes, exactly.  The user selects enablement of 1) boards 2) non-embedded
>> devices.  This mimics the level at which configuration is done today in
>> default-configs (it worked like this in 2013 during GSoC, and it is
>> still pretty much the same).  The idea is that everything else is
>> selected automatically by the configuration tool, but two different
>> paths are available depending on the desired defaults:
>>
>> - users of something (that is often "default n") use "select" to force
>> that configuration symbol to y
>>
>> - "depends on" is used for something that is (usually) default y, but
>> becomes n if the dependencies are missing
>>
>
> So "depends on" will go through the dependency graph and turn the config
> off if they're not entirely filled. But "select" just turns the config on
> regardless of the dependencies. Is that correct?

Almost; if there's a conflict between the decision from "depends on" and
"select" says, it's an error.  (Likewise if there's a conflict between
default-configs/ on one side, and "depends on"/"select" on the other).

This is different between kernel Kconfig and minikconf in my git repo.
The difference is because the Kconfig documentation warns against the
surprising effects of "select" blindly enabling the target symbol;
making minikconf stricter avoids those surprises.


So can we rename your tool Qconfig?



Paolo
