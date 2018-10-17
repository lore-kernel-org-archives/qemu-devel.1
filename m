Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gCo0e-00062H-Q1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gCo0W-0000vM-2S
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:45:18 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:43073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1gCo0V-0000rs-RV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:45:11 -0400
Received: by mail-qt1-x82f.google.com with SMTP id q41-v6so30532069qtq.10
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:45:11 -0700 (PDT)
MIME-Version: 1.0
From: Frank Yang <lfy@google.com>
Date: Wed, 17 Oct 2018 08:44:59 -0700
Message-ID: <CAEkmjvWv=CCf-Y4kDqG=Z-Fb2jPBUBVzHzy69rTxDinPZQ72YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU hangs in main_loop_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi all,

After quite some backports, such as

https://android.googlesource.com/platform/external/qemu/+/a8da859b1b011e509056f03cbcb73df27afe4337

we are not seeing hangs in flatview_do_translate, but are still getting
hangs in main-loop:

    qemu_mutex_unlock_iothread();
    replay_mutex_unlock();

    ret = qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len, timeout);
<-------------this seems to be the hanging part

    replay_mutex_lock();
    qemu_mutex_lock_iothread();

Any idea how to diagnose the cause of taking too much time in g_poll in
qemu_poll_ns?

Frank
