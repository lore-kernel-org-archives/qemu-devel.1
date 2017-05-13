Received: from eggs.gnu.org ([2001:4830:134:3::10]:55512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9LnR-0003T1-Up
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9LnO-0003AO-Pf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:24:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:2961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d9LnO-00037y-E5
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:24:34 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Sat, 13 May 2017 01:24:30 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
	<20170513000141.GA542@morn.lan>
In-Reply-To: <20170513000141.GA542@morn.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Kevin O'Connor [mailto:kevin@koconnor.net]
> Sent: Friday, May 12, 2017 5:02 PM
> To: Xu, Anthony <anthony.xu@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; qemu-devel@nongnu.org
> Subject: Re: [PATCH] target/i386: enable A20 automatically in system
> management mode
>=20
> On Fri, May 12, 2017 at 11:19:00PM +0000, Xu, Anthony wrote:
> > > SeaBIOS defaults to enabling A20 and it's a rare beast that disables
> > > it.  One could change x86.h:set_a20 and romlayout.S:transition32 to
> > > only issue the outb() if the inb() indicates a change is needed.  Tha=
t
> > > would likely eliminate half the accesses.
> >
> > The 350 port 92 access is for write operation only.
> > If include the inb(), it would be 700, and every time it actually has a=
 change
> > To be precise, It is about 175 switches from 32 bit to 16 bit, then bac=
k to 32
> bit.
> > call16 is called 175 times during Seabios boot without any option rom,
> > It would be more if some option roms are included.
> >
> >
> > I think A20 is disabled by default in SeaBios.
>=20
> I don't know why you think that.  One can check with:
>=20
> --- a/src/stacks.c
> +++ b/src/stacks.c
> @@ -99,6 +99,8 @@ call32_post(void)
>          if (cr0_caching)
>              cr0_mask(CR0_CD|CR0_NW, cr0_caching);
>      }
> +    if (!get_a20())
> +        dprintf(1, "a20=3D0\n");
>=20
>      // Restore cmos index register
>      outb(GET_LOW(Call16Data.cmosindex), PORT_CMOS_INDEX);
>=20
> With the above I only see a handful of cases where SeaBIOS has to
> restore a20 to a disabled state.

I think it is related to accel and platform, the result I gave before is fo=
r q35 tcg,

With the above change,   I got below data

Platform	accel		count of restoring A20 to 0
Q35		kvm		96
Q35		tcg		271
PC		kvm		3
PC		tcg		3

A lot of A20 restoring happen when SeaBIOS scans AHCI links.


>=20
> The handful I do see are due to cases where yield() is called prior to
> option rom initialization.  Those handful are eliminated for me with
> the following fix:
>=20
> --- a/src/stacks.c
> +++ b/src/stacks.c
> @@ -496,6 +496,7 @@ void
>  thread_setup(void)
>  {
>      CanInterrupt =3D 1;
> +    call16_override(1);
>      if (! CONFIG_THREADS)
>          return;
>      ThreadControl =3D romfile_loadint("etc/threads", 1);

But I still see a lot of PORT_A20 accesses in QEMU as I expected


>=20
> What OS / bootloader are you running?

/x86_64-softmmu/qemu-system-x86_64 -bios /home/root/git/seabios/out/bios.bi=
n -smp 1=20
-machine q35,accel=3Dtcg -m 1G -drive format=3Draw,file=3D/home/root/images=
/centos7.2.img,if=3Dide,index=3D0=20
-nographic  -nodefaults  -serial stdio -monitor pty

-Anthony
