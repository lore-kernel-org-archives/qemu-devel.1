Received: from eggs.gnu.org ([2001:4830:134:3::10]:33462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duFDc-0001O9-Tv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duFDc-0006ed-2x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:53:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duFDb-0006eI-TN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:53:28 -0400
Date: Tue, 19 Sep 2017 11:53:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170919115321.0f3b5c57.cohuck@redhat.com>
In-Reply-To: <63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
	<63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 19 Sep 2017 11:11:27 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 13/09/2017 13:50, Halil Pasic wrote:
> > This is a preparation for introducing handling for indirect data
> > addressing and modified indirect data addressing (CCW). Here we introduce
> > an interface which should make the addressing scheme transparent for the
> > client code. Here we implement only the basic scheme (no IDA or MIDA).
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >   hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
> >   include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 122 insertions(+)

> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index 0653d3c9be..79acaf99b7 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -75,6 +75,29 @@ typedef struct CMBE {
> >       uint32_t reserved[7];
> >   } QEMU_PACKED CMBE;
> > 
> > +typedef enum CcwDataStreamOp {
> > +    CDS_OP_R = 0,
> > +    CDS_OP_W = 1,
> > +    CDS_OP_A = 2
> > +} CcwDataStreamOp;
> > +
> > +/** normal usage is via SuchchDev.cds instead of instantiating */
> > +typedef struct CcwDataStream {
> > +#define CDS_F_IDA   0x01
> > +#define CDS_F_MIDA  0x02
> > +#define CDS_F_I2K   0x04
> > +#define CDS_F_C64   0x08
> > +#define CDS_F_STREAM_BROKEN  0x80
> > +    uint8_t flags;
> > +    uint8_t at_idaw;
> > +    uint16_t at_byte;
> > +    uint16_t count;
> > +    uint32_t cda_orig;
> > +    int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
> > +                      CcwDataStreamOp op);  
> 
> I would have prefer one handler per operation instead of a operation 
> parameter.
> 
> Is it possible to change the name of the "buf" argument to "arg".
> I just think of the foollowing:
> If one day we do not want to gather all IDAs into a single buffer but 
> keep them split, we can have something like an array of buffers as argument.

It should be possible to change the internal format should we decide to
want to do something different, so I'll leave that as-is for now.

> 
> 
> 
> > +    hwaddr cda;
> > +} CcwDataStream;
> > +

> otherwise, LGTM

Is that an ack? :)
