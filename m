Received: from eggs.gnu.org ([2001:4830:134:3::10]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMupb-00077T-3k
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMupX-0007QM-6A
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:59:11 -0500
Date: Thu, 7 Dec 2017 12:59:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171207125901.47be0af1.cohuck@redhat.com>
In-Reply-To: <e2e2ae84-e04a-df4f-50bb-328768a5464e@redhat.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
	<e2e2ae84-e04a-df4f-50bb-328768a5464e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 7 Dec 2017 07:33:19 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 08.11.2017 17:54, Halil Pasic wrote:

> > +static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode)
> > +{
> > +    switch (op_mode) {
> > +    case OP_MODE_FIB:
> > +        return ccw_testdev_ccw_cb_mode_fib;
> > +    case OP_MODE_NOP:
> > +    default:
> > +        return ccw_testdev_ccw_cb_mode_nop;  
> 
> Do we really want to use "nop" for unknown modes? Or should there rather
> be a ccw_testdev_ccw_cb_mode_error instead, too?

I like the idea of an error mode.

Related: Should the device have a mechanism to report the supported
modes?

> 
> > +    }
> > +}

(...)

> > +/* TODO This is the out-of-band variant. We may want to get rid of it */  
> 
> I agree, this should rather go away in the final version.

I'm not sure that the in-band variant with its magic buffer value is
superior to this version using a dedicated hypercall.

> 
> > +static int set_mode_diag(const uint64_t *args)
> > +{
> > +    uint64_t subch_id = args[0];
> > +    uint64_t op_mode = args[1];
> > +    SubchDev *sch;
> > +    CcwTestDevDevice *dev;
> > +    int cssid, ssid, schid, m;
> > +
> > +    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
> > +        return -EINVAL;
> > +    }
> > +    sch = css_find_subch(m, cssid, ssid, schid);
> > +    if (!sch || !css_subch_visible(sch)) {
> > +        return -EINVAL;
> > +    }
> > +    dev = CCW_TESTDEV(sch->driver_data);
> > +    if (dev->op_mode_locked) {
> > +        return op_mode == dev->op_mode ? 0 : -EINVAL;
> > +    }
> > +    dev->op_mode = op_mode;
> > +    sch->ccw_cb = get_ccw_cb(dev->op_mode);
> > +    return 0;
