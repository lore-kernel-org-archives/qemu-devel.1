Received: from eggs.gnu.org ([2001:4830:134:3::10]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWPXo-00066A-Pj
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWPXl-0000Vc-Lg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:40:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gWPXl-0000VR-Bq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:40:33 -0500
Date: Mon, 10 Dec 2018 12:40:31 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181210174031.GA22562@flamenco>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-7-cota@braap.org>
	<002301d4907c$b9854390$2c8fcab0$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002301d4907c$b9854390$2c8fcab0$@ru>
Subject: Re: [Qemu-devel] [RFC v2 06/38] plugin: add core code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, 'Alex =?iso-8859-1?Q?Benn=E9e'?= <alex.bennee@linaro.org>, 'Richard Henderson' <richard.henderson@linaro.org>

On Mon, Dec 10, 2018 at 14:37:25 +0300, Pavel Dovgalyuk wrote:
> > From: Emilio G. Cota [mailto:cota@braap.org]
(snip)
> > +struct qemu_plugin_dyn_cb_arr {
> > +    struct qemu_plugin_dyn_cb *data;
> > +    size_t n;
> > +    size_t capacity;
> > +};
> > +
> 
> Why not list or something dynamic?

Performance. Registering of dynamic callbacks can happen
very frequently (e.g. several times per instruction
translated), so we avoid malloc/free churn by keeping
an array of callback requests that we reuse across
translated TB's. The hierarchy is:

struct qemu_plugin_tb {
	insns[n_insns_in_the_tb] {
		dyn_cb_arr[various types];
	}
}

Each array has a "capacity" field so that we only ever expand
the arrays. This ensures that the amortized cost of
adding callbacks is negligible.

> Is the indexing required?

No, this is done just for performance.

> Can you add the comments for the data structures and functions?
> It is very hard to seek through the whole patch to get the details about them.

I had some comments but then the code evolved quickly and the
comments were outdated, which led to confusion. So I removed
most of them.

To understand the code I recommend you to go through one
of the examples and then follow the API calls, first through
plugin.c and then to plugin-gen.c where the instrumentation
is injected (based on the contents of the dyn_cb arrays).

Please ask further questions if anything is unclear.

Thanks,

		Emilio
