Received: from eggs.gnu.org ([2001:4830:134:3::10]:59727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJmu-0004uu-93
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJmr-0004qr-0F
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:20:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diJmq-0004qc-QY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CB68745DD
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 12:20:31 +0000 (UTC)
References: <20170817102848.19294-1-famz@redhat.com>
	<1d0ebe1e-293d-b119-0621-d0f666b9ca36@redhat.com>
	<20170817120348.GE616@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4902208-fca3-519a-76d9-3074aa802ef6@redhat.com>
Date: Thu, 17 Aug 2017 14:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170817120348.GE616@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 17/08/2017 14:03, Fam Zheng wrote:
> On Thu, 08/17 13:44, Paolo Bonzini wrote:
>> On 17/08/2017 12:28, Fam Zheng wrote:
>>> This makes the werror/rerror options available on the scsi-block devi=
ce,
>>> to allow user specify error handling policy in the same way as scsi-h=
d
>>> etc.
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> I'm not sure this is enough, because you would only obey the
>> rerror/werror action if ioctl fails, not if the ioctl succeeds but the
>> command fails (the "r->status && *r->status" conditional in
>> scsi_disk_req_check_error).
>=20
> Yes, I missed that.  Why isn't scsi_handle_rw_error called in that if b=
lock
> currently?

A recursive answer is because scsi-block doesn't have rerror and werror
(and it's the only one that sets r->status, see scsi_block_dma_command).

More precisely, scsi_handle_rw_error more or less assumes error !=3D 0
(see the switch statement and blk_error_action), so some other changes
are needed to cover that case---at least not overwrite the sense and
ensure something sensible comes out of the QMP event.

Paolo
