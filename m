Received: from eggs.gnu.org ([2001:4830:134:3::10]:43749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXtK9-0006LL-Dd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXtK6-0003vH-Oq
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:40:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXtK6-0003uc-CJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:40:34 -0500
Date: Fri, 14 Dec 2018 14:40:31 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181214194031.GA12657@flamenco>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
	<20181214170822.GA15965@flamenco> <20181214175022.GA18314@flamenco>
	<20181214184733.GA12361@quinoa.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214184733.GA12361@quinoa.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Fri, Dec 14, 2018 at 18:47:42 +0000, Aaron Lindsay wrote:
> On Dec 14 12:50, Emilio G. Cota wrote:
> > On Fri, Dec 14, 2018 at 12:08:22 -0500, Emilio G. Cota wrote:
> > > On Fri, Dec 14, 2018 at 15:57:32 +0000, Aaron Lindsay wrote:
> > (snip)
> > > > I added a function to the user-facing plugin API in my own version of
> > > > Pavel's plugin patchset to clear all existing plugin instrumentation,
> > (snip)
> > > I think the following API call would do what you need:
> > > 
> > >   typedef int (*qemu_plugin_reset_cb_t)(qemu_plugin_id_t id);
> > >   void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_reset_cb_t cb);
> > > 
> > > (or maybe qemu_plugin_reinstall?)
> > 
> > An alternative is to track the TBs that a plugin has inserted
> > instrumentation into, and only flush those. This would require
> > us to do an additional hash table insert when adding a
> > direct callback, but it allow us to avoid exporting tb_flush indirectly
> > to plugins, which could be abused by malicious plugins to perform
> > a DoS attack.
> 
> I don't think I have a preference. Though now I'm curious - when/why do
> you expect users might run plugins that could be malicious in this way?

When this work started, others expressed concern about potentially
malicious plugins, although I think they were thinking of preventing
plugins from gaining access to data structures that could affect
the guest, e.g. CPUState. That's why I'm using a hash table for
the plugin context id, although that's probably overkill (do we
care about malicious plugins messing with the subscriptions of
other plugins? Not sure we should.)

Here I'm thinking more about giving plugin developers too much rope to
hang themselves with, e.g. calling repeatedly plugin_reset() out
of convenience, without realising the performance impact that
it entails. That's why I'd like to explore the alternative.

		Emilio
