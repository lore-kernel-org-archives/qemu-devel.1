Received: from eggs.gnu.org ([2001:4830:134:3::10]:43768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIZx-0002JD-Pb
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIZw-0004wx-Q0
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:07:49 -0500
From: John Snow <jsnow@redhat.com>
Message-ID: <8891d390-0862-fcd9-555c-cde0b02c117b@redhat.com>
Date: Tue, 21 Nov 2017 19:07:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-iotest 059 vmdk failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Lukas Doktor <ldoktor@redhat.com>

The last sub-test in 059, which uses an AFL fuzzer image to test for how
a large L1 table of a specific size is handled has a slight regression.

Previously, QEMU expects -EFBIG to come out the vmdk_open call. Now, we
get -EINVAL. Not too ominous.

Now, QEMU actually allocates the L1 table (1.6GB) and gets a little
further, only to eventually trip up here:

#0  vmdk_read_cid (bs=0x555555d4c5a0, parent=0, pcid=0x555555d5786c) at
/home/bos/jhuston/src/qemu/block/vmdk.c:272
#1  0x00005555555947cb in vmdk_open (bs=0x555555d4c5a0,
options=0x555555d509b0, flags=65536, errp=0x7fffffffd950)
    at /home/bos/jhuston/src/qemu/block/vmdk.c:989

where p_name is NULL, so we return -EINVAL back up the stack. We get all
the way through vmdk_open_sparse --> vmdk_open_vmdk4 before we
eventually catch an error in the header and return a fairly nondescript
EINVAL which doesn't tell the end user much.

We don't error out earlier because the vmdk_add_extent function checks
to see if we are exceeding 512*1024*1024 ... entries, which means that
later when we get to vmdk_init_tables, we do multiply this number by
four again, so our actual maximum L1 table size in terms of bytes is
2GiB, not 512MiB.

(Maybe you knew that, I didn't, enjoy useless facts. The comment in code
seemed to suggest the size was a literal size in bytes, but it's treated
more as the number of L1 entries, which is different.)

Anyway, this still seems slightly silly that we don't catch obviously
bogus images a little sooner, so I wanna rewind and see why we don't get
-EFBIG anymore.

The output changes as of 9877860e which adds the p_name check, so we
appear to actually be failing even earlier, just not before we
apparently load up a 2GB L1 table from a file that clocks in at less
than 1KB.

(Wait, why does that work? Am I tracing this wrong? -EOUTTATIME)

Anyway, we can fix this by amending the reference test output, or we
might want to shore up the vmdk input validation a bit.

Not a regression, and the test was broken in v2.10 anyway, so not
critical to fix during rc phase, I think.

Anyway, I need to go prepare some food for Thanksgiving, so I won't come
back to this one for a few days. If it's not important to anyone else,
I'll get back around to it eventually.

--js
