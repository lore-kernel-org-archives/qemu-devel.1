Received: from eggs.gnu.org ([2001:4830:134:3::10]:41468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan@doxpara.com>) id 1elQZD-0004um-PZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan@doxpara.com>) id 1elQZD-0008A5-2F
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:43:35 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan@doxpara.com>) id 1elQZC-00088D-R1
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:43:34 -0500
Received: by mail-ot0-x22c.google.com with SMTP id h14so15939069otj.5
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 18:43:34 -0800 (PST)
MIME-Version: 1.0
From: Dan Kaminsky <dan@doxpara.com>
Date: Mon, 12 Feb 2018 18:43:33 -0800
Message-ID: <CAEW7AC=UFbKT9MPb-q4KvBRSBf-O_V2QjG_1BkfyYf1Rt_bOsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] gdbstub.c gdb-get-register returns 0,
 breaking remote gdb call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unsure the scope of this bug or the proper fix, so bringing it up here
first.

gdbstub.c:gdb_read_register will return 0, and thus E14, when a remote gdb
tries to call a function in the exposed linux kernel.  This appears to be
because the caller expects to be able to receive a generic register size by
calling one plus the number of known registers.  However,
x86_cpu_gdb_read_register() in target/i386/gdbstub.c will only provide
register sizes for known registers, since they're not always the same.

I'm dealing with this just by shimming 8 whenever gdb_read_register returns
0, but that's obviously not correct.  Suggestions?

--Dan

P.S.  call still won't work unless linux is launched with noexec=off
noexec32=off, due to NX.
