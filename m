Received: from eggs.gnu.org ([2001:4830:134:3::10]:53161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT6YK-0001jO-N8
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT6YE-0007qc-1l
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:10:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dT6YD-0007qP-OA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:10:33 -0400
Date: Thu, 6 Jul 2017 14:10:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170706131028.GM3988@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
	<87r2xuay5h.fsf@dusky.pond.sub.org>
	<20170706080741.GB3988@redhat.com>
	<87lgo14xgs.fsf@dusky.pond.sub.org>
	<20170706114509.GL3988@redhat.com>
	<87lgo1lpss.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgo1lpss.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC v3 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@xilinx.com>, philippe@mathieu-daude.net, qemu-devel@nongnu.org

On Thu, Jul 06, 2017 at 02:20:51PM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > On Thu, Jul 06, 2017 at 01:27:15PM +0200, Markus Armbruster wrote:
> >> "Daniel P. Berrange" <berrange@redhat.com> writes:
> >> 
> >> > On Thu, Jul 06, 2017 at 08:15:54AM +0200, Markus Armbruster wrote:
> >> >> Alistair Francis <alistair.francis@xilinx.com> writes:
> >> >> 
> >> >> > This patch converts the existing error_vreport() function into a generic
> >> >> > qmesg_vreport() function that takes an enum describing the
> >> >> > information to be reported.
> >> >> >
> >> >> > As part of this change a new qmesg_report() function is added as well with the
> >> >> > same capability.
> >> >> >
> >> >> > To maintain full compatibility the original error_report() function is
> >> >> > maintained and no changes to the way errors are printed have been made.
> >> >> > To improve access to the new informaiton and warning options wrapper functions
> >> >> > similar to error_report() have been added for warnings and information
> >> >> > printing.
> >> >> >
> >> >> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >> >
> >> >> > diff --git a/util/qemu-error.c b/util/qemu-error.c
> >> >> > index 1c5e35ecdb..63fdc0e174 100644
> >> >> > --- a/util/qemu-error.c
> >> >> > +++ b/util/qemu-error.c
> >> >> > @@ -179,17 +179,29 @@ static void print_loc(void)
> >> >> >  
> >> >> >  bool enable_timestamp_msg;
> >> >> >  /*
> >> >> > - * Print an error message to current monitor if we have one, else to stderr.
> >> >> > + * Print a message to current monitor if we have one, else to stderr.
> >> >> >   * Format arguments like vsprintf().  The resulting message should be
> >> >> >   * a single phrase, with no newline or trailing punctuation.
> >> >> >   * Prepend the current location and append a newline.
> >> >> >   * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> >> >> >   */
> >> >> > -void error_vreport(const char *fmt, va_list ap)
> >> >> > +void qmsg_vreport(report_type type, const char *fmt, va_list ap)
> >> >> >  {
> >> >> >      GTimeVal tv;
> >> >> >      gchar *timestr;
> >> >> >  
> >> >> > +    switch (type) {
> >> >> > +    case REPORT_TYPE_ERROR:
> >> >> > +        /* To maintain compatibility we don't add anything here */
> >> >> 
> >> >> I feel the comment isn't going to be useful in the future.  Let's drop
> >> >> it.
> >> >
> >> > Do we really need to care about compatibility of the precise way we output
> >> > error messages. It has never been something we call a "stable API", as we
> >> > don't guarantee error message text will remain the same across releases. So
> >> > anyone relying on scraping QEMU stderr to match some error message has always
> >> > been liable to break.
> >> >
> >> > IOW, just add an "error: " prefix to the text
> >> 
> >> I agree the error message format isn't ABI.
> >> 
> >> But what would adding "error: " buy us?
> >
> > It would clearly distinguish errors from any other output on stderr, which
> > may not be error related (for example SPICE commonly pollutes stderr with
> > lots of messages).
> 
> Changing the current error message format
> 
>     <TIMESTAMP><PROGNAME>:<LOCATION><MSG>
> 
> to
> 
>     <TIMESTAMP><PROGNAME>:<LOCATION>error: <MSG>
> 
> makes recognizing error messages a bit easier, but it also makes them
> even longer.  Can't we make do with recognizing <PROGNAME>:?

I'm not convinced 7 extra characters is a big deal compared with the
size of the timestamps, program name, location & error message itself.
We'll already have such a prefix for info & warnings, so consistency is
good IMHO.

If line length is a concern, perhaps we should make the error printing
function able to intelligently line wrap at 80 chars, taking into account
the size of the metadata (timestamp, program, location, msg type prefix).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
