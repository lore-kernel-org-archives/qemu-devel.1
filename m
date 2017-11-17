Received: from eggs.gnu.org ([2001:4830:134:3::10]:47580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eFZJF-0008E5-Nr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eFZJC-0004XV-Ef
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:35:25 -0500
References: <1510867014-13423-1-git-send-email-thuth@redhat.com>
	<20171117061341-mutt-send-email-mst@kernel.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <e20e2c2c-fd32-8665-405d-4081c1a2e3df@weilnetz.de>
Date: Fri, 17 Nov 2017 06:35:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171117061341-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/net/eepro100: Fix endianness
 problem on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-s390x@nongnu.org

Am 17.11.2017 um 05:14 schrieb Michael S. Tsirkin:
> On Thu, Nov 16, 2017 at 10:16:54PM +0100, Thomas Huth wrote:
>> Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmissio=
n
>> mode"), the test/pxe-test is broken for the eepro100 device on big
>> endian hosts. However, it seems like that commit did not introduce the
>> problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr a=
nd
>> EEPRO100State->tx.tcb_bytes fields are already in host byte order, sin=
ce
>> they have already been byte-swapped in the read_cb() function.
>> Thus byte-swapping them in tx_command() again results in the wrong
>> endianness. Removing the byte-swapping here fixes the pxe-test.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Thomas, how about adding sparse endian-ness annotations
> a la le32 in Linux? We could then use static checkers to
> catch these bugs at build time.

My main problem is that running big endian tests are
much more complex and time consuming simply because
my only big endian machines are QEMU virtual machines
(PPC* or MIPS*), so a test requires running QEMU
inside QEMU.

Nevertheless I had run such tests with network boot
and Linux guests as test cases, and they worked
(see comments in the header of eepro100.c).

So I wonder how the tests have to be enhanced to cover
more cases.

Stefan
