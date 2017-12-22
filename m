Received: from eggs.gnu.org ([2001:4830:134:3::10]:57919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSSNC-0004eK-Bj
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 13:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSSNB-0007gc-Et
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 13:48:46 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSSNB-0007fv-7h
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 13:48:45 -0500
Received: by mail-wm0-x244.google.com with SMTP id n138so23388827wmg.2
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 10:48:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 19:48:43 +0100
Message-ID: <CAJ+F1CJOkEJMizL3EAVVyW16L5ucW2gU+4U2BKHw7OFzfOpWag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi

On Mon, Oct 23, 2017 at 4:18 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Add a new Linux-specific memory backend, similar to hostmem-file,
> except that it doesn't need file path. It also try to enforce memory
> sealing if available. It is thus slightly easier and secure, and is
> compatible with transparent huge-pages since Linux 4.8.
>
> Since Linux 4.14, memfd supports explicit hugetlb, however without
> sealing.

A little update here, 4.16 is likely to support sealing with hugetlb
too (patches are in -mm tree). This should make memfd the prefered
backend for sharing memory with a vhost-user backend.

please review.
thanks

>
> v6:
> - add hugetlbsize option
> - run vhost-user read-guest-mem test with memfile & memfd backend
>
> v5:
> - add memfd hugetlb support
> - add seal and hugeltb options to memfd memory backend
> - update qemu-option to explain sharing works with vhost-user for now
> - rebased, misc code changes
>
> v4:
> - rebased, now that preliminary patches are merged
>
> v3:
> - make vhost-user-test use memfd only if possible
> - rebased
>
> v1->v2:
> - make it linux-specific
> - minor changes and commit message tweaks
>
> Marc-Andr=C3=A9 Lureau (9):
>   memfd: split qemu_memfd_alloc()
>   memfd: remove needless include
>   memfd: add error argument, instead of perror()
>   memfd: add hugetlb support
>   memfd: add hugetlbsize argument
>   Add memfd based hostmem
>   tests: keep compiling failing vhost-user tests
>   vhost-user-test: make read-guest-mem setup its own qemu
>   tests: use memfd in vhost-user-test
>
>  include/qemu/memfd.h     |   4 +-
>  backends/hostmem-memfd.c | 168 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/virtio/vhost.c        |   8 ++-
>  tests/vhost-user-test.c  | 160 +++++++++++++++++++++++++++--------------=
---
>  util/memfd.c             | 115 ++++++++++++++++++++------------
>  backends/Makefile.objs   |   2 +
>  qemu-options.hx          |  23 +++++++
>  7 files changed, 378 insertions(+), 102 deletions(-)
>  create mode 100644 backends/hostmem-memfd.c
>
> --
> 2.15.0.rc0.40.gaefcc5f6f
>
>



--=20
Marc-Andr=C3=A9 Lureau
