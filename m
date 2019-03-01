Received: from eggs.gnu.org ([209.51.188.92]:50912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzkNP-0004vr-47
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzkBd-0006Lc-Ts
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:34:59 -0500
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:40550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzkBd-0006Bu-M8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:34:57 -0500
Received: from player715.ha.ovh.net (unknown [10.109.159.73])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id AB961462C6
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 16:34:47 +0100 (CET)
Date: Fri, 1 Mar 2019 16:34:42 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190301163442.4b7a61e3@bahia.lan>
In-Reply-To: <CAFEAcA9gQpGzQ73ARykA56Dg=41L8oTQKs7Jpi-yqYEt5kg2SA@mail.gmail.com>
References: <155137665241.44413.528147250140332507.stgit@bahia.lan>
	<CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
	<20190301155951.11122086@bahia.lan>
	<CAFEAcA9gQpGzQ73ARykA56Dg=41L8oTQKs7Jpi-yqYEt5kg2SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

On Fri, 1 Mar 2019 15:15:43 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 1 Mar 2019 at 14:59, Greg Kurz <groug@kaod.org> wrote:
> >
> > On Thu, 28 Feb 2019 18:28:23 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Thu, 28 Feb 2019 at 17:57, Greg Kurz <groug@kaod.org> wrote:  
> > > > +    /*
> > > > +     * MTP Specification 3.2.3 Strings
> > > > +     * Strings in PTP (and thus MTP) consist of standard 2-byte Unicode
> > > > +     * characters as defined by ISO 10646. Strings begin with a single, 8-bit
> > > > +     * unsigned integer that identifies the number of characters to follow (not
> > > > +     * bytes).
> > > > +     *
> > > > +     * This causes dataset->filename to be unaligned.
> > > > +     */
> > > > +    filename_len = MIN(dataset->length, dlen - offsetof(ObjectInfo, filename));
> > > > +    utf16_filename = g_memdup(dataset->filename, filename_len * 2);
> > > > +    filename = utf16_to_str(filename_len, utf16_filename);
> > > > +    g_free(utf16_filename);  
> 
> > > Do we do the right thing if we are
> > > passed a malicious USB packet that ends halfway through a
> > > utf16_t character, or do we index off the end of the packet
> > > data ?
> > >  
> >
> > Can you elaborate ?  
> 
> If the data packet length is such that the packet stops
> one byte into a two-byte character in the filename,
> do we try to read the two bytes that straddle
> the end of the buffer ?
> 
> In fact this expression looks bogus:
>  filename_len = MIN(dataset->length, dlen - offsetof(ObjectInfo, filename));
> 
> because dataset->length (as the comment says) is a
> count of 2-byte characters, but the calculation involving
> offsetof() is a byte count. So we don't correctly clip
> the character count and utf16_to_str() will happily
> read off the end of the buffer it is passed.
> 

Oh you're right, this should rather be:

    filename_len = MIN(dataset->length * 2, dlen - offsetof(ObjectInfo, filename)) / 2;

So that if length is say 20 (ie, 40 bytes) but the buffer only has say 39 bytes
for the filename, we clip at 19 characters.

Since the current code already has the issue, I guess this should be fixed
in its own patch.

> thanks
> -- PMM
