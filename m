Received: from eggs.gnu.org ([2001:4830:134:3::10]:60383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpDCn-0007u0-3Q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpDCi-00035G-90
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:43:49 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dpDCi-00034T-3D
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:43:44 -0400
Received: by mail-oi0-f41.google.com with SMTP id x190so8032784oix.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ad3ad60-1f03-4585-45e1-d12ab593008f@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-17-eblake@redhat.com>
	<2ad3ad60-1f03-4585-45e1-d12ab593008f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Sep 2017 14:43:41 +0200
Message-ID: <CABgObfYCUmUO8oTp3oM56t1d9cX-t7FdRTE4e5SaDVqp4UAS0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 16/29] libqos: Use explicit
 QTestState for virtio operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, armbru@redhat.com, Eric Blake <eblake@redhat.com>

>  typedef struct QVirtioDevice {
>      const QVirtioBus *bus;
> +    QTestState *qts;
>      /* Device type */
>      uint16_t device_type;
>  } QVirtioDevice;
> @@ -35,12 +36,14 @@ typedef struct QVirtQueue {
>      uint16_t last_used_idx;
>      bool indirect;
>      bool event;
> +    QTestState *qts;
>  } QVirtQueue;
>
>  typedef struct QVRingIndirectDesc {
>      uint64_t desc; /* This points to an array fo struct vring_desc */
>      uint16_t index;
>      uint16_t elem;
> +    QTestState *qts;
>  } QVRingIndirectDesc;

Adding QTestState to QVRingIndirectDesc and QVirtQueue sounds somewhat
ugly to me. I think they should either rather have a pointer to the
associated QVirtioDevice, or the functions where this is needed
(qvring_init() for example) should get a "QTestState *" parameter instead.


I agree with Thomas and even extend it to QVirtioDevice. If there is a
has-a hierarchy between libqos objects, only the topmost one (such as the
virtio mmio bus device, and the PCI host bridge---or possibly even the
machine object exclusively) should have a QTestState. Everyone else can
access it implicitly through operations on its bus.

Test code on the other hand can use global_qtest implicitly when they
prepare/read buffers that the devices do DMA from/to.

Paolo



Just my 0.02 =E2=82=AC.

 Thomas
