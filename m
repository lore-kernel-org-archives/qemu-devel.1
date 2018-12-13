Received: from eggs.gnu.org ([2001:4830:134:3::10]:43858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQ6U-0004if-Qs
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQ6O-0002XE-Tz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXQ6O-0002Rl-NL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:28:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
	<CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
Date: Thu, 13 Dec 2018 13:28:23 +0100
In-Reply-To: <CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
	(Peter Maydell's message of "Thu, 13 Dec 2018 11:27:35 +0000")
Message-ID: <87o99pa9w8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 13 Dec 2018 at 10:19, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Wed, Dec 12, 2018 at 06:09:37PM -0800, Li Qiang wrote:
>> > Assert that the return value is not an error. This is like commit
>> > 7e6478e7d4f for qemu_set_cloexec.
>> >
>> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> > ---
>> >  util/oslib-posix.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> > index c1bee2a581..4ce1ba9ca4 100644
>> > --- a/util/oslib-posix.c
>> > +++ b/util/oslib-posix.c
>> > @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
>> >  {
>> >      int f;
>> >      f =3D fcntl(fd, F_GETFL);
>> > -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
>> > +    assert(f !=3D -1);
>>
>> This leads to *awful* diagnostics. We need to print something
>> useful when it fails so we stand a chance of understanding what
>> is wrong.
>
> It's the same thing we do in qemu_set_cloexec(), though,
> and nobody's complained about that that I know of. I think
> we need to understand whether we're getting asserts in
> vhost_user_test because of something silly like passing -1
> as the fd, or because the fcntl() can legitimately fail.
> If the former, the assert isn't a big deal because when
> we hit it in newly developed code the problem is going
> to be obvious when run under a debugger. If the latter,
> we need to actually pass out the error status and fix
> all the callers to check it...

Yes.

Assertions are not expected to fail *by definition*.  When they do,
there's a bug in the code, and having to look at the code to see what's
wrong is totally fine.

When you feel you have to print something fancy when an assertion fails,
either your feelings are misguided, or the assertion is wrong.
