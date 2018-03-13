Received: from eggs.gnu.org ([2001:4830:134:3::10]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evfWL-0001Od-EX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evfWI-0002w4-8v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:42:57 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evfWI-0002uq-2Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:42:54 -0400
Received: by mail-wr0-f180.google.com with SMTP id f14so20092634wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 01:42:53 -0700 (PDT)
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
	<20180308164910.GF4718@redhat.com>
	<e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
	<20180308224412.GF3417@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cf2f9bc-0339-1c80-b53b-ef5915248d1f@redhat.com>
Date: Tue, 13 Mar 2018 09:42:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180308224412.GF3417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 08/03/2018 23:44, Eduardo Habkost wrote:
>> I think doing so will be an issue for the migration. Consider your above
>> use case, a SEV guest is running on EPYC with cbitpos=47 and if we
>> migrate to some $NEXT AMD CPU which uses need to use cbitpos=48 and we
>> will fail to resume the guest on destination after migrating.
> 
> Exactly, in other words these two options are part of the guest
> ABI, and QEMU promises to never make the guest ABI depend on the
> host hardware unless you're using "-cpu host".

This is not entirely true; while MAXPHYADDR is constant downstream
unless using "-cpu host", in practice that behavior is wrong and a guest
could misbehave if passed a MAXPHYADDR that is different from the host's.

I think this is the same, and management software will have to live with it.

Paolo

> In theory we could make QEMU choose the right values
> automatically if we document very clearly that the default
> behavior is unsafe.  But I would rather not take that risk and
> force management software to be aware of the gotchas involved in
> using SEV + live-migration.
