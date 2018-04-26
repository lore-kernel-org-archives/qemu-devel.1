Received: from eggs.gnu.org ([2001:4830:134:3::10]:43028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkug-00036s-7g
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkud-0002Az-DT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:34 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkud-0002Ac-2l
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:31 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23266.3971.318335.800114@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 18:42:27 +0100
In-Reply-To: <ccb01c57-22e7-8b04-d278-eb7c0e654fe7@redhat.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
	<ccb01c57-22e7-8b04-d278-eb7c0e654fe7@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/7] error reporting: Provide
 error_report_errnoval (and error_vreport_errnoval)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel
	P.=?iso-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

Eric Blake writes ("Re: [RFC PATCH 5/7] error reporting: Provide error_report_errnoval (and error_vreport_errnoval)"):
> On 04/26/2018 11:53 AM, Ian Jackson wrote:
> > I have chosen to provide all of
> >    error_report_errno       error_vreport_errno
> >    error_report_errnoval    error_vreport_errnoval
> > because the former are much more common, and deserve a short spelling;
> > whereas there are still at least 30-40 potential callers of the latter.
> 
> As mentioned in 2/7, that's inconsistent with error_setg_errno().

I didn't see error_setg_errno().  But I don't mind your alternative
approach, with the explicit errno, if that's what people prefer.  I
agree about the names of the functions, in that case.

> > +void error_vreport_errnoval(int errnoval,
> > +                            const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
> > +void error_report_errnoval(int errnoval,
> > +                           const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> 
> Bikeshedding - can we name the parameter 'os_error' (as in
> error_seg_errno), or 'err' or 'errval', rather than the longer 'errnoval'?

In speech, one always refers to these things as `errno values'.
`os_error' and `errnoval' are the same length of course.  See my other
mail about this particular bikeshed.

> Should this explicitly document that passing 0 for errnoval is
> acceptable or forbidden?  If acceptable, does that mean no suffix (other
> than \n) is added?  If forbidden, do we want to assert() that?

My intend was that passing 0 for errnoval is exactly as permitted or
forbidden as passing 0 to strerror.  I think that this is neatly
implied by the specification:

> > + * Prepend the current location and append ": " strerror(errnoval) "\n".

These functions already have a problem with excessive boilerplate in
their language.  I'm loathe to make that worse by being other than
terse.  I wouldn't mind a note somewhere else.

I would be open to asserting that the value is not negative, because
we do have some of the confusing -errno convention in some of qemu.
OTOH that turns a mishandling of -errno on an error path from a wrong
error message into a crash which is a bit unfortunate.

Ian.
