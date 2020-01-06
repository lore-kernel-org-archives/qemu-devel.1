Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC8C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9A62080A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="kznIJyHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9A62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioaAv-0006hL-5W
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 16:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioa9x-00066p-TL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioa9w-0005lf-Id
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:43:37 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:43405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ioa9w-0005iu-46
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bs1CitDd0qsfE+jyXqvSXvpyYXXpDL1DvwyOHkblyzU=; b=kznIJyHcPZ87FC/nC9cHSTucNf
 ufdJrdtsBvdH0glnM7UHAOsxpv+eucbwpwBjoWKzN2rijlenJ8YTPyJRCXl57cEDuREETfIYJxMYK
 qGkjQdnJSyMmt1ZrH0vS3MSV0aFsplY3qUb2AHDVp4rK4so7FIed/OR6E4MosehEvECD2nKf9NBEp
 qG/0AJQcBnH3jkd8Hgc9kk6IE11+LNWlHMsvTZpmXwTz/hmEexgJyAW59bYtFVluJGpJQcZ1wNUzy
 8eNOxl1YdZHt6dc8maJHSfj7785CIXhDe9BOAbyNQKhOBF1OoZ5i3/lEynwLzWBiERgsGFYfL4Y5y
 X9AqfRWekYTHnne9FEqUTVq+EctGqSGV8ldRN7Na0zW0z8CKmDK4hVWIDT90pZSKVxhhKvbRn6J/d
 6x+w++gX0byGIgogZJLmVIrkCB+7QelMW1gNNjvjePmahfImSTAUWvcFsMpLxM2x6zuc0dVNR1I5R
 UX6EZ89KdGSpjvEhgylfHNS0Izw9iGTayhyOweI3ZslUpKHV+e5bdiNTmTUZQpdgTCImdNBQHH4pe
 dgXjQVCxfdYuiEU9BlEnPNzX+sxAIyFZlb8bu1fNXiJysf+uVo9b77/vbFE1M7MgZSssqdwxAIrCh
 OPnTBY5PEFPHleeawkbfiEXINylXpAsgRvvlhwW/M=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 anthony.perard@citrix.com, Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/9] 9pfs: validate count sent by client with T_readdir
Date: Mon, 06 Jan 2020 22:43:31 +0100
Message-ID: <2103050.NphggzUy0g@silver>
In-Reply-To: <20200106184852.4f035e53@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <6289486.8nMSniMWIK@silver> <20200106184852.4f035e53@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 6. Januar 2020 18:49:10 CET Greg Kurz wrote:
> On Mon, 06 Jan 2020 16:10:28 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Montag, 6. Januar 2020 13:30:24 CET Greg Kurz wrote:
> > > On Wed, 18 Dec 2019 14:17:59 +0100
> > > 
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > A good 9p client sends T_readdir with "count" parameter that's
> > > > sufficiently smaller than client's initially negotiated msize
> > > > (maximum message size). We perform a check for that though to
> > > > avoid the server to be interrupted with a "Failed to encode
> > > > VirtFS reply type 41" error message by bad clients.
> > > 
> > > Hmm... doesn't v9fs_do_readdir() already take care of that ?
> > 
> > No, unfortunately it doesn't. It just looks at the "count" parameter
> > transmitted with client's T_readdir request, but not at session's msize.
> 
> Indeed.
> 
> > So a bad client could send a T_readdir request with a "count" parameter
> > that's substantially higher than session's msize, which would lead to
> > that mentioned transport error ATM. Hence I suggested this patch here to
> > address it.
> > 
> > You can easily reproduce this issue:
> > 
> > 1. Omit this patch 2 (since it would fix it).
> > 
> > 2. Apply patch 3 and patch 4 of this patch set, which assemble a T_readdir
> > 
> >    test case combined, then stop patches here (i.e. don't apply subsequent
> >    patches of this patch set, since e.g. patch 6 would increase test
> >    client's
> >    msize).
> > 
> > 3. Set QTEST_V9FS_SYNTH_READDIR_NFILES in hw/9pfs/9p-synth.h to a high
> > number> 
> >    (e.g. several thousands).
> > 
> > 4. Run the T_readdir test case:
> >    cd build
> >    make && make tests/qos-test
> >    export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
> >    tests/qos-test -p $(tests/qos-test -l | grep readdir/basic)
> > 
> > Result: Since the test client's msize is quite small at this point (4kB),
> > test client would transmit a very large "count" parameter with T_readdir
> > request to retrieve all QTEST_V9FS_SYNTH_READDIR_NFILES files, and you'll
> > end up getting the quoted transport error message on server (see precise
> > error message above).
> 
> I don't observe this behavior with:
> 
> -#define QTEST_V9FS_SYNTH_READDIR_NFILES 100
> +#define QTEST_V9FS_SYNTH_READDIR_NFILES 20000
> 
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> 9p-tests/fs/readdir/basic: **
> ERROR:/home/greg/Work/qemu/qemu-9p/tests/virtio-9p-test.c:597:fs_readdir:
> assertion failed (nentries == QTEST_V9FS_SYNTH_READDIR_NFILES + 2): (101 ==
> 20002)
> 
> The server didn't hit the transport error...

Ah sorry, I forgot I had this already defused on test case side. Change this 
as well to reproduce it:

diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 036d7e4a5b..7d6cedcdac 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -58,7 +58,7 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int 
mode,
 /* for READDIR test */
 #define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
 #define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
-#define QTEST_V9FS_SYNTH_READDIR_NFILES 100
+#define QTEST_V9FS_SYNTH_READDIR_NFILES 2000
 
 /* Any write to the "FLUSH" file is handled one byte at a time by the
  * backend. If the byte is zero, the backend returns success (ie, 1),
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 48c0eca292..1d49d97a83 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -586,7 +586,7 @@ static void fs_readdir(void *obj, void *data, 
QGuestAllocator *t_alloc)
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlopen(req, &qid, NULL);
 
-    req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - P9_IOHDRSZ, 0);
+    req = v9fs_treaddir(v9p, 1, 0, 900000, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rreaddir(req, &count, &nentries, &entries);

Then run the test, which leads to this error here:

/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/
virtio-9p-tests/fs/readdir/basic: qemu-system-x86_64: Failed to encode VirtFS 
reply type 41

-> Hang.

Best regards,
Christian Schoenebeck



