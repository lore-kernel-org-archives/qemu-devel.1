Received: from eggs.gnu.org ([2001:4830:134:3::10]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csWgh-0003Vh-H1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csWge-0005G8-Eb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csWge-0005E5-1x
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:36:04 -0400
Date: Mon, 27 Mar 2017 16:35:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170327153559.GB2757@work-vm>
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
	<87bmsv29ok.fsf@dusky.pond.sub.org>
	<CAFEAcA-XZ-STrvzv4nrxrMCd3ureKXpLeAFpoPktNYb++YMusQ@mail.gmail.com>
	<87zigfyj9v.fsf@dusky.pond.sub.org>
	<7cd9f32b-5004-fbcf-bc53-67b1e669df0b@redhat.com>
	<40d2f327-46ec-8a1d-a3c4-0bb90180b847@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d2f327-46ec-8a1d-a3c4-0bb90180b847@gnu.org>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

* Paolo Bonzini (bonzini@gnu.org) wrote:
> 
> 
> On 20/03/2017 18:16, Paolo Bonzini wrote:
> > 
> > 
> > On 20/03/2017 18:01, Markus Armbruster wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >>> On 20 March 2017 at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
> >>>> Peter Maydell <peter.maydell@linaro.org> writes:
> >>>>> I have some comments which feel kind of nit-picky, but since this
> >>>>> is a public-facing HMP API I think they need attention since we only
> >>>>> get one chance to get it right.
> >>>>
> >>>> HMP is not a stable interface.  If we get it wrong, we change it.  If
> >>>> our change breaks your usage, you get to keep the pieces.
> >>>
> >>> Oh yes, I had my HMP and QMP the wrong way round.
> >>>
> >>> ...which reminds me that I thought we preferred all HMP commands
> >>> to be implemented in terms of their QMP equivalent ?
> >>
> >> Yes.  We make exceptions for commands we believe have no QMP use, such
> >> as "print".  I figure the rationale for these is "just for testing".
> >> Paolo, can you confirm?
> > 
> > Yes.  If somebody comes up with a non-testing use, I suppose we can
> > always add a QMP variant.  I'll send v3 which uses the current monitor
> > CPU's address space according to Peter's review.
> 
> Since there is no CPU method to transform a CPU state into a MemTxAttrs
> value, and the MemTxAttrs are needed to get the right address space, v2
> is the best I can do for 2.9.
> 
> Changing it to take the CPU state into account (e.g. include secure
> memory when in secure mode) can be done in later releases if necessary.
> 
> David, are you queuing the patch?
> 
> Paolo

Unfortunately it's hitting a warning on the mingw build:

/home/dgilbert/git/hmp/monitor.c: In function 'hmp_gpa2hva':
/home/dgilbert/git/hmp/monitor.c:1461:5: error: 'mr' may be used uninitialized in this function [-Werror=maybe-uninitialized]
     memory_region_unref(mr);
     ^~~~~~~~~~~~~~~~~~~~~~~

I think that's the compiler not being clever enough to spot that path
would always be initialised.

I guess it just needs an = NULL on the mr.

(i686-w64-mingw32-gcc gcc version 6.3.0 20161221 (Fedora MinGW 6.3.0-1.fc25) (GCC) )

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
