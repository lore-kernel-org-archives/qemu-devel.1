Received: from eggs.gnu.org ([2001:4830:134:3::10]:43638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1esqJb-0002BF-Cf
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1esqJX-0005UZ-Bd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:38:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1esqJX-0005UE-6b
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:38:03 -0500
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-12-brijesh.singh@amd.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6a76cb62-99ec-f442-28cd-ba9daf478a05@redhat.com>
Date: Mon, 5 Mar 2018 14:37:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180228211028.83970-12-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 11/28] sev/i386: add command to
 initialize the memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Brijesh,

I triggered an assertion failure here:

On 02/28/18 22:10, Brijesh Singh wrote:
> When memory encryption is enabled, KVM_SEV_INIT command is used to
> initialize the platform. The command loads the SEV related persistent
> data from non-volatile storage and initializes the platform context.
> This command should be first issued before invoking any other guest
> commands provided by the SEV firmware.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c       |  15 ++++
>  include/sysemu/sev.h      |  22 +++++
>  stubs/Makefile.objs       |   1 +
>  stubs/sev.c               |  21 +++++
>  target/i386/Makefile.objs |   2 +-
>  target/i386/monitor.c     |  11 ++-
>  target/i386/sev-stub.c    |  41 +++++++++
>  target/i386/sev.c         | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h    |  29 ++++++
>  target/i386/trace-events  |   3 +
>  10 files changed, 364 insertions(+), 3 deletions(-)
>  create mode 100644 include/sysemu/sev.h
>  create mode 100644 stubs/sev.c
>  create mode 100644 target/i386/sev-stub.c

[...]

> @@ -1636,6 +1640,17 @@ static int kvm_init(MachineState *ms)
>  
>      kvm_state = s;
>  
> +    /*
> +     * if memory encryption object is specified then initialize the memory
> +     * encryption context.
> +     */
> +    if (ms->memory_encryption) {
> +        kvm_state->memcrypt_handle = sev_guest_init(ms->memory_encryption);
> +        if (!kvm_state->memcrypt_handle) {
> +            goto err;
> +        }
> +    }
> +

You should set the "err" variable to a negative error code; otherwise
the assertion at the "err" label will trigger:

err:
    assert(ret < 0);

Thanks
Laszlo
