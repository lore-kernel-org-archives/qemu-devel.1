Received: from eggs.gnu.org ([209.51.188.92]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxMV-0007OC-Ft
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxMU-0003lq-Dz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDxMU-0003lZ-3H
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id k21so16881568otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
	<CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
In-Reply-To: <CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 21:28:41 +0100
Message-ID: <CAFEAcA9S0H=tX4wZOxwbar-UpxH3D+JUc0_6VRStz_doRKmB+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, 9 Apr 2019 at 21:15, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Apr 9, 2019 at 1:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> > > computation of @dt_size overflows to a negative number, which then
> > > gets converted to a very large size_t for g_malloc0() and
> > > load_image_size().  In the (fortunately improbable) case g_malloc0()
> > > succeeds and load_image_size() survives, we'd assign the negative
> > > number to *sizep.  What that would do to the callers I can't say, but
> > > it's unlikely to be good.
> > >
> > > Fix by rejecting images whose size would overflow.
> > >
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > I think this patch is missing some attributions for the
> > security researchers who found the issue initially.
> > PJP's patch for this from a couple of weeks back has a
> > reported-by credit:
> > https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/
>
> It seems like from that discussion that this patch is the correct approach.
>
> I can add the attributions and send a PR for 4.0. I'll send it by EOD
> unless anyone has any objections.

Thanks. I think given it's 21:30 here I'm going to postpone
tagging rc3 til tomorrow (mid-afternoon UK time). I'm still
hoping we can avoid an rc4...

thanks
-- PMM
