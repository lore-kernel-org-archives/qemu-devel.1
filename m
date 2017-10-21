Received: from eggs.gnu.org ([2001:4830:134:3::10]:32773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5x4p-0004hp-F9
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5x4o-0008A5-Fg
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:56:47 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:49721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5x4o-000895-8o
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:56:46 -0400
Received: by mail-wr0-x22f.google.com with SMTP id g90so13677127wrd.6
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 09:56:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877evo8ukl.fsf@frigg.lan>
References: <87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco>
	<87vak1w53a.fsf@frigg.lan> <20170930180941.GA22048@flamenco>
	<8760bu333n.fsf@frigg.lan> <20171005005043.GA20425@flamenco>
	<87vajsl3h7.fsf@frigg.lan> <20171006175929.GA28281@flamenco>
	<87tvz08jc3.fsf@frigg.lan>
	<CAFEAcA8drKvtqmLNKx4oQs+zGUNBgnh3g9Q1X=TbPzoqT2iC2g@mail.gmail.com>
	<877evo8ukl.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Oct 2017 17:56:22 +0100
Message-ID: <CAFEAcA-P4S4967+OD7eML1uFKRcZ3tYatBe59VcCjvu=vg9NHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 21 October 2017 at 15:05, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrot=
e:
> Peter Maydell writes:
>
>> On 15 October 2017 at 17:30, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> w=
rote:
>>> Thinking about it, shouldn't this always be the same given QEMU's TLB/p=
age table
>>> consistency assurances?
>
>> What TLB/page table consistency assurances? For ARM at least
>> we will only update (ie flush) the TLB when the guest next
>> executes a relevant TLB maintenance instruction. So a
>> misbehaving guest can set things up so the page table
>> is completely different from what's in QEMU's TLB if it
>> wants. This all falls in the realms of architecturally
>> unpredictable behaviour for the guest -- whether you
>> want the instrumentation to be confused as well is a
>> different question...
>
> I meant that if the contents of a virtual memory page change while QEMU i=
s
> translating an instruction, it must be able to detect that and act accord=
ingly
> for correctness.

That's an interesting corner case, actually. Traditionally
it simply couldn't happen because we were strictly single
threaded and so if we were translating then we weren't
running guest code. We did need to handle "writes mean we
must invalidate an already produced translation", but not
"invalidate one we're halfway through and haven't put in
our data structures yet". Did we get that right in the MTTCG
design? How does it work?

(Did we produce a summary of the MTTCG design anywhere?
I didn't follow the development in detail as it was going
on, but it would be useful to understand the final result.)

In any case, the only assurance we provide over QEMU as a
whole is that if the guest writes to a physical address then
we don't keep hold of a now-duff translation for that physaddr.
We don't guarantee the same thing for guest changes of
the vaddr-to-physaddr mapping -- instead we let the target
specific code deal with this by invalidating QEMU's TLB
when the guest code does TLB invalidate ops.

> Having that in mind, the same should hold true when an instrumentor reads=
 a
> page's contents during translation (e.g., to gather information on opcode=
s).

Basically I don't think we actually have very strong
guarantees here, and that's another reason for not
providing instrumentation callbacks at translate time.

thanks
-- PMM
