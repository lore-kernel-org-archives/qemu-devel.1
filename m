Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cr3SY-0004Qn-4Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cr3SX-0005pf-2A
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:11:26 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1cr3SW-0005pR-QM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:11:24 -0400
Received: by mail-ua0-x22d.google.com with SMTP id u30so94966422uau.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 07:11:24 -0700 (PDT)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Thu, 23 Mar 2017 10:11:23 -0400
Message-ID: <CAF++6APQ=H6=-BmE=wJHzibKLcAGbP75FLOPJP3vX3kdeww+5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] .PO files modified under build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

I have a git clone of qemu, and I build out of qemu-build...  essentially
the layout looks like:
./
  ./qemu/ -> clone of qemu
  ./qemu-build/
  ./Makefile

The contents of the top level Makefile contain the following rules:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call
rwildcard,$d/,$2))
files   := $(call rwildcard,qemu/,*.[ch])

.PHONY: clean_orphan_artifacts
clean_orphan_artifacts: $(note update)
        $(Q)                            \
        $(GIT_VERBOSE)  ;               \
        cd qemu &&                      \
        git clean -f -d -X
                $(call trace,GIT CLEAN)

qemu-build: qemu $(files) clean_orphan_artifacts
        $(Q)    \
        mkdir -p $(@)                   &&      \
        cd $(@)                         &&      \
        ../qemu/configure                       \
                --prefix=$(current_path)/local  \
                --target-list=arm-softmmu       \
                --disable-werror        &&      \
        $(MAKE)                         &&      \
        $(MAKE) install                         \
        $(call trace,BUILD)

It seems that somehow the .po files are being modified under the qemu repo
even though the entire build is out of ./qemu-build.

The two questions are:
   Should the .po files be modified under the qemu path when building out
of another (ie qemu-build)?
   Should the .po files continue to be versioned or placed in .gitignore if
they are (apparently) generated?
