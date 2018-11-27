Received: from eggs.gnu.org ([2001:4830:134:3::10]:50926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRgj7-0003wI-5r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRgj1-0000E7-MT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:00:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRgj1-0000BA-1l
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:00:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 950B03002F95
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 17:00:37 +0000 (UTC)
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<20181126173604-mutt-send-email-mst@kernel.org>
	<6cd98ced-a043-18c0-3aa5-4cda15c76ec5@redhat.com>
	<20181127112541-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a39469b6-5b91-04b9-32f5-e0e2ba3ab363@redhat.com>
Date: Tue, 27 Nov 2018 18:00:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181127112541-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 27/11/18 17:27, Michael S. Tsirkin wrote:
> On Tue, Nov 27, 2018 at 10:04:59AM +0100, Paolo Bonzini wrote:
>> On 26/11/18 23:43, Michael S. Tsirkin wrote:
>>> On Mon, Nov 26, 2018 at 02:20:38PM +0100, Paolo Bonzini wrote:
>>>> vhost does not have to be supported only if KVM is present, in fact
>>>> vhost-user does not even need any kind of kernel support.  This seri=
es
>>>> changes this.  The rationale is that, when vhost-user-test.c will be
>>>> converted to qgraph, it will be able to test vhost-user support
>>>> for virtio-mmio backend even on x86.
>>>
>>> The reason for limiting it to KVM was very simple:
>>> it has the same set of problems with ordering
>>> as mttcg.
>>>
>>> So I guess it's fine but I think we must then limit it
>>> to when tcg emits fence instructions.
>>>
>>> Otherwise we'll get subtle race conditions.
>>
>> Got it, I'll take a look.  However, right now you _can_ use vhost with
>> tcg as long as e.g. qemu-system-x86_64 is compiled with KVM support, s=
o
>> this patch is not changing anything in this respect; the bug is
>> independent of this series.
>=20
> Well qemu built with KVM implies host architecture =3D=3D guest
> architecture, right? That should ensure race conditions do not happen i=
n
> a very hacky way.

It's not enough, event_idx requires smp_mb and single-threaded TCG does
not emit them.  It is enough for smp_rmb/smp_wmb however, that makes sens=
e.

Paolo
