Received: from eggs.gnu.org ([2001:4830:134:3::10]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBklE-000643-AB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBklB-0006rL-2a
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:48 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBklA-0006r7-Qz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:45 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23266.3384.611703.928502@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 18:32:40 +0100
In-Reply-To: <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
	<f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce
 errnoval parameter to vreport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel P.=?iso-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

Eric Blake writes ("Re: [RFC PATCH 1/7] error reporting: Introduce errnoval parameter to vreport"):
> On 04/26/2018 11:53 AM, Ian Jackson wrote:
> > We use strerror rather than strerror_r because strerror_r presents
> > portability difficulties.  Replacing strerror with strerror_r (or
> > something else) is left to the future.
> 
> Is g_strerror() suitably easy to use, which would at least avoid the
> portability difficulties?

Possibly.  I would prefer to leave that to a future cleanup so as not
to block the centralisation of the strerror calls...

> >   * Print a message to current monitor if we have one, else to stderr.
> >   * @report_type is the type of message: error, warning or informational.
> > + * If @errnoval is nonnegative it is fed to strerror and printed too.
> 
> That implies 0 is fed to strerror(), which is not the case.

But, 0 might be fed to strerror.  This is not normally deliberate, but
it does occor.  It is not unusual for people to write code which can
feed 0 to strerror.  strerror then conventionally returns "Error 0".

This is why I chose -1 as the sentinel value meaning "there is no
errno being passed".

> "If @errnoval is not zero, its absolute value is fed to strerror" to let
> people pass in both EIO and -EIO for the same output (something that
> strerror() can't do, but our wrapper can) - but I don't know if that
> convenience is a good thing.

I think it is more important not to turn inintended situations where 0
would previously have been passed to strerror, into situations where
the errno value string simply vanishes.

> > -static void vreport(report_type type, const char *fmt, va_list ap)
> > +static void vreport(report_type type, int errnoval,
> 
> Bikeshedding: Is 'err' or 'errval' a better name in terms of length and
> legibility?

`err' could be some kind of qemu-specific or library-specific error
code.  `errno' is the name for the specific error code space for Unix
errno.

> > +    if (errnoval >= 0) {
> > +        error_printf(": %s", strerror(errnoval));
> 
> Off-by-one.  You do NOT want to print strerror(0) (that results in
> appending ": Success" or similar to what is supposed to be an error
> message).

See above.

> > -    vreport(REPORT_TYPE_ERROR, fmt, ap);
> > +    vreport(REPORT_TYPE_ERROR, -1, fmt, ap);
> 
> Passing -1 to suppress the output feels awkward, especially if 0 can be
> used for the same purpose and would then let us use -errno and errno
> interchangeable by passing the absolute value to sterror.

I think no good can come of taking the absolute value.  The confusion
resulting from -errnoval is bad enough already IMO.

Regards,
Ian.
