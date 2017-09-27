Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dx4uD-0004kC-1V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dx4u9-0003Hl-Rn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dx4u9-0003HR-M7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:29:05 -0400
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<20170926222730-mutt-send-email-mst@kernel.org>
	<4b4c8d9e-101b-ee27-b4d2-249890c14d21@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ae66b288-8762-061f-5e07-5ac8cdd82d82@redhat.com>
Date: Wed, 27 Sep 2017 07:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <4b4c8d9e-101b-ee27-b4d2-249890c14d21@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>

On 26.09.2017 22:35, Stefan Weil wrote:
> Am 26.09.2017 um 21:30 schrieb Michael S. Tsirkin:
>> On Fri, Sep 22, 2017 at 05:06:57AM +0200, Thomas Huth wrote:
>>> If QEMU has been compiled with the flags --enable-tcg-interpreter and
>>> --enable-debug, the guest is running incredibly slow. The pxe boot te=
st
>>> can take up to 400 seconds when testing the pseries ppc64 machine. Wh=
ile
>>> we should still look for ways to speed up the test on the pseries mac=
hine,
>>> it's better to increase the timeout in this test to 600 seconds anywa=
y to
>>> allow the test to pass successfully now with this unusal configuratio=
n
>>> already.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Well I do break things sometimes and I won't be happy about
>> spending 10 minutes waiting for a test to fail.
>>
>> Can we break out of the test if all CPUs are halted with
>> interrupts disabled?

qemu-system-s390x exits automatically in that case (unless you specified
the -no-shutdown parameter) ... what about x86?

Another idea: We could run the "info registers" HMP command regularly
(is there an equivalent for HMP?) to see whether the guest is still
doing something and abort if the all registers stayed the same for,
let's say 30 seconds?

> Any fixed timeout is either too long (when you expect a failing
> test) or too short (when you need time for the test to pass).
>=20
> Would it be possible to get some speed factor (like Linux
> bogomips) at the beginning of all tests? Then that factor
> could be used later for all tests which currently use a
> hard timeout.

We've got at least three changing factors here: Hardware speed of the
host (MHz / bogomips), speed of TCG / the emulated guest (e.g. TCI is
slow) and current other workload of the host. Even if we get the first
two factors right, the workload of the host can still change very
dynamically, so I think it's quite hard to do a good prediction at the
beginning of the test here.

 Thomas
