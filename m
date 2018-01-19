Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaBA-00049E-2U
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaB6-0006DL-1n
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecaB5-0006Cr-P8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:10:07 -0500
Date: Fri, 19 Jan 2018 15:09:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119170954.GA15832@localhost.localdomain>
References: <20180116134217.8725-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/14] Support building with py2 or py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


On Tue, Jan 16, 2018 at 01:42:03PM +0000, Daniel P. Berrange wrote:
> This is an update for my previously posted series:
> 
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06528.html
>  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02978.html
>  v4: https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03150.html
> 
> This series enables some level of CI testing for py3 so that our CI jobs will
> get coverage of both py2 and py3 builds to avoid bitrot.
> 

I'm queueing this on python-next.  Thanks!



> I did a test travis build with py 3.0 and py 3.6 and got success:
> 
>   https://travis-ci.org/berrange/qemu/builds/328223261
> 
> The goal was to achieve the following
> 
>   ./configure --python=/usr/bin/python3
>   make
>   make check
> 
> This still requires passing python path to configure explicitly. A
> further improvement would be for configure to automatically detect
> a pythjon 3 binary and use it preferentially to python 2.
> 
> I have not attempted to fix/validate the block I/O tests. I would expect
> them to be broken, but easily fixable with the similar kind of scope
> changes as seen here. I felt it better to tackle that separately to
> avoid this initial series getting too large.
> 
> Although the Python 2 EOL date is 2020, we already have distros which
> are not shipping Python 2 by default (Fedora >= 26 has dropped Py2 from
> the default install). Any new releases of long life and/or enterprise
> distros may well not ship Python 2 given that it would go EOL long
> before the EOL of the distro itself. IOW QEMU does have a fairly pressing
> need to be able to support Python 3 for building.
> 
> A request for py3 is tracked here:
> 
>    https://bugs.launchpad.net/qemu/+bug/1708462
> 
> If, rather than supporting py2+py3 in parallel, we wish to entirely drop
> py2 support, this series would not change significantly
> 
>  - The "from __future__ import print_function" line can be removed
>    from patch 1.
>  - The code in patches 2, 3, 4 to deal with changed module names
>    for a few functions can be simpified to only try the py3 location
>  - The travis + docker jobs would be fully updated to install py3,
>    or delete jobs which can't support py3
> 
> Given how little code is removed should we drop py2 support, I don't
> believe it is in our immediate interests to do this. It would create
> extra pain for consumers of QEMU, with little benefit to QEMU code
> maintainance. The key thing is ensuring our travis+docker jobs provide
> satisfactory automated test coverage for the variety of python versions
> in the distros we care about targetting.
> 
> NB, Patch 11 here is not related to python 3 work - it was just a
> temporary pre-requisite of pulling in the keycodemapdb update.
> 
> Changes since v4:
> 
>  - Fix broken rebase which accidentally squashed first two
>    patches together
>  - Unset LC_ALL, and set LANG + LC_CTYPE, instead of only LANG (Eric)
> 
> Changes since v3:
> 
>  - Remove space before '(' in print() function calls (Phillippe)
>  - Force use of en_US.UTF-8 for QAPI code generation (Patchew)
> 
> Changes since v2:
> 
>  - Pull in fix for keycodemapdb
>  - Enable testing with Travis
>  - Enable testing with Fedora Docker images
>  - Fix for sort ordering to fix 'make check-qapi-schema'
>  - Fix for signrom data
> 
> Daniel P. Berrange (13):
>   qapi: convert to use python print function instead of statement
>   qapi: use items()/values() intead of iteritems()/itervalues()
>   qapi: Use OrderedDict from standard library if available
>   qapi: adapt to moved location of StringIO module in py3
>   qapi: Adapt to moved location of 'maketrans' function in py3
>   qapi: remove '-q' arg to diff when comparing QAPI output
>   qapi: ensure stable sort ordering when checking QAPI entities
>   qapi: force a UTF-8 locale for running Python
>   scripts: ensure signrom treats data as bytes
>   configure: allow use of python 3
>   ui: update keycodemapdb to get py3 fixes
>   travis: improve python version test coverage
>   docker: change Fedora images to run with python3
> 
> Miika S (1):
>   input: add missing JIS keys to virtio input
> 
>  .travis.yml                            | 14 +++++++----
>  Makefile                               | 22 +++++++++--------
>  configure                              |  5 ++--
>  hw/input/virtio-input-hid.c            |  7 ++++++
>  qapi/ui.json                           |  5 +++-
>  scripts/qapi.py                        | 43 ++++++++++++++++++++--------------
>  scripts/qapi2texi.py                   | 11 +++++----
>  scripts/signrom.py                     |  4 ++--
>  tests/Makefile.include                 |  6 ++---
>  tests/docker/dockerfiles/fedora.docker |  3 ++-
>  tests/qapi-schema/test-qapi.py         | 43 +++++++++++++++++-----------------
>  ui/keycodemapdb                        |  2 +-
>  12 files changed, 96 insertions(+), 69 deletions(-)
> 
> -- 
> 2.14.3
> 
> 

-- 
Eduardo
