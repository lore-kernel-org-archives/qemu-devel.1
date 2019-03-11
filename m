Received: from eggs.gnu.org ([209.51.188.92]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IAB-0006H2-Uw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3Hx7-0000a0-J8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:14:38 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:54662 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3Hx7-0000Wf-7r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:14:37 -0400
Date: Mon, 11 Mar 2019 10:14:28 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v4 0/10] qemu-binfmt-conf.sh
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
  arch or a list of them.
* Option '--clear' is added, which allows to remove an already registered
  target interpreter or a list of them. The implementation is functional but
  partial. Please, see the corresponding commit.
* Option '--test|--dry-run' is added, which allows to execute the CHECK according
  to the provided arguments, but no interpreter is configured.
* Support to set options through environment variables: QEMU_TARGETS,
  QEMU_PATH, QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL, QEMU_CLEAR and
  QEMU_TEST.

The following changes are not backward compatible:

* Option '--persistent' no longer requires/accepts an argument.
* Option '--credential' no longer requires/accepts an argument.
* Option '--systemd' no longer requires/accepts an argument.
* Option '--qemu-path' is renamed to '--path'.
* Option '--qemu-suffix' is renamed to '--suffix'.

The functionality of all of them is untouched. Changes are related to syntax only.

The main differences compared to v3 are:

* Suggestions by Laurent Vivier regarding syntax and usage of redundant variables are
  addressed.
* The same presentation format as for qemu-XXXX ("Argument Env-variable Description")
  is used and defaults for envvars are shown.
* '--reset' (now '--clear') is exclusive, i.e., the list of positional arguments is used,
  and no registration function is executed.
* Commas are no longer accepted as separators for TARGETS.
* The order of some patches is reorganized and some are squashed:
  * v4 4/10 is new
  * v3 4/10 -> v4 5/10
  * v3 5/10 -> v4 6/10
  * v3 6/10 and 10/10 --> v4 7/10
  * v3 7/10 -> v4 8/10
  * v3 8/10 and v3 9/10 --> v4 9/10
  * v4 10/10 is new

Based on:

* [PATCH v3 0/10] qemu-binfmt-conf.sh
* [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)
* [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)

Regards

Unai Martinez-Corral (10):
      qemu-binfmt-conf.sh: enforce safe style consistency
      qemu-binfmt-conf.sh: make opts -p and -c boolean
      qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
      qemu-binfmt-conf.sh: use the same presentation format as for qemu-*
      qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
      qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
      qemu-binfmt-conf.sh: generalize <CPU> to positional [TARGETS]
      qemu-binfmt-conf.sh: add option --clear
      qemu-binfmt-conf.sh: update usage()
      qemu-binfmt-conf.sh: add --test|--dry-run

scripts/qemu-binfmt-conf.sh | 215
1 file changed, 78 insertions(+), 137 deletions(-)
