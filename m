Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dv0EG-0000gC-KH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dv0EF-0007Yu-KZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:16 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dv0EF-0007Yq-GF
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:15 -0400
Received: by mail-qk0-x243.google.com with SMTP id d70so3476023qkc.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:05:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505975754-21555-1-git-send-email-peterx@redhat.com>
References: <1505975754-21555-1-git-send-email-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Sep 2017 14:05:13 +0200
Message-ID: <CAJ+F1C+ku-8oinXzwX7nWHh35r2RUoc3yUF=i3j20UhBd5kz4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] chardev: support non-default
 gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 21, 2017 at 8:35 AM, Peter Xu <peterx@redhat.com> wrote:
> The old chardev may not fully support non-default GMainContext.  One
> direct clue is that when we call io_add_watch_poll() sometimes we are
> still passing in the NULL context pointer.
>
> IIUC we are fine during setup since the context will be passed
> correctly during setup via chr_update_read_handler().  However it
> won't survive if chardev reconnected due to some reason.
>
> This series tries to solve above problem by caching the gcontext
> pointer in Chardev itself.
>
> This will be required for the monitor OOB (out-of-band) support, since
> in that series monitor backends may be run in non-default contexts.
>
> Please review.  Thanks.
>
> Peter Xu (4):
>   chardev: new qemu_chr_be_update_read_handlers()
>   chardev: add Chardev.gcontext field
>   chardev: use per-dev context for io_add_watch_poll
>   chardev: remove context in chr_update_read_handler
>
>  chardev/char-fd.c      |  5 ++---
>  chardev/char-fe.c      |  7 ++-----
>  chardev/char-pty.c     |  5 ++---
>  chardev/char-socket.c  |  7 +++----
>  chardev/char-udp.c     |  5 ++---
>  chardev/char.c         | 11 +++++++++++
>  include/chardev/char.h | 13 ++++++++++++-
>  7 files changed, 34 insertions(+), 19 deletions(-)

It's only for the read handler, perhaps the gcontext field should be
named "read_context" or adding a comment to explain this is only used
for that.

Otherwise, looks good:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
