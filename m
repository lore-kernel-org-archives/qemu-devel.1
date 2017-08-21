Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djlk9-0006Nc-KW
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djlk6-00046I-Vj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djlk6-00045y-P1
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:23:42 -0400
Message-ID: <1503318220.26016.15.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 14:23:40 +0200
In-Reply-To: <CAE-Qwfz-RqR_qiOPmv8XF9SO-+4nroai0tNhE_CboEge9ufy+w@mail.gmail.com>
References: <CAE-Qwfz-RqR_qiOPmv8XF9SO-+4nroai0tNhE_CboEge9ufy+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] xhci: move command stop and command abort flag
 check to the case when the crcr_low register is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jaroslav =?ISO-8859-1?Q?Jindr=E1k?= <dzejrou@gmail.com>, qemu-devel@nongnu.org

On Tue, 2017-08-01 at 01:48 +0200, Jaroslav Jindr=C3=A1k wrote:
> Hello,
>=20
> I'd like to submit a patch to the xhci subsystem of QEMU. Currently,
> when the command stop or command abort flags in the crcr_low register
> are set, nothing happens. This is because the part of the code that
> tests those two flags (and performs command ring abort/stop) is in
> the crcr_high case. This error has a simple workaround - after
> writing to the crcr_low register with either of these two flags set,
> one can write the value of crcr_high to crcr_high, so I
> assume this fix does not have that big of a priority, but a driver
> that follows the specification strictly would misbehave in this kind
> of situation (stopping/aborting the command ring).

Specs says (section 5.1, Register Conventions):

<quote>
If the xHC supports 64-bit addressing (AC64 =3D =E2=80=981=E2=80=99), the=
n software
should write registers containing 64-bit address fields using only
Qword accesses. If a system is incapable of issuing Qword accesses,
then writes to the 64-bit address fields shall be performed using 2
Dword accesses; low Dword-first, high-Dword second.
</quote>

So I think the guest must write both crcr_low and crcr_high, and the
qemu behavior is correct.

Are there any guests which actually have problems?

cheers,
  Gerd
