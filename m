Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728EC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6033223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3Nccepv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6033223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6oc-0007ys-PF
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6ml-00060X-3W
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mi-0004mb-0n
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=igFD3/rcu7GUgCsj1upAqVDY5017xLQ8w+Z6DoKbz9Y=;
 b=W3NccepvToBOvqi6c8Rsu8D/vviejeitW7Mu+lQfJZzJjmLSbpTHpjVhPpauTVvUtcdzVw
 M5b3BrcYnAWRupHeUNtNtdFwH6YrTA/XGt+Jak/gp/Cy3rVUVnQM4VYDAMD1PyxTVmK2Km
 ff1bF0xWv55GNf6aUKwI9gAX1EoplD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-7DKOupDWMbmGXqft3XSxmA-1; Tue, 03 Nov 2020 19:36:13 -0500
X-MC-Unique: 7DKOupDWMbmGXqft3XSxmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28116876E3E
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:12 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 487296266E;
 Wed,  4 Nov 2020 00:36:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/72] python: move scripts/qmp to python/qemu/qmp
Date: Tue,  3 Nov 2020 19:34:50 -0500
Message-Id: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20201020193555.1493936-1-jsnow@redhat.com>=0D
          [PATCH v3 00/15] python: create installable package=0D
=0D
Hi! This series looks big, but don't panic. Like many python refactoring=0D
series, most of the individual patches are very tiny, isolated changes.=0D
=0D
This series depends on the details of the installable package series,=0D
so don't sweat too hard reviewing the particulars just yet, or at all.=0D
I did want to showcase the process of moving scripts INTO the python=0D
library, though, so here it is.=0D
=0D
The purpose of this series is to move ./scripts/qmp/* to=0D
./python/qemu/qmp/*.py.  To do so, we need to ensure that these files=0D
pass the various linters and code quality standards we have instituted=0D
for the python library. Doing so allows us to check these tools with the=0D
same type checking utilities that we use to enforce integrity in the=0D
base library.=0D
=0D
This way, changes to the library will cause integration tests to fail,=0D
and we can ensure the continued stability of these scripts.=0D
=0D
Nicest of all, by installing this python package to your working=0D
environment, you will now have access to 'qom-set', 'qom-get',=0D
'qmp-shell', etc no matter what your working directory is, and it will=0D
Just Work.=0D
=0D
Let's run down the list:=0D
=0D
- qom-set, qom-get, qom-tree, and qom-list are merged into a 'qom' tool.=0D
- qom-[set|get|tree|list] are still available under those names, too.=0D
- qemu-ga-client is lightly refurbished and is also now available.=0D
- qmp-shell is lightly polished and will be available.=0D
=0D
Patches 1-3: Introduce 'qom' tool, deprecate qom-[set|get|tree|list]=0D
Patches 4-16: port qom-fuse to qemu.qmp.qom tool=0D
Patches 17-27: port qemu-ga-client to qemu.qmp package=0D
Patches 28-72: port qmp-shell to qemu.qmp package=0D
=0D
Reviewer notes:=0D
=0D
- I just rewrote qom-xxx entirely, though it is based on the original=0D
  scripts. Doing it brick by brick was too slow and awkward.=0D
=0D
- I added symlinks (not in git) to the old scripts in the new location=0D
  to run the linters against the files that haven't been moved yet, and=0D
  once they're almost done (except for import problems), I move them.=0D
=0D
- After moving scripts, I add a forwarder to the new location from the=0D
  old location. The forwarders can be deleted eventually.=0D
=0D
- some scripts disappear for a commit or two before being=0D
  re-established. This helps preserve git-blame history where it=0D
  happens; it was the best I could do.=0D
=0D
John Snow (72):=0D
  python/qmp: Add qom script rewrites=0D
  python/qmp: add qom script entry points=0D
  scripts/qmp: redirect qom-xxx scripts to python/qemu/qmp/=0D
  scripts/qom-fuse: apply isort rules=0D
  scripts/qom-fuse: apply flake8 rules=0D
  python: Add 'fh' to known-good variable names=0D
  scripts/qom-fuse: Apply pylint rules=0D
  scripts/qom-fuse: Add docstrings=0D
  scripts/qom-fuse: Convert to QOMCommand=0D
  scripts/qom-fuse: use QOMCommand.qom_list()=0D
  scripts/qom-fuse: ensure QOMFuse.read always returns bytes=0D
  scripts/qom-fuse: add static type hints=0D
  scripts/qom-fuse: move to python/qemu/qmp/qom_fuse.py=0D
  scripts/qom-fuse: add redirection shim to python/qemu/qmp/qom-fuse.py=0D
  python: add fuse command to 'qom' tools=0D
  python: add optional fuse dependency=0D
  scripts/qemu-ga-client: apply isort rules=0D
  scripts/qemu-ga-client: apply (most) flake8 rules=0D
  scripts/qemu-ga-client: Fix exception handling=0D
  scripts/qemu-ga-client: replace deprecated optparse with argparse=0D
  scripts/qemu-ga-client: add module docstring=0D
  scripts/qemu-ga-client: apply (most) pylint rules=0D
  python/qmp: Correct type of QMPReturnValue=0D
  scripts/qmp/qemu-ga-client: add mypy type hints=0D
  scripts/qemu-ga-client: move to python/qemu/qmp/qemu_ga_client.py=0D
  python/qemu-ga-client: add entry point=0D
  scripts/qemu-ga-client: Add forwarder stub=0D
  scripts/qmp-shell: apply isort rules=0D
  scripts/qmp-shell: Apply flake8 rules=0D
  scripts/qmp-shell: fix show_banner signature=0D
  scripts/qmp-shell: fix exception handling=0D
  scripts/qmp-shell: fix connect method signature=0D
  scripts/qmp-shell: remove shadowed variable from _print()=0D
  scripts/qmp-shell: use @classmethod where appropriate=0D
  scripts/qmp-shell: Use python3-style super()=0D
  scripts/qmp-shell: declare verbose in __init__=0D
  scripts/qmp-shell: use triple-double-quote docstring style=0D
  scripts/qmp-shell: ignore visit_Name name=0D
  scripts/qmp-shell: make QMPCompleter returns explicit=0D
  scripts/qmp-shell: rename one and two-letter variables=0D
  scripts/qmp-shell: fix shell history exception handling=0D
  scripts/qmp-shell: explicitly chain exception context=0D
  scripts/qmp-shell: remove if-raise-else patterns=0D
  scripts/qmp-shell: use isinstance() instead of type()=0D
  scripts/qmp-shell: use argparse=0D
  python/qmp: Fix type of SocketAddrT=0D
  python/qmp: add parse_address classmethod=0D
  scripts/qmp-shell: Add pretty attribute to HMP shell=0D
  scripts/qmp-shell: Make verbose a public attribute=0D
  scripts/qmp-shell: move get_prompt() to prompt property=0D
  scripts/qmp-shell: remove prompt argument from read_exec_command=0D
  scripts/qmp-shell: move the REPL functionality into QMPShell=0D
  scripts/qmp-shell: Fix "FuzzyJSON" parser=0D
  scripts/qmp-shell: refactor QMPCompleter=0D
  scripts/qmp-shell: initialize completer early=0D
  python/qmp: add QMPObject type alias=0D
  scripts/qmp-shell: add mypy types=0D
  scripts/qmp-shell: Accept SocketAddrT instead of string=0D
  scripts/qmp-shell: unprivatize 'pretty' property=0D
  python/qmp: return generic type from context manager=0D
  scripts/qmp-shell: Use context manager instead of atexit=0D
  scripts/qmp-shell: use logging to show warnings=0D
  scripts/qmp-shell: remove TODO=0D
  scripts/qmp-shell: Fix empty-transaction invocation=0D
  scripts/qmp-shell: Remove too-broad-exception=0D
  scripts/qmp-shell: convert usage comment to docstring=0D
  scripts/qmp-shell: remove double-underscores=0D
  scripts/qmp-shell: make QMPShellError inherit QMPError=0D
  scripts/qmp-shell: add docstrings=0D
  scripts/qmp-shell: move to python/qemu/qmp/qmp_shell.py=0D
  python: add qmp-shell entry point=0D
  scripts/qmp-shell: add redirection shim=0D
=0D
 python/Pipfile.lock               |  13 +-=0D
 python/qemu/qmp/__init__.py       |  61 +++-=0D
 python/qemu/qmp/qemu_ga_client.py | 323 ++++++++++++++++++=0D
 python/qemu/qmp/qmp_shell.py      | 535 ++++++++++++++++++++++++++++++=0D
 python/qemu/qmp/qom.py            | 217 ++++++++++++=0D
 python/qemu/qmp/qom_common.py     | 153 +++++++++=0D
 python/qemu/qmp/qom_fuse.py       | 207 ++++++++++++=0D
 python/setup.cfg                  |  30 +-=0D
 scripts/qmp/qemu-ga-client        | 297 +----------------=0D
 scripts/qmp/qmp-shell             | 454 +------------------------=0D
 scripts/qmp/qom-fuse              | 144 +-------=0D
 scripts/qmp/qom-get               |  66 +---=0D
 scripts/qmp/qom-list              |  63 +---=0D
 scripts/qmp/qom-set               |  63 +---=0D
 scripts/qmp/qom-tree              |  74 +----=0D
 15 files changed, 1546 insertions(+), 1154 deletions(-)=0D
 create mode 100644 python/qemu/qmp/qemu_ga_client.py=0D
 create mode 100644 python/qemu/qmp/qmp_shell.py=0D
 create mode 100644 python/qemu/qmp/qom.py=0D
 create mode 100644 python/qemu/qmp/qom_common.py=0D
 create mode 100644 python/qemu/qmp/qom_fuse.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


