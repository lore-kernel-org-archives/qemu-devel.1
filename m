Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evozt-0007TN-4V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evozo-00046W-9n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:50:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evozo-000462-3b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:50:00 -0400
Date: Tue, 13 Mar 2018 15:49:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180313184950.GB3417@localhost.localdomain>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
	<20180308164910.GF4718@redhat.com>
	<e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
	<20180308224412.GF3417@localhost.localdomain>
	<8cf2f9bc-0339-1c80-b53b-ef5915248d1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf2f9bc-0339-1c80-b53b-ef5915248d1f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 08/28] target/i386: add Secure
 Encrypted Virtulization (SEV) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Tue, Mar 13, 2018 at 09:42:51AM +0100, Paolo Bonzini wrote:
> On 08/03/2018 23:44, Eduardo Habkost wrote:
> >> I think doing so will be an issue for the migration. Consider your above
> >> use case, a SEV guest is running on EPYC with cbitpos=47 and if we
> >> migrate to some $NEXT AMD CPU which uses need to use cbitpos=48 and we
> >> will fail to resume the guest on destination after migrating.
> > 
> > Exactly, in other words these two options are part of the guest
> > ABI, and QEMU promises to never make the guest ABI depend on the
> > host hardware unless you're using "-cpu host".
> 
> This is not entirely true; while MAXPHYADDR is constant downstream
> unless using "-cpu host", in practice that behavior is wrong and a guest
> could misbehave if passed a MAXPHYADDR that is different from the host's.
> 
> I think this is the same, and management software will have to live with it.
> 

I think they are very far from being equivalent.

In practice guests don't seem to mind if we don't perfectly
emulate behavior that depend on MAXPHYADDR, and live-migration
between hosts with different MAXPHYADDR works.

But if you tell the guest the wrong C-bit location, guests are
likely to rely on it and break.  Migration between hosts with
different C-bit locations won't work, will it?

-- 
Eduardo
