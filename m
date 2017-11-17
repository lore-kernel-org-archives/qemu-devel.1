Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFax7-0008Nz-L4
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFax3-00037x-Lr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:20:41 -0500
References: <1510867014-13423-1-git-send-email-thuth@redhat.com>
	<20171117061341-mutt-send-email-mst@kernel.org>
	<e20e2c2c-fd32-8665-405d-4081c1a2e3df@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b277521d-dc09-1fde-0dac-745ff68e18f1@redhat.com>
Date: Fri, 17 Nov 2017 08:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <e20e2c2c-fd32-8665-405d-4081c1a2e3df@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Stefan Weil <sw@weilnetz.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-s390x@nongnu.org

On 17.11.2017 06:35, Stefan Weil wrote:
> Am 17.11.2017 um 05:14 schrieb Michael S. Tsirkin:
>> On Thu, Nov 16, 2017 at 10:16:54PM +0100, Thomas Huth wrote:
>>> Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmissi=
on
>>> mode"), the test/pxe-test is broken for the eepro100 device on big
>>> endian hosts. However, it seems like that commit did not introduce th=
e
>>> problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr =
and
>>> EEPRO100State->tx.tcb_bytes fields are already in host byte order, si=
nce
>>> they have already been byte-swapped in the read_cb() function.
>>> Thus byte-swapping them in tx_command() again results in the wrong
>>> endianness. Removing the byte-swapping here fixes the pxe-test.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Thomas, how about adding sparse endian-ness annotations
>> a la le32 in Linux? We could then use static checkers to
>> catch these bugs at build time.

Sounds like a good idea - but also like a bigger project. I don't have
time for that right now, so if somebody wants to have a look, you're
very welcome! (but I'll also put it on my way-too-big todo-list.txt, so
in case nobody else picks this up, maybe I can have a look at it in a
couple of months...)

> My main problem is that running big endian tests are
> much more complex and time consuming simply because
> my only big endian machines are QEMU virtual machines
> (PPC* or MIPS*), so a test requires running QEMU
> inside QEMU.
>=20
> Nevertheless I had run such tests with network boot
> and Linux guests as test cases, and they worked
> (see comments in the header of eepro100.c).
>=20
> So I wonder how the tests have to be enhanced to cover
> more cases.

I think this specific problem was "hidden" by the code that has been
removed with commit 1865e288a823c7, so there was no chance that you
could detect this with tests. As I wrote in the description, the
pxe-test worked fine in rc0, it just got broken in rc1.

But if you want to increase automatic test coverage, I think you should
try to improve tests/eepro100-test.c with some more code, e.g. something
similar as it is done in tests/e1000e-test.c.

 Thomas
