Received: from eggs.gnu.org ([2001:4830:134:3::10]:44842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crNra-0008IU-Sc
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crNrX-0006FT-Pb
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1crNrX-0006E2-Jt
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:58:35 -0400
Date: Fri, 24 Mar 2017 11:58:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170324115830.GC16047@work-vm>
References: <CAF++6APQ=H6=-BmE=wJHzibKLcAGbP75FLOPJP3vX3kdeww+5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF++6APQ=H6=-BmE=wJHzibKLcAGbP75FLOPJP3vX3kdeww+5Q@mail.gmail.com>
Subject: Re: [Qemu-devel] .PO files modified under build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hanley <jhanley@dgtlrift.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

* James Hanley (jhanley@dgtlrift.com) wrote:
> I have a git clone of qemu, and I build out of qemu-build...  essentially
> the layout looks like:
> ./
>   ./qemu/ -> clone of qemu
>   ./qemu-build/
>   ./Makefile
> 
> The contents of the top level Makefile contain the following rules:
> rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call
> rwildcard,$d/,$2))
> files   := $(call rwildcard,qemu/,*.[ch])
> 
> .PHONY: clean_orphan_artifacts
> clean_orphan_artifacts: $(note update)
>         $(Q)                            \
>         $(GIT_VERBOSE)  ;               \
>         cd qemu &&                      \
>         git clean -f -d -X
>                 $(call trace,GIT CLEAN)
> 
> qemu-build: qemu $(files) clean_orphan_artifacts
>         $(Q)    \
>         mkdir -p $(@)                   &&      \
>         cd $(@)                         &&      \
>         ../qemu/configure                       \
>                 --prefix=$(current_path)/local  \
>                 --target-list=arm-softmmu       \
>                 --disable-werror        &&      \
>         $(MAKE)                         &&      \
>         $(MAKE) install                         \
>         $(call trace,BUILD)
> 
> It seems that somehow the .po files are being modified under the qemu repo
> even though the entire build is out of ./qemu-build.
> 
> The two questions are:
>    Should the .po files be modified under the qemu path when building out
> of another (ie qemu-build)?
>    Should the .po files continue to be versioned or placed in .gitignore if
> they are (apparently) generated?

It's a known problem we've had for ages, and IMHO really needs fixing.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
