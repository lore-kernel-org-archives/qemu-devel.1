Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dn9lv-0006sP-OP
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dn9ls-0005gj-HH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dn9ls-0005fv-6v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:39:32 -0400
Date: Wed, 30 Aug 2017 17:39:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170830203920.GB7570@localhost.localdomain>
References: <bad6020b-1054-3bfb-7b21-d30e31382276@redhat.com>
	<20170808224120-mutt-send-email-mst@kernel.org>
	<20170830131727.GD15315@localhost.localdomain>
	<20170830171653-mutt-send-email-mst@kernel.org>
	<20170830192510.GA7570@localhost.localdomain>
	<20170830231508-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830231508-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC v2] [OVS/NOVA] Vhost-user backends
 cross-version migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Kevin Traynor <ktraynor@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, Laine Stump <laine@redhat.com>, Flavio Leitner <fleitner@redhat.com>, Daniele Di Proietto <diproiettod@ovn.org>, Yuanhan Liu <yliu@fridaylinux.org>, Ciara Loftus <ciara.loftus@intel.com>, "Kavanagh, Mark B" <mark.b.kavanagh@intel.com>, "Mooney, Sean K" <sean.k.mooney@intel.com>, "dev@openvswitch.org" <dev@openvswitch.org>, openstack-dev@lists.openstack.org, libvir-list@redhat.com, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 11:19:08PM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 30, 2017 at 04:25:10PM -0300, Eduardo Habkost wrote:
> > On Wed, Aug 30, 2017 at 05:23:39PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, Aug 30, 2017 at 10:17:27AM -0300, Eduardo Habkost wrote:
> > > > I'm CCing libvir-list and qemu-devel because I would like to get
> > > > feedback from libvirt and QEMU developers too.
> > > > 
> > > > On Tue, Aug 08, 2017 at 10:49:21PM +0300, Michael S. Tsirkin wrote:
> > > > > On Tue, Jul 18, 2017 at 03:42:08PM +0200, Maxime Coquelin wrote:
> > > > > > This is an revival from a thread I initiated earlier this year [0], that
> > > > > > I had to postpone due to other priorities.
> > > > > > 
> > > > > > First, I'd like to thanks reviewers of my first proposal, this new
> > > > > > version tries to address the comments made:
> > > > > >  1.This is Nova's role and not Libvirt's to query hosts supported
> > > > > > compatibility modes and to select one, since Nova adds the vhost-user
> > > > > > ports and has visibility on other hosts. Hence I remove libvirt ML and
> > > > > > add Openstack one in the recipient list.
> > > > > >  2. By default, the compatibility version selected is the most recent
> > > > > > one, except if the admin selects on older compat version.
> > > > > > 
> > > > > > The goal of this thread is to draft a solution based on the outcomes
> > > > > > of discussions with contributors of the different parties (DPDK/OVS
> > > > > > /Nova/...).
> > > > > > 
> > > > > > I'm really interested on feedback from OVS & Nova contributors,
> > > > > > as my experience with these projects is rather limited.
> > > > > > 
> > > > > > Problem statement:
> > > > > > ==================
> > > > > > 
> > > > > > When migrating a VM from one host to another, the interfaces exposed by
> > > > > > QEMU must stay unchanged in order to guarantee a successful migration.
> > > > > > In the case of vhost-user interface, parameters like supported Virtio
> > > > > > feature set, max number of queues, max vring sizes,... must remain
> > > > > > compatible. Indeed, the frontend not being re-initialized, no
> > > > > > re-negotiation happens at migration time.
> > > > > > 
> > > > > > For example, we have a VM that runs on host A, which has its vhost-user
> > > > > > backend advertising VIRTIO_F_RING_INDIRECT_DESC feature. Since the Guest
> > > > > > also support this feature, it is successfully negotiated, and guest
> > > > > > transmit packets using indirect descriptor tables, that the backend
> > > > > > knows to handle.
> > > > > > 
> > > > > > At some point, the VM is being migrated to host B, which runs an older
> > > > > > version of the backend not supporting this VIRTIO_F_RING_INDIRECT_DESC
> > > > > > feature. The migration would break, because the Guest still have the
> > > > > > VIRTIO_F_RING_INDIRECT_DESC bit sets, and the virtqueue contains some
> > > > > > decriptors pointing to indirect tables, that backend B doesn't know to
> > > > > > handle.
> > > > > > This is just an example about Virtio features compatibility, but other
> > > > > > backend implementation details could cause other failures. (e.g.
> > > > > > configurable queues sizes)
> > > > > > 
> > > > > > What we need is to be able to query the destination host's backend to
> > > > > > ensure migration is possible before it is initiated.
> > > > > 
> > > > > This remided me strongly of the issues around the virtual CPU modeling
> > > > > in KVM, see
> > > > > https://wiki.qemu.org/index.php/Features/CPUModels#Querying_host_capabilities
> > > > > 
> > > > > QEMU recently gained query-cpu-model-expansion to allow capability queries.
> > > > > 
> > > > > Cc Eduardo accordingly. Eduardo, could you please take a look -
> > > > > how is the problem solved on the KVM/VCPU side? Do the above
> > > > > problem and solution for vhost look similar?
> > > > 
> > > > (Sorry for taking so long to reply)
> > > > 
> > > > CPU configuration in QEMU has the additional problem of features
> > > > depending on host hardware and kernel capabilities (not just QEMU
> > > > software capabilities).  Do you have vhost-user features that
> > > > depend on the host kernel or hardware too, or all of them just
> > > > depend on the vhost-user backend software?
> > > 
> > > vhost-net features depend on host kernel.
> > > 
> > > > If it depends only on software, a solution similar to how
> > > > machine-types work in QEMU sound enough.  If features depend on
> > > > host kernel or host hardware too, it is a bit more complex: it
> > > > means you need an interface to find out if each configurable
> > > > feature/version is really available on the host.
> > > > 
> > > > (In the case of CPU models, we started with an interface that
> > > > reported which CPU models were runnable on the host.  But as
> > > > libvirt allows enabling/disabling individual CPU features, the
> > > > interface had to be extended to report which CPU features were
> > > > available/unavailable on the host.)
> > > > 
> > > >                           * * *
> > > > 
> > > > Now, there's one thing that seems very different here: the
> > > > guest-visible interface is not defined only by QEMU, but also by
> > > > the vhost-user backend.  Is that correct?
> > > 
> > > Not exactly. As long as there are no bugs it's defined by QEMU but
> > > depends on backend capabilities. Bugs in a backend could be guest
> > > visible - same as kvm really.
> > 
> > I'm a bit confused here.
> > 
> > I will try to enumerate the steps involved in the process, for
> > clarity:
> > 1) Querying which features are available on a host;
> > 2) Choosing a reasonable default based on what's available on the
> >    relevant host(s), before starting a VM;
> > 3) Actually configuring what will be seen by the guest, based on
> >    (1), (2) (and optionally user input/configuration).
> > 
> > Above you say that (1) on vhost-net depend on host kernel too.
> > That's OK.
> > 
> > I also understand that (2) can't be done by libvirt and QEMU
> > alone, because they don't have information about the vhost-user
> > backend before the VM is configured.  That's OK too.
> > 
> > However, I don't see the data flow of the configuration step (3)
> > clearly.  If the guest ABI is only defined by QEMU, does that
> > mean configuring the guest-visible features would always be done
> > through libvirt+QEMU?
> > 
> > In other words, would the corresponding
> > vhostuser_compat.virtio_features value (or other knobs that
> > affect guest ABI) always flow this way:
> >   OVS -> libvirt -> QEMU -> vhost-user-backend -> guest
> > and not directly this way:
> >   OVS -> vhost-user-backend -> guest
> > ?
> 
> Barring bugs, after init it works like this
> 
> libvirt -----------------------+
>                                |
>                                v
> OVS -> vhost-user-backend <-> QEMU -> guest
> 
> On device init qemu queries all features, enables
> the subset configured by libvirt and also supplies
> them (with possible modifications) to guest.

