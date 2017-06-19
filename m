Received: from eggs.gnu.org ([2001:4830:134:3::10]:53644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMnzP-0007sx-Ad
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMnzL-0000Hq-UT
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:08:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dMnzL-0000Ge-Iz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:08:31 -0400
Date: Mon, 19 Jun 2017 00:08:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170619040829.GA10709@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615220501.GA26408@flamenco> <87y3spcqfg.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3spcqfg.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH] translator mega-patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 18, 2017 at 17:37:39 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> 
> > On Mon, Jun 12, 2017 at 17:54:09 +0300, Lluís Vilanova wrote:
> >> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> >> ---
> >> include/exec/gen-icount.h             |    2 
> >> include/exec/translate-all_template.h |   73 ++++++++++++
> >> include/qom/cpu.h                     |   22 ++++
> >> translate-all_template.h              |  204 +++++++++++++++++++++++++++++++++
> 
> > I think this concept of "template" is quite painful.
> 
> > Find appended something that I find more palatable: it embeds
> > DisasContextBase in DisasContext, so that we can have a standalone
> > object with all generic code;
> 
> I don't get it. Isn't that what my series is already doing? Or do you mean
> explicitly passing DisasContextBase to all the generic translator functions
> below?

Yes, I mean the latter.

> I kind of dislike it every time I see container_of, and it makes type
> checking from the compiler a bit more fragile.

container_of is *very* useful! You should like it more :-)

The pattern of having a struct of function pointers ("ops") +
container_of is used in the kernel extensively, and it works
very well there.

The compiler will catch misuses of container_of, which in my
experience is basically all you need. If you want stricter
typing, there's TCON ("typed container"), which is really cool:
  http://ccodearchive.net/info/tcon.html
A neat usage example are type-safe linked lists:
  http://ccodearchive.net/info/tlist2.html

> > target-specific code is called via
> > an "ops" struct with function pointers that targets fill in.
> > The target-specific DisasContext struct can then be retrieved from
> > the base struct with container_of().
> 
> I seem to remember we discussed this at some point before I sent the first
> version, to allow multiple targets on the same binary, but decided against it.
> 
> Still, I can leave the ops struct in place without even trying to support
> multiple targets.

I didn't have this in mind, but it is a nice side effect.

> It should be a little bit slower (using function pointers
> instead of a "template"), but I don't think performance will suffer that much
> since we're at the translation path.

Yes performance wouldn't be an issue, even if all we benchmarked was
translation--the key is that the function called is always the same
so prediction takes care of it. See Agner's comment on this (in the
context of C++ though, but it applies here):
> The time it takes to call a virtual member function is a few clock
> cycles more than it takes to call a non-virtual member function, provided
> that the function call statement always calls the same version of the
> virtual function. If the version changes then you may get a misprediction
> penalty of 10 - 20 clock cycles. 
http://www.agner.org/optimize/optimizing_cpp.pdf

Cheers,

		Emilio
