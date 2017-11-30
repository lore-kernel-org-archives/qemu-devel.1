Received: from eggs.gnu.org ([2001:4830:134:3::10]:58755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eKJs1-0007F4-3G
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eKJrz-0001e3-UV
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:06:57 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:44306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1eKJrz-0001cL-OE
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:06:55 -0500
Received: by mail-oi0-x231.google.com with SMTP id k2so4264218oib.11
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 00:06:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMxP3BQaWaoAAepffqmWcR07j_RTXcqo41RPXM=U2WoGmne3iw@mail.gmail.com>
References: <20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<20170808230043-mutt-send-email-mst@kernel.org>
	<CAMxP3BR=WHKJxcWKH27dcC7DTKGD2y7r12teAUSmMkwp1VDafA@mail.gmail.com>
	<20170822105659.75b5c7e0@w520.home>
	<20170822205940-mutt-send-email-mst@kernel.org>
	<CAMxP3BSNPjRZGOULZ0zKBq8v5Rqv9f5xasx+BD57c=oAS5tSWg@mail.gmail.com>
	<20170829081305.7a2685c6@w520.home>
	<CAMxP3BRFzyyHemEW-2DFRd7r9Py-bkjY7vQRNeBfuhN0XKupJQ@mail.gmail.com>
	<20170830104304.4a0fca34@w520.home>
	<CAMxP3BQaWaoAAepffqmWcR07j_RTXcqo41RPXM=U2WoGmne3iw@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Thu, 30 Nov 2017 16:06:54 +0800
Message-ID: <CAMxP3BRW_w7+CttE9VQiPaoDJiKP6y82ciXt4JNmEdXvhdw=AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
	=?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

Hi,

After 3 months of work and investigation, and tedious mail discussions with
Nvidia, I think some progress have been made, in terms of the
GPUDirect(p2p) in virtual environment.

The only remaining issue then, is the low bidirectional bandwidth between
two sibling GPUs under the same PCIe switch.

We expanded the tests to run on even more GPU cards, so the results seemed
to be explicit now.


P40 is OK, and its hardware topology on host is:
 \-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D DMI2
             +-01.0-[03]----00.0  LSI Logic / Symbios Logic MegaRAID SAS-3
3008 [Fury]
             +-02.0-[04]----00.0  NVIDIA Corporation GP102GL [Tesla P40]
             +-03.0-[02]----00.0  NVIDIA Corporation GP102GL [Tesla P40]


M60, not OK, low bandwidth:
 \-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D DMI2
             +-01.0-[06]----00.0  LSI Logic / Symbios Logic MegaRAID SAS-3
3008 [Fury]
             +-02.0-[07-0a]----00.0-[08-0a]--+-08.0-[09]----00.0  NVIDIA
Corporation GM204GL [Tesla M60]
             |                               \-10.0-[0a]----00.0  NVIDIA
Corporation GM204GL [Tesla M60]


V100, not OK, low bandwidth:
\-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon
D DMI2
             +-01.0-[01]--+-00.0  Mellanox Technologies MT27710 Family
[ConnectX-4 Lx]
             |            \-00.1  Mellanox Technologies MT27710 Family
[ConnectX-4 Lx]
             +-02.0-[02-05]----00.0-[03-05]--+-08.0-[04]----00.0  NVIDIA
Corporation GV100 [Tesla V100 PCIe]
             |                               \-10.0-[05]----00.0  NVIDIA
Corporation GV100 [Tesla V100 PCIe]



So what might be the actual effect of the PLX switch hardware for GPU data
flow? Although it is not visible in guest OS.
Nvidia tech-support guys are not familiar with virtualization. They asked
us to consult the community first.
