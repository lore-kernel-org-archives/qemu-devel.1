Received: from eggs.gnu.org ([2001:4830:134:3::10]:35065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d5RzE-0006Tw-6T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d5Rz9-0002Tz-4P
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d5Rz8-0002Tb-UU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:12:35 -0400
Message-ID: <1493709150.8581.24.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 02 May 2017 09:12:30 +0200
In-Reply-To: <87h918iuo4.fsf@dusky.pond.sub.org>
References: <20170428084237.23960-1-kraxel@redhat.com>
	<87h918iuo4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>, P J P <ppandit@redhat.com>

  Hi,

> Drive-by comment, feel free to ignore: I'd be tempted to lower the limit
> to something comparable to actual hardware, then dumb down the queue to
> an array.

Well, the point of this queuing feature is to make automated tests a bit
easier, i.e. a script passes something longish like a install URL to
qemu, and qemu forwards it to the guest with small delays so the
keyboard hardware buffers don't overflow.

So I left he limit relatively high.  Even 1024 isn't as much as it
sounds, each typed char is at least four queue items (keydown, delay,
keyup, delay), in case modifiers are needed even more.  So this gives
buffering room for roughly 150-250 chars typed.

Also lowering the limit to something hardware-comparable is rather
pointless, we have those buffers in the hardware emulation, so we could
just drop the queuing support at input layer altogether.  I don't think
this is a good idea though.

cheers,
  Gerd
