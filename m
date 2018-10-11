Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAcfc-0005iT-GZ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAcfY-0005Y0-5s
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:14:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAcfO-0005Ts-Sf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:14:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so9390076wmw.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 08:14:16 -0700 (PDT)
References: <20181011131413.22208-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7762db82-6044-df69-a1b7-c05100a0e938@redhat.com>
Date: Thu, 11 Oct 2018 17:14:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181011131413.22208-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] chardev: Convert IOReadHandler to read an
 unsigned number of bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Antony Pavlov <antonynpavlov@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Zhang Chen <zhangckid@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Samuel Thibault <samuel.thibault@ens-lyon.org>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, Thomas Huth <huth@tuxfamily.org>, Michael Walle <michael@walle.cc>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 11/10/2018 15:14, Philippe Mathieu-Daudé wrote:
> The number of bytes can not be negative nor zero.
> 
> Fixed 2 format string:
> - hw/char/spapr_vty.c
> - hw/usb/ccid-card-passthru.c
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> See: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02212.html

Not that easy; you need to adjust qemu_chr_be_can_write,
qemu_chr_be_write_impl, qemu_chr_be_write (which is where the callbacks
are invoked).

On the other hand, fd_chr_read_poll is not an IOCanReadHandler, and this
patch therefore probably doesn't compile?

Paolo
