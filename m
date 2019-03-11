Received: from eggs.gnu.org ([209.51.188.92]:52759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Udl-0006TW-VH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uc8-0006ME-Gr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:45:50 -0400
Date: Mon, 11 Mar 2019 19:45:35 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190311234535.oaejcgcewgcof7ql@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-7-crosa@redhat.com>
	<20190301113227.04f1f128.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301113227.04f1f128.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/20] Acceptance tests: use "arch:" tag
 to filter target specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, Mar 01, 2019 at 11:32:27AM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 19:57:39 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
> > Currently, the only test that contains some target architecture
> > information is "boot_linux_console.py" which test contains a "x86_64"
> 
> But there are two others changed by you here, aren't there?
>

Yes, the "only test" is now outdated.  Fixing it.

> > tag.  But that tag is not respected in the default execution, that is,
> > "make check-acceptance" doesn't do anything with it.
> > 
> > That said, even the target architecture handling currently present in
> > the "avocado_qemu.Test" class, class is pretty limited.  For instance,
> 
> s/class, class/class/

You are so good at proof reading! Kudos!

> 
> > by default, it chooses a target based on the host architecture.
> > 
> > Because the original implementation of the tags feature in Avocado did
> > not include any time of namespace or "key:val" mechanism, no tag has
> > relation to another tag.  The new implementation of the tags feature
> > from version 67.0 onwards, allows "key:val" tags, and because of that,
> > a test can be classified with a tag in a given key.  For instance, the
> > new proposed version of the "boot_linux_console.py" test, which
> > downloads and attempts to run a x86_64 kernel, is now tagged as:
> > 
> >   :avocado: tags=arch:x86_64
> > 
> > This means that it can be filtered (out) when no x86_64 target is
> > available.  At the same time, tests that don't have a "arch:" tag,
> > will not be filtered out.
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/Makefile.include                 | 3 +++
> >  tests/acceptance/boot_linux_console.py | 2 +-
> >  tests/acceptance/linux_initrd.py       | 2 +-
> >  tests/acceptance/virtio_version.py     | 2 +-
> >  tests/requirements.txt                 | 2 +-
> >  5 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 93ea42553e..633992603d 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -1090,6 +1090,7 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
> >  # Any number of command separated loggers are accepted.  For more
> >  # information please refer to "avocado --help".
> >  AVOCADO_SHOW=app
> > +AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_DIRS)))
> >  
> >  ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> >  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> > @@ -1115,6 +1116,8 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> >  	$(call quiet-command, \
> >              $(TESTS_VENV_DIR)/bin/python -m avocado \
> >              --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
> > +            --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
> > +            $(AVOCADO_TAGS) \
> >              --failfast=on $(SRC_PATH)/tests/acceptance, \
> >              "AVOCADO", "tests/acceptance")
> >  
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> > index 98324f7591..46b20bdfe2 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
> >      and the kernel command line is properly passed from QEMU to the kernel
> >  
> >      :avocado: enable
> > -    :avocado: tags=x86_64
> > +    :avocado: tags=arch:x86_64
> >      """
> >  
> >      timeout = 60
> > diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> > index 737355c2ef..c75e29be70 100644
> > --- a/tests/acceptance/linux_initrd.py
> > +++ b/tests/acceptance/linux_initrd.py
> > @@ -19,7 +19,7 @@ class LinuxInitrd(Test):
> >      Checks QEMU evaluates correctly the initrd file passed as -initrd option.
> >  
> >      :avocado: enable
> > -    :avocado: tags=x86_64
> > +    :avocado: tags=arch:x86_64
> >      """
> >  
> >      timeout = 60
> > diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> > index ce990250d8..3b280e7fc3 100644
> > --- a/tests/acceptance/virtio_version.py
> > +++ b/tests/acceptance/virtio_version.py
> > @@ -62,7 +62,7 @@ class VirtioVersionCheck(Test):
> >      `disable-legacy`.
> >  
> >      :avocado: enable
> > -    :avocado: tags=x86_64
> > +    :avocado: tags=arch:x86_64
> >      """
> >  
> >      # just in case there are failures, show larger diff:
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index 64c6e27a94..002ded6a22 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -1,4 +1,4 @@
> >  # Add Python module requirements, one per line, to be installed
> >  # in the tests/venv Python virtual environment. For more info,
> >  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > -avocado-framework==65.0
> > +avocado-framework==68.0
> 
> I think you should explain why you bump the required version to 68.0
> instead of the 67.0 you mention above.

Actually, this bit will be removed in the rebase, because other commit
(9531d26c106) already merged did that for other reason.  So, it looks
like the explanation of the needed feature being present in 67.0 (and
later) is adequate.

Thanks,
- Cleber.
