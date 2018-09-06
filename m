Received: from eggs.gnu.org ([2001:4830:134:3::10]:46662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wehuang@redhat.com>) id 1fxx4O-0003b5-86
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wehuang@redhat.com>) id 1fxx4M-0002cF-JX
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:23:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wehuang@redhat.com>) id 1fxx4M-0002Yt-9k
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:23:46 -0400
Date: Thu, 6 Sep 2018 12:23:45 -0400 (EDT)
From: Wei Huang <wehuang@redhat.com>
Message-ID: <1833468426.33436803.1536251025029.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180906140033.3dqtxioxa6d3gdxb@kamzik.brq.redhat.com>
References: <1536174934-26022-1-git-send-email-wei@redhat.com>
	<1536174934-26022-3-git-send-email-wei@redhat.com>
	<20180906120332.w7rhhurm6vtibc2t@kamzik.brq.redhat.com>
	<1848345586.33384050.1536241024207.JavaMail.zimbra@redhat.com>
	<20180906140033.3dqtxioxa6d3gdxb@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Andrew Jones <drjones@redhat.com>
Cc: lvivier@redhat.com, peter maydell <peter.maydell@linaro.org>, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, alex bennee <alex.bennee@linaro.org>



----- Original Message -----
> From: "Andrew Jones" <drjones@redhat.com>
> To: "Wei Huang" <wehuang@redhat.com>
> Cc: lvivier@redhat.com, "peter maydell" <peter.maydell@linaro.org>, quintela@redhat.com, qemu-devel@nongnu.org,
> dgilbert@redhat.com, "alex bennee" <alex.bennee@linaro.org>
> Sent: Thursday, September 6, 2018 9:00:33 AM
> Subject: Re: [Qemu-devel] [PATCH V9 2/4] tests/migration: Support cross compilation in generating boot header file
> 
> On Thu, Sep 06, 2018 at 09:37:04AM -0400, Wei Huang wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Andrew Jones" <drjones@redhat.com>
> > > To: "Wei Huang" <wei@redhat.com>
> > > Cc: qemu-devel@nongnu.org, lvivier@redhat.com, "peter maydell"
> > > <peter.maydell@linaro.org>, quintela@redhat.com,
> > > dgilbert@redhat.com, "alex bennee" <alex.bennee@linaro.org>
> > > Sent: Thursday, September 6, 2018 7:03:32 AM
> > > Subject: Re: [Qemu-devel] [PATCH V9 2/4] tests/migration: Support cross
> > > compilation in generating boot header file
> > > 
> > > On Wed, Sep 05, 2018 at 03:15:32PM -0400, Wei Huang wrote:
> > > > Recently a new configure option, CROSS_CC_GUEST, was added to
> > > > $(TARGET)-softmmu/config-target.mak to support TCG-related tests. This
> > > > patch tries to leverage this option to support cross compilation when
> > > > the
> > > > migration boot block file is being re-generated:
> > > > 
> > > >  * The x86 related files are moved to a new sub-dir (named ./i386).
> > > >  * A new top-layer Makefile is created in tests/migration/ directory.
> > > >    This Makefile searches and parses CROSS_CC_GUEST to generate
> > > >    CROSS_PREFIX.
> > > >    The CROSS_PREFIX, if available, is then passed to
> > > >    migration/$ARCH/Makefile.
> > > > 
> > > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > > Signed-off-by: Wei Huang <wei@redhat.com>
> > > > ---
> > > >  tests/migration-test.c                             |  2 +-
> > > >  tests/migration/Makefile                           | 44
> > > >  ++++++++++++----------
> > > >  tests/migration/i386/Makefile                      | 22 +++++++++++
> > > >  .../{x86-a-b-bootblock.S => i386/a-b-bootblock.S}  |  4 --
> > > >  .../{x86-a-b-bootblock.h => i386/a-b-bootblock.h}  |  8 ++--
> > > >  5 files changed, 51 insertions(+), 29 deletions(-)
> > > >  create mode 100644 tests/migration/i386/Makefile
> > > >  rename tests/migration/{x86-a-b-bootblock.S => i386/a-b-bootblock.S}
> > > >  (93%)
> > > >  rename tests/migration/{x86-a-b-bootblock.h => i386/a-b-bootblock.h}
> > > >  (92%)
> > > > 
> > > > diff --git a/tests/migration-test.c b/tests/migration-test.c
> > > > index 0e687b7..fe6b41a 100644
> > > > --- a/tests/migration-test.c
> > > > +++ b/tests/migration-test.c
> > > > @@ -83,7 +83,7 @@ static const char *tmpfs;
> > > >  /* A simple PC boot sector that modifies memory (1-100MB) quickly
> > > >   * outputting a 'B' every so often if it's still running.
> > > >   */
> > > > -#include "tests/migration/x86-a-b-bootblock.h"
> > > > +#include "tests/migration/i386/a-b-bootblock.h"
> > > >  
> > > >  static void init_bootfile_x86(const char *bootpath)
> > > >  {
> > > > diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> > > > index c0824b4..a9ed875 100644
> > > > --- a/tests/migration/Makefile
> > > > +++ b/tests/migration/Makefile
> > > > @@ -1,31 +1,35 @@
> > > > -# To specify cross compiler prefix, use CROSS_PREFIX=
> > > > -#   $ make CROSS_PREFIX=x86_64-linux-gnu-
> > > > +#
> > > > +# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> > > > +#
> > > > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > > > later.
> > > > +# See the COPYING file in the top-level directory.
> > > > +#
> > > > +
> > > > +TARGET_LIST = i386
> > > > +
> > > > +SRC_PATH = ../..
> > > >  
> > > >  override define __note
> > > > -/* This file is automatically generated from
> > > > - * tests/migration/x86-a-b-bootblock.S, edit that and then run
> > > > - * tests/migration/rebuild-x86-bootblock.sh to update,
> > > > - * and then remember to send both in your patch submission.
> > > > +/* This file is automatically generated from the assembly file in
> > > > + * tests/migration/$@. Edit that file and then run "make all"
> > > > + * inside tests/migration to update, and then remember to send both
> > > > + * the header and the assembler differences in your patch submission.
> > > >   */
> > > >  endef
> > > >  export __note
> > > >  
> > > > -.PHONY: all clean
> > > > -all: x86-a-b-bootblock.h
> > > > -
> > > > -x86-a-b-bootblock.h: x86.bootsect
> > > > -	echo "$$__note" > header.tmp
> > > > -	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
> > > > -	mv header.tmp $@
> > > > +find-arch-cross-cc = $(lastword $(shell grep -h "CROSS_CC_GUEST="
> > > > $(wildcard $(SRC_PATH)/$(patsubst
> > > > i386,*86*,$(1))-softmmu/config-target.mak)))
> > > 
> > > The above function hangs unless configuring with
> > > '--target-list=x86_64-softmmu,aarch64-softmmu'. I tried just x86_64
> > > alone,
> > > just aarch64 alone, and also configuring both x86_64 and i386, but none
> > > of those worked. For some reason grep isn't happy with the generated path
> > > list. I tested like this
> > > 
> > >  ./configure --target-list=x86_64-softmmu,i386-softmmu
> > >  make -C tests/migration
> > > 
> > > And, while not an issue of this series, I had to manually add
> > > CROSS_CC_GUEST="aarch64-linux-gnu-gcc" to
> > > aarch64-softmmu/config-target.mak
> > > for it to work, because configure's compiler test fails with the Fedora
> > > aarch64-linux-gnu-gcc installation (the linker can't find code it needs
> > > to a build a program with main()). I'm not sure if building programs with
> > > main() is something the CROSS_CC_GUEST compiler needs to do. Maybe that
> > > test can be relaxed. Alex?
> > 
> > I saw the same problem and it needs to be addressed in ./configure file.
> > Most distros don't ship with
> > cross-compiled glibc. So compiling main() will fail because of that.
> 
> I don't care too much about that problem. You just need to have the right
> cross compiler installed. I care about the one above, which is a separate
> problem and should be fixed. The tests/migration build shouldn't hang
> when a target-list other than x86_64-softmmu,aarch64-softmmu is used.
> 

Since you don't have aarch64, the stall happens when grep is supplied with
an empty file name and waiting on standard input. There is no easy way to
skip standard input for grep. How about the following? Basically we always
supply with a terminator. 

grep -h "CROSS_CC_GUEST=" $(wildcard $(SRC_PATH)/$(patsubst i386,*86*,$(1))-softmmu/config-target.mak) /dev/null)

