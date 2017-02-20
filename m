Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfsks-00088Z-Qt
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfskp-0006bo-6x
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:32:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfskp-0006bW-18
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:32:07 -0500
Date: Mon, 20 Feb 2017 18:32:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220183201.GD15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487053524-18674-1-git-send-email-den@openvz.org>
	<1487053524-18674-2-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487053524-18674-2-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] i386/cpu: add crash-information QOM
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Tue, Feb 14, 2017 at 09:25:22AM +0300, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
> 
> Windows reports BSOD parameters through Hyper-V crash MSRs. This
> information is very useful for initial crash analysis and thus
> it would be nice to have a way to fetch it.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  kvm-all.c         |  1 +
>  qapi-schema.json  | 24 ++++++++++++++++++++++++
>  target/i386/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/kvm-all.c b/kvm-all.c
> index a27c880..64f46c8 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -2000,6 +2000,7 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret = EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_CRASH:
> +                kvm_cpu_synchronize_state(cpu);
>                  qemu_mutex_lock_iothread();
>                  qemu_system_guest_panicked();
>                  qemu_mutex_unlock_iothread();
> diff --git a/qapi-schema.json b/qapi-schema.json
> index cbdffdd..9cb6ac5 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5846,6 +5846,30 @@
>    'data': [ 'pause', 'poweroff' ] }
>  
>  ##
> +# @GuestPanicInformation:
> +#
> +# Information about a guest panic
> +#
> +# Since: 2.9
> +##
> +{'union': 'GuestPanicInformation',
> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
> +
> +##
> +# @GuestPanicInformationHyperV:
> +#
> +# Hyper-V specific guest panic information (HV crash MSRs)
> +#
> +# Since: 2.9
> +##
> +{'struct': 'GuestPanicInformationHyperV',
> + 'data': { 'arg1': 'uint64',
> +           'arg2': 'uint64',
> +           'arg3': 'uint64',
> +           'arg4': 'uint64',
> +           'arg5': 'uint64' } }

Is there any benefit in naming these fields ?  In the Linux kernel
they are filled with ip, ax, bx, cx, dx register values. I'm unclear
if that's defined standard semantics by Microsoft, and thus consistent
for all OS using this interface, or just what Linux happens to store
there ?  If they're standard, then IMHO it could be nicer to name the
QAPI fields  ip, ax, bx, cx, dx.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
