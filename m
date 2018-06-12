Received: from eggs.gnu.org ([2001:4830:134:3::10]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSocG-0006mW-Hd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSocD-0001gf-DN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSocD-0001fQ-6J
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:06:01 -0400
Date: Tue, 12 Jun 2018 16:05:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180612190554.GO7451@localhost.localdomain>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
	<20180611211026.GA7451@localhost.localdomain>
	<DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612174021.GL7451@localhost.localdomain>
	<DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>

On Tue, Jun 12, 2018 at 06:38:08PM +0000, Moger, Babu wrote:
[...]
> > I'm starting to think that enabling TOPOEXT automatically is
> > adding too much complexity and compatibility problems, and it's
> > better to leave this task to management software.
> > 
> > The main problem here is:
> > 
> > This works today with QEMU 2.12 + Linux <= 4.15:
> >   $ $QEMU -machine pc -cpu EPYC,enforce -smp
> > 8,sockets=2,cores=2,threads=2"
> > and must keep working with QEMU 3.0 and Linux <= 4.15.
> > 
> > In addition to that, the results for:
> >   $ $QEMU -machine pc-q35-3.0 -cpu EPYC,enforce [...]
> > must be deterministic and expose exactly the same CPUID data even
> > if host hardware or software changes, as long as the QEMU
> > command-line is the same.
> > 
> > Do you see a way to fulfill those two constraints while making
> > "-machine pc-q35-3.0 -cpu EPYC" enable TOPOEXT automatically?
> > 
> 
> Now(setting feature before x86_cpu_expand_features), enabling
> TOPOEXT appears to work fine.

What about the above constraints?  Are you really fulfilling
them?

This one is tricky:

] This works today with QEMU 2.12 + Linux <= 4.15:
]   $ $QEMU -machine pc -cpu EPYC,enforce -smp 8,sockets=2,cores=2,threads=2"
] and must keep working with QEMU 3.0 and Linux <= 4.15.

If we enable TOPOEXT unconditionally, the command-line won't work
with Linux <= 4.15.

If we enable TOPOEXT only if the kernel returns TOPOEXT on
GET_SUPPORTED_CPUID, we break the second constraint:

] The results for:
]   $ $QEMU -machine pc-q35-3.0 -cpu EPYC,enforce [...]
] must be deterministic and expose exactly the same CPUID data even
] if host hardware or software changes, as long as the QEMU
] command-line is the same.

-- 
Eduardo
