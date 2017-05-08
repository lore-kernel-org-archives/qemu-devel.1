Received: from eggs.gnu.org ([2001:4830:134:3::10]:48289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d7o1i-0002vw-01
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d7o1h-0000Xw-2W
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:08:57 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:33309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1d7o1g-0000Xo-TD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:08:56 -0400
Received: by mail-io0-x22d.google.com with SMTP id p24so56735133ioi.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 12:08:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170504230520.k4hxva2la45cmuze@var.youpi.perso.aquilenet.fr>
References: <20170420204301.154912-1-lepton@google.com>
	<42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
	<20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
	<CALqoU4xQPynFnXH86z7+kw9fQ-3zFfesScMRYcK885HXMKKK5w@mail.gmail.com>
	<20170504230520.k4hxva2la45cmuze@var.youpi.perso.aquilenet.fr>
From: lepton <ytht.net@gmail.com>
Date: Mon, 8 May 2017 12:08:55 -0700
Message-ID: <CALqoU4wb=sQNQXOKKknpwb2n8Sfm3OZNDHHqaNNduXzp24kVCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Tao Wu <lepton@google.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hi Samuel,


There could 2 kind of bugs:

1.  For some reason, caller didn't setup anything in tcpiphdr, so there is
random data inside it.
2.  For some reason, caller setup correct src/dst address in tcpiphdr but
don't zero ix_h1

Actually I worried about bug 1 more than bug 2.

With assert in code, it's easy to catch bug 2 and bug 1.

But if I just zero ix_h1 in my code, then it's somewhat difficult to catch
bug 1. Finally the code could just send out some
random packets to some random address.

If you still think this doesn't look likely happen, I am fine with your
suggestion and will add zero for ih_x1, any comments?

On Thu, May 4, 2017 at 4:05 PM, Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> Hello,
>
> lepton, on mer. 03 mai 2017 11:35:05 -0700, wrote:
> > It sounds like a bug that  caller set up a
> > right src and dst address and without set right ih_x1.
>
> I wouldn't bet on that. ih_x1 is only a filler, the caller can be using
> the structure only as a C structure, and it's only here just before the
> checksum computation that we really need ih_x1 to be 0.
>
> Samuel
>
