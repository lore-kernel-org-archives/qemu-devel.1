Received: from eggs.gnu.org ([2001:4830:134:3::10]:35745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpToA-0005YJ-2j
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpTo6-000861-S0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpTo6-00085q-J5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:27:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
	<1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
	<CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
	<49cae611-f2fc-e6ef-d122-b498f20c05d8@redhat.com>
Date: Wed, 06 Sep 2017 08:27:21 +0200
In-Reply-To: <49cae611-f2fc-e6ef-d122-b498f20c05d8@redhat.com> (Eric Blake's
	message of "Tue, 5 Sep 2017 15:49:08 -0500")
Message-ID: <87y3pse3zq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 09/05/2017 05:42 AM, Marc-Andr=C3=A9 Lureau wrote:
>> On Mon, Sep 4, 2017 at 12:21 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>>> On 04.09.2017 11 <04%2009%2020%2017%2011>:03, Marc-Andr=C3=A9 Lureau wr=
ote:
>>> > tests/.gitignore is often out of date. Let's generate it based on the
>>> > files and directories to clean.
>>> >
>>> > Note: I didn't succeed yet at generalizing this approach for the rest
>>> > of qemu .gitignore files, but I hope it may eventually happen.
>>> >
>>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> > index f08b7418f0..e94671e879 100644
>>> > --- a/tests/Makefile.include
>>> > +++ b/tests/Makefile.include
>>> > @@ -901,8 +901,34 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): =
check-%.json: $(SRC_PATH)/%.json
>>> >  check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.te=
st.texi
>>> >       @diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
>>> >
>>> > -# Consolidated targets
>>> > +tests-cleanfiles =3D *.o
>>> > +tests-cleanfiles +=3D .gitignore
>>> > +tests-cleanfiles +=3D qht-bench$(EXESUF)
>>> > +tests-cleanfiles +=3D qapi-schema/*.test.*
>>> > +tests-cleanfiles +=3D test-qapi-event.[ch]
>>> > +tests-cleanfiles +=3D test-qapi-types.[ch]
>>> > +tests-cleanfiles +=3D test-qapi-visit.[ch]
>>> > +tests-cleanfiles +=3D test-qmp-introspect.[ch]
>>> > +tests-cleanfiles +=3D test-qmp-commands.h
>>> > +tests-cleanfiles +=3D test-qmp-marshal.c
>>> > +tests-cleanfiles +=3D $(subst tests/,,$(check-unit-y))
>>> > +tests-cleanfiles +=3D $(subst tests/,,$(check-speed-y))
>>> > +tests-cleanfiles +=3D $(subst tests/,,$(check-block-y))
>>> > +tests-cleanfiles +=3D $(subst tests/,,$(check-qtest-y))
>>> > +tests-cleanfiles +=3D $(subst tests/,,$(QEMU_IOTESTS_HELPERS-y))
>>> > +tests-cleanfiles +=3D migration/initrd-stress.img
>>> > +tests-cleanfiles +=3D migration/stress$(EXESUF)
>>> > +tests-cleanfiles +=3D atomic_add-bench$(EXESUF)
>>> > +tests-cleanfiles +=3D test-io-channel-file.txt
>>> > +tests-cleanfiles +=3D test-io-channel-command.fifo
>>> > +
>>> > +tests-cleandirs +=3D test-crypto-tlscredsx509-certs/
>>> > +tests-cleandirs +=3D test-crypto-tlscredsx509-work/
>>> > +tests-cleandirs +=3D test-crypto-tlssession-client/
>>> > +tests-cleandirs +=3D test-crypto-tlssession-server/
>>> > +tests-cleandirs +=3D test-crypto-tlssession-work/
>>> >
>>> > +# Consolidated targets
>>> >  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>>> >  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) che=
ck-tests/qapi-schema/doc-good.texi
>>> >  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>>> > @@ -912,15 +938,20 @@ check-block: $(patsubst %,check-%, $(check-bloc=
k-y))
>>> >  check: check-qapi-schema check-unit check-qtest
>>> >  check-clean:
>>> >       $(MAKE) -C tests/tcg clean
>>> > -     rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>> > -     rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-q=
test-$(target)-y)) $(check-qtest-generic-y))
>>> > -
>>> > +     rm -f $(addprefix tests/, $(tests-cleanfiles))
>>> > +     rm -rf $(addprefix tests/, $(tests-cleandirs))
>>>
>>> I think you should mention this in the patch description, too, that
>>> you're touching the "clean" target here.
>>>
>>> >  clean: check-clean
>>> >
>>> >  # Build the help program automatically
>>> >
>>> >  all: $(QEMU_IOTESTS_HELPERS-y)
>>> >
>>> > +$(SRC_PATH)/tests/.gitignore: $(MAKEFILE_LIST)
>>> > +     $(call quiet-command, echo "$(tests-cleanfiles)" "$(tests-clean=
dirs)" | \
>>> > +             xargs -n1 | sort | uniq | sed -e s:^:/: > $@,"GEN","$(@=
F)")
>>>
>>> Please do not use SRC_PATH here. I'm doing out of tree builds, and I
>>> don't want that these are touching my source folder!

I dislike generating .gitignore almost as much as I dislike maintaining
it, and I'm adamantly opposed to generating it into the source tree.

Let's step back and consider what the problem is.

The problem is that we choose to litter the source tree with haphazardly
named build artifacts.  "Doctor, it hurts when I do that!"

"Don't do that then" is the simplest and sanest solution.  Either name
the build artifacts so that a few simple patterns can safely catch them.
Or stop doing in-tree builds.  As a convenience for people who have
in-tree builds in muscle memory, have ./configure create and configure a
suitable build directory, and have a trivial Makefile in the source tree
that redirects there.  Name the default build directory bld, add bld* to
.gitignore, done.

I've meant to propose such a patch since forever, but I somehow never
get around to actually doing it.

>> I understand the feeling, I do also mostly out of tree build. However, I
>> don't think it makes much sense to generate .gitignore in the build dir.
>> It's git related, and in the git source dir, you have .git that is writa=
ble
>> already: it'd be odd that the git wortree/srcdir is read-only, and the
>> point is to generate .gitignore. Not so true with tarballs though.
>>=20
>> I wrote this patch inspired by how the
>> https://github.com/behdad/git.mk/blob/master/git.mk rules does it (it is
>> uses by many GNOME projects and others with autoconf). The way it gets a=
way
>> with not touching the srcdir in non-git tree, is that the git.mk file is
>> not shipped in distributed tarball. We could have a similar approach if
>> necessary.
>
> Shipping .gitignore in the tarball is not necessary; it's main benefit
> is for in-tree development.
>
>>=20
>> Another alternative, which I find much less appealing, is that qemu tree
>> keeps shipping .gitignore, and we just add a manual rule to maintain it.
>
> Keeping .gitignore in git, if it is generated, is a pain, because then
> we have to manually resync it every time it gets out of date (and we're
> already demonstrating that we forget to update .gitignore with new
> tests).  This patch is only worthwhile if it reduces maintainer
> overhead, but not if it trades one task for another.

Keeping generated files in Git is almost always a bad idea.

>> You suggested using more test* *test etc wildcards. I think this is bad,=
 I
>> would rather have a precise .gitignore, and not ignore extra files that =
are
>> not part of the build-system. I couldn't find a simple way to generate
>> precise rules for intermediary files (like .o etc), but for end targets,
>> this patch demonstrates it can be done quite easily.
>>=20
>> Finally, there is this trend these days with meson to not even allow
>> in-tree build, and thus no need for .gitignore..
>
> Please don't go the direction of forbidding in-tree builds.  While I am
> a BIG fan of VPATH builds, I'm also a big fan of in-tree builds (it's
> slightly faster to do a one-off in-tree build of a fresh git checkout
> than it is to set up yet another VPATH build directory).  Projects that
> force one way or the other are annoying.  I see no reason why we should
> not keep both approaches working, particularly if we have patchew or
> other automation that covers both styles.

I do: people regularly break the one they're not using right now.
Even when Patchew catches these mistake, it's still a waste of developer
time.
