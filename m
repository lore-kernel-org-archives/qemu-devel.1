Received: from eggs.gnu.org ([2001:4830:134:3::10]:46105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIZDw-0005Lj-Ve
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIZDt-00089a-RP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:38:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fIZDt-00088V-Lv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C6EA4168F0F
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 12:38:33 +0000 (UTC)
Date: Tue, 15 May 2018 20:38:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180515123827.GB9089@xz-mi>
References: <20180515091356.24106-1-peterx@redhat.com>
	<87mux16s9c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mux16s9c.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, May 15, 2018 at 02:02:55PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > I stole the printk_once() macro.
> >
> > I always wanted to be able to print some error directly if there is a
> > buffer to dump, however we can't use error_report() really quite often
> > when there can be any DDOS attack.
> 
> Got an example?

There aren't much, but there are still some error_report()s that can
be used in frequently called functions, especially on IO paths.  For
example:


*** hw/usb/dev-storage.c:
usb_msd_handle_data[422]       error_report("usb-msd: Bad CBW size");
usb_msd_handle_data[427]       error_report("usb-msd: Bad signature %08x",
usb_msd_handle_data[434]       error_report("usb-msd: Bad LUN %d", cbw.lun);

*** hw/usb/dev-uas.c:
usb_uas_handle_control[656]    error_report("%s: unhandled control request (req 0x%x, val 0x%x, idx 0x%x",
usb_uas_handle_data[823]       error_report("%s: unknown command iu: id 0x%x",
usb_uas_handle_data[870]       error_report("%s: no inflight request", __func__);
usb_uas_handle_data[888]       error_report("%s: invalid endpoint %d", __func__, p->ep->nr);

*** hw/virtio/vhost-user.c:
vhost_user_read[208]           error_report("Failed to read msg header. Read %d instead of %d."
vhost_user_read[215]           error_report("Failed to read msg header."
vhost_user_read[223]           error_report("Failed to read msg header."
vhost_user_read[234]           error_report("Failed to read msg payload."
process_message_reply[260]     error_report("Received unexpected msg type."
vhost_user_write[302]          error_report("Failed to set msg fds.");
vhost_user_write[308]          error_report("Failed to write msg."
...
slave_read[859]                error_report("Failed to read from slave.");
slave_read[864]                error_report("Failed to read msg header."
slave_read[873]                error_report("Failed to read payload from slave.");
slave_read[885]                error_report("Received unexpected msg type.");
slave_read[910]                error_report("Failed to send msg reply to slave.");
...

I only picked some of the callers, they might not all suite in this
case, but just to show what I mean.

Another example is in VT-d emulation code, we have trace_vtd_error()
tracer.  AFAIU all those places can be replaced by something like
error_report() but trace points are mostly used to avoid DDOS attack,
say, an evil guest might trigger this error tons of times to even use
up a host's disk space (e.g., in libvirt qemu log, since libvirt might
capture that).  However using trace points mean that errors are not
dumped if trace not enabled.

So this print_once() thing will make sure (1) it's on by deffault, so
we can even get something without turning the trace on and
reproducing, and (2) it won't be affected by DDOS attack.

> 
> >                                     To avoid that, we can introduce a
> > print-once function for it.
> >
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > We can for sure introduce similar functions for the rest of the
> > error_*() functions, it's just an idea to see whether we'd like it
> > in general.
> > ---
> >  include/qemu/error-report.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> > index e1c8ae1a52..efebb80e2c 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -44,6 +44,18 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >  
> > +#define error_report_once(fmt, ...)             \
> > +    ({                                          \
> > +        static bool __print_once;               \
> > +        bool __ret_print_once = !__print_once;  \
> > +                                                \
> > +        if (!__print_once) {					\
> > +            __print_once = true;				\
> > +            error_report(fmt, ##__VA_ARGS__);   \
> > +        }                                       \
> > +        unlikely(__ret_print_once);				\
> > +    })
> > +
> >  const char *error_get_progname(void);
> >  extern bool enable_timestamp_msg;
> 
> Ignorant question: what's the return value's intended use?

For me I don't need it, I just didn't see a reason to remove it - it's
quite cheap as a stack variable (comparing to the heap variable
__print_once which will really consume some byte in the binaries) and
basically it works just like we exported that __print_once when
needed, so I kept it in case people might use it.

One example I can think of is that we can keep some error environment
when the first error happens:

  if (something_wrong_happened) {
     if (error_report_once("blablabla")) {
       /* only cache the first error */
       error_cmd = xxx;
       error_param = xxx;
       ...
     }
  }

Regards,

-- 
Peter Xu
