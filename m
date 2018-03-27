Received: from eggs.gnu.org ([2001:4830:134:3::10]:43388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0lTf-0006tW-Qy
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0lTb-0007Wq-6g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:05:15 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f0lTa-0007V5-Ve
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:05:11 -0400
Received: by mail-wr0-x243.google.com with SMTP id f14so21768207wre.8
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 03:05:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323204341.1501664-1-eblake@redhat.com>
References: <20180323204341.1501664-1-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Mar 2018 12:05:08 +0200
Message-ID: <CAJ+F1CK8bx_LvLRg9ALfn-eujgqvZXX1OyJfatPVeSLzUgvAsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] tests: Silence false positive
 warning on generated test name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Mar 23, 2018 at 9:43 PM, Eric Blake <eblake@redhat.com> wrote:
> Running 'make check' on rawhide with gcc 8.0.1 fails:
>
> tests/test-visitor-serialization.c: In function 'main':
> tests/test-visitor-serialization.c:1127:34: error: '/primitives/' directi=
ve writing 12 bytes into a region of size between 1 and 128 [-Werror=3Dform=
at-overflow=3D]
>
> The warning is a false positive (we have two buffers of size 128,
> so yes, if we FULLY used the first buffer, then sprint'ing it into
> the second will overflow the second).  But in practice, our first
> buffer will not be longer than "/visitor/serialization/String",
> so sizing it smaller is enough to let gcc see that we don't
> overflow the second.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>
> Makes sense for me to take this through my QAPI tree, if it gets a review=
.
>
>  tests/test-visitor-serialization.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
> index 438c18a0d64..d18d90db2c7 100644
> --- a/tests/test-visitor-serialization.c
> +++ b/tests/test-visitor-serialization.c
> @@ -1115,7 +1115,7 @@ static const SerializeOps visitors[] =3D {
>
>  static void add_visitor_type(const SerializeOps *ops)
>  {
> -    char testname_prefix[128];
> +    char testname_prefix[32];
>      char testname[128];
>      TestArgs *args;
>      int i =3D 0;
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
