Received: from eggs.gnu.org ([2001:4830:134:3::10]:34228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRitd-0005jf-SZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRitZ-0002yH-VM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:19:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRitZ-0002y1-BP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:19:41 -0500
Date: Tue, 27 Nov 2018 14:19:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127191938.GC8956@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-46-cota@braap.org>
	<87efb64c2e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efb64c2e.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 45/48] plugin: lockstep execution support
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

On Tue, Nov 27, 2018 at 18:20:25 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> There are no users of this for now so I don't think this qualifies for a
> first cut of the plugin API.

Fair enough. It was more as an example that plugins are not just
for instrumentation purposes. Another example of this is the use of
plugins to control the guest's clock -- for instance, there was
this series
  https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03028.html
that implemented a module to control the guest's clock over sockets.
Instead, a plugin can just be loaded to take control, and the plugin
is free to interact with the outer world in whatever way it
wants (sockets, pipes, etc.). So having a plugin infrastructure
can make adding those features much easier to implement (FWIW,
that patch never landed on master).

> Is the lockstep support only their for
> plugins? Is there any practical use that isn't handled by non-MTTCG
> round-robin and icount type scenarios?

This is a compromise between icount and MTTCG by limiting the latter's
skew among vCPUs. So you don't get full determinism, but get closer to
it without giving up parallelism.

I think this feature could be added without plugins, by for instance
defaulting to an "MTTCG icount-like" behaviour. That is, the
time window of each CPU would expire after N instructions executed.

But I didn't have a use case for that; my use case is to control
the time windows from the plugins, since in my simulator the
plugin controls the guest clock, and instructions have different
latencies.

So yes, feel free to skip this patch!

Thanks,

		Emilio
