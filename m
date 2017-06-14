Received: from eggs.gnu.org ([2001:4830:134:3::10]:44694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Rm-0007bK-B9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Rl-0008MF-FR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:26:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL6Rl-0008M6-8r
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:26:49 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
Date: Wed, 14 Jun 2017 13:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170614112506.GI2004@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>



On 14/06/2017 13:25, Roman Kagan wrote:
>> The problem with that is that it will break as soon as we create
>> VCPUs in a different order.  Unsolvable on hosts that don't allow
>> HV_X64_MSR_VP_INDEX to be set, however.
> Right, thanks for putting together a detailed explanation.
> 
> This was a thinko back then, not to have HV_X64_MSR_VP_INDEX maintained
> by QEMU.  I'm going to post a patch to KVM fixing that.
> 
> Meanwhile QEMU needs a way to maintain its notion of vp_index that is
>   1) in sync with kernel's notion
>   2) also with kernels that don't support setting the msr
>   3) persistent across migrations
> 
> cpu_index looked like a perfect candidate.
> 

What you want is the APIC id, which _is_ cpu_index but may not be in the
future.  But the APIC id is also the KVM vcpu_id, so there's no need to
have VP_INDEX maintained by QEMU.

Paolo
