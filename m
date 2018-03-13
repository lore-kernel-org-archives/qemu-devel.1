Received: from eggs.gnu.org ([2001:4830:134:3::10]:40875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evgJX-0003mv-AA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evgJS-0002Ev-D7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:33:47 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evgJS-0002A1-6c
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:33:42 -0400
Received: by mail-wr0-f173.google.com with SMTP id o1so8785844wro.10
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 02:33:36 -0700 (PDT)
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-25-brijesh.singh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0218f497-d397-0f49-3256-79d461e25be2@redhat.com>
Date: Tue, 13 Mar 2018 10:33:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180308124901.83533-25-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 24/28] sev/i386: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 08/03/2018 13:48, Brijesh Singh wrote:
>      sev_set_guest_state(SEV_STATE_RUNNING);
> +
> +    /* add migration blocker */
> +    error_setg(&sev_mig_blocker,
> +               "SEV: Migration is not implemented");
> +    ret = migrate_add_blocker(sev_mig_blocker, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        error_free(sev_mig_blocker);
> +        exit(1);
> +    }
>  }

I think this should be in sev_guest_init instead?  Does migration
transfer the measurement, or is it lost forever?  Not a blocker though.

Paolo
