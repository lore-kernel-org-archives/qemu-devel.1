Received: from eggs.gnu.org ([209.51.188.92]:51753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmBkN-0003pZ-H5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmBkM-0007eQ-Q2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:10:47 -0500
References: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <628a94ba-2202-6a15-865b-16d52653288d@redhat.com>
Date: Wed, 23 Jan 2019 07:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] object owner argument of memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ksourav <sourav.jb1988@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 2019-01-23 04:07, ksourav wrote:
> Hi All,
>=20
> I am trying to learn how qemu implements different soc.
> While reading the source code, I found that in some socs, object owner
> is passed as NULL to the routine memory_region_init_ram() (for example
> in nrf51 soc) and in some socs(for example in Allwinner A10) an
> object(non NULL) is passed to memory_region_initi_ram().
> When I checked docs/devel/memory.txt, I found below lines.
> "For regions that "have no owner" (NULL is passed at creation time), th=
e
> machine object is actually used as the owner."
> Is the machine object refers to the actual board instance that will
> use the soc? For example microbit in case of nrf51 soc ?
> Is there any reason of not passing object as owner or in other words,
> when do we pass NULL or an object to memory_region_initi_ram() ?

I'm not an expert here, but when you look at the description of
memory_region_init_ram() in include/exec/memory.h:

 * @owner: the object that tracks the region's reference count (must be
 *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)

So if you're calling memory_region_init_ram() from a device's
instance_init() or realize() function, you should use the current device
state as owner. But if you want to call the function from a
MachineClass->init function instead already, you don't have a
DeviceState* yet, so you have to use NULL there.

 HTH,
  Thomas
