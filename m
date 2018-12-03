Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTqwD-0006Wo-S4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTqwD-000499-1J
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:13 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTqwA-00046x-P4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:12 -0500
Received: by mail-ot1-x342.google.com with SMTP id 32so12085305ota.12
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20181203100608.28538-1-jasowang@redhat.com>
In-Reply-To: <20181203100608.28538-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 16:18:57 +0000
Message-ID: <CAFEAcA-n+vJ505AF1xzq6y4HUab8ivX-4sQ29jBXsogfZh0=FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>, Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon, 3 Dec 2018 at 10:06, Jason Wang <jasowang@redhat.com> wrote:
>
> Hi:
>
> This series tries to fix a possible OOB during queueing packets
> through qemu_net_queue_append_iov(). This could happen when it tries
> to queue a packet whose size is larger than INT_MAX which may lead
> integer overflow. We've fixed similar issue in the past during
> qemu_net_queue_deliver_iov() by ignoring large packets there. Let's
> just move the check earlier to qemu_sendv_packet_async() and reduce
> the limitation to NET_BUFSIZE. A simple qtest were also added this.
>
> Please review.

I did a test build and run, and the new test generates warning
messages during "make check":
  /ppc64/virtio/net/pci/large_tx:
qemu-system-ppc64: warning: hub 0 is not connected to host network
(similarly for /i386/ and /x86_64/).

thank
-- PMM