Good.  I thought there was no interface to configure the
guest-visible virtio features through libvirt, and OVS would
bypass that by configuring vhost-user-backend directly.

Which variables affect the set of available features, exactly?
Does it depend on QEMU capabilities too on some cases, or just
vhost-backend + kernel capabilities?

Is there anything libvirt+QEMU need do to help implement (1)
(querying host capabilities) so the rest of the stack can
implement (2) (choosing what to enable based on host
capabilities)?  Or this can be done without QEMU and libvirt
being involved at all?

> 
> 
> > 
> > > 
> > > > This means QEMU won't fully control the resulting guest ABI
> > > > anymore.  I would really prefer if we could keep libvirt+QEMU in
> > > > control of the guest ABI as usual, making QEMU configure all the
> > > > guest-visible vhost-user features.  But I understand this would
> > > > require additional interfaces between QEMU and libvirt, and
> > > > extending the libvirt APIs.
> > > > 
> > > > So, if QEMU is really not going to control the resulting guest
> > > > ABI completely, can we at least provide a mechanism which QEMU
> > > > can use to ask vhost-user for guest ABI details on migration, and
> > > > block migration if vhost-user was misconfigured on the
> > > > destination host when migrating?
> > > > 
> > > > 
> > > > > 
> > > > > > The below proposal has been drafted based on how Qemu manages machine types:
> > > > > > 
> > > > > > Proposal
> > > > > > ========
> > > > > > 
> > > > > > The idea is to have a table of supported version strings in OVS,
> > > > > > associated to key/value pairs. Nova or any other management tool could
> > > > > > query OVS for the list of supported versions strings for each hosts.
> > > > > > By default, the latest compatibility version will be selected, but the
> > > > > > admin can select manually an older compatibility mode in order to ensure
> > > > > > successful migration to an older destination host.
> > > > > > 
> > > > > > Then, Nova would add OVS's vhost-user port with adding the selected
> > > > > > version (compatibility mode) as an extra parameter.
> > > > > > 
> > > > > > Before starting the VM migration, Nova will ensure both source and
> > > > > > destination hosts' vhost-user interfaces run in the same compatibility
> > > > > > modes, and will prevent it if this is not the case.
> > > > > > 
> > > > > > For example host A runs OVS-2.7, and host B OVS-2.6.
> > > > > > Host A's OVS-2.7 has an OVS-2.6 compatibility mode (e.g. with indirect
> > > > > > descriptors disabled), which should be selected at vhost-user port add
> > > > > > time to ensure migration will succeed to host B.
> > > > > > 
> > > > > > Advantage of doing so is that Nova does not need any update if new keys
> > > > > > are introduced (i.e. it does not need to know how the new keys have to
> > > > > > be handled), all these checks remain in OVS's vhost-user implementation.
> > > > > > 
> > > > > > Ideally, we would support per vhost-user interface compatibility mode,
> > > > > > which may have an impact also on DPDK API, as the Virtio feature update
> > > > > > API is global, and not per port.
> > > > > > 
> > > > > > - Implementation:
> > > > > > -----------------
> > > > > > 
> > > > > > Goal here is just to illustrate this proposal, I'm sure you will have
> > > > > > good suggestion to improve it.
> > > > > > In OVS vhost-user library, we would introduce a new structure, for
> > > > > > example (neither compiled nor tested):
> > > > > > 
> > > > > > struct vhostuser_compat {
> > > > > >   char *version;
> > > > > >   uint64_t virtio_features;
> > > > > >   uint32_t max_rx_queue_sz;
> > > > > >   uint32_t max_nr_queues;
> > > > > > };
> > > > > > 
> > > > > > *version* field is the compatibility version string. It could be
> > > > > > something like: "upstream.ovs-dpdk.v2.6". In case for example Fedora
> > > > > > adds some more patches to its package that would break migration to
> > > > > > upstream version, it could have a dedicated compatibility string:
> > > > > > "fc26.ovs-dpdk.v2.6". In case OVS-v2.7 does not break compatibility with
> > > > > > previous OVS-v2.6 version, then no need to create a new entry, just keep
> > > > > > v2.6 one.
> > > > > > 
> > > > > > *virtio_features* field is the Virtio features set for a given
> > > > > > compatibility version. When an OVS tag is to be created, it would be
> > > > > > associated to a DPDK version. The Virtio features for these version
> > > > > > would be stored in this field. It would allow to upgrade the DPDK
> > > > > > package for example from v16.07 to v16.11 without breaking migration.
> > > > > > In case the distribution wants to benefit from latests Virtio
> > > > > > features, it would have to create a new entry to ensure migration
> > > > > > won't be broken.
> > > > > > 
> > > > > > *max_rx_queue_sz*
> > > > > > *max_nr_queues* fields are just here for example, don't think this is
> > > > > > needed today. I just want to illustrate that we have to anticipate
> > > > > > other parameters than the Virtio feature set, even if not necessary
> > > > > > at the moment.
> > > > > > 
> > > > > > We create a table with different compatibility versions in OVS
> > > > > > vhost-user lib:
> > > > > > 
> > > > > > static struct vhostuser_compat vu_compat[] = {
> > > > > >   {
> > > > > >     .version = "upstream.ovs-dpdk.v2.7",
> > > > > >     .virtio_features = 0x12045694,
> > > > > >     .max_rx_queue_sz = 512,
> > > > > >   },
> > > > > >   {
> > > > > >     .version = "upstream.ovs-dpdk.v2.6",
> > > > > >     .virtio_features = 0x10045694,
> > > > > >     .max_rx_queue_sz = 1024,
> > > > > >   },
> > > > > > };
> > > > > > 
> > > > > > At some time during installation, or system init, the table would be
> > > > > > parsed, and compatibility version strings would be stored into the OVS
> > > > > > database, or a new tool would be created to list these strings, or a
> > > > > > config file packaged with OVS stores the list of compatibiliy versions.
> > > > > > 
> > > > > > Before launching the VM, Nova will query the version strings for the
> > > > > > host so that the admin can select an older compatibility mode. If none
> > > > > > selected by the admin, then the most recent one will be used by default,
> > > > > > and passed to the OVS's add-port command as parameter. Note that if no
> > > > > > compatibility mode is passed to the add-port command, the most recent
> > > > > > one is selected by OVS as default.
> > > > > > 
> > > > > > When the vhost-user connection is initiated, OVS would know in which
> > > > > > compatibility mode to init the interface, for example by restricting the
> > > > > > support Virtio features of the interface.
> > > > > > 
> > > > > > Cheers,
> > > > > > Maxime
> > > > > > 
> > > > > > [0]:
> > > > > >  https://mail.openvswitch.org/pipermail/ovs-dev/2017-February/328257.html
> > > > > >  <b2a5501c-7df7-ad2a-002f-d731c445a502 at redhat.com>
> > > > 
> > > > -- 
> > > > Eduardo
> > 
> > -- 
> > Eduardo

-- 
Eduardo
