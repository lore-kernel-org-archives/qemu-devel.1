Received: from eggs.gnu.org ([2001:4830:134:3::10]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dzuNG-0006hw-OF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 20:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dzuND-00088v-MB
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 20:50:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dzuND-00088M-Cz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 20:50:47 -0400
Date: Wed, 4 Oct 2017 20:50:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171005005043.GA20425@flamenco>
References: <87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco> <8760bu333n.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8760bu333n.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Oct 05, 2017 at 02:28:12 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> > I see some potential problems with this:
> > 1. Instrumenters' accesses could generate exceptions. I presume we'd want to avoid
> >    this, or leave it as a debug-only kind of option.
> 
> The API takes care of telling you if the access could be performed
> successfully. If you access the instruction's memory representation at
> translation time, it should be able to perform the access, since QEMU's
> translation loop just had to do so in order to access that instruction (I should
> check what happens in the corner case where another guest CPU changes the page
> table, since I'm not sure if the address translation functions I'm using in QEMU
> will use the per-vCPU TLB cache or always traverse the page table).

That was my concern, I'd rather just perform the read once, that is, the read(s)
done by ops->insn_translate.

> > 2. Instrumenters won't know where the end of an instruction (for variable-length
> >   ISAs) or of a TB is (TB != basic block). For instructions one could have a loop
> >   where we read byte-by-byte and pass it to the decoder, something similar to
> >   what we have in the capstone code recently posted to the list (v4). For TBs,
> >   we really should have a way to delimit the length of the TB. This is further
> >   complicated if we want instrumentation to be inserted *before* a TB is
> >   translated.
> 
> > Some thoughts on the latter problem: if we want a tb_trans_pre callback, like
> > Pin/DynamoRIO provide, instead of doing two passes (one to delimit the TB and
> > call the tb_trans_pre callback, to then generate the translated TB), we could:
> >   - have a tb_trans_pre callback. This callback inserts an exec-time callback
> >     with a user-defined pointer (let's call it **tb_info). The callback has
> >     no arguments, perhaps just the pc.
> >   - have a tb_trans_post callback. This one passes a copy of the guest
> >     instructions. The instrumenter then can allocate whatever data structure
> >     to represent the TB (*tb_info), and copies this pointer to **tb_info, so
> >     that at execution time, we can obtain tb_info _before_ the TB is executed.
> >     After the callback returns, the copy of the guest instructions can be freed.
> >   This has two disadvantages:
> >   - We have an extra dereference to find tb_info
> >   - If it turns out that the TB should not be instrumented, we have generated
> >     a callback for nothing.
> 
> That's precisely one of the reasons why I proposed adding instrumentation points
> before and after events happen (e.g., instrument right after translating an
> instruction, where you know its size).
> 
> What you propose is actually a broader issue, how to allow instrumentors to pass
> their own data to execution-time functions "after the fact". For this, I
> implemented "promises", a kind of generalization of what gen_icount() does (you
> pass a value to the execution-time callback that is computed later during
> translation-time).

I see. I implemented what I suggested above, i.e. tb_trans_cb
(i.e. post_trans) passes an opaque descriptor of the TB (which can
be iterated over insn by insn) and the return value (void *) of this
cb will be passed by tb_exec_cb (i.e. pre_exec).  Perf-wise this
is pretty OK, turns out even if we don't end up caring about the
TB, the additional per-TB helper (which might not end up calling
a callback) does not introduce significant overhead at execution time.

The major hurdle I found is what to do when removing a plugin,
so that we avoid flushing potentially all translated code. What I ended up
doing is adding a per-TB list of "plugin_tb" descriptors, which
track these user pointers so that (1) each plugin gets the right
pointer, and (2) if n_plugins > 1, we still have a single helper
that dispatches the callbacks instead of n_plugin helpers.

If I understand correctly, with promises we directly generate
a callback, which has the promise(s) as one (or more) of its
arguments. This is neat and very flexible. However, it forces us to
retranslate the TB when the plugin is removed (if we're lazy we could
flush all TBs), and if we have several plugins, we end up with one
helper per callback, instead of a single one.
None of this is a huge deal though, I just think is worth considering.

Also, I'm not sure Peter and others would be happy with allowing
plugin code to generate arbitrary callbacks (IIRC arbitrary code
has already been ruled out). So perhaps a more restrictive option
like what I suggested above would be more palatable.

Cheers,

		Emilio
