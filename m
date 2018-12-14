Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXrkI-000863-6T
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXrkD-0004FO-55
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:59:30 -0500
Received: from mail-eopbgr690093.outbound.protection.outlook.com
	([40.107.69.93]:47968
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gXrkC-0004B7-QE
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:59:25 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 14 Dec 2018 17:59:20 +0000
Message-ID: <20181214175915.GD4314@quinoa.localdomain>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
	<20181214170822.GA15965@flamenco>
In-Reply-To: <20181214170822.GA15965@flamenco>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <26847277DCCEC34FB2A58B1E0BE02175@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Dec 14 12:08, Emilio G. Cota wrote:
> On Fri, Dec 14, 2018 at 15:57:32 +0000, Aaron Lindsay wrote:
> > Emilio,
> >=20
> > First, thanks for putting this together - I think everyone doing this
> > sort of thing will benefit if we're able to agree on one upstream plugi=
n
> > interface.
> >=20
> > One thing I'd like to see is support for unregistering callbacks once
> > they are registered. For instance, you can imagine that a plugin may
> > have 'modality', where it may care about tracing very detailed
> > information in one mode, but trace only limited information otherwise -
> > perhaps only enough to figure out when it needs to switch back to the
> > other mode.
> >=20
> > I added a function to the user-facing plugin API in my own version of
> > Pavel's plugin patchset to clear all existing plugin instrumentation,
> > allowing the plugin to drop instrumentation if it was no longer
> > interested. Of course, you could always add logic to a plugin to ignore
> > unwanted callbacks, but it could be significantly more efficient to
> > remove them entirely. In Pavel's patchset, this was essentially just a
> > call to tb_flush(), though I think it would be a little more involved
> > for yours.
>=20
> This is a good point.
>=20
> "Regular" callbacks can be unregistered by just passing NULL as the
> callback (see plugin_unregister_cb__locked, which is called from
> do_plugin_register_cb).

Ah, okay, thanks - I missed this detail when looking through your
patches earlier.

> "Direct" callbacks, however (i.e. the ones
> that embed a callback directly in the translated code),
> would have to be unregistered by flushing the particular TB
> (or all TBs, which is probably better from an API viewpoint).
>=20
> I think the following API call would do what you need:
>=20
>   typedef int (*qemu_plugin_reset_cb_t)(qemu_plugin_id_t id);
>   void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_reset_cb_t cb);
>=20
> (or maybe qemu_plugin_reinstall?)

I think I prefer your initial suggestion of qemu_plugin_reset - to me it
does a better job communicating that existing callbacks will be removed.
But, then again, _reinstall makes it more clear that you are responsible
for re-adding any callbacks you still want...

> The idea is that a plugin can "reset" itself, so that (1) all
> its CBs are cleared and (2) the plugin can register new callbacks.
> This would all happen in an atomic context (no vCPU running), so
> that the plugin would miss no CPU events.

The implication being that there would not be the same possibility of
other callbacks being called between when qemu_plugin_reset and the
qemu_plugin_reset_cb_t callback are called as there is at plugin
un-installation time?

> How does this sound?

I think what you describe is exactly what I'm interested in.

-Aaron
