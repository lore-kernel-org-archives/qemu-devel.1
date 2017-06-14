Received: from eggs.gnu.org ([2001:4830:134:3::10]:60507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL79Z-0002NO-2q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL79V-0000cN-PJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL79V-0000br-K6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:12:01 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-17-rkagan@virtuozzo.com>
	<999e60c5-7ee7-5346-6940-1fcd5d7b4264@redhat.com>
	<20170614115421.GJ2004@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6f8c40b-6038-3b3a-e78e-a3ea6bc6fc2b@redhat.com>
Date: Wed, 14 Jun 2017 14:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170614115421.GJ2004@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 14/06/2017 13:54, Roman Kagan wrote:
>> Why not disable the zeroing for host-initiated MSR writes?  This is
>> pretty clearly a KVM bug, we can push it to stable kernels too.
>
> The only problem with this is that QEMU will have no reliable way to
> know if the KVM it runs with has this bug fixed or not.  Machines
> without vmbus work and even migrate fine with the current KVM despite
> this bug (the only user of those pages currently is synic timers which
> re-arm themselves and post messages regardless of zeroing).  Now
> updating QEMU to a vmbus-enabled version without updating the kernel
> will make the migrations cause guest hangs.

Return 2 from KVM_CHECK_EXTENSION(KVM_CAP_HYPERV_SYNIC)?  Then you can
make new QEMU refuse to enable synic if a new kernel is not available.

Paolo
