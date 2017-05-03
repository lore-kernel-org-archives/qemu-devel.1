Received: from eggs.gnu.org ([2001:4830:134:3::10]:43156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5sVs-000188-6O
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5sVn-0000jI-8q
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:32:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5sVn-0000hq-0c
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:32:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v43BU5TI033427
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 07:32:01 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ecfg1vr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 07:32:01 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 3 May 2017 12:31:57 +0100
Date: Wed, 3 May 2017 13:31:53 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CAJ+F1CKLUacSekNyMTohahLmMvLGFT=t7N4_cMNs-iMBw-4mTQ@mail.gmail.com>
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
	<20170407111851.20680-2-cornelia.huck@de.ibm.com>
	<CAJ+F1CKLUacSekNyMTohahLmMvLGFT=t7N4_cMNs-iMBw-4mTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170503133153.7b999ee3.cornelia.huck@de.ibm.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, pbonzini@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

On Fri, 28 Apr 2017 14:17:12 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Fri, Apr 7, 2017 at 3:19 PM Cornelia Huck <cornelia.huck@de.ibm.com>
> wrote:
>=20
> > From: Jing Liu <liujbjl@linux.vnet.ibm.com>
> >
> > This introduces basic support for TN3270, which needs to negotiate
> > three Telnet options during handshake:
> >   - End of Record
> >   - Binary Transmission
> >   - Terminal-Type
> >
> > As a basic implementation, this simply ignores NOP and Interrupt
> > Process(IP) commands. More work should be done for them later.
> >
> > For more details, please refer to RFC 854 and 1576.
> >
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> > Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  chardev/char-socket.c | 76
> > +++++++++++++++++++++++++++++++++++++--------------
> >  chardev/char.c        | 11 ++++++--
> >  include/sysemu/char.h |  8 ++++++
> >  qapi-schema.json      |  3 ++
> >  4 files changed, 76 insertions(+), 22 deletions(-)

> > diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> > index 450881d42c..f6d5cd0c9b 100644
> > --- a/include/sysemu/char.h
> > +++ b/include/sysemu/char.h
> > @@ -7,6 +7,14 @@
> >  #include "qemu/bitmap.h"
> >  #include "qom/object.h"
> >
> > +#define IAC_EOR 239
> > +#define IAC_SE 240
> > +#define IAC_NOP 241
> > +#define IAC_BREAK 243
> > +#define IAC_IP 244
> > +#define IAC_SB 250
> > +#define IAC 255
> > +
> >
>=20
> Those define are exposed because of a later patch.
>=20
> (I have pending patches to have a char/char-socket.h and friends where th=
is
> should fit, but for now it's fine)

OK. FWIW, I plan to send a pull req for 3270 this week.

>=20
> Patch looks good to me, basic testing done

Cool, thanks. May I count that as an ack? :)
