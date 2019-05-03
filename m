Received: from eggs.gnu.org ([209.51.188.92]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZrG-0008Hf-2j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZrF-0008HU-3f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:18 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZrE-0008C5-QL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id b1so5604700otp.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
	<b70484a8-b408-7c2b-7fd7-27f1c1d98f4d@redhat.com>
In-Reply-To: <b70484a8-b408-7c2b-7fd7-27f1c1d98f4d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:12:04 +0100
Message-ID: <CAFEAcA9iHz6At=siOPyc76HvNm=PQpBmTLqyPPBTgeoPDKx7qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, 3 May 2019 at 16:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> FYI I was running MinGW tests with "make docker-test-mingw@fedora
> SHOW_ENV=3D1 J=3D8 NETWORK=3D1" and ran "git pull" to refresh my local re=
po,
> and got:
>
> $ make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D8 NETWORK=3D1
> make[1]: Entering directory '/home/phil/source/qemu'
>   GEN
> /home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar
> slirp: unmerged (59a1b1f165458c2acb7ff0525b543945f7416225)
> fatal: git-write-tree: error building trees
> Cannot save the current index state
> Cloning into
> '/home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar.vroo=
t'...
> done.
> error: pathspec 'slirp:' did not match any file(s) known to git.
> error: pathspec 'needs' did not match any file(s) known to git.
> error: pathspec 'merge' did not match any file(s) known to git.
> failed to checkout slirp: needs merge revision
> tar: /var/tmp/qemu/qemu.tar: Cannot open: No such file or directory
> tar: Error is not recoverable: exiting now
> Failed to untar source
> tests/docker/Makefile.include:203: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 1

This weird set of errors is demonstrating a bug in
scripts/archive-source.sh where it is not checking
for errors from git. Specifically it does:

if git diff-index --quiet HEAD -- &>/dev/null
then
    HEAD=3DHEAD
else
    HEAD=3D$(git stash create)
fi

and git prints "slirp: needs merge revision", which we
blindly put into the HEAD variable, and then later do:

git checkout $HEAD

which is what's causing the weird pathspec errors, because
(a) we're trying to check out an error message and (b) our
shell quoting is nonexistent and so we don't even treat it
as a single argument...

thanks
-- PMM
