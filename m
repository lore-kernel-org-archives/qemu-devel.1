Received: from eggs.gnu.org ([2001:4830:134:3::10]:40519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Dk-0007r5-Un
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Dg-0002PG-TZ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL6Dg-0002Ox-Mj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:12:16 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-17-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <999e60c5-7ee7-5346-6940-1fcd5d7b4264@redhat.com>
Date: Wed, 14 Jun 2017 13:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170606181948.16238-17-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/23] hyperv: map overlay pages after
 updating msrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 06/06/2017 20:19, Roman Kagan wrote:
> There is a design flaw in the Hyper-V SynIC implementation in KVM: when
> message page or event flags page is enabled by setting the corresponding
> msr, KVM zeroes it out.  This violates the spec in general (per spec,
> the pages have to be overlay ones and only zeroed at cpu reset), but
> it's non-fatal in normal operation because the user exit happens after
> the page is zeroed, so it's the underlying guest page which is zeroed
> out, and sane guests don't depend on its contents to be preserved while
> it's overlaid.
> 
> However, in the case of vmstate load the overlay pages are set up before
> msrs are set so the contents of those pages get lost.
> 
> To work it around, avoid setting up overlay pages in .post_load.
> Instead, postpone it until after the msrs are pushed to KVM.  As a
> result, KVM just zeroes out the underlying guest pages similar to how it
> happens during guest-initiated msr writes, which is tolerable.

Why not disable the zeroing for host-initiated MSR writes?  This is
pretty clearly a KVM bug, we can push it to stable kernels too.

Paolo
