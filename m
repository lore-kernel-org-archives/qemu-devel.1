Received: from eggs.gnu.org ([2001:4830:134:3::10]:37754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d85dm-0006Xi-AI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d85dg-00042d-Kb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:57:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d85dg-00042X-Dz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:57:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49DrkLf011898
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 09:57:19 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ab02j6bu4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 09:57:18 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 9 May 2017 14:57:15 +0100
Date: Tue, 9 May 2017 15:57:02 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170508211953.28017-4-eblake@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170509155702.0d7cb606.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Stefan Weil <sw@weilnetz.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open
	list:Old World" <qemu-ppc@nongnu.org>, "open list:Overall" <kvm@vger.kernel.org>

On Mon,  8 May 2017 16:19:51 -0500
Eric Blake <eblake@redhat.com> wrote:

> Time to wire up all the call sites that request a shutdown or
> reset to use the enum added in the previous patch.
> 
> It would have been less churn to keep the common case with no
> arguments as meaning guest-triggered, and only modified the
> host-triggered code paths, via a wrapper function, but then we'd
> still have to audit that I didn't miss any host-triggered spots;
> changing the signature forces us to double-check that I correctly
> categorized all callers.
> 
> Since command line options can change whether a guest reset request
> causes an actual reset vs. a shutdown, it's easy to also add the
> information to reset requests.
> 
> Replay adds a FIXME to preserve the cause across the replay stream,
> that will be tackled in the next patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC part]

> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 68bd2f9..d2bb9aa 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -266,7 +266,7 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>          S390CPU *cpu = s390_env_get_cpu(env);
>          if (s390_cpu_halt(cpu) == 0) {
>  #ifndef CONFIG_USER_ONLY
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);

Looking at this, I think the non-kvm code path might want some panic
handling for disabled wait, but that would be an orthogonal change and
this transformation looks reasonable.

>  #endif
>          }
>      }

s390x parts:

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
