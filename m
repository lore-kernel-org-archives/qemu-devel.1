Received: from eggs.gnu.org ([209.51.188.92]:52656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Myu-0008Rk-0D
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Myt-00088K-53
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:12:31 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:35797 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1Mys-00085k-QN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:12:31 -0500
Date: Wed, 6 Mar 2019 03:12:21 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190306031221.GA53@03612eec87fc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v3 0/10] qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com

Hi,

This series reworks qemu-binfmt-conf.sh:

* Argument <CPU> from option '--systemd' is generalized to <TARGETS>, and it is
  accepted for any mode (default, debian or systemd). It can be a single target
  arch or a list of them. Valid separators are space, tab, newline and comma.
  Keywords 'ALL' and 'NONE' are supported.
* Option '--reset ARCHS' is added, which allows to remove an already registered
  target interpreter or a list of them. Valid separator is comma. Keyword 'ALL'
  is supported. The implementation is functional but partial. Please, see
  the corresponding commit.
* Support to set options through environment variables is added: QEMU_PATH,
  QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL and QEMU_TARGETS.

The following changes are not backward compatible:

* Option '--persistent' no longer requires/accepts an argument.
* Option '--credential' no longer requires/accepts an argument.
* Option '--systemd' no longer requires/accepts an argument.
* Option '--qemu-path' is renamed to '--path'.
* Option '--qemu-suffix' is renamed to '--suffix'.

The functionality of all of them is untouched. Changes are related to syntax only.

The main differences compared to version 2 are:

* Suggestions by Eric Blake regarding syntax and style consistency have been addressed.
* Changes are split in multiple patches, instead of a single one.
* Option names and support of environament variables is more consistent.

Based on:

* [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)
* [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)

Regards

Unai Martinez-Corral (10):
  qemu-binfmt-conf.sh: enforce safe style consistency
  qemu-binfmt-conf.sh: make opts -p and -c boolean
  qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
  qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
  qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
  qemu-binfmt-conf.sh: generalize <CPU> to positional <CPUS>
  qemu-binfmt-conf.sh: add option --reset <ARCHS>
  qemu-binfmt-conf.sh: refactor usage()
  qemu-binfmt-conf.sh: update usage()
  qemu-binfmt-conf.sh: support QEMU_TARGETS

 scripts/qemu-binfmt-conf.sh | 190
 1 file changed, 125 insertions(+), 65 deletions(-)
