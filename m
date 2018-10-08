Received: from eggs.gnu.org ([2001:4830:134:3::10]:45574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9W4v-0000fB-7I
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9W4p-0006eW-0I
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9W4m-0006ZK-SL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:02 -0400
Date: Mon, 8 Oct 2018 09:59:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008135953.GA19899@flamenco>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181007012337.GA23787@flamenco> <875zycohpl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zycohpl.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

On Mon, Oct 08, 2018 at 11:28:38 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > Again, for performance you'd avoid the tracepoint (i.e. calling
> > a helper to call another function) and embed directly the
> > callback from TCG. Same thing applies to TB's.
> 
> OK I see what you mean. I think that is doable although it might take a
> bit more tcg plumbing.

I have patches to do it, it's not complicated.

> >> So what do people think? Could this be a viable way to extend QEMU
> >> with plugins?
> >
> > For frequent events such as the ones mentioned above, I am
> > not sure plugins can be efficiently implemented under
> > tracing.
> 
> I assume some form of helper-per-instrumented-event/insn is still going
> to be needed though? We are not considering some sort of EBF craziness?

Helper, yes. But one that points directly to plugin code.

> > For others (e.g. cpu_init events), sure, they could.
> > But still, differently from tracers, plugins can come and go
> > anytime, so I am not convinced that merging the two features
> > is a good idea.
> 
> I don't think we have to mirror tracepoints and plugin points but I'm in
> favour of sharing the general mechanism and tooling rather than having a
> whole separate set of hooks. We certainly don't want anything like:
> 
>           trace_exec_tb(tb, pc);
>           plugin_exec_tb(tb, pc);
> 
> scattered throughout the code where the two do align.

We could have something like

	plugin_trace_exec_tb(tb, pc);

that would expand to the two lines above. Or similar.

So I agree with you that in some cases the "trace points"
for both tracing and plugin might be the same, perhaps
identical. But that doesn't necessarily mean that making
plugins a subset of tracing is a good idea.

I think sharing my plugin implementation will help the
discussion. I'll share it as soon as I can (my QEMU plate
is full already trying to merge a couple of other features
first).

Thanks,

		Emilio
