Received: from eggs.gnu.org ([2001:4830:134:3::10]:38322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8xvT-0005WM-I0
	for qemu-devel@nongnu.org; Thu, 11 May 2017 19:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8xvQ-0004fd-E2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 19:55:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:13154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d8xvQ-0004cX-4M
	for qemu-devel@nongnu.org; Thu, 11 May 2017 19:55:16 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Thu, 11 May 2017 23:55:11 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
In-Reply-To: <20170511163447.GA7785@morn.lan>
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
To: Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Paolo,

In KVM mode, seems A20 is ignored.
Do you see any potential issue here?


Anthony=20


> -----Original Message-----
> From: Kevin O'Connor [mailto:kevin@koconnor.net]
> Sent: Thursday, May 11, 2017 9:35 AM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org; Xu, Anthony <anthony.xu@intel.com>
> Subject: Re: [PATCH] target/i386: enable A20 automatically in system
> management mode
>=20
> On Thu, May 11, 2017 at 05:32:47PM +0200, Paolo Bonzini wrote:
> > On 11/05/2017 16:53, Kevin O'Connor wrote:
> > > On Thu, May 11, 2017 at 01:35:28PM +0200, Paolo Bonzini wrote:
> > >> Ignore env->a20_mask when running in system management mode.
> > >
> > > Thanks Paolo.  I don't think this patch will help SeaBIOS though.  Th=
e
> > > SeaBIOS SMM handler doesn't do much - it doesn't even access ram
> above
> > > 1MiB.  See SeaBIOS' code in src/fw/smm.c:handle_smi().
> > >
> > > Instead, the SeaBIOS code does a cpu state backup/restore to switch
> > > into 32bit mode.  I thought the A20 state would be part of that cpu
> > > backup/restore.  However, looking at the Intel SDM docs now, it's not
> > > really clear to me how the processor "inhibits" A20 when in SMM mode =
-
> > > does it save/restore that state on SMI/RSM or does it have special
> > > logic to ignore A20 while in SMM mode?
> >
> > There isn't any documented place for A20 in the state save map (I check=
ed
> > AMD's BIOS/Kernel Developer Guide which is pretty comprehensive), so I
> > think the latter is more plausible.  What I'm doing in this patch is
> > ignoring A20 while in SMM mode.
>=20
> Okay.
>=20
> > Then you would have to add an A20 save/restore in handle_smi; since
> > CALL32SMM_ENTERID should not nest, I think you can just do this:
>=20
> Yes, that should be fine.
>=20
> > --- a/src/fw/smm.c
> > +++ b/src/fw/smm.c
> > @@ -54,7 +54,8 @@ struct smm_layout {
> >      struct smm_state backup2;
> >      u8 stack[0x7c00];
> >      u64 codeentry;
> > -    u8 pad_8008[0x7df8];
> > +    u8 a20;
> > +    u8 pad_8009[0x7df7];
> >      struct smm_state cpu;
> >  };
>=20
> In order to avoid mixing code and data in the same cache line we could
> do this instead:
>=20
>  struct smm_layout {
>      struct smm_state backup1;
>      struct smm_state backup2;
> -    u8 stack[0x7c00];
> +    u32 backup_a20;
> +    u8 stack[0x8000 - sizeof(struct smm_state)*2 - sizeof(u32)];
>      u64 codeentry;
>      u8 pad_8008[0x7df8];
>      struct smm_state cpu;
>=20
> Thanks,
> -Kevin
