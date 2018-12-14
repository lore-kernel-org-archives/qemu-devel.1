Received: from eggs.gnu.org ([2001:4830:134:3::10]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXqwx-0007ZC-9q
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXqwu-0000O0-4T
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:08:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXqwt-0000Fp-Py
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:08:28 -0500
Date: Fri, 14 Dec 2018 12:08:22 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181214170822.GA15965@flamenco>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214155724.GB4314@quinoa.localdomain>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Fri, Dec 14, 2018 at 15:57:32 +0000, Aaron Lindsay wrote:
> Emilio,
> 
> First, thanks for putting this together - I think everyone doing this
> sort of thing will benefit if we're able to agree on one upstream plugin
> interface.
> 
> One thing I'd like to see is support for unregistering callbacks once
> they are registered. For instance, you can imagine that a plugin may
> have 'modality', where it may care about tracing very detailed
> information in one mode, but trace only limited information otherwise -
> perhaps only enough to figure out when it needs to switch back to the
> other mode.
> 
> I added a function to the user-facing plugin API in my own version of
> Pavel's plugin patchset to clear all existing plugin instrumentation,
> allowing the plugin to drop instrumentation if it was no longer
> interested. Of course, you could always add logic to a plugin to ignore
> unwanted callbacks, but it could be significantly more efficient to
> remove them entirely. In Pavel's patchset, this was essentially just a
> call to tb_flush(), though I think it would be a little more involved
> for yours.

This is a good point.

"Regular" callbacks can be unregistered by just passing NULL as the
callback (see plugin_unregister_cb__locked, which is called from
do_plugin_register_cb). "Direct" callbacks, however (i.e. the ones
that embed a callback directly in the translated code),
would have to be unregistered by flushing the particular TB
(or all TBs, which is probably better from an API viewpoint).

I think the following API call would do what you need:

  typedef int (*qemu_plugin_reset_cb_t)(qemu_plugin_id_t id);
  void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_reset_cb_t cb);

(or maybe qemu_plugin_reinstall?)

The idea is that a plugin can "reset" itself, so that (1) all
its CBs are cleared and (2) the plugin can register new callbacks.
This would all happen in an atomic context (no vCPU running), so
that the plugin would miss no CPU events.

How does this sound?

Thanks,

		Emilio
