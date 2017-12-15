Received: from eggs.gnu.org ([2001:4830:134:3::10]:44220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePmTg-0004GX-OC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePmTd-0000sg-KD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:40:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ePmTd-0000rM-Dk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:40:21 -0500
Date: Fri, 15 Dec 2017 17:40:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171215094010.GB15187@lemon>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-13-peterx@redhat.com>
	<20171213171934.GC8317@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213171934.GC8317@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 12/26] qmp: negociate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 12/13 17:19, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:46PM +0800, Peter Xu wrote:
> > @@ -1037,8 +1038,42 @@ static void monitor_init_qmp_commands(void)
> >                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
> >  }
> >  
> > -void qmp_qmp_capabilities(Error **errp)
> > +static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
> > +                           Error **errp)
> > +{
> > +    for (; list; list = list->next) {
> > +        assert(list->value < QMP_CAPABILITY__MAX);
> > +        switch (list->value) {
> > +        case QMP_CAPABILITY_OOB:
> > +            if (!mon->use_io_thr) {
> > +                /*
> > +                 * Out-Of-Band only works with monitors that are
> > +                 * running on dedicated IOThread.
> > +                 */
> > +                error_setg(errp, "This monitor does not support "
> > +                           "Out-Of-Band (OOB)");
> > +                return;
> > +            }
> > +            break;
> 
> QEMU always offers the 'oob' capability, even if the monitor does not
> support it.  Should it send 'oob' only when mon->use_io_thr to make
> things easier for clients?

So should we firstly agree on whether the capabilities is on the current monitor
connection or QEMU as a whole?

Fam
