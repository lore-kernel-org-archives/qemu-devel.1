Received: from eggs.gnu.org ([2001:4830:134:3::10]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP5FM-0007FV-9J
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP5FL-0004cj-7i
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:30:44 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eP5FL-0004cQ-0c
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:30:43 -0500
Received: by mail-wr0-x232.google.com with SMTP id k61so1796073wrc.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 03:30:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f632bd0e-66ad-2c90-3625-309cf99d5374@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-3-marcandre.lureau@redhat.com>
	<f632bd0e-66ad-2c90-3625-309cf99d5374@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Dec 2017 12:30:41 +0100
Message-ID: <CAJ+F1CJ4np6yn8-LcGW8uQScdv=6ocLY1GF=3+vXRP6ciXRk9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] build-sys: silence make by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Dec 8, 2017 at 8:19 PM, Eric Blake <eblake@redhat.com> wrote:
> On 12/07/2017 06:58 PM, Marc-Andr=C3=A9 Lureau wrote:
>> In particular, do not print anything when there is nothing to do, in
>> particular, after a successful build:
>
> Do we need both 'in particular'?
>

nope

>>
>> $ make
>> make[1]: '/home/elmarco/src/qemu/build/capstone/libcapstone.a' is up to =
date.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  rules.mak | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Yay!  I've been bothered by this.
>
> You may want to add that the noise is conditional on whether you have
> capstone-devel installed.
>
> However,
>
>>
>> diff --git a/rules.mak b/rules.mak
>> index 6e943335f3..b760d54908 100644
>> --- a/rules.mak
>> +++ b/rules.mak
>> @@ -131,6 +131,11 @@ modules:
>>  # If called with only a single argument, will print nothing in quiet mo=
de.
>>  quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &&=
 $1, @$1))
>>
>> +makeflags_ =3D $(makeflags_0)
>> +makeflags_0 =3D --no-print-directory -s
>
> Why the mix of long option and short option? Would it be more legible to
> use two long options?
>
> In my testing of your patch, '-s' alone also silenced things
> (admittedly, when libcapstone.a is up-to-date).  What is
> --no-print-directory adding?
>
> /me goes digging
>
> Hmm, we already have this in Makefile:
>
> SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUILD_D=
IR)
>

Thanks I didn't notice.

> So maybe our problem is that we are forgetting to feed SUBDIR_MAKEFLAGS
> to our sub-make that builds libcapstone.a?

We do.

Now I wonder if this is really a good idea to merge "generic"
makeflags (silence etc) with qemu build-sys specifics (BUILD_DIR=3D..).
It seems we are lucky enough that capstone uses BUILDDIR and qemu
BUILD_DIR, so we avoided the conflict...

Perhaps it's a good time to switch and use thje genreic MAKEFLAGS in
rules.mk for V=3D.

> Next, why is -s silencing the "is up to date" message?  Per 'make
> --help', -s controls whether recipes are echoed - but that doesn't seem
> to be a recipe that was echoed.  Furthermore, the make manual mentions
> that -s is automatically added to MAKEFLAGS if it was present in the
> command line; are we accidentally silencing too much (if the user wants
> to do 'make -s V=3D1' to get JUST command lines but not the make noise)?

V=3D1 shouldn't add the flags, so I don't see the conflict in your example.

>
>> +makeflags_1 =3D
>> +MAKEFLAGS +=3D $(makeflags_$(V))
>> +
>
> So I'm not yet convinced that this is the right place, or if it is too
> heavy of a hammer.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>



--=20
Marc-Andr=C3=A9 Lureau
