Received: from eggs.gnu.org ([2001:4830:134:3::10]:50383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgU36-0007SO-9c
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgU35-00068O-5T
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:53:44 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgU34-00067k-SB
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:53:43 -0400
Received: by mail-wm0-x232.google.com with SMTP id t201so8027608wmt.1
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 03:53:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Aug 2017 11:53:20 +0100
Message-ID: <CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Programmingkid <programmingkidx@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 11 August 2017 at 22:58, Samuel Thibault <samuel.thibault@gnu.org> wrote=
:
> Hello,
>
> Programmingkid, on jeu. 10 ao=C3=BBt 2017 16:44:19 -0400, wrote:
>> While compiling I saw these error messages:
>>
>> slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip_src=
' of class or
>>       structure 'ip6' may result in an unaligned pointer value
>>       [-Waddress-of-packed-member]
>>     if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
>>                                ^~~~~~~~~~
>
>> slirp/ip_input.c:159:43: warning: taking address of packed member 'ip_li=
nk' of class or
>>       structure 'ipq' may result in an unaligned pointer value
>>       [-Waddress-of-packed-member]
>>                 for (l =3D slirp->ipq.ip_link.next; l !=3D &slirp->ipq.i=
p_link;
>>                                                         ^~~~~~~~~~~~~~~~=
~~
>
> Well, if the compiler was counting well, it would notice that the
> structure are made so that even with packing, fields always get aligned
> on proper bounds.

The utility of the warning is that it means you get told
about stuff that might break on other architectures. Eg
x86's alignment restrictions are practically nonexistent
but sparc is much more restrictive. It's better to get
warnings on all hosts so these things can be cleaned
up rather than have them only be warnings on the less
commonly used hosts where nobody will notice them.

(GCC ideally ought to warn about this but doesn't:
that's a bug/missing feature in gcc.)

That said, some of these are a bit odd -- comparing
a pointer value should be fine, as should using
a pointer to a packed struct field inside a
function -- it's only when that pointer is cast
to a non-packed-pointer-type (including by passing
it to another function) that the compiler loses the
information that the pointer is potentially unaligned.

thanks
-- PMM
