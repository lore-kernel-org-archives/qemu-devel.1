Received: from eggs.gnu.org ([2001:4830:134:3::10]:53413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIHxp-0003Vx-Rb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIHxp-0006Ts-15
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:12:49 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIHxo-0006TP-Rb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:12:48 -0400
Received: by mail-ot0-x231.google.com with SMTP id h8-v6so15380018otb.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 11:12:48 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 19:12:27 +0100
Message-ID: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] virtio-ccw.c vs larger VIRTIO_QUEUE_MAX (coverity
 warning CID 1390619)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>

Hi; Coverity has I think enabled a new warning recently, which
is triggering on virtio_ccw_notify() in hw/s390x/virtio-ccw.c
(CID 1390619).

This function does
    indicators |= 1ULL << vector;
but the code is guarded only by
    if (vector < VIRTIO_QUEUE_MAX) {

That used to be OK when VIRTIO_QUEUE_MAX was 64, but in
commit b829c2a98f1 it was raised to 1024, and this is no longer
a useful guard. The commit message for b829c2a98f1 suggests that
this is a "can't happen" case -- is that so? If so then the
else {} part of the code and an earlier check on
"if (vector >= VIRTIO_QUEUE_MAX + 64)" are dead code.
However it looks like the device_plugged method is also
checking VIRTIO_QUEUE_MAX, rather than 64.

If this is a false positive, then an assert() in
virtio_ccw_notify() and cleaning up the dead code would
help placate coverity.

(Other odd code in that function:
    vector = 0;
    [...]
    indicators |= 1ULL << vector;
is that really supposed to ignore the input vector number?)

thanks
-- PMM
