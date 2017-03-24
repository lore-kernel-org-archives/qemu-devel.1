Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crN7t-0003tB-9t
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crN7q-0005wn-4J
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:11:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56773
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1crN7p-0005wS-VD
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:11:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2OB3mtt145847
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:11:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29cmcb4226-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:11:20 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Mar 2017 05:11:20 -0600
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Mar 2017 12:11:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
Subject: Re: [Qemu-devel] qemu-system-s390x tests/boot-serial-test
 intermittent failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

On 03/24/2017 11:57 AM, Peter Maydell wrote:
> Hi; qemu-system-s390x seems to have an intermittent failure at
> the moment -- it's been causing our Travis builds to flap. I actually
> caught it doing this on one of my local test builds (which happens
> to be aarch64 but I don't think that matters, since Travis is doing
> x86 builds):
> 
> while  QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
> QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
> 255 + 1))} gtester -k --verbose -m=quick tests/boot-serial-test ; do
> true; done
>  TEST: tests/boot-serial-test... (pid=1122)
>   /s390x/boot-serial/s390-ccw-virtio:                                  OK
> PASS: tests/boot-serial-test
> TEST: tests/boot-serial-test... (pid=1135)
>   /s390x/boot-serial/s390-ccw-virtio:                                  OK
> [skip lots more successes]
> TEST: tests/boot-serial-test... (pid=1582)
>   /s390x/boot-serial/s390-ccw-virtio:
> Broken pipe
> FAIL
> GTester: last random seed: R02Se94f36f305f2edd8391a22749ec91143
> (pid=1635)
> FAIL: tests/boot-serial-test
> 
> Any ideas?
> thanks

Adding Thomas who did the s390 version.

One idea. Maybe qemu exits before the other side is ready.
Does reverting

commit 864111f422babcf8ce837fb47f7f9e1948446f22
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Tue Oct 18 09:29:54 2016 +0200
Commit:     Paolo Bonzini <pbonzini@redhat.com>
CommitDate: Wed Nov 2 09:28:56 2016 +0100

    vl: exit qemu on guest panic if -no-shutdown is not set

help?

If yes, does 
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 57edf6a..11f48b0 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -79,8 +79,8 @@ static void test_machine(const void *data)
     g_assert(fd != -1);
 
     args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
-                           " -serial chardev:serial0 %s", test->machine,
-                           tmpname, test->extra);
+                           " -no-shutdown -serial chardev:serial0 %s",
+                           test->machine, tmpname, test->extra);
 
     qtest_start(args);
     unlink(tmpname);

also help?
