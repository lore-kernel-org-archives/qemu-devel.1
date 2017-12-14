Received: from eggs.gnu.org ([2001:4830:134:3::10]:59360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPvX-0002ZB-Kq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPvR-0005ra-Ge
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePPvR-0005qe-2s
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:35:33 -0500
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-3-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9398fd1b-e9f3-72f1-39e9-f0458854678d@redhat.com>
Date: Thu, 14 Dec 2017 10:34:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171213232025.24503-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/26] sdcard: add a Python qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On 14/12/2017 00:20, Philippe Mathieu-Daud=C3=A9 wrote:
> Use Python to write high-level SD commands.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/Makefile.include |   2 +
>  tests/sdcard_tests.py  | 172 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100755 tests/sdcard_tests.py

How hard would it be to rewrite this test as an SDHCI test?

Thanks,

Paolo

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 13673f6d1d..4a1afcb499 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -355,8 +355,10 @@ check-qtest-arm-y +=3D tests/virtio-blk-test$(EXES=
UF)
>  gcov-files-arm-y +=3D arm-softmmu/hw/block/virtio-blk.c
>  check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
>  gcov-files-arm-y +=3D hw/timer/arm_mptimer.c
> +check-qtest-arm-y +=3D tests/sdcard_tests.py
> =20
>  check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
> +check-qtest-aarch64-y +=3D tests/sdcard_tests.py
> =20
>  check-qtest-microblazeel-y =3D $(check-qtest-microblaze-y)
> =20
> diff --git a/tests/sdcard_tests.py b/tests/sdcard_tests.py
> new file mode 100755
> index 0000000000..033b756cf1
> --- /dev/null
> +++ b/tests/sdcard_tests.py
> @@ -0,0 +1,172 @@
> +#!/usr/bin/env python
> +#
> +# Tests for the SD-Bus protocol
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> +#
> +
> +import os
> +import base64
> +import struct
> +import binascii
> +import logging
> +
> +import qtest
> +
> +
> +# CMD
> +(GO_IDLE_STATE, SEND_OP_CMD, ALL_SEND_CID, SEND_RELATIVE_ADDR, # 0 ...
> +SEND_DSR, CMD5, SWITCH_FUNCTION, CMD7,
> +SEND_IF_COND, SEND_CSD, SEND_CID, READ_DAT_UNTIL_STOP, # 8 ...
> +STOP_TRANSMISSION, SEND_STATUS, CMD14, GO_INACTIVE_STATE,
> +SET_BLOCKLEN, READ_SINGLE_BLOCK, READ_MULTIPLE_BLOCK, CMD19, # 16 ...
> +CMD20, CMD21, CMD22, SET_BLOCK_COUNT,
> +WRITE_SINGLE_BLOCK, WRITE_MULTIPLE_BLOCK, PROGRAM_CID, PROGRAM_CSD,  #=
 24 ...
> +SET_WRITE_PROT, CLR_WRITE_PROT, SEND_WRITE_PROT, CMD31,
> +ERASE_WR_BLK_START, ERASE_WR_BLK_END, CMD34, CMD35, # 32 ...
> +CMD36, CMD37, ERASE, CMD39,
> +CMD40, CMD41, LOCK_UNLOCK, CMD43,
> +CMD44, CMD45, CMD46, CMD47,
> +CMD48, CMD49, CMD50, CMD51,
> +CMD52, CMD53, CMD54, APP_CMD,
> +GEN_CMD,) =3D range(57)
> +
> +# ACMD
> +SET_BUS_WIDTH =3D 6
> +SD_STATUS =3D 13
> +SEND_NUM_WR_BLOCKS =3D 22
> +SET_WR_BLK_ERASE_COUNT =3D 23
> +SD_APP_OP_COND =3D 41
> +SET_CLR_CARD_DETECT =3D 42
> +SEND_SCR =3D 51
> +
> +
> +class SDBus(object):
> +    def __init__(self, vm, qom_path, verbose=3DFalse):
> +        self.vm =3D vm
> +        self.path =3D qom_path
> +        self.verbose =3D verbose
> +
> +    def do_cmd(self, command, arg=3D0, verbose=3DNone):
> +        assert command < 64
> +        if verbose is None:
> +            verbose =3D self.verbose
> +
> +        data =3D self.vm.qmp('sdbus-command', qom_path=3Dself.path, co=
mmand=3Dcommand,
> +                           arg=3Darg)['return']
> +        if 'base64' in data:
> +            data =3D base64.b64decode(data['base64'])
> +            logging.info("CMD#%02d -> %s" % (command, binascii.hexlify=
(data)))
> +        else:
> +            logging.info("CMD#%02d -> (none)" % (command))
> +            data =3D None
> +        return data
> +
> +    def do_acmd(self, command, arg=3D0, verbose=3DNone):
> +        self.do_cmd(APP_CMD, verbose=3DFalse)
> +        return self.do_cmd(command, arg, verbose if verbose else self.=
verbose)
> +
> +
> +def sdbus_get_qom_path(vm, bus=3D0):
> +        qom_paths =3D []
> +
> +        result =3D vm.qmp('query-block')
> +        for block in result['return']:
> +            if not 'qdev' in block:
> +                continue
> +            d =3D vm.qmp('qom-get', path=3Dblock['qdev'], property=3D"=
parent_bus")
> +            qom_paths +=3D [d['return']]
> +        assert len(qom_paths) > 0
> +
> +        return qom_paths[bus]
> +
> +
> +# dumb helper
> +def l(buf):
> +    return struct.unpack("<L", buf)[0]
> +
> +
> +class TestSdCardSpecV2(qtest.QMPTestCase):
> +    def setUp(self):
> +        self.vm =3D qtest.createQtestMachine()
> +
> +        self.vm._args.append('-drive')
> +        self.vm._args.append("id=3Dtestcard,driver=3Dnull-co,if=3Dsd")
> +        self.vm._args.append("-machine")
> +        self.vm._args.append("xilinx-zynq-a9")
> +        self.vm.launch()
> +
> +        bus_path =3D sdbus_get_qom_path(self.vm)
> +        self.bus =3D SDBus(self.vm, bus_path, True)
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +
> +    def test_power_on_v2(self):
> +
> +        self.bus.do_cmd(GO_IDLE_STATE)
> +
> +        # get voltages
> +        for i in range(6):
> +            vhs =3D 1 << (8 + i)
> +            data =3D self.bus.do_cmd(SEND_IF_COND, vhs)
> +            v =3D l(data)
> +            self.assertNotEqual(v, 0)
> +            self.assertEqual(vhs, v >> 8)
> +
> +        # get OCR
> +        data =3D self.bus.do_acmd(SD_APP_OP_COND)
> +        v =3D l(data)
> +        ocr =3D (v >> 8) & 0xffff
> +        s1_8 =3D (v >> 24) & 1
> +        uhs_ii =3D (v >> 29) & 1
> +        ccs =3D (v >> 30) & 1
> +        init =3D (v >> 31) & 1
> +        # all those are null for v2.00
> +        self.assertEqual(s1_8, 0)
> +        self.assertEqual(uhs_ii, 0)
> +        self.assertEqual(ccs, 0)
> +        self.assertEqual(init, 0)
> +
> +        # ocr << 8
> +        # 0 << 24 # use current voltage
> +        # 0 << 28 # powersave
> +        # 0 << 30 # SDSC
> +        data =3D self.bus.do_acmd(SD_APP_OP_COND, ocr << 8)
> +        v =3D l(data)
> +        # check OCR accepted
> +        self.assertEqual(ocr, v >> 8)
> +
> +        # check CID
> +        data =3D self.bus.do_cmd(ALL_SEND_CID)
> +        oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
> +        self.assertEqual(oid, "XY") # QEMU default
> +        self.assertEqual(pnm, "QEMU!") # QEMU default
> +        self.assertEqual(psn, 0xdeadbeef) # QEMU default
> +
> +        # check non null RCA
> +        data =3D self.bus.do_cmd(SEND_RELATIVE_ADDR)
> +        rca, =3D struct.unpack(">H", data[:2])
> +        self.assertNotEqual(rca, 0)
> +
> +        self.assertEqual(rca, 0x4567) # QEMU default
> +
> +        # check for new RCA
> +        data =3D self.bus.do_cmd(SEND_RELATIVE_ADDR)
> +        new_rca, =3D struct.unpack(">H", data[:2])
> +        self.assertNotEqual(new_rca, rca)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    qtest.main(supported_machines=3D['xilinx-zynq-a9'])
>=20
