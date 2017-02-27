Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciHIj-0004ac-EQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciHIg-00075Q-A3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ciHIg-00074a-1L
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:08:58 -0500
Date: Mon, 27 Feb 2017 09:08:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170227090851.GA2350@work-vm>
References: <20170226202709.2114-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA94FrJq7-i=z5FGXm2ar+xPKS+qoA+_E8y8b-Stomshig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA94FrJq7-i=z5FGXm2ar+xPKS+qoA+_E8y8b-Stomshig@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/5] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 26 February 2017 at 20:27, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> > The following changes since commit 685783c5b69c83c942d1fc21679311eeb8f79ab9:
> >
> >   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-02-26 16:38:40 +0000)
> >
> > are available in the git repository at:
> >
> >   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >
> > for you to fetch changes up to c363a5b7f9ca9e802665587900b7ea1aefcf26ea:
> >
> >   slirp: VMStatify remaining except for loop (2017-02-26 21:16:38 +0100)
> >
> > ----------------------------------------------------------------
> > slirp updates
> >
> > ----------------------------------------------------------------
> > Dr. David Alan Gilbert (5):
> >       slirp: VMState conversion; tcpcb
> >       slirp: VMStatify sbuf
> >       slirp: Common lhost/fhost union
> >       slirp: VMStatify socket level
> >       slirp: VMStatify remaining except for loop
> 
> I'm afraid this doesn't build on OSX:
> 
> 
> /Users/pm215/src/qemu-for-merges/slirp/slirp.c:1291:9: error:
> 'uint16_t *' (aka 'unsigned short *') and 'typeof (((union
> slirp_sockaddr *)0)->ss.ss_family) *' (aka 'unsigned char *') are not
> pointers to compatible types
>         VMSTATE_SS_FAMILY(ss.ss_family, union slirp_sockaddr),
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yes, we need to drop 4 and 5;  as per the separate thread the problem
is the BSDs just have a char for their ss_family.

Dave

> /Users/pm215/src/qemu-for-merges/slirp/slirp.c:1277:33: note: expanded
> from macro 'VMSTATE_SS_FAMILY'
> #define VMSTATE_SS_FAMILY(f, s) VMSTATE_UINT16(f, s)
>                                 ^~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/migration/vmstate.h:785:5:
> note: expanded from macro 'VMSTATE_UINT16'
>     VMSTATE_UINT16_V(_f, _s, 0)
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/migration/vmstate.h:764:5:
> note: expanded from macro 'VMSTATE_UINT16_V'
>     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, uint16_t)
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> note: (skipping 1 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> /Users/pm215/src/qemu-for-merges/include/migration/vmstate.h:300:21:
> note: expanded from macro 'VMSTATE_SINGLE_TEST'
>     .offset       = vmstate_offset_value(_state, _field, _type),     \
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/migration/vmstate.h:272:6:
> note: expanded from macro 'vmstate_offset_value'
>      type_check(_type, typeof_field(_state, _field)))
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qemu/compiler.h:86:35: note:
> expanded from macro 'type_check'
> #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>                            ~~~~~~ ^ ~~~~~~
> 1 error generated.
> 
> In the OSX headers sockaddr_storage is:
> 
> struct sockaddr_storage {
>         __uint8_t       ss_len;         /* address length */
>         sa_family_t     ss_family;      /* [XSI] address family */
>         char                    __ss_pad1[_SS_PAD1SIZE];
>         __int64_t       __ss_align;     /* force structure storage alignment */
>         char                    __ss_pad2[_SS_PAD2SIZE];
> };
> 
> and sa_family_t is
> 
> typedef __uint8_t               sa_family_t;
> 
> (NetBSD also defines sa_family_t as an 8 bit type, and
> perhaps so do the other BSDs.)
> 
> I think we can't get away with having the on-the-wire
> type for this field be the same as the in-memory
> representation, since the on-the-wire rep. should
> be host-OS-independent...
> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
