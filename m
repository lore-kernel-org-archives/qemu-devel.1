Received: from eggs.gnu.org ([208.118.235.92]:57542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1egeBB-0005mq-6n
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ege9o-00077L-SL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:15:00 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:12353)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ege9o-00072d-6d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:13:36 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Tue, 30 Jan 2018 23:12:59 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
	<fe13d005-de44-fea3-6102-e9723aac398a@redhat.com>
In-Reply-To: <fe13d005-de44-fea3-6102-e9723aac398a@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801302312.59762.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Hello Paolo,

thanks much for conversion to acceptable QOM model.

On Tuesday 30 of January 2018 15:15:22 Paolo Bonzini wrote:
> On 25/01/2018 22:33, Pavel Pisa wrote:
> > Hello Paolo,
> >
> > thanks for suggestions. I understand and fully agree with your
> > request to switch to QOM. I have succeed with that for CAN devices
> > some time ago. It worth to be done for the rest of the objects
> > but I fear that I do not find time to complete QOMification
> > in reasonable future. Contributions/suggestions from other
> > are welcomed. I can look for students for GSoC at our university
> > or under other funding.
>
> Please take a look at branch can-pci-qom of github.com/bonzini/qemu.git.
>  Apart from QOMification of the backend include, I simplified the IRQ
> handling in can_kvaser_pci (fixing bugs too I think), and removed an
> unnecessary mutex.  I also moved the files to net/can and hw/net/can so
> that in the future Jason (networking maintainer) can take care of pull
> requests.
>
> I might have broken something, and the top commit in particular is
> completely untested.

I have run basic test with Linux kernel on both sides
for one kavser_pci card on guest side and vcan (no real interface)
on host side.

Mesages exchange tests passed and looks OK.

I have used next parameters

      -object can-bus,id=3Dcanbus0 \
      -device kvaser_pci,canbus=3Dcanbus0 \
      -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0,id=3Dcanbus0-so=
cketcan

The id parameter is required for "can-host-socketcan" object.
Else next error is printed

  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0=
: Parameter 'id' is missing

If "-object can-bus,id=3Dcanbus0" is missing then next error is reported

  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0=
,id=3Dcanbus0-socketcan: Device 'canbus0' not found

I have inspected through monitor the state of objects

  (qemu) qom-list /objects
  canbus0-socketcan (child<can-host-socketcan>)
  type (string)
  canbus0 (child<can-bus>)

  (qemu) info qom-tree
  /machine (pc-i440fx-2.12-machine)
    ...
    /peripheral-anon (container)
      /device[1] (kvaser_pci)
        /bus master[0] (qemu:memory-region)
        /kvaser_pci-xilinx[0] (qemu:memory-region)
        /kvaser_pci-s5920[0] (qemu:memory-region)
        /kvaser_pci-sja[0] (qemu:memory-region)
        /bus master container[0] (qemu:memory-region)
    ...


  (qemu) qom-list /objects
  canbus0-socketcan (child<can-host-socketcan>)
  type (string)
  canbus0 (child<can-bus>)

  (qemu) qom-list /machine/peripheral-anon/device[1]
  bus master container[0] (child<qemu:memory-region>)
  canbus (link<can-bus>)
  rombar (uint32)
  hotpluggable (bool)
  x-pcie-lnksta-dllla (bool)
  kvaser_pci-sja[0] (child<qemu:memory-region>)
  multifunction (bool)
  hotplugged (bool)
  parent_bus (link<bus>)
  romfile (str)
  kvaser_pci-s5920[0] (child<qemu:memory-region>)
  x-pcie-extcap-init (bool)
  command_serr_enable (bool)
  addr (int32)
  type (string)
  legacy-addr (str)
  kvaser_pci-xilinx[0] (child<qemu:memory-region>)
  realized (bool)
  bus master[0] (child<qemu:memory-region>)

=46rom the user point of view, it would be nice if "can-bus"
can be populated when required automatically.

I am not sure, but may it be that it would worth to
push can-bus objects under some category/specific
container. The path /objects is quite wide.
Into something like /object/can-bus or /net/can.

But generally thanks much, the progress you have made
in one day is really great. I hope that others check
your branch. I have pushed your unmodified version into
"can-pci-qom" branch of my repo

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-qom

It would be great if others can check that everything
works in their setup. I think that then it can be pushed
into mainline and some usability improvements can be
done/experiment with later.

Thanks much,


                Pavel Pisa
