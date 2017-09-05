Received: from eggs.gnu.org ([2001:4830:134:3::10]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpBJL-0000ZW-Gl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpBJF-0008Ab-5N
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpBJE-00088z-Ua
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id g15so2313324oib.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 03:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
	<1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
In-Reply-To: <1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 05 Sep 2017 10:42:08 +0000
Message-ID: <CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: generate tests/.gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

Hi

On Mon, Sep 4, 2017 at 12:21 PM Thomas Huth <thuth@redhat.com> wrote:

> On 04.09.2017 11 <04%2009%2020%2017%2011>:03, Marc-Andr=C3=A9 Lureau wrot=
e:
> > tests/.gitignore is often out of date. Let's generate it based on the
> > files and directories to clean.
> >
> > Note: I didn't succeed yet at generalizing this approach for the rest
> > of qemu .gitignore files, but I hope it may eventually happen.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  Makefile                   |  7 +++-
> >  tests/.gitignore           | 97
> ----------------------------------------------
> >  tests/Makefile.include     | 39 +++++++++++++++++--
> >  tests/migration/.gitignore |  2 -
> >  4 files changed, 41 insertions(+), 104 deletions(-)
> >  delete mode 100644 tests/.gitignore
> >  delete mode 100644 tests/migration/.gitignore
> >
> > diff --git a/Makefile b/Makefile
> > index 81447b1f08..89d5edf531 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -6,7 +6,7 @@ BUILD_DIR=3D$(CURDIR)
> >  # Before including a proper config-host.mak, assume we are in the
> source tree
> >  SRC_PATH=3D.
> >
> > -UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-%
> > +UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% gitignor=
e
> >
> >  # All following code might depend on configuration variables
> >  ifneq ($(wildcard config-host.mak),)
> > @@ -14,6 +14,11 @@ ifneq ($(wildcard config-host.mak),)
> >  all:
> >  include config-host.mak
> >
> > +.PHONY: gitignore
> > +ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if
> $(MAKECMDGOALS),,fail))
> > +all $(MAKECMDGOALS): gitignore
> > +endif
> > +
> >  # Check that we're not trying to do an out-of-tree build from
> >  # a tree that's been used for an in-tree build.
> >  ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> > diff --git a/tests/.gitignore b/tests/.gitignore
> > deleted file mode 100644
> > index fed0189a5a..0000000000
> > --- a/tests/.gitignore
> > +++ /dev/null
> > @@ -1,97 +0,0 @@
> > -atomic_add-bench
> > -benchmark-crypto-cipher
> > -benchmark-crypto-hash
> > -benchmark-crypto-hmac
> > -check-qdict
> > -check-qnum
> > -check-qjson
> > -check-qlist
> > -check-qnull
> > -check-qstring
> > -check-qom-interface
> > -check-qom-proplist
> > -qht-bench
> > -rcutorture
> > -test-aio
> > -test-aio-multithread
> > -test-arm-mptimer
> > -test-base64
> > -test-bitops
> > -test-bitcnt
> > -test-blockjob
> > -test-blockjob-txn
> > -test-bufferiszero
> > -test-char
> > -test-clone-visitor
> > -test-coroutine
> > -test-crypto-afsplit
> > -test-crypto-block
> > -test-crypto-cipher
> > -test-crypto-hash
> > -test-crypto-hmac
> > -test-crypto-ivgen
> > -test-crypto-pbkdf
> > -test-crypto-secret
> > -test-crypto-tlscredsx509
> > -test-crypto-tlscredsx509-work/
> > -test-crypto-tlscredsx509-certs/
> > -test-crypto-tlssession
> > -test-crypto-tlssession-work/
> > -test-crypto-tlssession-client/
> > -test-crypto-tlssession-server/
> > -test-crypto-xts
> > -test-cutils
> > -test-hbitmap
> > -test-hmp
> > -test-int128
> > -test-iov
> > -test-io-channel-buffer
> > -test-io-channel-command
> > -test-io-channel-command.fifo
> > -test-io-channel-file
> > -test-io-channel-file.txt
> > -test-io-channel-socket
> > -test-io-channel-tls
> > -test-io-task
> > -test-keyval
> > -test-logging
> > -test-mul64
> > -test-opts-visitor
> > -test-qapi-event.[ch]
> > -test-qapi-types.[ch]
> > -test-qapi-util
> > -test-qapi-visit.[ch]
> > -test-qdev-global-props
> > -test-qemu-opts
> > -test-qdist
> > -test-qga
> > -test-qht
> > -test-qht-par
> > -test-qmp-commands
> > -test-qmp-commands.h
> > -test-qmp-event
> > -test-qobject-input-strict
> > -test-qobject-input-visitor
> > -test-qmp-introspect.[ch]
> > -test-qmp-marshal.c
> > -test-qobject-output-visitor
> > -test-rcu-list
> > -test-replication
> > -test-shift128
> > -test-string-input-visitor
> > -test-string-output-visitor
> > -test-thread-pool
> > -test-throttle
> > -test-timed-average
> > -test-uuid
> > -test-visitor-serialization
> > -test-vmstate
> > -test-write-threshold
> > -test-x86-cpuid
> > -test-x86-cpuid-compat
> > -test-xbzrle
> > -test-netfilter
> > -test-filter-mirror
> > -test-filter-redirector
> > -*-test
> > -qapi-schema/*.test.*
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index f08b7418f0..e94671e879 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -901,8 +901,34 @@ $(patsubst %, check-%, $(check-qapi-schema-y)):
> check-%.json: $(SRC_PATH)/%.json
> >  check-tests/qapi-schema/doc-good.texi:
> tests/qapi-schema/doc-good.test.texi
> >       @diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
> >
> > -# Consolidated targets
> > +tests-cleanfiles =3D *.o
> > +tests-cleanfiles +=3D .gitignore
> > +tests-cleanfiles +=3D qht-bench$(EXESUF)
> > +tests-cleanfiles +=3D qapi-schema/*.test.*
> > +tests-cleanfiles +=3D test-qapi-event.[ch]
> > +tests-cleanfiles +=3D test-qapi-types.[ch]
> > +tests-cleanfiles +=3D test-qapi-visit.[ch]
> > +tests-cleanfiles +=3D test-qmp-introspect.[ch]
> > +tests-cleanfiles +=3D test-qmp-commands.h
> > +tests-cleanfiles +=3D test-qmp-marshal.c
> > +tests-cleanfiles +=3D $(subst tests/,,$(check-unit-y))
> > +tests-cleanfiles +=3D $(subst tests/,,$(check-speed-y))
> > +tests-cleanfiles +=3D $(subst tests/,,$(check-block-y))
> > +tests-cleanfiles +=3D $(subst tests/,,$(check-qtest-y))
> > +tests-cleanfiles +=3D $(subst tests/,,$(QEMU_IOTESTS_HELPERS-y))
> > +tests-cleanfiles +=3D migration/initrd-stress.img
> > +tests-cleanfiles +=3D migration/stress$(EXESUF)
> > +tests-cleanfiles +=3D atomic_add-bench$(EXESUF)
> > +tests-cleanfiles +=3D test-io-channel-file.txt
> > +tests-cleanfiles +=3D test-io-channel-command.fifo
> > +
> > +tests-cleandirs +=3D test-crypto-tlscredsx509-certs/
> > +tests-cleandirs +=3D test-crypto-tlscredsx509-work/
> > +tests-cleandirs +=3D test-crypto-tlssession-client/
> > +tests-cleandirs +=3D test-crypto-tlssession-server/
> > +tests-cleandirs +=3D test-crypto-tlssession-work/
> >
> > +# Consolidated targets
> >  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> >  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y))
> check-tests/qapi-schema/doc-good.texi
> >  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
> > @@ -912,15 +938,20 @@ check-block: $(patsubst %,check-%,
> $(check-block-y))
> >  check: check-qapi-schema check-unit check-qtest
> >  check-clean:
> >       $(MAKE) -C tests/tcg clean
> > -     rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
> > -     rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST),
> $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> > -
> > +     rm -f $(addprefix tests/, $(tests-cleanfiles))
> > +     rm -rf $(addprefix tests/, $(tests-cleandirs))
>
> I think you should mention this in the patch description, too, that
> you're touching the "clean" target here.
>
> >  clean: check-clean
> >
> >  # Build the help program automatically
> >
> >  all: $(QEMU_IOTESTS_HELPERS-y)
> >
> > +$(SRC_PATH)/tests/.gitignore: $(MAKEFILE_LIST)
> > +     $(call quiet-command, echo "$(tests-cleanfiles)"
> "$(tests-cleandirs)" | \
> > +             xargs -n1 | sort | uniq | sed -e s:^:/: > $@,"GEN","$(@F)=
")
>
> Please do not use SRC_PATH here. I'm doing out of tree builds, and I
> don't want that these are touching my source folder!
>

I understand the feeling, I do also mostly out of tree build. However, I
don't think it makes much sense to generate .gitignore in the build dir.
It's git related, and in the git source dir, you have .git that is writable
already: it'd be odd that the git wortree/srcdir is read-only, and the
point is to generate .gitignore. Not so true with tarballs though.

I wrote this patch inspired by how the
https://github.com/behdad/git.mk/blob/master/git.mk rules does it (it is
uses by many GNOME projects and others with autoconf). The way it gets away
with not touching the srcdir in non-git tree, is that the git.mk file is
not shipped in distributed tarball. We could have a similar approach if
necessary.

Another alternative, which I find much less appealing, is that qemu tree
keeps shipping .gitignore, and we just add a manual rule to maintain it.

You suggested using more test* *test etc wildcards. I think this is bad, I
would rather have a precise .gitignore, and not ignore extra files that are
not part of the build-system. I couldn't find a simple way to generate
precise rules for intermediary files (like .o etc), but for end targets,
this patch demonstrates it can be done quite easily.

Finally, there is this trend these days with meson to not even allow
in-tree build, and thus no need for .gitignore..
--=20
Marc-Andr=C3=A9 Lureau
