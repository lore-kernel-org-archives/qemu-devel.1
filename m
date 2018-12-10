Received: from eggs.gnu.org ([2001:4830:134:3::10]:52308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMT3-0000Jh-8q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMT2-0007I1-8E
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:23:29 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWMT2-0007Hc-1q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:23:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id a77so9069343oii.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20181210135803.20208-1-peter.maydell@linaro.org>
	<20181210151310.3f13c28f.cohuck@redhat.com>
In-Reply-To: <20181210151310.3f13c28f.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 14:23:15 +0000
Message-ID: <CAFEAcA8q6sgirc9ydFRNGs5tCn0PjScHD_tHCR2XhxBM=CoZeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/s390/ccw.c: Don't take address of
 packed members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, qemu-s390x <qemu-s390x@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 10 Dec 2018 at 14:13, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 10 Dec 2018 13:58:03 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Taking the address of a field in a packed struct is a bad idea, because
> > it might not be actually aligned enough for that pointer type (and
> > thus cause a crash on dereference on some host architectures). Newer
> > versions of clang warn about this.
> >
> > Avoid the problem by using local copies of the PMCW and SCSW
> > struct fields in copy_schib_from_guest() and copy_schib_to_guest().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This seemed like a not totally ugly and reasonably localised fix
> > that satisfies clang. Oddly, this makes the generated object file
> > 15K smaller (421K vs 406K), so it might even be better code...
>
> Nice :)
>
> >
> >  hw/s390x/css.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 04ec5cc9705..ef07691e36b 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -1290,9 +1290,15 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
> >  static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
> >  {
> >      int i;
> > +    PMCW srcpmcw, destpmcw;
> > +    SCSW srcscsw, destscsw;
>
> <bikeshed>
> I would find src_pmcw etc. easier to read. Other opinions?
> </bikeshed>

CODING_STYLE's "Naming" section agrees with you...

thanks
-- PMM
