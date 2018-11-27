Received: from eggs.gnu.org ([2001:4830:134:3::10]:42985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRjMN-0000lN-8H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRjMM-0003Zp-3Y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:49:27 -0500
Date: Tue, 27 Nov 2018 17:49:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127194908.GR18284@habkost.net>
References: <20181127105034.21045-1-crosa@redhat.com>
	<20181127190006.GC22880@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127190006.GC22880@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH] Introduce Python module structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Nov 27, 2018 at 05:00:07PM -0200, Caio Carrara wrote:
> Hi, Cleber.
> 
> On Tue, Nov 27, 2018 at 05:50:34AM -0500, Cleber Rosa wrote:
> > This is a simple move of Python code that wraps common QEMU
> > functionality, and are used by a number of different tests
> > and scripts.
> > 
> > By treating that code as a real Python module, we can more easily,
> > among other things:
> >  * reuse more code
> >  * apply a more consistent style
> >  * add tests to that code
> >  * generate documentation
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  configure                                  |  1 +
> >  scripts/qemu.py => python/qemu/__init__.py | 11 ++++++-----
> 
> Well, we all know how difficult is to pick up names, but I would avoid
> use `python` here. This is the name of python bin itself. Is there any
> chance of a clash? I do not have a specific case right now, I'm just
> wondering if it can happen we should avoid.

I'm don't see how it would be a problem: this won't be the name
of a Python module, but just a directory to appear on sys.path.


> 
> >  {scripts/qmp => python/qemu}/qmp.py        |  0
> >  {scripts => python/qemu}/qtest.py          |  5 +++--
> >  scripts/device-crash-test                  |  5 +++++
> >  scripts/qmp/__init__.py                    |  0
> >  tests/acceptance/avocado_qemu/__init__.py  |  9 +++++----
> >  tests/migration/guestperf/engine.py        | 10 +++++++---
> >  tests/qemu-iotests/iotests.py              |  8 ++++++--
> >  tests/vm/basevm.py                         |  9 +++++++--
> >  10 files changed, 40 insertions(+), 18 deletions(-)
> >  rename scripts/qemu.py => python/qemu/__init__.py (98%)
> >  rename {scripts/qmp => python/qemu}/qmp.py (100%)
> >  rename {scripts => python/qemu}/qtest.py (97%)
> 
> What if we keep `qmp.py` and `qtest.py` directly under `/python`
> directory?  It seems it can be more semantic regarding the subject of
> each module. I'm not completely sure about `qmp.py`, but definetly I
> think qtest should be under python directly.

I'd prefer to have everything inside a "qemu" top-level package
to avoid module namespace conflicts with other software.


> 
> >  delete mode 100644 scripts/qmp/__init__.py
> > 
> > diff --git a/configure b/configure
> > index 0a3c6a72c3..2b64c51009 100755
> [...]
> > rename from scripts/qemu.py
> > rename to python/qemu/__init__.py
> [...]
> > diff --git a/scripts/qmp/qmp.py b/python/qemu/qmp.py
> > similarity index 100%
> > rename from scripts/qmp/qmp.py
> > rename to python/qemu/qmp.py
> > diff --git a/scripts/qtest.py b/python/qemu/qtest.py
> > similarity index 97%
> > rename from scripts/qtest.py
> > rename to python/qemu/qtest.py
> > index adf1fe3f26..bff79cdd13 100644
> > --- a/scripts/qtest.py
> > +++ b/python/qemu/qtest.py
> [...]
> > diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> > index e93a7c0c84..c75ae0ecbc 100755
> > --- a/scripts/device-crash-test
> > +++ b/scripts/device-crash-test
> > @@ -35,6 +35,11 @@ import random
> >  import argparse
> >  from itertools import chain
> >  
> > +THIS_DIR = os.path.dirname(os.path.abspath(__file__))
> > +TOP_DIR = os.path.dirname(THIS_DIR)
> > +PYTHON_MODULE_PATH = os.path.join(TOP_DIR, 'python')
> > +sys.path.append(PYTHON_MODULE_PATH)

