Received: from eggs.gnu.org ([2001:4830:134:3::10]:55397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ePVXi-0001z8-Rx
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ePVXh-00081z-BS
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:35:26 -0500
MIME-Version: 1.0
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
In-Reply-To: <20171214093907.GA14433@stefanha-x1.localdomain>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 14 Dec 2017 15:35:07 +0000
Message-ID: <CAMr-obtBNF8eetFgz=s8vJGqnzGa8+9n4VnF40vZYy5yeFZ3wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Thu, Dec 14, 2017 at 11:39 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> On Wed, Dec 13, 2017 at 06:35:51PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > With this series we can now write tests using Python rather than C.
> > For complex tests this can reduce the test development time, we can
> focus on
> > the test purposes instead of his implementation details.
> >
> > - 1,2: we already have Python classes to run Block tests, move all the
> >   non Block-related methods to qtest.py,
> > - 3: default TEST_DIR to TMPDIR,
> > - 4: add a method to restrict tests to a list of supported machines,
> > - 5: since the Block tests are output sensitive, do not mess with their
> >   current tuned iotests::main(unittest), add a more generic one in
> qtest.py,
> > - 6: finally modify the tests Makefile to run C/Python tests with the
> same
> >   rule.
>
> Python tests are great for functional tests of qemu-system-* that
> interact via the command-line and QMP monitor.  From this perspective I
> think the series is good.
>
> > to have a better idea, here is a snippet from the next series:
> >
> >     class TestSdCardSpecV2(qtest.QMPTestCase):
> >         [...]
> >         def test_power_on_spec_v2(self):
> >             self.bus.do_cmd(GO_IDLE_STATE)
> >             [...]
> >             # verify Card ID
> >             data =3D self.bus.do_cmd(ALL_SEND_CID)
> >             oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
> >             self.assertEqual(oid, "XY") # QEMU default
> >             self.assertEqual(pnm, "QEMU!") # QEMU default
> >             self.assertEqual(psn, 0xdeadbeef) # QEMU default
>
> Device qtests are better done in C than Python.  Python is not good at
> binary I/O


Why do you think that? what is missing in python 2 for binary io?


> and porting this to Python 3 will be extra work later (Python
> 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>

You can write today code that work with both python 2 and 3. For binary
io the key is using io.FileIO and io.BytesIO instead of open() and StringIO
and CStringIO.

Nir


>
> More importantly, we already have libqos in C with a guest memory
> allocator, PCI, and virtio support.  Fragmenting the small amount effort
> that goes into device testing will delay libqos reaching critical mass.
> Critical mass is where libqos provides all the infrastructure you need
> to set up a device and focus on your actual test instead of machine,
> bus, or device initialization.  Starting a Python device testing effort
> will just lead to duplication and 2 underdeveloped device testing
> frameworks.
>
> Is there a specific reason why adding SD Card support to libqos is not
> possible in C?
>
