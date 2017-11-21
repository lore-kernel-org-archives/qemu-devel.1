Received: from eggs.gnu.org ([2001:4830:134:3::10]:43418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHGqO-0003GE-8h
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 17:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHGqN-0004Dt-GF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 17:16:40 -0500
From: John Snow <jsnow@redhat.com>
Message-ID: <6d62e07f-af78-e3bf-5765-1d3e5dba341e@redhat.com>
Date: Tue, 21 Nov 2017 17:16:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu iotest 020 failing for vmdk after 2b7731938d9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>, Max Reitz <mreitz@redhat.com>

Commit 2b7731938d9 adds a blkdebug driver test for failing commits, but
the vmdk driver doesn't appear to appreciate this format:

+_qemu_img_wrapper create -f vmdk -b "json:{'driver': 'raw',
+                         'file': {
+                             'driver': 'blkdebug',
+                             'inject-error': [{
+                                 'event': 'write_aio',
+                                 'errno': 28,
+                                 'once': true
+                             }],
+                             'image': {
+                                 'driver': 'null-co'
+                             }}}"
"/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/t.vmdk"
+qemu-img: TEST_DIR/t.IMGFMT: Could not create image: Invalid argument


...so;

(A) VMDK should be dropped from 020, or
(B) This sub-test should be rewritten, or
(C) This sub-test should be split out into a new unit where VMDK can be
dropped.

I don't like (A) very much because I like testing our weird formats when
possible, I don't like (B) very much because I don't really like
wrangling QMP commands inside of the bash unit tests.

(C) Could work; though it's odd to have it away from its kin in 020.

Opinions?

--js
