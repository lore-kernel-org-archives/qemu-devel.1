Received: from eggs.gnu.org ([208.118.235.92]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fzPX8-0002ew-LG
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fzPX2-0001Yi-1D
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:59:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fzPX1-0001WP-Px
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:59:23 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <871sa1comw.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Mon, 10 Sep 2018 17:18:15 +0100")
References: <1536174934-26022-1-git-send-email-wei@redhat.com>
	<1536174934-26022-3-git-send-email-wei@redhat.com>
	<871sa1comw.fsf@linaro.org>
Reply-To: quintela@redhat.com
Date: Mon, 10 Sep 2018 18:59:15 +0200
Message-ID: <87sh2h70gs.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V9 2/4] tests/migration: Support cross
 compilation in generating boot header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, drjones@redhat.com, dgilbert@redhat.com

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
D> Wei Huang <wei@redhat.com> writes:
>
>> Recently a new configure option, CROSS_CC_GUEST, was added to
>> $(TARGET)-softmmu/config-target.mak to support TCG-related tests. This
>> patch tries to leverage this option to support cross compilation when the
>> migration boot block file is being re-generated:
>>
>>  * The x86 related files are moved to a new sub-dir (named ./i386).
>>  * A new top-layer Makefile is created in tests/migration/ directory.
>>    This Makefile searches and parses CROSS_CC_GUEST to generate CROSS_PR=
EFIX.
>>    The CROSS_PREFIX, if available, is then passed to migration/$ARCH/Mak=
efile.
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Wei Huang <wei@redhat.com>


>> -.PHONY: all clean
>> -all: x86-a-b-bootblock.h
>> -
>> -x86-a-b-bootblock.h: x86.bootsect
>> -	echo "$$__note" > header.tmp
>> -	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>> -	mv header.tmp $@
>> +find-arch-cross-cc =3D $(lastword $(shell grep -h "CROSS_CC_GUEST=3D" $=
(wildcard $(SRC_PATH)/$(patsubst i386,*86*,$(1))-softmmu/config-target.mak)=
))
>> +parse-cross-prefix =3D $(subst gcc,,$(patsubst cc,gcc,$(patsubst CROSS_=
CC_GUEST=3D"%",%,$(call find-arch-cross-cc,$(1)))))
>> +gen-cross-prefix =3D $(patsubst %-,CROSS_PREFIX=3D%-,$(call
>> parse-cross-prefix,$(1)))
>
> This all seems awfully fiddly compared to moving the code to tests/tcg
> and building with the existing machinery. You don't even get the docker
> fall-back this way.
>
> The aim being to have the ability to build the binary and manually
> update the .hex/.S encoded version actually used in the test when you
> don't have cross compilers available right?
>
> I've got some TODOs in tests/tcg to start building the various system
> tests. Perhaps I should port the various migration kernels when I get to
> that?

One only needs to run the compiler when they modify the aarch64 test,
and that should be almost never.  And if anyone does, it is expected to
be an arm developer being runing on an ARM host or having a propper
cross-compiler.  I.e. that code is not intended to be part of a normal
build.

I guess that in general would be useful to have a way to tell Makefile:
I want to compile this with an arm compiler (native or cross), or any
other architecture.  But this case is a quite simple case that is not
supposed to be run often.  To put things in prespective,  I think that
we haven't ever changed the x86-64 migration test code.  I can be wrong,
but we are talking in less than a run for each qemu release.

Later, Juan.
