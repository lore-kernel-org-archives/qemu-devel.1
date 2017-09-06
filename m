Received: from eggs.gnu.org ([2001:4830:134:3::10]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZoM-0004PW-ES
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZoI-0005bQ-I5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpZoI-0005ay-A7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:52:02 -0400
Date: Wed, 6 Sep 2017 14:51:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906145158.252cf0cd.cohuck@redhat.com>
In-Reply-To: <bd30a18f-6d22-e5a7-6e8c-08f628466cc4@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-2-pasic@linux.vnet.ibm.com>
	<20170906141846.0be413fb.cohuck@redhat.com>
	<bd30a18f-6d22-e5a7-6e8c-08f628466cc4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 6 Sep 2017 14:40:48 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 02:18 PM, Cornelia Huck wrote:
> > On Tue,  5 Sep 2017 13:16:41 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> +static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
> >> +                                  CcwDataStreamOp op)
> >> +{
> >> +    int ret;
> >> +
> >> +    ret = cds_check_len(cds, len);
> >> +    if (ret <= 0) {
> >> +        return ret;
> >> +    }
> >> +    if (op == CDS_OP_A) {
> >> +        goto incr;
> >> +    }
> >> +    ret = address_space_rw(&address_space_memory, cds->cda,
> >> +                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
> >> +    if (ret != MEMTX_OK) {
> >> +        cds->flags |= CDS_F_STREAM_BROKEN;  
> > 
> > Do we want to distinguish between different reasons for the stream
> > being broken? I.e, is there a case where we want to signal different
> > errors back to the caller?
> >   
> 
> Hm, after I've done the error handling it seems that basically
> everything is to be handled with a program check. The stream
> records the place where the problem was encountered, so for debug
> we would not have to search for long.
> 
> There seems to be no need to distinguish.

OK, makes sense. Let's keep it as it is.

> 
> >> +        return -EINVAL;
> >> +    }
> >> +incr:
> >> +    cds->at_byte += len;
> >> +    cds->cda += len;
> >> +    return 0;
> >> +}
> >> +
> >> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >> +{
> >> +    /*
> >> +     * We don't support MIDA (an optional facility) yet and we
> >> +     * catch this earlier. Just for expressing the precondition.
> >> +     */
> >> +    assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));  
> > 
> > I don't know, this is infrastructure, should it trust its callers? If
> > you keep the assert, please make it g_assert().  
> 
> 
> Why g_assert? I think g_assert comes form a test framework, this is not
> test code.

g_assert() is glib, no?

> 
> I feel more comfortable having this assert around.

Let's revisit that when we add mida support :) I don't really object to
it.

> 
> >   
> >> +    cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
> >> +                 (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> >> +                 (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
> >> +    cds->count = ccw->count;
> >> +    cds->cda_orig = ccw->cda;
> >> +    ccw_dstream_rewind(cds);
> >> +    if (!(cds->flags & CDS_F_IDA)) {
> >> +        cds->op_handler = ccw_dstream_rw_noflags;
> >> +    } else {
> >> +        assert(false);  
> > 
> > Same here.
> > 
> > Or should we make this return an error and have the callers deal with
> > that? (I still need to look at the users.)
> >   
> 
> This assert is going away soon (patch 4). I'm not sure doing much more here
> is justified.

OK, if it is transient anyway...
