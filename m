Received: from eggs.gnu.org ([2001:4830:134:3::10]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYdaW-0002PU-UG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYdaV-0004qw-LJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:55:33 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYdaV-0004qn-8p
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:55:31 -0500
Received: by mail-yb0-x241.google.com with SMTP id w194so30920777ybe.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
	<CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
In-Reply-To: <CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jan 2017 18:55:19 +0000
Message-ID: <CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Chr split patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

Hi!

On Tue, Jan 31, 2017 at 10:42 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 31 January 2017 at 16:20, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > The following changes since commit
> a0def594286d9110a6035e02eef558cf3cf5d847:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into
> staging (2017-01-30 10:23:20 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/elmarco/qemu.git tags/chr-split-pull-request
> >
> > for you to fetch changes up to 3766519be2843e0947425cafd1e7e205dd63f0fd=
:
> >
> >   char: headers clean-up (2017-01-31 13:03:48 +0400)
> >
> > ----------------------------------------------------------------
> >
>
> 'make check' fails on a linux-user-targets-only build:
>
> tests/test-char.o: In function `char_stdio_test_subprocess':
> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:47: undefined
> reference to `qemu_chr_new'
> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:50: undefined
> reference to `qemu_chr_fe_init'
> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:51: undefined
> reference to `qemu_chr_fe_set_open'
> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:52: undefined
> reference to `qemu_chr_fe_write'
> [etc etc etc]
>
>
Oh good catch. We want to have chardev-obj-y defined globally, but only
linked with -softmmu target.

A possible fix to squash with chardev-obj-j patch is:

Eric, do you want me to resend the patch for review or is that enough for
you to ack?

diff --git a/Makefile.objs b/Makefile.objs
index 91a4794f28..b09a9588fc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -4,6 +4,8 @@ stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
 util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o

+chardev-obj-y =3D chardev/
+
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img

@@ -78,8 +80,6 @@ common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o

 common-obj-$(CONFIG_FDT) +=3D device_tree.o

-chardev-obj-y =3D chardev/
-
 ######################################################################
 # qapi

diff --git a/Makefile.target b/Makefile.target
index 5a487b5187..054db85e9e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -188,10 +188,9 @@ dummy :=3D $(call unnest-vars,.., \
                common-obj-m)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
-all-obj-y +=3D $(chardev-obj-y)
 all-obj-y +=3D $(target-obj-y)
 all-obj-y +=3D $(qom-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
--=20
Marc-Andr=C3=A9 Lureau
