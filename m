Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKoKR-0005Yi-Pc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKoKQ-0000NG-GM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:06:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKoKQ-0000Mq-7M
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:06:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 16:54:47 +0100
Message-Id: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Automate coverity scan uploads via Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This patchset automates our uploads to the coverity scan service
by making them a travis build job. I wrote this code because I
kept finding that our Coverity build was days or weeks behind
master, so it seemed worth automating. We could do this via something
other than Travis (some of the notes below discuss issues with
doing it this way) but I do think we should be doing this
automatically rather than ad-hoc, and patch 2 at least is
probably a useful part of any automation we want to do.


Patch 1 is a preliminary that improves the set of code that Travis
builds by adding some -dev packages to the set of installs. (There's
a limit to the improvement possible because the base machine is
Ubuntu Precise or Trusty, and some of our dependencies need versions
that are closer to the bleeding edge than those distros provide.)

Patch 2 is a shell script which automates the process of
downloading the coverity build tools, running the local build
and uploading it to the scan server. To be able to run the script
and upload a build you need a secret token which only people with
coverity scan project admin access have.

Patch 3 changes the travis config to run the script. We use
Travis's ability to have encrypted config to pass the secret token
to the script without exposing it to the world.


Notes:

(1) There is an official Coverity/Travis integration, but I haven't
used it, because it's awkwardly inflexible (no option for "don't
actually upload" to use when debugging, for instance) and no use
if you want to do a local Coverity build. The official integration
does basically the same thing that this local script does, but
in a weird two part way with some code in a Travis "addon"
 https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/addons/coverity_scan.rb
which downloads a shell script:
 https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh
which does the work.

(2) The job is quite close to the travis 50 minute timeout limit :-(
This might just be Travis running slow today, though -- one of our
normal builds hit the same timeout just now.

(3) There is an upload limit on the server side of one build a day.
The travis changes here make no attempt to rate limit, but rely
on the server side doing it. (If the server says "no upload permitted"
then we don't attempt to do the build phase.) We see if we can do
an upload for every commit to master. This seems fine to me, but if
the server changes its limits we might want to rethink. The simplest
way to impose a travis-side rate limit seems to be to have the travis
integration only run on a particular branch name (eg "coverity-scan")
and have a cron job push master to that branch periodically.

(4) Because Travis worker hosts are running Ubuntu Trusty some of
the code we were previously scanning is no longer scanned
because configure won't build it due to too-old dependencies.
Notable casualties are iscsi, gluster, rdma and qxl.
One way to work around this might be to have a docker container
set up with the desired config for running the scan, and then have
Travis use that docker container. (Wanting to possibly do something
like this is another reason to roll our own script rather than
using the official travis/coverity integration.)

(5) We could in theory run the builds on something other than
travis but it wasn't clear to me that we had any suitable machines
set up in the project currently. Travis has the advantage that
somebody else is doing the admin and providing the hardware :-)

(6) It would be nice to be able to automatically update the
Coverity Scan server's model file and the regexes defining
components, but that doesn't seem to be conveniently doable.

thanks
-- PMM


Peter Maydell (3):
  travis: install more library dependencies
  scripts/run-coverity-scan: Script to run Coverity Scan build
  travis: Add config to do a Coverity Scan upload

 .travis.yml               |  42 ++++++++++++
 scripts/run-coverity-scan | 170 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100755 scripts/run-coverity-scan

-- 
2.7.4
