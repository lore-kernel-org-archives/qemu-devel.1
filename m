Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e41YM-0005WY-Rj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e41YJ-0005q4-Ln
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e41YJ-0005pZ-FW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 931207F756
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 09:19:14 +0000 (UTC)
Message-ID: <1508145553.15782.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 16 Oct 2017 11:19:13 +0200
In-Reply-To: <20171013095724.GE20515@redhat.com>
References: <20171013081450.29647-1-kraxel@redhat.com>
	<20171013095724.GE20515@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171013 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> I'm afraid this is quite likely to fail build smoke test again. I've
> just tried a build on OpenBSD with the bash -> sh fix in it, and I
> found that it still tried to build the keycodemap files in parallel
> with checking out the GIT submodules. It also tried to run the
> mkdir -p dtc/libfdt in parallel and this caused git to refuse to
> checkout the dtc module due to that empty dir existing. So there's
> still some deps problems in here I think that let make build in
> the wrong order :-(

> In all my debugging the one thing I've seen work correctly is the
> re-running of configure (via config.status), which always happens
> earlier and is serialized wrt everything else. So I wonder if we
> should change direction slightly, and have configure checkout the
> submodules. Then just make sure that config.status is triggered
> when submodules are out of date.

I've noticed configure running *in parallel* to other stuff.=20
Reproducer:

  (1) Apply patch #1
  (2) run normal build
  (3) make -C dtc clean
  (4) touch configure
  (5) make

Watch configure and dtc build running in parallel.
I think the added Makefile dependency breaks it.

Incremental fix (also pushed to queue/ui):

--- a/Makefile
+++ b/Makefile
@@ -35,8 +35,6 @@ endif
=C2=A0
=C2=A0.git-submodule-status: git-submodule-update config-host.mak
=C2=A0
-Makefile: .git-submodule-status
-
=C2=A0# Check that we're not trying to do an out-of-tree build from
=C2=A0# a tree that's been used for an in-tree build.
=C2=A0ifneq ($(realpath $(SRC_PATH)),$(realpath .))
@@ -107,6 +105,7 @@ endif
=C2=A0GENERATED_FILES +=3D $(TRACE_HEADERS)
=C2=A0GENERATED_FILES +=3D $(TRACE_SOURCES)
=C2=A0GENERATED_FILES +=3D $(BUILD_DIR)/trace-events-all
+GENERATED_FILES +=3D .git-submodule-status
=C2=A0
=C2=A0trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/=
g')

cheers,
  Gerd
