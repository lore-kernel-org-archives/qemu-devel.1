Received: from eggs.gnu.org ([209.51.188.92]:56318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gj1TV-0006ek-Bz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gj1TU-0000ZZ-MP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:36:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gj1TU-0000Yh-GO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:36:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<f5631b6b-d313-88dc-f80a-890c26f109e4@126.com>
Date: Mon, 14 Jan 2019 13:36:13 +0100
In-Reply-To: <f5631b6b-d313-88dc-f80a-890c26f109e4@126.com> (Fei Li's message
	of "Sun, 13 Jan 2019 23:44:28 +0800")
Message-ID: <878sznquv6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: Fei Li <fli@suse.com>, Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> Just to make sure about how to do the cleanup. I notice that in device_se=
t_realized(),
> the current code does not call "dc->unrealize(dev, NULL);" when dc->reali=
ze() fails.
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dc->realize) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->re=
alize(dev, &local_err);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ail;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Is this on purpose? (Maybe due to some devices' realize() do their own cl=
eanup
> when fails? Sorry for the unsure, it is such a common function that I did=
 not
> check all. :( ) Or else, I prefer to do the cleanup in a unified manner, =
e.g. call "dc->unrealize(dev, NULL);" which is the pci_qdev_unrealize() for=
 pci devices.

Yes, this is on purpose.

When a realize() method fails, it must revert everything it has done so
far.  Results in sane "either succeed completely, or fail and do
nothing" semantics.
