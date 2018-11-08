Received: from eggs.gnu.org ([2001:4830:134:3::10]:55500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKntM-00052O-EC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKntH-0002h3-DG
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKntH-0002XH-1J
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:47 -0500
Date: Thu, 8 Nov 2018 15:14:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108171437.GM12503@habkost.net>
References: <41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 08, 2018 at 02:42:19PM +0100, Paolo Bonzini wrote:
> On 08/11/2018 14:06, Eduardo Habkost wrote:
> > On Thu, Nov 08, 2018 at 10:55:21AM +0100, Paolo Bonzini wrote:
> >> On 07/11/2018 20:30, Thomas Huth wrote:
> >>> On 2018-11-07 20:24, Eduardo Habkost wrote:
> >>>> On Wed, Nov 07, 2018 at 06:39:54PM +0100, Paolo Bonzini wrote:
> >>>>> On 07/11/2018 16:41, Samuel Ortiz wrote:
> >>>>>> - The Kconfig parser would be used to generate the equivalent of=
 what we
> >>>>>>   currently have under default-configs/
> >>>
> >>> I think we would still have something like default-configs - but th=
ere
> >>> would only be the bare minimum config switches in there, the rest w=
ould
> >>> be pulled in by dependencies.
> >>
> >> Yes, in theory default-configs would end up empty, except for possib=
ly
> >> some commented lines to show the "default y" symbols for the target.
> >>
> >>> We could then also even have multiple config directories:
> >>>
> >>> ./configs
> >>>  +-------/default-softmmu
> >>>  +-------/default-linux-user
> >>>  +-------/nemu (or lean-kvm or something similar)
> >>>  +...
> >>>
> >>> ... just my 0.02 =E2=82=AC, feel free to ignore that idea ;-)
> >>
> >> Yup, one can also think of a configure option like "./configure
> >> --with-device-config=3Dconfigs/nemu/" to pick up the alternative
> >> configurations.
> >>
> >>>> Also, I would like to eventually replace many ./configure options
> >>>> with options read from a build configuration file.
> >>>>
> >>>> Distributions often have huge ./configure command lines in their
> >>>> QEMU packages, and they could be replaced by simple build
> >>>> configuration files.
> >>>>
> >>>> Having a mode that requires all build options to be specified
> >>>> explicitly (instead of silently picking a default) would be
> >>>> useful for distributions, too.
> >>>
> >>> I think we should maybe not mix host configuration (via ./configure=
) and
> >>> the target configuration (via kconfig), should we?
> >>
> >> Yeah, the configure command line is a different story.  If there are
> >> suggestion on how to improve it, great, but let's not conflate it wi=
th
> >> Kconfig.
> >=20
> > I believe we have many ./configure options that are supposed to
> > be target configuration.  e.g.: --enable-slirp, --eanble-kvm,
> > --enable-xen, etc.
>=20
> SLIRP is not a target configuration, it's a backend like most other
> configure command line options.  The accelerators are but (except for
> TCG of course) they also depend on the host OS and architecture, which
> makes them a bit more complicated than default-configs/ symbols.  There
> are also things like --enable-vhost-user which affect the creation of
> both devices (e.g. vhost-user-scsi-pci) and backends (e.g. the
> vhost-user-net backend, which uses a "regular" virtio-net-pci device).
>=20

Keeping in mind that I might be talking about extra challenges we
won't address right now (no cart before the horse), I have new
questions:

Why you say backends are not a target configuration and
accelerators are?  What's the definition of "target
configuration"?

Are we explicitly restricting the scope of this work to
enabling/disabling device emulation code right now?  Why?  Why
wouldn't we use kconfig to enable/disable simple backends with no
host dependency like SLIRP?

Don't we want to make backends configurable per binary, too?
e.g.: I would expect the default configuration for a NEMU-like
binary to disable many backends.


> It would surely be possible for configure to call into minikconf to
> parse a configuration file and apply dependencies (do we actually have
> dependencies across configure options?) or something like that, but
> let's not put the cart before the horse...

Agreed.

--=20
Eduardo
