Received: from eggs.gnu.org ([209.51.188.92]:38717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gm0wF-0005F6-IF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gm0w6-00007j-A8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gm0w5-0008Nb-Nd
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:09 -0500
From: Bandan Das <bsd@redhat.com>
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
	<CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
Date: Tue, 22 Jan 2019 07:38:43 -0500
Message-ID: <jpgd0ooc1f0.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1798780] [NEW] hw/usb/dev-mtp.c:1616: bad
 test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1798780 <1798780@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 19 Oct 2018 at 10:22, dcb <1798780@bugs.launchpad.net> wrote:
>> hw/usb/dev-mtp.c:1616:52: warning: logical =E2=80=98or=E2=80=99 of colle=
ctively
>> exhaustive tests is always true [-Wlogical-op]
>>
>> Source code is
>>
>>                 if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D E=
AGAIN ||
>>                                     errno !=3D EWOULDBLOCK)) {
>>
>> Maybe better code
>>
>>                 if ((ret =3D=3D -1) && (errno !=3D EINTR && errno !=3D E=
AGAIN &&
>>                                     errno !=3D EWOULDBLOCK)) {
>
> Hi Gerd, Bandan -- I was going through older launchpad bugs and
> noticed that this one about a dubious conditional in dev-mtp.c is
> still unfixed.
>
> Is the file descriptor being used here one that's in non-blocking
> mode? If so, then busy-waiting in a loop while the write() returns
> EWOULDBLOCK is probably not what you wanted. If it's not then
> there's no need to check for EAGAIN or EWOULDBLOCK, I think.
> Consider using qemu_write_full() instead of open-coding
> the retry loop ?
>

Thanks for the suggestion, Peter. I agree, this isn't
non-blocking and qemu_write_full() can be used. Following up
with a patch.

Bandan

> thanks
> -- PMM
