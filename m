Received: from eggs.gnu.org ([209.51.188.92]:49378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9ll-0006jt-Sw
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9ll-000684-3o
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs9lk-00065A-Rl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E0E983F42
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 17:16:48 +0000 (UTC)
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
	<20190208124844.GE4494@dhcp-200-176.str.redhat.com>
	<d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
	<20190208160013.GA4441@dhcp-200-176.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fffb008e-c16c-5db9-14bf-c779b7b08ae1@redhat.com>
Date: Fri, 8 Feb 2019 18:16:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190208160013.GA4441@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 08/02/19 17:00, Kevin Wolf wrote:
> Am 08.02.2019 um 14:46 hat Paolo Bonzini geschrieben:
>> On 08/02/19 13:48, Kevin Wolf wrote:
>>> I just wanted to work on a unit test and found that a simple 'make
>>> check-tests/test-bdrv-drain' (which used to build and run the test with
>>> a single command) doesn't work any more.
>>>
>>> git bisect points to this commit.
>>
>> What's wrong with "tests/test-bdrv-drain"?  (Before there were some
>> differences in test environment, but not now).
> 
> It runs the old version without building the source I just modified.

Oh.  Since it wasn't documented, it seemed to be just an implementation
detail rather than something that would be used by people...  So
basically something like this?

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 048cf5639c..6ac3f2c7eb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -861,6 +861,9 @@ check-unit: $(check-unit-y)
 check-speed: $(check-speed-y)
 	$(call do_test_human, $^)

+$(patsubst %, check-%, $(check-unit-y) $(check-speed-y): check-%: %
+        $<
+
 # gtester tests with TAP output

 $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)):
check-report-qtest-%.tap: $(check-qtest-y)


Paolo
