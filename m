Received: from eggs.gnu.org ([2001:4830:134:3::10]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fzjVm-00058L-4C
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fzjVh-00085v-2c
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:19:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fzjVg-00084J-T3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:19:20 -0400
References: <20180904084648.680c564b@redhat.com>
	<CAJ+F1CLDPQr04Khj-B4UXMzEV-Cu_J2e4S4j2c43NT-s3HwywQ@mail.gmail.com>
	<20180906095802.7dffbf1b@redhat.com>
	<CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
	<20180906085937.GA2639@work-vm>
	<CAJ+F1CKeo2fGc5fLUG7Ezpk0OTkMATioqQ64A3gKT7jXvULTkA@mail.gmail.com>
	<20180906094245.GB2639@work-vm>
	<CAJ+F1C+b8Q3P7=s4W+-GCbWeLqhVCvs_xei_LTw22YWTJ16Bmg@mail.gmail.com>
	<20180906172304.GF2639@work-vm>
	<43c91014-2ca4-681b-51e7-b8cde063014c@redhat.com>
	<20180910104408.GE2482@work-vm>
	<CAJ+F1CJEnLkJo29eahWS6F1cRyvS1nJZy-kGvQH04mGZdntbCw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c2824184-8e20-259d-bae1-b54d054757d0@redhat.com>
Date: Tue, 11 Sep 2018 16:19:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJEnLkJo29eahWS6F1cRyvS1nJZy-kGvQH04mGZdntbCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex Williamson <alex.williamson@redhat.com>

+Alex, due to mention of 21e00fa55f3fd

On 09/10/18 15:03, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Sep 10, 2018 at 2:44 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
>> (I didn't know about guest_phys_block* and would have probably just us=
ed
>> qemu_ram_foreach_block )
>>
>=20
> guest_phys_block*() seems to fit, as it lists only the blocks actually
> used, and already skip the device RAM.
>=20
> Laszlo, you wrote the functions
> (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dc5d7f60f0614250bd925=
071e25220ce5958f75d0),
> do you think it's appropriate to list the memory to clear, or we
> should rather use qemu_ram_foreach_block() ?

Originally, I would have said, "use either, doesn't matter". Namely,
when I introduced the guest_phys_block*() functions, the original
purpose was not related to RAM *contents*, but to RAM *addresses*
(GPAs). This is evident if you look at the direct child commit of
c5d7f60f0614, namely 56c4bfb3f07f, which put GuestPhysBlockList to use.
And, for your use case (=3D wiping RAM), GPAs don't matter, only contents
matter.

However, with the commits I mentioned previously, namely e4dc3f5909ab9
and 21e00fa55f3fd, we now filter out some RAM blocks from the dumping
based on contents / backing as well. I think? So I believe we should
honor that for the wiping to. I guess I'd (vaguely) suggest using
guest_phys_block*().

(And then, as Dave suggests, maybe extend the filter to consider pmem
too, separately.)

Laszlo
