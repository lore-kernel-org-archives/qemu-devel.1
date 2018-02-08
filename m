Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejqEp-00069I-4W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejqEo-0002nB-3U
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:43:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180208193033-mutt-send-email-mst@kernel.org>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-10-andrew.smirnov@gmail.com>
	<CAFEAcA-=-+1A6toXM-ddP+iKBgHKh28Xq3VeGXfSLJ08xMRijA@mail.gmail.com>
	<20180208193033-mutt-send-email-mst@kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Feb 2018 09:43:53 -0800
Message-ID: <CAHQ1cqGr2e8vjQUUypkoyUc=QGQDNVkjydmOadfsSCzm78nkJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 09/14] pci: Use pci_config_size in
 pci_data_* accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Feb 8, 2018 at 9:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Feb 08, 2018 at 05:20:53PM +0000, Peter Maydell wrote:
>> On 7 February 2018 at 04:24, Andrey Smirnov <andrew.smirnov@gmail.com> w=
rote:
>> > Use pci_config_size (as opposed to PCI_CONFIG_SPACE_SIZE) in
>> > pci_data_read() and pci_data_write(), so this function would work for
>> > both classic PCI and PCIe use-cases.
>> >
>> > Cc: Peter Maydell <peter.maydell@linaro.org>
>> > Cc: Jason Wang <jasowang@redhat.com>
>> > Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> > Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
>> > Cc: Michael S. Tsirkin <mst@redhat.com>
>> > Cc: qemu-devel@nongnu.org
>> > Cc: qemu-arm@nongnu.org
>> > Cc: yurovsky@gmail.com
>> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> > ---
>> >  hw/pci/pci_host.c | 13 +++++++++----
>> >  1 file changed, 9 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
>> > index 5eaa935cb5..ea52ea07cd 100644
>> > --- a/hw/pci/pci_host.c
>> > +++ b/hw/pci/pci_host.c
>> > @@ -89,30 +89,35 @@ uint32_t pci_host_config_read_common(PCIDevice *pc=
i_dev, uint32_t addr,
>> >  void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len)
>> >  {
>> >      PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
>> > -    uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
>> > +    uint32_t config_addr;
>> >
>> >      if (!pci_dev) {
>> >          return;
>> >      }
>> >
>> > +    config_addr =3D addr & (pci_config_size(pci_dev) - 1);
>> > +
>> >      PCI_DPRINTF("%s: %s: addr=3D%02" PRIx32 " val=3D%08" PRIx32 " len=
=3D%d\n",
>> >                  __func__, pci_dev->name, config_addr, val, len);
>> > -    pci_host_config_write_common(pci_dev, config_addr, PCI_CONFIG_SPA=
CE_SIZE,
>> > +    pci_host_config_write_common(pci_dev, config_addr,
>> > +                                 pci_config_size(pci_dev),
>> >                                   val, len);
>> >  }
>> >
>> >  uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len)
>> >  {
>> >      PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
>> > -    uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
>> > +    uint32_t config_addr;
>> >      uint32_t val;
>> >
>> >      if (!pci_dev) {
>> >          return ~0x0;
>> >      }
>> >
>> > +    config_addr =3D addr & (pci_config_size(pci_dev) - 1);
>> > +
>> >      val =3D pci_host_config_read_common(pci_dev, config_addr,
>> > -                                      PCI_CONFIG_SPACE_SIZE, len);
>> > +                                      pci_config_size(pci_dev), len);
>> >      PCI_DPRINTF("%s: %s: addr=3D%02"PRIx32" val=3D%08"PRIx32" len=3D%=
d\n",
>> >                  __func__, pci_dev->name, config_addr, val, len);
>> >
>>
>> I've just discovered that this breaks the e1000e-test:
>>
>> $ (cd build/clang; QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
>> ./tests/e1000e-test)
>> /x86_64/e1000e/init: **
>> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/e1000e-test.c:11=
8:e1000e_device_find:
>> 'e1000e_dev' should not be NULL
>>
>> Any idea what's going on here?
>>

Peter:

Don't really have a good idea what's going on, but I am guessing this
change broke affected pci_host_data_* methods in negative way.

>> thanks
>> -- PMM
>
> I'm yet to review these patches, but IIRC pci_data_read and friends
> aren't designed with pcie in mind - they implement the classic pci
> config space.
>
> I'd like to see more justification about how these are now going
> to be used.
>

Michael:

My only justification for this change was suggestion from Marcel to
use pci_data_* functions, instead of calling pci_host_config_*_common
explicitly in designware.c introduced in next patch in the series. My
v4 patches incorrectly limited config space size to 256, so such
replacement didn't require this patch, but switching pci_data_* to use
pci_config_size() seemed harmless enough. I am more than happy to got
back to using pci_host_config_*_common in designware.c and dropping
this patch.

Thanks,
Andrey Smirnov
