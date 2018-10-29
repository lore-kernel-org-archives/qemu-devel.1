Received: from eggs.gnu.org ([2001:4830:134:3::10]:37629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHAfv-0005Ze-O4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHAfq-0005Np-9e
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:45:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHAfp-0005LC-NC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:45:54 -0400
Date: Mon, 29 Oct 2018 12:45:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181029164548.GD17805@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<000701d46f6c$7dc635c0$7952a140$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701d46f6c$7dc635c0$7952a140$@ru>
Subject: Re: [Qemu-devel] [RFC 00/48] Plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?'Llu=EDs?= Vilanova' <vilanova@ac.upc.edu>, 'Peter Maydell' <peter.maydell@linaro.org>, 'Alex =?iso-8859-1?Q?Benn=E9e'?= <alex.bennee@linaro.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>

On Mon, Oct 29, 2018 at 12:48:05 +0300, Pavel Dovgalyuk wrote:
> > From: Emilio G. Cota [mailto:cota@braap.org]
> > - 2-pass translation. Once a "TB translation" callback is called,
> >   the plugin must know the span of the TB. We should not
> >   force plugins to guess where the TB will end; that is strictly
> >   QEMU's job, and can change any time. A TB is thus a sequence
> >   of instructions of whatever length the particular QEMU
> >   implementation decides. Thus, for each TB, a 3-step process
> >   is followed: (1) the plugin layer keeps a copy of the contents
> >   of the current TB, (2) once the TB is well-defined, its
> >   descriptor and contents are passed to plugins, which then
> >   register their desired instrumentation (e.g. "call me back
> >   on this particular instruction", or "call me back when
> >   the whole TB executes"); note that plugins can use a disassembler
> >   like capstone to decide what to do with each instruction; they
> >   can also allocate memory and then get a pointer to it passed
> >   back from the callbacks. And finally, (3) the target translator
> >   is called again to generate the final instrumented translated TB.
> >   This is what I called the "2-pass translation", since we go
> >   twice over the translation loop in translator.c. Note that the
> >   2-pass approach has virtually no overhead (0.40% for SPEC06int);
> >   translation is much cheaper than execution. But anyway, if no
> >   plugins have subscribed to TB translation, we only do one pass.
> 
> Can plugin affect the translation somehow to force flushing cached registers?
> E.g. callback may need correct EFLAGS which usually does not updated
> until the end of the block.

I'd provide an API call to get those up to date, since the common
case is that callbacks won't require those to be up to date.

> > - Support for inlining instrumentation. This is done via an
> >   explicit API, i.e. we do not export TCG ops, which are internal
> >   to QEMU. For now, I just have support for incrementing a u64
> >   with an immediate, e.g. to increment a counter.
> 
> It means that we'll have "yet another one TCG"?

That's certainly not my intention.

I'd only export common ops that are trivial to implement,
whether with TCG or whatever we use in 100 years time. I think
incrementing a counter is a good use of this; letting plugins
go wild by exporting a "TCG-like API" is not at all the
point. Users that demand that can be just told to fork QEMU.

Thanks,

		Emilio
