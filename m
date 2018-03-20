Received: from eggs.gnu.org ([2001:4830:134:3::10]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJaH-000575-D0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJaG-0008J9-Fd
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:53:57 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyJaG-0008Iz-AQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:53:56 -0400
Received: by mail-ot0-x244.google.com with SMTP id q5-v6so2233449oth.12
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d0d29c49-f45d-3bdd-ca40-f87a0d3ecd36@vivier.eu>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-11-lukeshu@lukeshu.com>
	<CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
	<d0d29c49-f45d-3bdd-ca40-f87a0d3ecd36@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 15:53:34 +0000
Message-ID: <CAFEAcA-xE2qeTiJ4LFFF_gQgTrk=hcYydhe3YvuVM7=hEvighQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Luke Shumaker <lukeshu@lukeshu.com>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>

On 20 March 2018 at 15:23, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 02/03/2018 =C3=A0 15:13, Peter Maydell a =C3=A9crit :
>> On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
>>> +#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>>> +    /* On 32-bit ARM, we need to map not just the usable memory, but
>>> +     * also the commpage.  Try to find a suitable place by allocating
>>> +     * a big chunk for all of it.  If host_start, then the naive
>>> +     * strategy probably does good enough.
>>> +     */
>>> +    if (!host_start) {
>>> +        unsigned long guest_full_size, host_full_size, real_start;
>>> +
>>> +        guest_full_size =3D
>>> +            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
>>
>> I think this is probably more clearly written as 0x100000000ULL,
>> since rounding down to the host-page-size then adding the host-page-size
>> gets us the full 32-bit size of the guest address space.
>
> Perhaps, I've missed something, but it seems not true.
>
> On x86_64, we have:
>
> qemu_host_page_mask =3D 0xfffffffffffff000
> qemu_host_page_size =3D 0x0000000000001000
>
> but
>
> 0xffff0f00 & 0xfffffffffffff000 =3D 0xffff0000
> then
> 0xffff0000 + 0x0000000000001000 =3D 0xffff1000

Yes, you're right -- I'd thought that the kernel commpage was
right at the top of memory, but it isn't.

thanks
-- PMM
