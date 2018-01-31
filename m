Received: from eggs.gnu.org ([2001:4830:134:3::10]:51912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egoaz-00019B-Ss
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egoau-0002TW-Q3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:22:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egoau-0002Sm-Ij
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:22:16 -0500
Date: Wed, 31 Jan 2018 10:22:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180131092213.srlhijglevhha6jw@sirius.home.kraxel.org>
References: <20180130051837.8725-1-programmingkidx@gmail.com>
	<20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
	<167881EE-F694-46C3-A15B-94B1733D2E40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167881EE-F694-46C3-A15B-94B1733D2E40@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new
 logging API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 30, 2018 at 10:30:46AM -0500, Programmingkid wrote:
> 
> > On Jan 30, 2018, at 4:41 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> >> @@ -148,15 +142,16 @@ static int irq_of_magic (int magic)
> >> #if 0
> >> static void log_dsp (SB16State *dsp)
> >> {
> >> -    ldebug ("%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:speaker=%d\n",
> >> -            dsp->fmt_stereo ? "Stereo" : "Mono",
> >> -            dsp->fmt_signed ? "Signed" : "Unsigned",
> >> -            dsp->fmt_bits,
> >> -            dsp->dma_auto ? "Auto" : "Single",
> >> -            dsp->block_size,
> >> -            dsp->freq,
> >> -            dsp->time_const,
> >> -            dsp->speaker);
> >> +    qemu_log_mask(LOG_UNIMP, "%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:"
> >> +                  "speaker=%d\n",
> >> +                  dsp->fmt_stereo ? "Stereo" : "Mono",
> >> +                  dsp->fmt_signed ? "Signed" : "Unsigned",
> >> +                  dsp->fmt_bits,
> >> +                  dsp->dma_auto ? "Auto" : "Single",
> >> +                  dsp->block_size,
> >> +                  dsp->freq,
> >> +                  dsp->time_const,
> >> +                  dsp->speaker);
> >> }
> >> #endif
> > 
> > Hmm, dead code.  Any places which call log_dsp() ?
> 
> There are several places but they are all dead code. Do you want this removed?

So it is still used but not compiled in by default.

Looking at all of this again, I think "qemu_log_mask(LOG_UNIMP, ...)"
should only be used in case there *really* is some soundblaster feature
unimplemented.  Otherwise converting to a tracepoint is probably more
useful, so the debug messages can be enabled/disabled individually at
runtime.

The "#if 0" seems to be there to limit the flood of debug messages.  So
once they all are converted to trace points this is not needed any more
and I think we should just enable all this code.

dolog() seems to be mostly cases where the code warns about
unimplemented featues or incomplete emulation, so using LOG_UNIMP looks
sensible.

ldebug() should probably trace points.

Probably makes sense to split this patch up into a small series.

cheers,
  Gerd
