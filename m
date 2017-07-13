Received: from eggs.gnu.org ([2001:4830:134:3::10]:38220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVeTQ-0007TA-Cp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVeTM-0006zI-Fw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:48:08 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVeTM-0006yo-Af
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:48:04 -0400
Received: by mail-ua0-f175.google.com with SMTP id z22so33958730uah.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:48:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713133206.GA18623@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-2-lprosek@redhat.com>
	<20170713133206.GA18623@stefanha-x1.localdomain>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 15:48:02 +0200
Message-ID: <CABdb735h_vjCsHR+5reKxdHXLZkzfiCiW0qr=xoxXyYJ=1Y3Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Thu, Jul 13, 2017 at 3:32 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Thu, Jul 13, 2017 at 01:02:30PM +0200, Ladi Prosek wrote:
>> +/*
>> + * Print an error message to current monitor if we have one, else to stderr.
>> + * Format arguments like sprintf().  The resulting message should be a
>> + * single phrase, with no trailing punctuation.  The no-LF version allows
>> + * additional text to be appended with error_printf() or error_vprintf().
>> + * Make sure to always close with a newline after all text is printed.
>> + * Prepends the current location.
>> + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
>> + */
>> +void error_report_nolf(const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +
>> +    va_start(ap, fmt);
>> +    error_vreport_nolf(fmt, ap);
>> +    va_end(ap);
>>  }
>
> Each call to this function prepends the timestamp, so it cannot really
> be used for a sequence of prints in a single line.

True, the _nolf means "does not append \n" rather than "can be called
repeatedly". You would use error_printf() / error_vprintf() for
subsequent prints, as mentioned in the comment above this function.

> It's a little ugly but I expected something along the lines of
> g_strdup_vprintf() in virtio_error():
>
>   char *msg;
>
>   va_start(ap, fmt);
>   msg = g_strdup_vprintf(fmt, ap);
>   va_end(ap);
>
>   error_report("%s: %s", DEVICE(vdev)->id, msg);
>
>   g_free(msg);
>
> https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-strdup-vprintf

I wanted to avoid the memory allocation, that's all. Not for
performance, obviously, but to increase the chances that it will come
through and always look the same if the process is under memory
pressure, the heap corrupted or otherwise in a bad state.

Both approaches look about the same ugly to me but I can certainly
change it to the one you're suggesting.

> Stefan
