Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu3P-0001Ld-MI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu3K-0005Db-Uf
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:07:15 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYu3K-0005BU-L1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:07:10 -0400
Received: by mail-wr0-x229.google.com with SMTP id c13-v6so8979817wrq.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:07:10 -0700 (PDT)
References: <20180626165658.31394-1-peter.maydell@linaro.org>
	<20180626165658.31394-24-peter.maydell@linaro.org>
	<50e46f22-1e3d-10ce-5b5b-a10af49a95f1@vivier.eu>
	<CAFEAcA8141WC556H1fZLM4AEaz62o4qb7JOOVB-+75N9vugi+g@mail.gmail.com>
	<a46a8b06-c780-0c22-b9f7-8eaae73dd26d@vivier.eu>
	<CAFEAcA8gKWG9O7rjhC1+n_Bqce+CGQvUEiM+mc7wu-1C7no2ug@mail.gmail.com>
	<489d8470-c12f-a441-4e87-b2b3013a3ab8@vivier.eu>
	<CAFEAcA8jVXUapKN7nP5eJ0SAP5QWa_PHeZXThZEN3Gn249qRug@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8jVXUapKN7nP5eJ0SAP5QWa_PHeZXThZEN3Gn249qRug@mail.gmail.com>
Date: Fri, 29 Jun 2018 15:07:07 +0100
Message-ID: <877emhvg8k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 23/32] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 28 June 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
>> ./m68k-softmmu/qemu-system-m68k -M q800 \
>>     -serial none -serial mon:stdio \
>>     -kernel vmlinux-4.15.0-2-m68k \
>>     -nographic
>
> Thanks for the test case. I'm still investigating, but there
> are a couple of things happening here.
>
> First, there's a bug in get_page_addr_code()'s "is this a
> TLB miss?" condition which was introduced in commit 71b9a45330fe22:
>
>     if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=3D
>                  (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
>
> takes a (not necessarily page aligned) address, and masks out
> everything but the page-aligned top half (good) and the
> TLB_INVALID bit (not good, because that could be either 0 or 1
> depending on the address). This means sometimes we'll incorrectly
> decide we got a miss in the TLB and do an unnecessary refill.
>
> The second thing that's going on here is that the m68k target
> code writes TLB entries for the same address with different
> prot bits without doing a flush in between:
>
> tlb_set_page_with_attrs: vaddr=3D0029b000 paddr=3D0x000000000029b000 prot=
=3D3 idx=3D0
> tlb_set_page_with_attrs: vaddr=3D0029b000 paddr=3D0x000000000029b000 prot=
=3D7 idx=3D0
>
> The tlb_set_page_with_attrs() code isn't expecting this, so
> we end up with two TLB entries for the same address, one in
> the main TLB and one in the victim cache TLB. The bug above
> means that we get this sequence of events:
>  * fill main TLB entry with prot=3D3 entry
>  * later, fill main TLB with prot=3D7 entry, and evict prot=3D3
>    entry to victim cache
>  * hit on the prot=3D7 entry in the main TLB
>  * refill condition incorrectly fails, but we hit in the victim cache
>  * so we pull the prot=3D3 entry from victim to main TLB
>  * prot=3D3 means "addr_code =3D=3D -1", so the check of the TLB_RECHECK
>    bit succeeds
>  * in the TLB_RECHECK code we do a tlb_fill()
>  * that fills in the main TLB with a prot=3D7 entry again, bouncing
>    the prot=3D3 entry back out to the victim cache
>  * prot=3D7 means the addr_code is correct, so we find ourselves in
>    the "TLB_RECHECK but this is RAM" abort code path
>
> I'm not sure whether it's supposed to be the responsibility
> of the target code or the common accel/tcg code to ensure
> that we don't have multiple TLB entries for the same address.

My gut feeling is we should fail safely in the case of the guest writing
two mostly identical page entries in a row. We can check for aliasing
when we update and either evict to the victim cache or reset the vtlb
entry.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
