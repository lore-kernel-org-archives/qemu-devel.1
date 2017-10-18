Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4kk3-00054s-PJ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4kk0-00019a-MS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:34:23 -0400
Date: Wed, 18 Oct 2017 11:34:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171018113415.0a96ca7a.cohuck@redhat.com>
In-Reply-To: <b4123d43-4f09-d4c8-a280-61d1d1c77035@redhat.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-3-pasic@linux.vnet.ibm.com>
	<b4123d43-4f09-d4c8-a280-61d1d1c77035@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 18 Oct 2017 10:45:28 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.10.2017 16:04, Halil Pasic wrote:
> > CSS code needs to tell the IO instruction handlers located in how should  
> 
> locate in? ... sorry, I've got trouble to parse this sentence ...

"located in ioinst.c", I guess.

And maybe also move "should" a bit later in the sentence.

> 
> > the emulated instruction be ended. Currently this is done by returning
> > generic (POSIX) error codes, and mapping them to outcomes like condition
> > codes. This makes bugs easy to create and hard to recognise.
> > 
> > As a preparation for moving a way form (mis)using generic error codes for  
> 
> s/a way/away/ ?

I can fix that up as well.

> 
> > flow control let us introduce a type which tells the instruction
> > handler function how to end the instruction, in a more straight-forward
> > and less ambiguous way.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >  include/hw/s390x/css.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index 69b374730e..7e0dbd162f 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -99,6 +99,22 @@ typedef struct CcwDataStream {
> >      hwaddr cda;
> >  } CcwDataStream;
> >  
> > +/*
> > + * IO instructions conclude according this. Currently we have only  
> 
> Maybe rather "terminate like this" or "finish like this"? I'm not a
> native speaker, but "conclude" sounds a little bit strange to me here.

I do remember reading "conclude" in various places in s390
documentation, so I think I'll keep this.

> 
> > + * cc codes. Valid values are 0,1,2,3 and the generic semantic for
> > + * IO instructions is described briefly. For more details consult the PoP.
> > + */
> > +typedef enum IOInstEnding {
> > +    /* produced expected result */
> > +    IOINST_CC_EXPECTED = 0,
> > +    /* status conditions were present or produced alternate result */
> > +    IOINST_CC_STATUS_PRESENT = 1,
> > +    /* inst. ineffective because busy with previously initiated function */
> > +    IOINST_CC_BUSY = 2,
> > +    /* inst. ineffective because not operational */
> > +    IOINST_CC_NOT_OPERATIONAL = 3
> > +} IOInstEnding;
> > +
> >  typedef struct SubchDev SubchDev;
> >  struct SubchDev {
> >      /* channel-subsystem related things: */
> >   
> 
> With the patch description fixed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
