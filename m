Received: from eggs.gnu.org ([2001:4830:134:3::10]:35162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egh32-0003SS-Dt
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egh2z-0003bN-8i
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egh2z-0003aE-0t
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:18:45 -0500
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
	<fe13d005-de44-fea3-6102-e9723aac398a@redhat.com>
	<201801302312.59762.pisa@cmp.felk.cvut.cz>
	<650E61A4-F6BF-46A4-B63D-6D935925F5AE@icloud.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <099f6d2c-ab19-f590-7b58-f5f2058c8c6b@redhat.com>
Date: Tue, 30 Jan 2018 20:08:52 -0500
MIME-Version: 1.0
In-Reply-To: <650E61A4-F6BF-46A4-B63D-6D935925F5AE@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Deniz Eren <deniz.eren@icloud.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 30/01/2018 19:13, Deniz Eren wrote:
> Hi Pavel, Paolo,
>=20
> I tried to rerun my environment to test however it seems the interface =
has changed a little and my standard program options cause complaints. Un=
fortunately I don=E2=80=99t have too much time to dig through at the mome=
nt.
>=20
> My standard startup command is:
>=20
> $ ./qemu-local/bin/qemu-system-i386 -hda sdd2gb-uno1483-16.04-2.0-dev.i=
mg -boot d -k en-us -device mioe3680_pci,canbus1=3Dcanbus0,host1=3Dvcan0,=
canbus2=3Dcanbus1,host2=3Dvcan1 -m size=3D2048 -netdev user,id=3Duser.0 -=
device e1000,netdev=3Duser.0 -redir tcp:5022::22 -enable-kvm &

Yep, it's now like this:

./qemu-local/bin/qemu-system-i386 \
  -hda sdd2gb-uno1483-16.04-2.0-dev.img -boot d -k en-us \
  -object can-bus,id=3Dcanbus0 \
  -object can-bus,id=3Dcanbus1 \
  -object can-host-socketcan,id=3Dcanhost0,canbus=3Dcanbus0,ifname=3Dvcan=
0 \
  -object can-host-socketcan,id=3Dcanhost1,canbus=3Dcanbus1,ifname=3Dvcan=
1 \
  -device mioe3680_pci,canbus0=3Dcanbus0,canbus1=3Dcanbus1 \
  -m size=3D2048 -netdev user,id=3Duser.0 -device e1000,netdev=3Duser.0 \
  -redir tcp:5022::22 -enable-kvm

Thanks,

Paolo

>=20
>=20
>=20
> Best regards,
> Deniz
>=20
> Sent from my iPhone
>=20
> Deniz Eren
> +61 400 307 762
>=20
>> On 31 Jan 2018, at 9:12 am, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>>
>> Hello Paolo,
>>
>> thanks much for conversion to acceptable QOM model.
>>
>>> On Tuesday 30 of January 2018 15:15:22 Paolo Bonzini wrote:
>>>> On 25/01/2018 22:33, Pavel Pisa wrote:
>>>> Hello Paolo,
>>>>
>>>> thanks for suggestions. I understand and fully agree with your
>>>> request to switch to QOM. I have succeed with that for CAN devices
>>>> some time ago. It worth to be done for the rest of the objects
>>>> but I fear that I do not find time to complete QOMification
>>>> in reasonable future. Contributions/suggestions from other
>>>> are welcomed. I can look for students for GSoC at our university
>>>> or under other funding.
>>>
>>> Please take a look at branch can-pci-qom of github.com/bonzini/qemu.g=
it.
>>> Apart from QOMification of the backend include, I simplified the IRQ
>>> handling in can_kvaser_pci (fixing bugs too I think), and removed an
>>> unnecessary mutex.  I also moved the files to net/can and hw/net/can =
so
>>> that in the future Jason (networking maintainer) can take care of pul=
l
>>> requests.
>>>
>>> I might have broken something, and the top commit in particular is
>>> completely untested.
>>
>> I have run basic test with Linux kernel on both sides
>> for one kavser_pci card on guest side and vcan (no real interface)
>> on host side.
>>
>> Mesages exchange tests passed and looks OK.
>>
>> I have used next parameters
>>
>>      -object can-bus,id=3Dcanbus0 \
>>      -device kvaser_pci,canbus=3Dcanbus0 \
>>      -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0,id=3Dcanbus=
0-socketcan
>>
>> The id parameter is required for "can-host-socketcan" object.
>> Else next error is printed
>>
>>  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcan=
bus0: Parameter 'id' is missing
>>
>> If "-object can-bus,id=3Dcanbus0" is missing then next error is report=
ed
>>
>>  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcan=
bus0,id=3Dcanbus0-socketcan: Device 'canbus0' not found
>>
>> I have inspected through monitor the state of objects
>>
>>  (qemu) qom-list /objects
>>  canbus0-socketcan (child<can-host-socketcan>)
>>  type (string)
>>  canbus0 (child<can-bus>)
>>
>>  (qemu) info qom-tree
>>  /machine (pc-i440fx-2.12-machine)
>>    ...
>>    /peripheral-anon (container)
>>      /device[1] (kvaser_pci)
>>        /bus master[0] (qemu:memory-region)
>>        /kvaser_pci-xilinx[0] (qemu:memory-region)
>>        /kvaser_pci-s5920[0] (qemu:memory-region)
>>        /kvaser_pci-sja[0] (qemu:memory-region)
>>        /bus master container[0] (qemu:memory-region)
>>    ...
>>
>>
>>  (qemu) qom-list /objects
>>  canbus0-socketcan (child<can-host-socketcan>)
>>  type (string)
>>  canbus0 (child<can-bus>)
>>
>>  (qemu) qom-list /machine/peripheral-anon/device[1]
>>  bus master container[0] (child<qemu:memory-region>)
>>  canbus (link<can-bus>)
>>  rombar (uint32)
>>  hotpluggable (bool)
>>  x-pcie-lnksta-dllla (bool)
>>  kvaser_pci-sja[0] (child<qemu:memory-region>)
>>  multifunction (bool)
>>  hotplugged (bool)
>>  parent_bus (link<bus>)
>>  romfile (str)
>>  kvaser_pci-s5920[0] (child<qemu:memory-region>)
>>  x-pcie-extcap-init (bool)
>>  command_serr_enable (bool)
>>  addr (int32)
>>  type (string)
>>  legacy-addr (str)
>>  kvaser_pci-xilinx[0] (child<qemu:memory-region>)
>>  realized (bool)
>>  bus master[0] (child<qemu:memory-region>)
>>
>> From the user point of view, it would be nice if "can-bus"
>> can be populated when required automatically.
>>
>> I am not sure, but may it be that it would worth to
>> push can-bus objects under some category/specific
>> container. The path /objects is quite wide.
>> Into something like /object/can-bus or /net/can.
>>
>> But generally thanks much, the progress you have made
>> in one day is really great. I hope that others check
>> your branch. I have pushed your unmodified version into
>> "can-pci-qom" branch of my repo
>>
>>  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-qom
>>
>> It would be great if others can check that everything
>> works in their setup. I think that then it can be pushed
>> into mainline and some usability improvements can be
>> done/experiment with later.
>>
>> Thanks much,
>>
>>
>>                Pavel Pisa
