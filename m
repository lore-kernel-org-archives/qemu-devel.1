Received: from eggs.gnu.org ([2001:4830:134:3::10]:58798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRMER-00008G-Km
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRMEL-0000uZ-OR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:07:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRMEL-0000uJ-0U
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:07:37 -0500
Date: Mon, 26 Nov 2018 14:07:33 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126190733.GC6688@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Mon, Nov 26, 2018 at 10:27:12 -0800, Richard Henderson wrote:
> On 11/26/18 6:52 AM, Alex Bennée wrote:
> > I'm not convinced this is the best way to go about it. We end up having
> > to sprinkle the plugin calls into each decoder rather than keeping all
> > the infrastructure in the common main loop. However the common loop will
> > need to know the total number of bytes decoded so we could change the
> > declaration to:
> > 
> >   int (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> > 
> > and return the number of bytes decoded. 
> 
> Returning the number of bytes is more difficult than simply just
> 
>     old_pc = db->pc_next;
>     opc->translate_insn(db, cpu);
>     bytes = db->pc_next - old_pc;
> 
> requiring no target changes at all.

The main reason why I added the qemu_plugin_insn_append calls
was to avoid reading the instructions twice from guest memory,
because I was worried that doing so might somehow alter the
guest's execution, e.g. what if we read a cross-page instruction,
and both pages mapped to the same TLB entry? We'd end up having
more TLB misses because instrumentation was enabled.

If you think that's not really a concern, we could just re-do
the reads in the translator loop and get the size as above.

Thanks,

		Emilio
