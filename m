Received: from eggs.gnu.org ([2001:4830:134:3::10]:49697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etCca-0004QI-Pq
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etCcU-0002XF-SM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:27:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etCcU-0002X1-N8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:27:06 -0500
Date: Tue, 6 Mar 2018 14:27:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306132701.ezej6d7pysp6roxb@sirius.home.kraxel.org>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
	<20180306114232.v5gtwxald4mmelab@sirius.home.kraxel.org>
	<CAJ+F1CJo28aN6mwihp8UTwq4jtgz21BxT+U7F-jGu7fyhefBkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJo28aN6mwihp8UTwq4jtgz21BxT+U7F-jGu7fyhefBkA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] audio: modularize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

> >> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-pa.so: undefined
> >> symbol: audio_pt_unlock_and_signal

> Fresh directory, cleaned ccache. That didn't help. fwiw, I am
> compiling on f27, gcc (GCC) 7.3.1 20180130. I'll investigate further
> if you can't reproduce.

Hmm, working fine here (both rhel-7 and fedora-27 testbuild container, default
build flags).

The symbol in question should be provided by qemu:

kraxel@fedora-64bit ~/projects/qemu/build/fedora# objdump -x audio-pa.so | grep audio_pt_unlock_and_signal
0000000000000000         *UND*  0000000000000000              audio_pt_unlock_and_signal
kraxel@fedora-64bit ~/projects/qemu/build/fedora# objdump -x x86_64-softmmu/qemu-system-x86_64 | grep audio_pt_unlock_and_signal
00000000004735f0 g     F .text  0000000000000067              audio_pt_unlock_and_signal

Possibly your linker throws it away, thinking there is no user because of the
modular drivers?

cheers,
  Gerd
