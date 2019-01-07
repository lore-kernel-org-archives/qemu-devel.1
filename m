Received: from eggs.gnu.org ([209.51.188.92]:49882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggQF2-0005ep-R4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggQEw-0007rd-PI
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggQEl-0007h3-EF
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:26:24 -0500
Date: Mon, 7 Jan 2019 09:16:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107081627.btzrwwnodcszuftl@sirius.home.kraxel.org>
References: <ddc7219f-98c3-28be-084f-64606452e49b@suse.com>
	<e51bd6dc-e135-b66a-189d-8b79bc5f7e49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e51bd6dc-e135-b66a-189d-8b79bc5f7e49@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Can I have someone's feedback on [bug 1809075]
 Concurrency bug on keyboard events: capslock LED messing up keycode streams
 causes character misses at guest kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Gao Zhiyuan <zgao@suse.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 03, 2019 at 12:05:54PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Marc-Andr=E9 & Gerd.
>=20
> On 12/19/18 10:31 AM, Gao Zhiyuan wrote:
> > Hi everyone.
> >=20
> > Can I please have someone's feedback on this bug?
> > https://bugs.launchpad.net/qemu/+bug/1809075
> > Briefly, guest OS loses characters sent to it via vnc. And I spot the
> > bug in relation to ps2 driver.
> >=20
> > I'm thinking of possible fixes and I might want to use a memory barri=
er.
> > But I would really like to have some suggestion from a qemu developer
> > first. For example, can we brutally drop capslock LED key events in p=
s2
> > queue?

There is no "capslock LED key event".  0xfa is KBD_REPLY_ACK, and the
device queues it in response to guest port writes.  Yes, the ack can
race with actual key events.  But IMO that isn't a bug in qemu.

Probably the linux kernel just throws away everything until it got the
ack for the port write, and that way the key event gets lost.  On
physical hardware you will not notice because it is next to impossible
to type fast enough to hit the race window.

So, go fix the kernel.

Alternatively fix vncdotool to send uppercase letters properly with
shift key pressed.  Then qemu wouldn't generate capslock key events
(that happens because qemu thinks guest and host capslock state is out
of sync) and the guests's capslock led update request wouldn't get into
the way.

cheers,
  Gerd
