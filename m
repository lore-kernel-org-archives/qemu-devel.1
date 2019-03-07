Received: from eggs.gnu.org ([209.51.188.92]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1i1V-0007P6-Pg
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1i1U-0005Tu-SM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:40:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1i1U-0005Sv-LH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:40:36 -0500
Date: Wed, 6 Mar 2019 20:40:28 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305172139.32662-9-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] docs: Provide separate conf.py
 for each manual we want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Tue, Mar 05, 2019 at 05:21:35PM +0000, Peter Maydell wrote:
> By default Sphinx wants to build a single manual at once.
> For QEMU, this doesn't suit us, because we want to have
> separate manuals for "Developer's Guide", "User Manual",
> and so on, and we don't want to ship the Developer's Guide
> to end-users. However, we don't want to completely duplicate
> conf.py for each manual, and we'd like to continue to
> support "build all docs in one run" for third-party sites
> like readthedocs.org.
> 
> Make the top-level conf.py support two usage forms:
>  (1) as a common config file which is included by the conf.py
>  for each of QEMU's manuals: in this case sphinx-build is run
>  multiple times, once per subdirectory.
>  (2) as a top level conf file which will result in building all
>  the manuals into a single document: in this case sphinx-build is
>  run once, on the top-level docs directory.
> 
> Provide per-manual conf.py files and top level pages for
> our first two manuals:
>  * QEMU Developer's Guide (docs/devel)
>  * QEMU System Emulation Management and Interoperability Guide
>    (docs/interop)
>

I have the impression that this can be simplified by making use of
"only" tags:

https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-only

So, conf.py could detect if it's being run on readthedocs.org:

  ON_RTD = os.environ.get('READTHEDOCS', None) == 'True'

And manipulate the "tags" variable accordingly:

  if ON_RTD:
     tags.add('devel')
     tags.add('interop')

Then, on an index.rst, it could be a simple matter of:

.. only:: devel
================
Developers Guide
================
.. toctree::
   docs/devel

.. only:: interop
=============
Interop Guide
=============
.. toctree::
   docs/interop

.. only:: devel and interop
===============
QEMU Full Guide
===============
.. toctree::
   docs/devel
   docs/interop

Or some alternative layout.  Please beware that I haven't performed a
full examination of that (or similar) approach.

If that doesn't work, I'd consider having a top level "common.py",
whose contents are imported by the various "conf.py", instead of
exec()'d.  That I've tried, and a simple:

  from common import *
  release = 'overridden_value'

Works as expected and is respected by sphinx.

- Cleber.
