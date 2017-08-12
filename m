Received: from eggs.gnu.org ([2001:4830:134:3::10]:42234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgYV0-00007s-2B
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgYUt-0002CM-ND
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:38:50 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgYUt-0002BE-I0
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:38:43 -0400
Received: by mail-qk0-x241.google.com with SMTP id x77so5985835qka.4
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 08:38:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
	<20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
	<60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <52a8c2c0-5d51-9c92-3dbe-3c25bd09e16e@amsat.org>
Date: Sat, 12 Aug 2017 12:38:37 -0300
MIME-Version: 1.0
In-Reply-To: <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Eric,

On 08/12/2017 08:41 AM, Eric Blake wrote:
> Here's an idea:  Instead of using struct ip6 { ... } QEMU_PACKED, use
> 
> struct ip6 {
> ...
> };
> QEMU_BUG_ON(sizeof(struct ip6) != 32);
> 
> so that the compiler explicitly chokes if it introduced any padding, and
> then we know all our accesses are naturally aligned which shuts up the
> warning.

Following your suggestion I tried:

#define QEMU_BUG_STRUCT_UNALIGNED(s) \
         QEMU_BUILD_BUG_ON(sizeof(s) != sizeof(s QEMU_PACKED))

QEMU_BUG_STRUCT_UNALIGNED(struct ip6);

but this gives:

qemu/slirp/ip6.h:157:1: warning: 'packed' attribute ignored when parsing 
type [-Wignored-attributes]
QEMU_BUG_STRUCT_UNALIGNED(struct ip6);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
qemu/slirp/ip6.h:155:49: note: expanded from macro 
'QEMU_BUG_STRUCT_UNALIGNED'
         QEMU_BUILD_BUG_ON(sizeof(s) != sizeof(s QEMU_PACKED))
                                                 ^~~~~~~~~~~
qemu/include/qemu/compiler.h:40:37: note: expanded from macro 'QEMU_PACKED'
# define QEMU_PACKED __attribute__((packed))
                                     ^~~~~~
1 warning generated.