> Thanks,
> drew
> 
> > 
> > > 
> > > Thanks,
> > > drew
> > > 
> > > > +parse-cross-prefix = $(subst gcc,,$(patsubst cc,gcc,$(patsubst
> > > > CROSS_CC_GUEST="%",%,$(call find-arch-cross-cc,$(1)))))
> > > > +gen-cross-prefix = $(patsubst %-,CROSS_PREFIX=%-,$(call
> > > > parse-cross-prefix,$(1)))
> > > >  
> > > > -x86.bootsect: x86.boot
> > > > -	dd if=$< of=$@ bs=256 count=2 skip=124
> > > > +.PHONY: all $(TARGET_LIST)
> > > >  
> > > > -x86.boot: x86.o
> > > > -	$(CROSS_PREFIX)objcopy -O binary $< $@
> > > > +all: $(TARGET_LIST)
> > > >  
> > > > -x86.o: x86-a-b-bootblock.S
> > > > -	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
> > > > +$(TARGET_LIST):
> > > > +	$(MAKE) -C $@ $(call gen-cross-prefix,$@)
> > > >  
> > > >  clean:
> > > > -	@rm -rf *.boot *.o *.bootsect
> > > > +	for target in $(TARGET_LIST); do \
> > > > +		$(MAKE) -C $$target clean; \
> > > > +	done
> > > > diff --git a/tests/migration/i386/Makefile
> > > > b/tests/migration/i386/Makefile
> > > > new file mode 100644
> > > > index 0000000..5c03241
> > > > --- /dev/null
> > > > +++ b/tests/migration/i386/Makefile
> > > > @@ -0,0 +1,22 @@
> > > > +# To specify cross compiler prefix, use CROSS_PREFIX=
> > > > +#   $ make CROSS_PREFIX=x86_64-linux-gnu-
> > > > +
> > > > +.PHONY: all clean
> > > > +all: a-b-bootblock.h
> > > > +
> > > > +a-b-bootblock.h: x86.bootsect
> > > > +	echo "$$__note" > header.tmp
> > > > +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
> > > > +	mv header.tmp $@
> > > > +
> > > > +x86.bootsect: x86.boot
> > > > +	dd if=$< of=$@ bs=256 count=2 skip=124
> > > > +
> > > > +x86.boot: x86.o
> > > > +	$(CROSS_PREFIX)objcopy -O binary $< $@
> > > > +
> > > > +x86.o: a-b-bootblock.S
> > > > +	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
> > > > +
> > > > +clean:
> > > > +	@rm -rf *.boot *.o *.bootsect
> > > > diff --git a/tests/migration/x86-a-b-bootblock.S
> > > > b/tests/migration/i386/a-b-bootblock.S
> > > > similarity index 93%
> > > > rename from tests/migration/x86-a-b-bootblock.S
> > > > rename to tests/migration/i386/a-b-bootblock.S
> > > > index b164264..3f97f28 100644
> > > > --- a/tests/migration/x86-a-b-bootblock.S
> > > > +++ b/tests/migration/i386/a-b-bootblock.S
> > > > @@ -3,10 +3,6 @@
> > > >  #  range.
> > > >  #  Outputs an initial 'A' on serial followed by repeated 'B's
> > > >  #
> > > > -# run   tests/migration/rebuild-x86-bootblock.sh
> > > > -#   to regenerate the hex, and remember to include both the .h and .s
> > > > -#   in any patches.
> > > > -#
> > > >  # Copyright (c) 2016 Red Hat, Inc. and/or its affiliates
> > > >  # This work is licensed under the terms of the GNU GPL, version 2 or
> > > >  later.
> > > >  # See the COPYING file in the top-level directory.
> > > > diff --git a/tests/migration/x86-a-b-bootblock.h
> > > > b/tests/migration/i386/a-b-bootblock.h
> > > > similarity index 92%
> > > > rename from tests/migration/x86-a-b-bootblock.h
> > > > rename to tests/migration/i386/a-b-bootblock.h
> > > > index 78a151f..7d459d4 100644
> > > > --- a/tests/migration/x86-a-b-bootblock.h
> > > > +++ b/tests/migration/i386/a-b-bootblock.h
> > > > @@ -1,7 +1,7 @@
> > > > -/* This file is automatically generated from
> > > > - * tests/migration/x86-a-b-bootblock.s, edit that and then run
> > > > - * tests/migration/rebuild-x86-bootblock.sh to update,
> > > > - * and then remember to send both in your patch submission.
> > > > +/* This file is automatically generated from the assembly file in
> > > > + * tests/migration/i386. Edit that file and then run "make all"
> > > > + * inside tests/migration to update, and then remember to send both
> > > > + * the header and the assembler differences in your patch submission.
> > > >   */
> > > >  unsigned char x86_bootsect[] = {
> > > >    0xfa, 0x0f, 0x01, 0x16, 0x74, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00,
> > > >    0x00,
> > > > --
> > > > 1.8.3.1
> > > > 
> > > > 
> > > 
> > 
> 
