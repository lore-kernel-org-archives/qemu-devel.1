Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fv39h-0002Il-Ls
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fv39d-00086K-9V
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:17:17 -0400
Date: Wed, 29 Aug 2018 18:17:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180829181706.43601750.cohuck@redhat.com>
In-Reply-To: <87bm9l88bx.fsf@dusky.pond.sub.org>
References: <20180828123346.17548-1-cohuck@redhat.com>
	<20180828123346.17548-2-cohuck@redhat.com>
	<87bm9l88bx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-error: add {error,
 warn}_report_once_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Wed, 29 Aug 2018 18:07:46 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
> 
> > Add two functions to print an error/warning report once depending
> > on a passed-in condition variable and flip it if printed. This is
> > useful if you want to print a message not once-globally, but e.g.
> > once-per-device.
> >
> > Inspired by warn_once() in hw/vfio/ccw.c.  
> 
> This leaves the reader wondering why you don't replace that function.
> You do, in PATCH 3.  I'd either announce that here, or squash the two
> patches.

Squashing probably makes the most sense.

> 
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/qemu/error-report.h |  5 +++++
> >  util/qemu-error.c           | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> > index 72fab2b031..d2a6515e68 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -44,6 +44,11 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  
> > +void error_report_once_cond(bool *printed, const char *fmt, ...)
> > +    GCC_FMT_ATTR(2, 3);
> > +void warn_report_once_cond(bool *printed, const char *fmt, ...)
> > +    GCC_FMT_ATTR(2, 3);
> > +
> >  /*
> >   * Similar to error_report(), except it prints the message just once.
> >   * Return true when it prints, false otherwise.
> > diff --git a/util/qemu-error.c b/util/qemu-error.c
> > index a25d3b94c6..0894ab6995 100644
> > --- a/util/qemu-error.c
> > +++ b/util/qemu-error.c
> > @@ -310,3 +310,47 @@ void info_report(const char *fmt, ...)
> >      vreport(REPORT_TYPE_INFO, fmt, ap);
> >      va_end(ap);
> >  }
> > +
> > +/*
> > + * If *printed is false, print an error message to current monitor if we
> > + * have one, else to stderr, and flip *printed to true.
> > + * If printed is NULL, do not print anything.  
> 
> Any particular reason for supporting null @printed?
> 
> For what it's worth, warn_once() supports it, but its caller doesn't use
> it.

I can change this to asserting on NULL @printed. If you call this with
NULL, you probably have messed up somewhere already.

> 
> > + * Format arguments like sprintf().  The resulting message should be
> > + * a single phrase, with no newline or trailing punctuation.
> > + * Prepend the current location and append a newline.
> > + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> > + */
> > +void error_report_once_cond(bool *printed, const char *fmt, ...)
> > +{
> > +    va_list ap;
> > +
> > +    if (!printed || *printed) {
> > +        return;
> > +    }
> > +    *printed = true;
> > +    va_start(ap, fmt);
> > +    vreport(REPORT_TYPE_ERROR, fmt, ap);
> > +    va_end(ap);
> > +}
> > +
> > +/*
> > + * If *printed is false, print a warning message to current monitor if we
> > + * have one, else to stderr, and flip *printed to true.
> > + * If printed is NULL, do not print anything.
> > + * Format arguments like sprintf().  The resulting message should be
> > + * a single phrase, with no newline or trailing punctuation.
> > + * Prepend the current location and append a newline.
> > + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> > + */
> > +void warn_report_once_cond(bool *printed, const char *fmt, ...)
> > +{
> > +    va_list ap;
> > +
> > +    if (!printed || *printed) {
> > +        return;
> > +    }
> > +    *printed = true;
> > +    va_start(ap, fmt);
> > +    vreport(REPORT_TYPE_WARNING, fmt, ap);
> > +    va_end(ap);
> > +}  
