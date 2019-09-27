Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89062146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89062146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmsJ-0000gd-UF
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmm6-0002yx-IN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmm3-0007Ev-UV
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmly-00072d-Pt; Fri, 27 Sep 2019 05:42:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ACC911A07;
 Fri, 27 Sep 2019 09:42:45 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBBA8608C2;
 Fri, 27 Sep 2019 09:42:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/18] iotests: Allow ./check -o data_file
Date: Fri, 27 Sep 2019 11:42:24 +0200
Message-Id: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 27 Sep 2019 09:42:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

It=E2=80=99s my understanding that we want better test coverage for qcow2=
=E2=80=99s
external data files.  I think the natural thing to do is to let all
tests create images with external data files.

We already have the -o option for ./check for additional image options
(and I regularly use it for recount_bits=3D1 and compat=3D0.10).
Unfortunately, we cannot use it directly for data_file, because of
course every test image needs its own data file.  What I think we want
is a pattern: Something like -o 'data_file=3D$TEST_IMG.data_file', and
then =E2=80=9C$TEST_IMG=E2=80=9D is replaced by the qcow2 image name.

This is done by the final patch in this series.  There is a lot of
preparatory work to be done, though.

(1) Some tests overwrite IMGOPTS.  This will make them ignore
    user-specified options.  That was always a problem (that means those
    tests ignored my pleas for refcount_bits=3D1 and compat=3D0.10) but
    someone needs to fix this at some point, and I guess that=E2=80=99s m=
e right
    now.
    So we need to stop tests from overwriting IMGOPTS.  This is done by
    patches 1 through 9.

    In addition, patch 10 fixes other cases where user-specified options
    are ignored (because some tests use qemu-img create directly instead
    of _make_test_img).

(2) Some tests access image files directly.  This can only work for
    images without external data files.  There are two subcases:
    (A) rm: Fixed by patch 11
    (B) cp/mv: Fixed by patch 12

(3) Some tests are broken with data_file, but we can fix it.  Done by
    patches 13 through 16.

(4) Some tests are broken with data_file, and I don=E2=80=99t think we ca=
n fix
    it.  So patch 17 adds _unsupported_imgopts data_file for them.

(5) And then there=E2=80=99s patch 18, which does what we really want.


Future work:
- Python tests currently completely ignore IMGOPTS.  Preexisting
  problem, needs to be addressed in another series, but for the moment
  it at least means they won=E2=80=99t break if you run the tests with
  data_file.

- data_file_raw=3Don needs to be addressed in another series.  I suspect
  this will mainly consist of making it unsupported in all tests that
  use backing files.


