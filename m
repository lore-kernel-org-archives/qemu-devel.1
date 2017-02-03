Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cZZMb-00016i-Rf
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cZZMY-0001GL-RO
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:37:01 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:55252 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cZZMY-0001Ff-H3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:36:58 -0500
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
	<ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
	<03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
	<2BB6EFE6-C476-4A48-AFC9-52B9B9F8433F@flyingcircus.io>
From: Peter Lieven <pl@kamp.de>
Message-ID: <f3aa837e-70de-91e9-c82f-6a7dd2907fb0@kamp.de>
Date: Fri, 3 Feb 2017 09:36:54 +0100
MIME-Version: 1.0
In-Reply-To: <2BB6EFE6-C476-4A48-AFC9-52B9B9F8433F@flyingcircus.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Theune <ct@flyingcircus.io>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com

Am 03.02.2017 um 09:22 schrieb Christian Theune:
> Hi,
>
>> On 3 Feb 2017, at 09:20, Peter Lieven <pl@kamp.de <mailto:pl@kamp.de>> wrote:
>>
>> If you try to THAW an unfrozen FS you get EINVAL.
>>
>> The current code thaws until an error is returned.
>>
>>
>> So it should work as is.
>>
>>
>> If you feel uncomfortable with the EBUSY approach. The other idea would
>>
>> be to track all devices which have been successfully frozen and skip consecutive
>>
>> tries to freeze them.
>
> Which will be subject to race conditions as other processes may call freeze/thaw on any device. Those are completely out of our control.

That will always be out of control. If we freeze the FS and another process thaws it, we snapshot an unfrozen fs and believe it is frozen.

I think the EBUSY approach is fine. If I look at the documentation of the thaw in the code it seems that the behaviour of the linux kernel changed. It seems
that it was possible to call FIFREEZE multiple times on an FS and this required multiple FITHAWs to unfreeze it.

Peter
