Received: from eggs.gnu.org ([2001:4830:134:3::10]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXNu-0002JT-Pn
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXNt-0003dy-Vh
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:33:26 -0500
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
	<CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
	<874lotwb0w.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfaa75b2-0da8-847d-0328-ec291ae81001@redhat.com>
Date: Thu, 14 Dec 2017 18:33:07 +0100
MIME-Version: 1.0
In-Reply-To: <874lotwb0w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, Nir Soffer <nirsof@gmail.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>

On 14/12/2017 17:05, Markus Armbruster wrote:
> Nir Soffer <nirsof@gmail.com> writes:
>=20
>> On Thu, Dec 14, 2017 at 1:36 PM Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>>
>>> On 14/12/2017 10:39, Stefan Hajnoczi wrote:
>>>>>             # verify Card ID
>>>>>             data =3D self.bus.do_cmd(ALL_SEND_CID)
>>>>>             oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
>>>>>             self.assertEqual(oid, "XY") # QEMU default
>>>>>             self.assertEqual(pnm, "QEMU!") # QEMU default
>>>>>             self.assertEqual(psn, 0xdeadbeef) # QEMU default
>>>> Device qtests are better done in C than Python.  Python is not good =
at
>>>> binary I/O and porting this to Python 3 will be extra work later (Py=
thon
>>>> 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>>>>
>>>> More importantly, we already have libqos in C with a guest memory
>>>> allocator, PCI, and virtio support.  Fragmenting the small amount ef=
fort
>>>> that goes into device testing will delay libqos reaching critical ma=
ss.
>>>> Critical mass is where libqos provides all the infrastructure you ne=
ed
>>>> to set up a device and focus on your actual test instead of machine,
>>>> bus, or device initialization.  Starting a Python device testing eff=
ort
>>>> will just lead to duplication and 2 underdeveloped device testing
>>>> frameworks.
>>>
>>> I agree that fragmentation is bad.  However, libqos is small (about 4=
k
>>> lines of code, maybe 3k in Python).
>>>
>>> I also agree that any qtest written in Python should be written in
>>> Python 3 from the beginning (in fact we should consider dropping Pyth=
on
>>> 2.x support in 2.12).  Doing so should not make binary I/O much
>>> different than C.
>>
>> Using python 3 will make it hard to develop and test qemu on RHEL/Cent=
OS
>> which do not provide python 3 yet.
>=20
> s/hard/slightly inconvenient/: Python 3 is available in EPEL. =20

And also in software collections.  For 2.12 (as part of the above "drop
Python 2.x support" plan) my idea is to set up a virtual Python
environment as part of configure, so that you can just do

	scl enable rh-python36 ./configure
	make

if you don't want to use EPEL.

Paolo

>> Doing binary io in python 2 and 3 is the same, there is no need to use
>> python 3 for this. The only advantage is not having to backport code
>> later from 2 to 3.
