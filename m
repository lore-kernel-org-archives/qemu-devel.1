Received: from eggs.gnu.org ([2001:4830:134:3::10]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gROpS-00076q-P5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gROpP-0007o1-JD
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:54:06 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gROpO-0007nk-Fn
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:54:02 -0500
Date: Mon, 26 Nov 2018 16:53:58 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126215358.GA22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-20-cota@braap.org>
	<87r2fbhgok.fsf@linaro.org> <20181123231528.GA13782@flamenco>
	<87va4k3xvj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va4k3xvj.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 19/48] translate-all: notify plugin code of
 tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, Nov 26, 2018 at 11:02:24 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > On Fri, Nov 23, 2018 at 17:00:59 +0000, Alex Bennée wrote:
> >> What is the purpose of letting the plugin know a flush has occurred?
> >
> > Plugins might allocate per-TB data that then they get passed each
> > time the TB is executed (via the *userdata pointer). For example,
> > in a simulator we'd allocate a per-TB struct that describes the
> > guest instructions, after having disassembled them at translate time.
> >
> > It is therefore useful for plugins to know when all TB's have been
> > flushed, so that they can then free that per-TB data.
> 
> Would they need a generation count propagated here or would it just be
> flush anything translation related at this point?

The callback is guaranteed to be called in an exclusive context, so
plugins can just rely on that; since no code execution can happen at
that time, there's no need to pass further info, since the plugins
can free that data right from the callback.

> >> It shouldn't have any knowledge of the details of liveliness of the
> >> translated code and if it still exits or not. If all it wants to do is
> >> look at the counts then I think we can provide a simpler less abuse-able
> >> way to do this.
> >
> > I'm confused. What does "look at the counts" mean here?
> >
> > To reiterate, plugins should have a way to know when a TB doesn't
> > exist any longer, so that they can reclaim memory.
>
> OK that makes sense. Could you expand the commit message just to explain
> the use case?
>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Updated the commit message with:

    translate-all: notify plugin code of tb_flush

    Plugins might allocate per-TB data that then they get passed each
    time a TB is executed (via the *userdata pointer).

    Notify plugin code every time a code cache flush occurs, so
    that plugins can then reclaim the memory of the per-TB data.

Thanks,

                Emilio
