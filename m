Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrIA-0001If-46
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrI4-0007DM-Ga
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxrI4-0007Cg-7O
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:00 -0400
Date: Fri, 29 Sep 2017 10:08:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929090850.GE6803@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-2-berrange@redhat.com>
	<3b48e116-7d88-4df0-05c3-7e45754db347@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b48e116-7d88-4df0-05c3-7e45754db347@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 12:58:32PM -0500, Eric Blake wrote:
> On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> > Currently if DTC is required by configure and not available in the host
> > OS install, we exit with an error message telling the user to checkout a
> > git submodule or install the library.
> > 
> > This introduces automatic handling of the git submodule checkout process
> > and enables it for dtc. This only runs if building from GIT, so users of
> > release tarballs still need the system library install. The current state
> > of the git checkout is stashed in .git-submodule-status, and a helper
> > program is used to determine if this state matches the desired submodule
> > state. A dependency against 'Makefile' ensures that the submodule state
> > is refreshed at the start of the build process
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  .gitignore               |  1 +
> >  Makefile                 | 23 ++++++++++++++++++++++-
> >  configure                | 46 ++++++++++++++++++++++++++--------------------
> >  scripts/git-submodule.sh | 31 +++++++++++++++++++++++++++++++
> >  4 files changed, 80 insertions(+), 21 deletions(-)
> >  create mode 100755 scripts/git-submodule.sh
> > 
> 
> > +++ b/Makefile
> > @@ -14,6 +14,27 @@ ifneq ($(wildcard config-host.mak),)
> >  all:
> >  include config-host.mak
> >  
> > +git-submodule-update:
> > +
> > +.PHONY: git-submodule-update
> > +
> > +ifeq (0,$(MAKELEVEL))
> > +  git_module_status := $(shell \
> > +    cd '$(SRC_PATH)'; \
> 
> Should this be && instead of ;, since I don't know if $(shell) implies
> 'set -e' semantics?

I don't know either, so lets just use &&


> > +++ b/configure
> > @@ -264,6 +264,7 @@ cc_i386=i386-pc-linux-gnu-gcc
> >  libs_qga=""
> >  debug_info="yes"
> >  stack_protector=""
> > +git_submodules=""
> >  
> >  # Don't accept a target_list environment variable.
> >  unset target_list
> > @@ -3580,27 +3581,30 @@ EOF
> >    if compile_prog "" "$fdt_libs" ; then
> >      # system DTC is good - use it
> >      fdt=yes
> > -  elif test -d ${source_path}/dtc/libfdt ; then
> ...
> > -       symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> 
> Old code is inconsistent on whether it quotes the expansion of
> $source_path.  Given the unquoted usage, we don't support a $source_path
> that contains spaces; however...
> 
> > +      # have GIT checkout, so activate dtc submodule
> > +      if test -d ${source_path}/.git ; then
> 
> ...we might as well consistently use quotes in all new code, especially,
> since it is already a red flag any time someone does unquoted test -d $foo.

Ok, I'll quote everything

> 
> > +	  git_submodules="${git_submodules} dtc"
> > +      fi
> > +      if test -d ${source_path}/dtc/libfdt || test -d ${source_path}/.git ; then
> 
> and again
> 
> .git is not always a directory; it can be a symlink or text file
> containing a directory name.  It is probably sufficient to just use test
> -e instead of test -d.

Yep, I'll use -e

> > +	  # have neither and want - prompt for system/submodule install
> > +	  error_exit "DTC (libfdt) version >= 1.4.2 not present." \
> > +		     "Please install the DTC (libfdt) devel package"
> 
> Is the comment accurate, given that the error message doesn't mention a
> submodule?

I'll fix the comment

> > +++ b/scripts/git-submodule.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/bash
> > +
> > +set -e
> 
> 'set -e' is notoriously awkward to work with, especially if your shell
> script includes functions.  Do we really need it, or can we do proper
> error checking in place?

IMHO using -e leads to simpler code and we've no functions that would
trip it up, so its OK.

> > +
> > +command=$1
> > +shift
> > +modules="$@"
> > +
> > +test -z "$modules" && exit 0
> > +
> > +if ! test -d ".git"
> 
> Again, .git doesn't necessarily have to be a directory; test -e may be
> better.

Yep

> > +then
> > +    echo "$0: unexpectedly called with submodules but no git checkout exists"
> > +    exit 1
> > +fi
> > +
> > +substat=".git-submodule-status"
> > +
> > +case "$command" in
> > +status)
> > +    test -f "$substat" || exit 1
> > +    git submodule status $modules > "${substat}.tmp"
> 
> This is one place where if 'set -e' is not in effect, you need to decide
> if failure to run the command should cause early exit.
> 
> > +    trap "rm -f ${substat}.tmp" EXIT
> 
> Don't you want the trap installed one line earlier, before you create
> the file?

Opps, yes

> > +    diff "${substat}" "${substat}.tmp" >/dev/null
> > +    exit $?
> > +    ;;
> > +update)
> > +    git submodule update --init $modules 1>/dev/null 2>&1
> > +    git submodule status $modules > "${substat}"
> > +    ;;
> > +esac


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
