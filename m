Received: from eggs.gnu.org ([209.51.188.92]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw9aP-0001os-9x
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw9aO-0002NA-Cw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:53:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<15b742d6-18e9-dfd6-dac2-2613c0b93e76@redhat.com>
	<CAFEAcA84KnN4GVnNyw1V7r2-=DLdNJEzwMQEn8e5ZGV2Vr_RQA@mail.gmail.com>
Date: Tue, 19 Feb 2019 18:53:35 +0100
In-Reply-To: <CAFEAcA84KnN4GVnNyw1V7r2-=DLdNJEzwMQEn8e5ZGV2Vr_RQA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 19 Feb 2019 16:21:56 +0000")
Message-ID: <8736ojpsv4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 19 Feb 2019 at 16:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>> Good news: when you read (0x0000, 0x0000, 0x0000, 0x0000) pflash IDs,
>> that means the code uses the "Virt PFlash".

Which code?

>>                                             IOW this is not a physical
>> model, since the guest obviously doesn't care about checking the flash
>> model.
>> The "VirtPFlash" only has 64KiB sectors.
>>
>> I suggest we add a pflash_cfi02_create_virt(reduced args) helper to make
>> this obvious:
>>
>>   pflash_cfi02_create_virt(paddr, name, size_bytes, mapping?).
>
> What would this be, and when would you use it without a
> /* FIXME this is not what the real hardware does */ ?

For a purely virtual machine such as ARM virt, perhaps?

Funnily, we use IDs 0x89, 0x18, 0x00, 0x00 there.  Which first appeared
in the microblaze petalogix-s3adsp1800 machine (commit 2548de3a343, Jan
2010), then got copied to ppc virtex-ml507 (commit 2c50e26efdb, Sep
2010), microblaze petalogix-ml605 (commit 00914b7d970, Mar 2011), ppc
sam460ex (commit 4b387f9ee16, Feb 2018), arm vexpress-* in different
form (commit b8433303fbc and 0163a2dc80, Dec 2013), and finally arm virt
(commit acf82361c61, Sep 2014).  Which ones match physical hardware is
anybody's guess.

> The real problem with most of these pflash creation calls
> is that they're using bogus data for the flash device
> (wrong IDs, wrong width, using the legacy weird implementation,
> etc etc)

Even better news: when we replace the helper function by longhand,=20
many of the (bogus) qdev_prop_set_FOO() become no-ops (because the
default is identically bogus), so we can sweep more of this under the
carpet!

>          because nobody cares much about the boards or has
> real hardware to see what the hardware really is doing.

Remind me, why are we shipping stuff nobody cares much about?
