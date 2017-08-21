Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dzejrou@gmail.com>) id 1djrTl-0001K6-IQ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 14:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dzejrou@gmail.com>) id 1djrTk-0005EN-Ie
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 14:31:13 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dzejrou@gmail.com>) id 1djrTk-0005BE-Bp
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 14:31:12 -0400
Received: by mail-ua0-x22a.google.com with SMTP id k12so12109690uag.3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:31:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503318220.26016.15.camel@redhat.com>
References: <CAE-Qwfz-RqR_qiOPmv8XF9SO-+4nroai0tNhE_CboEge9ufy+w@mail.gmail.com>
	<1503318220.26016.15.camel@redhat.com>
From: =?UTF-8?Q?Jaroslav_Jindr=C3=A1k?= <dzejrou@gmail.com>
Date: Mon, 21 Aug 2017 20:31:09 +0200
Message-ID: <CAE-Qwfy4+tf=AR=21S1rNxv4e_=nxDP_jOd01aWe2XK4uOguVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

that was an error on my part, I was debugging the non-working command ring
abort/stop functionality and as
the xhci driver implementation I was working on used crcr_low and crcr_high
as two separate registers it did not
hit me it was actually my way of accessing them that caused the abort/stop
to not work.

Thank you very much for the correction and I apologise for disturbing you,
hope I didn't eat too much of your time.

Have a nice day,
Jaroslav Jindrak

S pozdravem,
Jaroslav Jindrak

On 21 August 2017 at 14:23, Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, 2017-08-01 at 01:48 +0200, Jaroslav Jindr=C3=A1k wrote:
> > Hello,
> >
> > I'd like to submit a patch to the xhci subsystem of QEMU. Currently,
> > when the command stop or command abort flags in the crcr_low register
> > are set, nothing happens. This is because the part of the code that
> > tests those two flags (and performs command ring abort/stop) is in
> > the crcr_high case. This error has a simple workaround - after
> > writing to the crcr_low register with either of these two flags set,
> > one can write the value of crcr_high to crcr_high, so I
> > assume this fix does not have that big of a priority, but a driver
> > that follows the specification strictly would misbehave in this kind
> > of situation (stopping/aborting the command ring).
>
> Specs says (section 5.1, Register Conventions):
>
> <quote>
> If the xHC supports 64-bit addressing (AC64 =3D =E2=80=981=E2=80=99), the=
n software
> should write registers containing 64-bit address fields using only
> Qword accesses. If a system is incapable of issuing Qword accesses,
> then writes to the 64-bit address fields shall be performed using 2
> Dword accesses; low Dword-first, high-Dword second.
> </quote>
>
> So I think the guest must write both crcr_low and crcr_high, and the
> qemu behavior is correct.
>
> Are there any guests which actually have problems?
>
> cheers,
>   Gerd
>
>
