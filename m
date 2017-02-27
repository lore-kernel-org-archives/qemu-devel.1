Received: from eggs.gnu.org ([2001:4830:134:3::10]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciPXn-00055D-Hd
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciPXk-0007qr-EJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:57:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ciPXk-0007qN-6J
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:57:04 -0500
References: <1485333658-23035-1-git-send-email-thuth@redhat.com>
	<0eca8185-8e94-46f8-6b7a-36c4a21bc28d@redhat.com>
	<20170227140001.GV2778@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e297b78-dab8-93c5-2a86-1ec267d65eb3@redhat.com>
Date: Mon, 27 Feb 2017 18:57:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170227140001.GV2778@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] null-machine: Add support for the
 "-kernel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>

On 27.02.2017 15:00, Eduardo Habkost wrote:
> On Mon, Feb 27, 2017 at 12:43:23PM +0100, Thomas Huth wrote:
>> On 25.01.2017 09:40, Thomas Huth wrote:
>>> We can have basic support for the "-kernel" parameter quite easily
>>> by using the generic loader device. This should be enough for most
>>> boards which do not need special machine-specific magic for loading
>>> a kernel (and for those that need special magic, the generic "none"
>>> machine is likely not suitable for using it as an instruction set
>>> simulator board anyway).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  PS: If we can't agree on using the generic loader here, I can also
>>>      prepare a patch instead that simply prints out an error message
>>>      if the user tried to use the "-kernel" parameter.
>>>
>>>  hw/core/null-machine.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>> index 27c8369..866e699 100644
>>> --- a/hw/core/null-machine.c
>>> +++ b/hw/core/null-machine.c
>>> @@ -5,6 +5,7 @@
>>>   *
>>>   * Authors:
>>>   *  Anthony Liguori   <aliguori@us.ibm.com>
>>> + *  Thomas Huth       <thuth@redhat.com>
>>>   *
>>>   * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
>>>   * See the COPYING file in the top-level directory.
>>> @@ -16,6 +17,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "hw/hw.h"
>>>  #include "hw/boards.h"
>>> +#include "hw/core/generic-loader.h"
>>>  #include "sysemu/sysemu.h"
>>>  #include "exec/address-spaces.h"
>>>  #include "cpu.h"
>>> @@ -40,6 +42,18 @@ static void machine_none_init(MachineState *mch)
>>>          memory_region_allocate_system_memory(ram, NULL, "ram", mch->=
ram_size);
>>>          memory_region_add_subregion(get_system_memory(), 0, ram);
>>>      }
>>> +
>>> +    /* Load kernel */
>>> +    if (mch->kernel_filename) {
>>> +        DeviceState *loader;
>>> +
>>> +        loader =3D qdev_create(sysbus_get_default(), TYPE_GENERIC_LO=
ADER);
>>> +        qdev_prop_set_string(loader, "file", mch->kernel_filename);
>>> +        if (cpu) {
>>> +            qdev_prop_set_uint32(loader, "cpu-num", cpu->cpu_index);
>>> +        }
>>> +        qdev_init_nofail(loader);
>>> +    }
>>>  }
>>> =20
>>>  static void machine_none_machine_init(MachineClass *mc)
>>
>> *ping*
>>
>> Apparently the discussion has ceased ... can we get a consensus whethe=
r
>> we want to support the "-kernel" parameter for the "none" machine or n=
ot?
>=20
> I think Peter's point is still valid:
>=20
> ] If you just want "load a blob and start it" then we already
> ] have -device loader. Making -kernel have yet another set of
> ] semantics that this time depends on the machine being selected
> ] seems like a bad idea. If -kernel doesn't do what it does
> ] for the other machines of the same architecture then we should
> ] just not accept it.
>=20
> If you add a mechanism to ensure "-machine none -kernel" has the
> same behavior as the other machines in the same QEMU binary, then
> I believe it will be OK.
>=20
> I believe we don't need to make this work on all architectures at
> the same time, though. We can do this using an optional
> per-architecture kernel-loading hook.

And I still think it does not really make sense to introduce a
per-architecture hook here - let me cite my reply to Peter's mail a
couple of mails later in that e-mail thread:

'The -kernel parameter is not just only dependent on the target
architecture, it is even dependent on the machine type, e.g. on ppc it
is quite different between embedded (e500.c) and server (spapr.c)
variants. So an arch-specific hook might not make too much sense and
using the generic loader is likely the best we can do - if that does not
work, you likely can't use the "none" machine anyway.'

So as far as I can see, we should either go with the generic loader
here, or print out an error message if the user tries to run QEMU with
the "-kernel" parameter.

 Thomas
