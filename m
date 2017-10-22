Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ian@freebsd.org>) id 1e6LZo-0008HD-Be
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 15:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ian@freebsd.org>) id 1e6LZl-0001q2-7s
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 15:06:24 -0400
Received: from outbound1b.ore.mailhop.org ([54.200.247.200]:15750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ian@freebsd.org>) id 1e6LZl-0001mS-1u
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 15:06:21 -0400
Message-ID: <1508699172.7314.12.camel@freebsd.org>
From: Ian Lepore <ian@freebsd.org>
Date: Sun, 22 Oct 2017 13:06:12 -0600
In-Reply-To: <82BA0070-FFBB-4868-AE48-D7A3671621C5@gmail.com>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<20171022053315.GA15297@umbus>
	<82BA0070-FFBB-4868-AE48-D7A3671621C5@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>, devicetree-compiler@vger.kernel.org, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Sun, 2017-10-22 at 10:41 -0400, Programmingkid wrote:
> > 
> > On Oct 22, 2017, at 1:33 AM, David Gibson  wrote:
> > 
> > On Fri, Oct 20, 2017 at 04:44:58PM -0700, Richard Henderson wrote:
> > > 
> > > On 10/20/2017 10:55 AM, John Arbuckle wrote:
> > > > 
> > > > +static inline size_t strnlen(const char *string, size_t max_count)
> > > > +{
> > > > +    size_t count;
> > > > +    for (count = 0; count < max_count; count++) {
> > > > +        if (string[count] == '\0') {
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +    return count;
> > > Not to nitpick, but
> > > 
> > >  const char *p = memchr(string, 0, max_count);
> > >  return p ? max_count : p - string;
> > Richard's right, that's definitely a better implementation.
> His implementation is smaller, but this one is even smaller. Plus it uses the familiar strlen() function:
> 
> size_t strnlen(const char *string, size_t max_count)
> {
>     return strlen(string) < max_count ? strlen(string) : max_count;
> }

That is not a proper implementation of strnlen(), which is not supposed
to access any source-string bytes beyond max_count.

-- Ian
