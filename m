Received: from eggs.gnu.org ([2001:4830:134:3::10]:36341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSyj-0003NB-2X
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSyg-0008Vw-1G
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:53:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejSyf-0008V4-S1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:53:45 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-4-brijesh.singh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5454b283-6fa1-3c0c-56b2-e82c08fd50a4@redhat.com>
Date: Wed, 7 Feb 2018 17:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180207160638.98872-4-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 04/26] monitor/i386: use debug APIs when
 accessing guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>

On 07/02/2018 17:06, Brijesh Singh wrote:
>  
>      sum = 0;
>      for(addr = start; addr < (start + size); addr++) {
> -        uint8_t val = address_space_ldub(&address_space_memory, addr,
> -                                         MEMTXATTRS_UNSPECIFIED, NULL);
> +        uint8_t buf[0];
> +        uint8_t val;
> +        cpu_physical_memory_read_debug(addr, buf, 1);
> +        val = ldub_p(buf);

This is a buffer overflow on "buf".  All you need is

    cpu_physical_memory_read_debug(addr, &val, 1);

Thanks,

Paolo

>          /* BSD sum algorithm ('sum' Unix command) */
>          sum = (sum >> 1) | (sum << 15);
