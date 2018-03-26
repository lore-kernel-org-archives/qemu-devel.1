Received: from eggs.gnu.org ([2001:4830:134:3::10]:33744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f0PD6-0008Bn-HA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f0PD2-0001bL-9h
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:18:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f0PD2-0001b0-0Y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:18:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2QAGxL3144204
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:18:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gxwwmk2f8-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:18:33 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 26 Mar 2018 11:18:31 +0100
References: <20180326063901.27425-1-peterx@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 26 Mar 2018 12:18:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <fc8f214d-9e71-8c45-cb0d-b4832c480cd9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/8] Monitor: some oob related
 patches (fixes, new param, tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Thanks for the quick fixing. This series on top of master
works fine on s390. (make check and iotests)

Christian



On 03/26/2018 08:38 AM, Peter Xu wrote:
> I suppose these are all good even for 2.12, so marked in subject.
> Tested with "make check" for all targets on x86_64, and iotest -raw.
> 
> Patch 1 fixes one OOB error message regression reported by Marc-Andre.
> 
> Patch 2 fixes one potential OOB problem when more than one clients are
> there, reported by Marc-Andre (too).
> 
> Patch 3 introduce "-mon x-oob=on" parameter to allow user to
> explicitly enable Out-Of-Band for a specific monitor.
> 
> Patch 4-6 are qapi-schema fixes and tests for Out-Of-Band.
> 
> Patch 7-8 add back the OOB test on the new parameter (with more
> enhancements).
> 
> Please review, thanks.
> 
> Peter Xu (8):
>   qmp: fix qmp_capabilities error regression
>   qmp: cleanup qmp queues properly
>   monitor: new parameter "x-oob"
>   qapi: restrict allow-oob value to be "true"
>   tests: let qapi-schema tests detect oob
>   tests: add oob-test for qapi-schema
>   tests: introduce qtest_init_with_qmp_format()
>   tests: qmp-test: add test for new "x-oob"
> 
>  include/monitor/monitor.h               |   1 +
>  monitor.c                               | 124 ++++++++++++++++++++++----------
>  scripts/qapi/common.py                  |   2 +-
>  tests/Makefile.include                  |   1 +
>  tests/libqtest.c                        |  14 +++-
>  tests/libqtest.h                        |  14 ++++
>  tests/qapi-schema/doc-good.out          |   4 +-
>  tests/qapi-schema/ident-with-escape.out |   2 +-
>  tests/qapi-schema/indented-expr.out     |   4 +-
>  tests/qapi-schema/oob-test.err          |   1 +
>  tests/qapi-schema/oob-test.exit         |   1 +
>  tests/qapi-schema/oob-test.json         |   2 +
>  tests/qapi-schema/oob-test.out          |   0
>  tests/qapi-schema/qapi-schema-test.json |   3 +
>  tests/qapi-schema/qapi-schema-test.out  |  20 +++---
>  tests/qapi-schema/test-qapi.py          |   4 +-
>  tests/qmp-test.c                        |  84 ++++++++++++++++++++++
>  tests/test-qmp-cmds.c                   |   4 ++
>  vl.c                                    |   5 ++
>  19 files changed, 233 insertions(+), 57 deletions(-)
>  create mode 100644 tests/qapi-schema/oob-test.err
>  create mode 100644 tests/qapi-schema/oob-test.exit
>  create mode 100644 tests/qapi-schema/oob-test.json
>  create mode 100644 tests/qapi-schema/oob-test.out
> 
