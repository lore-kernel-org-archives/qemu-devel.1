Received: from eggs.gnu.org ([209.51.188.92]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goo6x-0006mz-Hd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goo6w-0004RH-Pc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:32:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1goo6w-0004Qv-IC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:32:54 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<815dd9b2-f2fb-40d1-67c1-9862e05f6b22@redhat.com>
	<0390e138-dc06-f82b-7867-c29e9be2e4fb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <819e9476-cb5d-e4c8-71b8-de22c8d2e6a2@redhat.com>
Date: Wed, 30 Jan 2019 12:32:51 +0100
MIME-Version: 1.0
In-Reply-To: <0390e138-dc06-f82b-7867-c29e9be2e4fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 2019-01-30 12:13, Paolo Bonzini wrote:
> On 30/01/19 11:53, Thomas Huth wrote:
>>> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
>>> index edb3d42..35ccb72 100644
>>> --- a/hw/watchdog/Kconfig
>>> +++ b/hw/watchdog/Kconfig
>>> @@ -8,6 +8,8 @@ config WDT_IB6300ESB
>>> =20
>>>  config WDT_IB700
>>>      bool
>>> +    default y
>>> +    depends on ISA_BUS
>> By the way, for pluggable ISA devices (like NE2000_ISA or WDT_IB700), =
it
>> would be great to have a ISA_DEVICES config switch, just like the
>> "PCI_DEVICES" switch, which the ISA devices should then depend on
>> instead of "ISA_BUS". Then it would be easier for the users to disable
>> optional devices in their builds.
>=20
> Note that the only reason for PCI_DEVICES's existence is that s390x doe=
s
> not want _all_ PCI devices.

Oh, I thought this was for convenience. So for s390x, the main problem is
AFAIK that the architecture does not support LSI, so all devices that
require LSI can not work here. Maybe we should introduce a "LSI" switch
instead, so that the boards which provide LSI can select it, and all norm=
al
PCI devices (at least the ones that do not work with MSI only) would
"depend on LSI", too?

> Is there a use case for disabling
> CONFIG_ISA_DEVICES but not wanting to base your configuration on
> "allnoconfig"?

"make allnoconfig" is not working for me yet:

make MINIKCONF=3D"python -B /home/thuth/devel/qemu/scripts/minikconf.py  =
--" config-all-devices.mak
make[1]: Entering directory `/tmp/qemu-kconfig'
  GEN     x86_64-softmmu/config-devices.mak.tmp
/home/thuth/devel/qemu/scripts/minikconf.py: invalid option --

So I disabled PCI_DEVICES here intead for my tests for the hard
requirements, and then I ran into this error:

hw/net/ne2000-isa.c:65: undefined reference to `ne2000_setup_io'
hw/net/ne2000-isa.c:71: undefined reference to `ne2000_reset'
../hw/net/ne2000-isa.o:(.data.rel+0x1d0): undefined reference to `vmstate=
_ne2000'
../hw/net/ne2000-isa.o:(.data.rel+0x270): undefined reference to `ne2000_=
receive'

That's why I thought a CONFIG_ISA_DEVICES switch would be good, too.
But we likely should simply fix the dependency of the NE2000_ISA switch
instead.

 Thomas
