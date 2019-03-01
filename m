Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzjtF-00086e-Dc
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzjtE-0008Fv-Jz
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:15:57 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzjtE-0008Ax-C0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:15:56 -0500
Received: by mail-oi1-x241.google.com with SMTP id t206so19752825oib.3
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 07:15:55 -0800 (PST)
MIME-Version: 1.0
References: <155137665241.44413.528147250140332507.stgit@bahia.lan>
	<CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
	<20190301155951.11122086@bahia.lan>
In-Reply-To: <20190301155951.11122086@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 15:15:43 +0000
Message-ID: <CAFEAcA9gQpGzQ73ARykA56Dg=41L8oTQKs7Jpi-yqYEt5kg2SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

On Fri, 1 Mar 2019 at 14:59, Greg Kurz <groug@kaod.org> wrote:
>
> On Thu, 28 Feb 2019 18:28:23 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 28 Feb 2019 at 17:57, Greg Kurz <groug@kaod.org> wrote:
> > > +    /*
> > > +     * MTP Specification 3.2.3 Strings
> > > +     * Strings in PTP (and thus MTP) consist of standard 2-byte Unicode
> > > +     * characters as defined by ISO 10646. Strings begin with a single, 8-bit
> > > +     * unsigned integer that identifies the number of characters to follow (not
> > > +     * bytes).
> > > +     *
> > > +     * This causes dataset->filename to be unaligned.
> > > +     */
> > > +    filename_len = MIN(dataset->length, dlen - offsetof(ObjectInfo, filename));
> > > +    utf16_filename = g_memdup(dataset->filename, filename_len * 2);
> > > +    filename = utf16_to_str(filename_len, utf16_filename);
> > > +    g_free(utf16_filename);

> > Do we do the right thing if we are
> > passed a malicious USB packet that ends halfway through a
> > utf16_t character, or do we index off the end of the packet
> > data ?
> >
>
> Can you elaborate ?

If the data packet length is such that the packet stops
one byte into a two-byte character in the filename,
do we try to read the two bytes that straddle
the end of the buffer ?

In fact this expression looks bogus:
 filename_len = MIN(dataset->length, dlen - offsetof(ObjectInfo, filename));

because dataset->length (as the comment says) is a
count of 2-byte characters, but the calculation involving
offsetof() is a byte count. So we don't correctly clip
the character count and utf16_to_str() will happily
read off the end of the buffer it is passed.

thanks
-- PMM