I would prefer to use pathlib:

  from pathlib import Path
  sys.path.append(str(Path(__file__).parent / '..' / 'python'))

but pathlib is not available on Python 2, so we could at least
avoid using dirname(dirname(abspath(...))) and use '..' instead:

  MY_DIR = os.path.dirname(__file__)
  sys.path.append(os.path.join(MY_DIR, '..', 'python'))


> 
> This sys.path handling to use the new QEMU Python module is not good. I
> understand it can be a first step, but to expect everyone knows/do it to
> use the module is a bad assumption because it's not intuitive and can
> cause some confusion.
> 
> If we need something available from a Python script/module that is not
> directly acessible from PYTHONPATH we should install it so Python can
> turn it available. So, probably we need to think make `python/qemu` a
> proper installable module.

Avoiding the sys.path trick would be nice, but how can we do that
while keeping scripts still working out of the box?  In other
words, how can we keep this working:

  $ git clone https://.../qemu.git
  $ cd qemu
  $ ./scripts/qmp-shell /path/to/qmp-socket


> 
> > +
> >  from qemu import QEMUMachine
> >  
> >  logger = logging.getLogger('device-crash-test')
> > diff --git a/scripts/qmp/__init__.py b/scripts/qmp/__init__.py
> > deleted file mode 100644
> [...]
> > diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
> > index 398e3f2706..73c9b66821 100644
> > --- a/tests/migration/guestperf/engine.py
> > +++ b/tests/migration/guestperf/engine.py
> > @@ -24,13 +24,17 @@ import re
> >  import sys
> >  import time
> >  
> > -sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '..', 'scripts'))
> > -import qemu
> > -import qmp.qmp
> >  from guestperf.progress import Progress, ProgressStats
> >  from guestperf.report import Report
> >  from guestperf.timings import TimingRecord, Timings
> >  
> > +THIS_DIR = os.path.dirname(os.path.abspath(__file__))
> > +TOP_DIR = os.path.dirname(os.path.dirname(os.path.dirname(THIS_DIR)))
> > +PYTHON_MODULE_PATH = os.path.join(TOP_DIR, 'python')
> > +sys.path.append(PYTHON_MODULE_PATH)
> > +
> > +import qemu
> 
> Since `qemu` is a common word here, I would rather import the members
> directly than only the module. Just like you did in
> `/tests/vm/basevm,py`

I don't disagree, but I would prefer to do this in a separate
patch, to make review easier.

> 
> > +
> >  
> >  class Engine(object):
> >  
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index d537538ba0..92fddd2a58 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -31,8 +31,12 @@ import logging
> [...]
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -17,8 +17,6 @@ import sys
> >  import logging
> >  import time
> >  import datetime
> > -sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
> > -from qemu import QEMUMachine, kvm_available
> >  import subprocess
> >  import hashlib
> >  import optparse
> > @@ -28,6 +26,13 @@ import shutil
> >  import multiprocessing
> >  import traceback
> >  
> > +THIS_DIR = os.path.dirname(os.path.abspath(__file__))
> > +TOP_DIR = os.path.dirname(os.path.dirname(THIS_DIR))
> > +PYTHON_MODULE_PATH = os.path.join(TOP_DIR, 'python')
> > +sys.path.append(PYTHON_MODULE_PATH)

Same as above, I would prefer:

  MY_DIR = os.path.dirname(__file__)
  sys.path.append(os.path.join(MY_DIR, '..', '..', 'python'))

> > +
> > +from qemu import QEMUMachine, kvm_available
> > +
> >  SSH_KEY = open(os.path.join(os.path.dirname(__file__),
> >                 "..", "keys", "id_rsa")).read()
> >  SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
> > -- 
> > 2.19.1
> > 
> 
> Thanks,
> -- 
> Caio Carrara
> Software Engineer, Virt Team - Red Hat
> ccarrara@redhat.com

-- 
Eduardo
