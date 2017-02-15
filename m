Received: from eggs.gnu.org ([2001:4830:134:3::10]:42637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ce2k8-0002PC-Dg
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ce2k4-00050R-Gn
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:47:48 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ce2k4-000505-9r
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:47:44 -0500
Received: by mail-wm0-x243.google.com with SMTP id r18so9115427wmd.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 08:47:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487053524-18674-1-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d150ddd6-ba35-b2d2-28be-231949927d3d@redhat.com>
Date: Wed, 15 Feb 2017 17:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <1487053524-18674-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] kvm: report available guest crash
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On 14/02/2017 07:25, Denis V. Lunev wrote:
> Windows reports BSOD parameters through Hyper-V crash MSRs. This
> information is very useful for initial crash analysis and thus
> it would be nice to see it in the QEMU log file. There is suitable
> log mask for the purpose.
> 
> Linux guest does not provide this information, but still it would
> be nice to log that we have crashed.
> 
> Changes from v3:
> - existing kvm_cpu_synchronize_state() used to fetch HV crash MSRs
>   (hence, no separate storage for these MSRs in struct X86CPU anymore)

Nice. :)

> - qapi_free_GuestPanicInformation() used to release memory
> 
> Changes from v2:
> - fixed PPC compilation
> 
> Changes since v1:
> - patches resplit
> - created property to query crash parameters
> - crash parameters added to panic event
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Marcelo Tosatti <mtosatti@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> 
> Anton Nefedov (3):
>   i386/cpu: add crash-information QOM property
>   report guest crash information in GUEST_PANICKED event
>   vl: log available guest crash information
> 
>  hw/misc/pvpanic.c       |  2 +-
>  hw/ppc/spapr_rtas.c     |  3 ++-
>  include/qom/cpu.h       | 10 +++++++++
>  include/sysemu/kvm.h    |  2 ++
>  include/sysemu/sysemu.h |  2 +-
>  kvm-all.c               |  3 ++-
>  qapi-schema.json        | 24 +++++++++++++++++++++
>  qapi/event.json         |  6 ++++--
>  qom/cpu.c               | 11 ++++++++++
>  stubs/Makefile.objs     |  1 +
>  stubs/kvm-crash.c       |  8 +++++++
>  target/i386/cpu.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h       |  3 +++
>  target/i386/kvm.c       | 41 ++++++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c      |  4 ++--
>  vl.c                    | 23 ++++++++++++++++++---
>  16 files changed, 187 insertions(+), 11 deletions(-)
>  create mode 100644 stubs/kvm-crash.c
> 

Queued for 2.9, thanks!

Paolo
