Received: from eggs.gnu.org ([2001:4830:134:3::10]:40679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1rA-000425-Hb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1r7-00015Q-EB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX1r7-00013z-4h
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:58:17 -0400
Date: Mon, 17 Jul 2017 09:58:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717085804.GC3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-2-lprosek@redhat.com>
	<20170713133206.GA18623@stefanha-x1.localdomain>
	<20170714104127.GA28095@redhat.com>
	<CABdb7341GwdRQA1B54zcZTrVNaZt57OWSwCY098spF-bJom=fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABdb7341GwdRQA1B54zcZTrVNaZt57OWSwCY098spF-bJom=fw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] qemu-error: introduce
 error_report_nolf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fernando Casas =?utf-8?B?U2Now7Zzc293?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Mon, Jul 17, 2017 at 08:54:18AM +0200, Ladi Prosek wrote:
> On Fri, Jul 14, 2017 at 12:41 PM, Daniel P. Berrange
> <berrange@redhat.com> wrote:
> > On Thu, Jul 13, 2017 at 02:32:06PM +0100, Stefan Hajnoczi wrote:
> >> On Thu, Jul 13, 2017 at 01:02:30PM +0200, Ladi Prosek wrote:
> >> > +/*
> >> > + * Print an error message to current monitor if we have one, else to stderr.
> >> > + * Format arguments like sprintf().  The resulting message should be a
> >> > + * single phrase, with no trailing punctuation.  The no-LF version allows
> >> > + * additional text to be appended with error_printf() or error_vprintf().
> >> > + * Make sure to always close with a newline after all text is printed.
> >> > + * Prepends the current location.
> >> > + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> >> > + */
> >> > +void error_report_nolf(const char *fmt, ...)
> >> > +{
> >> > +    va_list ap;
> >> > +
> >> > +    va_start(ap, fmt);
> >> > +    error_vreport_nolf(fmt, ap);
> >> > +    va_end(ap);
> >> >  }
> >>
> >> Each call to this function prepends the timestamp, so it cannot really
> >> be used for a sequence of prints in a single line.
> >>
> >> It's a little ugly but I expected something along the lines of
> >> g_strdup_vprintf() in virtio_error():
> >>
> >>   char *msg;
> >>
> >>   va_start(ap, fmt);
> >>   msg = g_strdup_vprintf(fmt, ap);
> >>   va_end(ap);
> >>
> >>   error_report("%s: %s", DEVICE(vdev)->id, msg);
> >>
> >>   g_free(msg);
> >
> > You could get the same thing by turning virtio_Error into a macro with
> > a few games. Rename the current method to virtio_error_impl() and then
> > define:
> >
> >   #define virtio_error(dev, fmt, ...) \
> >      virtio_error_impl(dev, "%s: " fmt, DEVICE(dev)->id, __VA_ARGS__)
> 
> Neat! I think I'll stick with a function though. This doesn't allocate
> but it adds a little bit of code to each call site which has the
> potential of slowing down the fast no-error path (I have no data, just
> the general keeping-the-code-compact-is-good principle). Holler if you
> disagree!

IMHO that would be uneccessary optimization, particular since this is in
the error scenario and so is not performance critical to normal operation.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
