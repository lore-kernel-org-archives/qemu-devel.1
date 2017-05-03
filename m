Received: from eggs.gnu.org ([2001:4830:134:3::10]:49366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5swk-0002BU-7E
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5swj-00050i-6S
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:59:54 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5swi-00050P-U0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:59:53 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so22390666wrc.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
	<20170407111851.20680-2-cornelia.huck@de.ibm.com>
	<CAJ+F1CKLUacSekNyMTohahLmMvLGFT=t7N4_cMNs-iMBw-4mTQ@mail.gmail.com>
	<20170503133153.7b999ee3.cornelia.huck@de.ibm.com>
In-Reply-To: <20170503133153.7b999ee3.cornelia.huck@de.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 11:59:41 +0000
Message-ID: <CAJ+F1CKVTxgQS-vgKrN540a1jUGbyg6sWfEY0SJgNiDK19oR_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/8] chardev: Basic support for
 TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, pbonzini@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

On Wed, May 3, 2017 at 3:32 PM Cornelia Huck <cornelia.huck@de.ibm.com>
wrote:

> On Fri, 28 Apr 2017 14:17:12 +0000
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
> > Hi
> >
> > On Fri, Apr 7, 2017 at 3:19 PM Cornelia Huck <cornelia.huck@de.ibm.com>
> > wrote:
> >
> > > From: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > >
> > > This introduces basic support for TN3270, which needs to negotiate
> > > three Telnet options during handshake:
> > >   - End of Record
> > >   - Binary Transmission
> > >   - Terminal-Type
> > >
> > > As a basic implementation, this simply ignores NOP and Interrupt
> > > Process(IP) commands. More work should be done for them later.
> > >
> > > For more details, please refer to RFC 854 and 1576.
> > >
> > Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > > Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> > > Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > > Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > ---
> > >  chardev/char-socket.c | 76
> > > +++++++++++++++++++++++++++++++++++++--------------
> > >  chardev/char.c        | 11 ++++++--
> > >  include/sysemu/char.h |  8 ++++++
> > >  qapi-schema.json      |  3 ++
> > >  4 files changed, 76 insertions(+), 22 deletions(-)
>
> > > diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> > > index 450881d42c..f6d5cd0c9b 100644
> > > --- a/include/sysemu/char.h
> > > +++ b/include/sysemu/char.h
> > > @@ -7,6 +7,14 @@
> > >  #include "qemu/bitmap.h"
> > >  #include "qom/object.h"
> > >
> > > +#define IAC_EOR 239
> > > +#define IAC_SE 240
> > > +#define IAC_NOP 241
> > > +#define IAC_BREAK 243
> > > +#define IAC_IP 244
> > > +#define IAC_SB 250
> > > +#define IAC 255
> > > +
> > >
> >
> > Those define are exposed because of a later patch.
> >
> > (I have pending patches to have a char/char-socket.h and friends where
> this
> > should fit, but for now it's fine)
>
> OK. FWIW, I plan to send a pull req for 3270 this week.
>
> >
> > Patch looks good to me, basic testing done
>
> Cool, thanks. May I count that as an ack? :)
>

yep
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
--=20
Marc-Andr=C3=A9 Lureau