Max Reitz (18):
  iotests: Filter refcount_order in 036
  iotests: Replace IMGOPTS by _unsupported_imgopts
  iotests: Drop compat=3D1.1 in 050
  iotests: Let _make_test_img parse its parameters
  iotests: Add -o and --no-opts to _make_test_img
  iotests: Inject space into -ocompat=3D0.10 in 051
  iotests: Replace IMGOPTS=3D by -o
  iotests: Replace IMGOPTS=3D'' by --no-opts
  iotests: Drop IMGOPTS use in 267
  iotests: Avoid qemu-img create
  iotests: Use _rm_test_img for deleting test images
  iotests: Avoid cp/mv of test images
  iotests: Make 091 work with data_file
  iotests: Make 110 work with data_file
  iotests: Make 137 work with data_file
  iotests: Make 198 work with data_file
  iotests: Disable data_file where it cannot be used
  iotests: Allow check -o data_file

 tests/qemu-iotests/005           |  2 +-
 tests/qemu-iotests/007           |  5 +--
 tests/qemu-iotests/014           |  2 ++
 tests/qemu-iotests/015           |  5 +--
 tests/qemu-iotests/019           |  6 ++--
 tests/qemu-iotests/020           |  6 ++--
 tests/qemu-iotests/024           | 10 +++---
 tests/qemu-iotests/026           |  5 ++-
 tests/qemu-iotests/028           |  2 +-
 tests/qemu-iotests/029           |  7 ++--
 tests/qemu-iotests/031           |  9 +++--
 tests/qemu-iotests/036           | 15 ++++----
 tests/qemu-iotests/036.out       |  6 ++--
 tests/qemu-iotests/039           | 27 ++++++--------
 tests/qemu-iotests/043           |  4 ++-
 tests/qemu-iotests/046           |  2 ++
 tests/qemu-iotests/048           |  4 ++-
 tests/qemu-iotests/050           |  8 ++---
 tests/qemu-iotests/051           |  7 ++--
 tests/qemu-iotests/053           |  4 +--
 tests/qemu-iotests/058           |  7 ++--
 tests/qemu-iotests/059           | 20 +++++------
 tests/qemu-iotests/060           | 12 ++++---
 tests/qemu-iotests/061           | 61 +++++++++++++++++---------------
 tests/qemu-iotests/062           |  3 +-
 tests/qemu-iotests/063           | 18 +++++-----
 tests/qemu-iotests/063.out       |  3 +-
 tests/qemu-iotests/066           |  3 +-
 tests/qemu-iotests/067           |  6 ++--
 tests/qemu-iotests/068           |  4 ++-
 tests/qemu-iotests/069           |  2 +-
 tests/qemu-iotests/071           |  7 ++--
 tests/qemu-iotests/073           |  2 ++
 tests/qemu-iotests/074           |  4 ++-
 tests/qemu-iotests/079           |  3 +-
 tests/qemu-iotests/080           |  7 ++--
 tests/qemu-iotests/081           |  6 ++--
 tests/qemu-iotests/085           | 18 +++++-----
 tests/qemu-iotests/085.out       |  8 ++---
 tests/qemu-iotests/088           |  2 +-
 tests/qemu-iotests/090           |  2 ++
 tests/qemu-iotests/091           |  3 +-
 tests/qemu-iotests/091.out       |  1 -
 tests/qemu-iotests/092           |  2 +-
 tests/qemu-iotests/094           |  4 +--
 tests/qemu-iotests/095           |  5 +--
 tests/qemu-iotests/098           |  5 +--
 tests/qemu-iotests/099           | 10 +++---
 tests/qemu-iotests/103           |  5 +--
 tests/qemu-iotests/106           |  2 +-
 tests/qemu-iotests/108           |  8 +++--
 tests/qemu-iotests/109           |  4 +--
 tests/qemu-iotests/110           | 11 +++---
 tests/qemu-iotests/110.out       |  4 +--
 tests/qemu-iotests/111           |  3 +-
 tests/qemu-iotests/112           | 37 +++++++++----------
 tests/qemu-iotests/114           |  2 ++
 tests/qemu-iotests/115           |  3 +-
 tests/qemu-iotests/121           |  9 +++--
 tests/qemu-iotests/122           |  6 ++--
 tests/qemu-iotests/123           |  4 +--
 tests/qemu-iotests/125           |  2 +-
 tests/qemu-iotests/137           | 12 ++++---
 tests/qemu-iotests/137.out       |  4 +--
 tests/qemu-iotests/138           |  5 +--
 tests/qemu-iotests/141           |  4 ++-
 tests/qemu-iotests/142           |  2 +-
 tests/qemu-iotests/144           |  4 ++-
 tests/qemu-iotests/153           | 12 +++----
 tests/qemu-iotests/156           | 10 ++++--
 tests/qemu-iotests/159           |  2 +-
 tests/qemu-iotests/160           |  3 +-
 tests/qemu-iotests/161           |  4 +--
 tests/qemu-iotests/170           |  2 +-
 tests/qemu-iotests/172           |  6 ++--
 tests/qemu-iotests/173           |  3 +-
 tests/qemu-iotests/174           |  2 +-
 tests/qemu-iotests/175           |  2 +-
 tests/qemu-iotests/176           |  7 ++--
 tests/qemu-iotests/178           |  6 ++--
 tests/qemu-iotests/182           |  2 +-
 tests/qemu-iotests/183           |  2 +-
 tests/qemu-iotests/185           |  4 +--
 tests/qemu-iotests/187           |  6 ++--
 tests/qemu-iotests/190           |  4 +--
 tests/qemu-iotests/191           | 11 +++---
 tests/qemu-iotests/195           |  2 +-
 tests/qemu-iotests/197           |  6 ++--
 tests/qemu-iotests/198           |  6 ++--
 tests/qemu-iotests/198.out       |  4 +--
 tests/qemu-iotests/200           |  7 ++--
 tests/qemu-iotests/201           |  6 ++--
 tests/qemu-iotests/214           |  3 +-
 tests/qemu-iotests/215           |  6 ++--
 tests/qemu-iotests/217           |  3 +-
 tests/qemu-iotests/220           |  5 ++-
 tests/qemu-iotests/225           |  2 +-
 tests/qemu-iotests/229           |  3 +-
 tests/qemu-iotests/232           |  4 ++-
 tests/qemu-iotests/243           | 10 ++++--
 tests/qemu-iotests/244           | 15 ++++----
 tests/qemu-iotests/247           |  4 ++-
 tests/qemu-iotests/249           |  4 +--
 tests/qemu-iotests/250           |  5 +--
 tests/qemu-iotests/252           |  2 +-
 tests/qemu-iotests/265           |  2 +-
 tests/qemu-iotests/267           | 17 +++++----
 tests/qemu-iotests/common.filter | 21 +++++++++--
 tests/qemu-iotests/common.rc     | 51 +++++++++++++++++++++-----
 109 files changed, 455 insertions(+), 316 deletions(-)

--=20
2.21.0


