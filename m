Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dWFyD-0006Hf-L4
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 01:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dWFyA-0005TP-Hn
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 01:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dWFyA-0005T7-8Q
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 01:50:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-2-lprosek@redhat.com>
	<20170713133206.GA18623@stefanha-x1.localdomain>
	<CABdb735h_vjCsHR+5reKxdHXLZkzfiCiW0qr=xoxXyYJ=1Y3Mw@mail.gmail.com>
	<20170714102551.GB27446@stefanha-x1.localdomain>
Date: Sat, 15 Jul 2017 07:50:13 +0200
In-Reply-To: <20170714102551.GB27446@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 14 Jul 2017 11:25:51 +0100")
Message-ID: <87vamuckq2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, Fernando Casas =?utf-8?Q?Sch=C3=B6s?= =?utf-8?Q?sow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Thu, Jul 13, 2017 at 03:48:02PM +0200, Ladi Prosek wrote:
>> On Thu, Jul 13, 2017 at 3:32 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > On Thu, Jul 13, 2017 at 01:02:30PM +0200, Ladi Prosek wrote:
>> >> +/*
>> >> + * Print an error message to current monitor if we have one, else to stderr.
>> >> + * Format arguments like sprintf().  The resulting message should be a
>> >> + * single phrase, with no trailing punctuation.  The no-LF version allows
>> >> + * additional text to be appended with error_printf() or error_vprintf().
>> >> + * Make sure to always close with a newline after all text is printed.
>> >> + * Prepends the current location.
>> >> + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
>> >> + */
>> >> +void error_report_nolf(const char *fmt, ...)
>> >> +{
>> >> +    va_list ap;
>> >> +
>> >> +    va_start(ap, fmt);
>> >> +    error_vreport_nolf(fmt, ap);
>> >> +    va_end(ap);
>> >>  }
>> >
>> > Each call to this function prepends the timestamp, so it cannot really
>> > be used for a sequence of prints in a single line.
>> 
>> True, the _nolf means "does not append \n" rather than "can be called
>> repeatedly". You would use error_printf() / error_vprintf() for
>> subsequent prints, as mentioned in the comment above this function.
>> 
>> > It's a little ugly but I expected something along the lines of
>> > g_strdup_vprintf() in virtio_error():
>> >
>> >   char *msg;
>> >
>> >   va_start(ap, fmt);
>> >   msg = g_strdup_vprintf(fmt, ap);
>> >   va_end(ap);
>> >
>> >   error_report("%s: %s", DEVICE(vdev)->id, msg);
>> >
>> >   g_free(msg);
>> >
>> > https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-strdup-vprintf
>> 
>> I wanted to avoid the memory allocation, that's all. Not for
>> performance, obviously, but to increase the chances that it will come
>> through and always look the same if the process is under memory
>> pressure, the heap corrupted or otherwise in a bad state.
>> 
>> Both approaches look about the same ugly to me but I can certainly
>> change it to the one you're suggesting.
>
> The chance that error_report_nolf() will be used incorrectly is high.

Concur.

When malloc() starts to fail or crash, the process is basically screwed.
This should be rare.  Keeping error paths simple to improve the chances
of a useful error message getting through before the process dies is a
laudable idea anyway.  But:

* When timestamps are enabled, error_vreport() already allocates.

* When error messages go to the monitor, monitor_vprintf() already
  allocates().

We could get rid of both allocations with some effort.  Wouldn't affect
the interface.  Until we do, avoiding another small allocation is
unlikely to help.

> Performance isn't a big concern for printing error messages.  That's why
> I suggest a single error_report() call instead.
