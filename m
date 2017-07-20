Received: from eggs.gnu.org ([2001:4830:134:3::10]:57343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYJDL-0007uN-0k
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYJDK-0001jt-2s
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:42:31 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYJDJ-0001jI-QC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:42:29 -0400
Received: by mail-wr0-x22e.google.com with SMTP id k71so22145380wrc.2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2bba3c89-e4f0-655b-c9ed-aab911beaaa7@redhat.com>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
	<CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
	<2bba3c89-e4f0-655b-c9ed-aab911beaaa7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 22:42:08 +0100
Message-ID: <CAFEAcA9ZhxrnKzw9WUVCNrSJxy_y4pPyX92_DqXn89LRq7LVbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 20 July 2017 at 22:29, Eric Blake <eblake@redhat.com> wrote:
> On 07/20/2017 04:03 PM, Peter Maydell wrote:
>> https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/sys/ctype_inline.h
>> The implementation is
>>   #define toupper(c) ((int)((_toupper_tab_ + 1)[(c)]))
>>
>> (where I assume _toupper_tab_ is the obvious array.)
>
> In fact, if NetBSD's implementation is anything like Cygwin's, then it
> is a safe bet that _toupper_tab_ is a symbol that lands in the middle of
> a larger 384-byte array, such that _toupper_tab_[-1] (for (signed
> char)'\xfe') happens to resolve to a valid image address, and will have
> the same contents as _toupper_tab_[255] (for (unsigned char)'\xfe'),
> precisely to cater to so many clueless programs have forgotten about
> signed char widening to negative values (even though the standard says
> the behavior is undefined, quality-of-implementation demands that you
> try to do the sane thing anyway).

Nope, looks like they just implement as _toupper_tab_[0] is for
EOF, and indexes >0 are for the characters, if I've found the
right bit of their libc:
https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/lib/libc/locale/rune.c

thanks
-- PMM
