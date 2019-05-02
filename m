Received: from eggs.gnu.org ([209.51.188.92]:44618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFTx-0004dK-Ir
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFTw-00028q-II
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:26:53 -0400
MIME-Version: 1.0
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
	<af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
In-Reply-To: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 10:24:53 -0700
Message-ID: <CAKmqyKP+o6MfqBQfkOmSXvoj-BX43KJD+ayzxZA6t-N-DucD5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "kraxel@redhat.com" <kraxel@redhat.com>

On Wed, May 1, 2019 at 5:00 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/1/19 4:40 AM, Laurent Vivier wrote:
> > On 01/05/2019 01:28, Alistair Francis wrote:
> >> Fix this warning when building with GCC9 on Fedora 30:
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/li=
nux-user/uname.c:94:3:
> >> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string of=
 length 64 [-Werror=3Dstringop-truncation]
> >>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I'm dropping this patch in favour of the other one.

Alistair

> >> ---
> >>  linux-user/uname.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/linux-user/uname.c b/linux-user/uname.c
> >> index 313b79dbad..2fc6096a5b 100644
> >> --- a/linux-user/uname.c
> >> +++ b/linux-user/uname.c
> >> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
> >>  #define COPY_UTSNAME_FIELD(dest, src) \
> >>    do { \
> >>        /* __NEW_UTS_LEN doesn't include terminating null */ \
> >> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> >> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); =
\
> >
> > You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> > character if it is present and fit in __NEW_UTS_LEN.
>
> No, the NUL character is already present, due to the memset() prior to
> any use of COPY_UTSNAME_FIELD().  However, the commit message should
> call that out, as it is not part of the default 3-line diff.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
