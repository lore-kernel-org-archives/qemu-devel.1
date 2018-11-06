Received: from eggs.gnu.org ([2001:4830:134:3::10]:46629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gK28n-0001lp-Q3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gK26c-0002Lz-81
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:13:25 -0500
Date: Tue, 6 Nov 2018 12:13:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181106141302.GP12503@habkost.net>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bd429f-198a-ee27-9184-636692332816@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Fix Python 3 detection on older GNU
 make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

The $(SHELLSTATUS) variable requires GNU make >= 4.2, but Travis
seems to provide an older version.  Change the existing rules to
use command output instead of exit code, to make it compatible
with older GNU make versions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
I think that's the cause of the Travis failures.  I have
submitted a test job right now, at:
  https://travis-ci.org/ehabkost/qemu-hacks/jobs/451387962
Let's see if it fixes the issue.
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d2e577eabb..074eece558 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -913,8 +913,8 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 # information please refer to "avocado --help".
 AVOCADO_SHOW=none
 
-$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
-ifeq ($(.SHELLSTATUS),0)
+PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
+ifeq ($(PYTHON3), 1)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 	$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
-- 
2.18.0.rc1.1.g3f1ff2140
