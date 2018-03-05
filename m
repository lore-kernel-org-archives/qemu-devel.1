Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esvSh-0001Iy-Ml
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esvSg-0002Ij-QW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:07:51 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esvSg-0002IO-Ly
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:07:50 -0500
Received: by mail-oi0-x241.google.com with SMTP id t185so12891683oif.6
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 11:07:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
	<20180305110356.GF7910@stefanha-x1.localdomain>
	<12e1269c-6eae-a400-cc00-2c5c8e4bb8f9@linux.vnet.ibm.com>
	<c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 19:07:29 +0000
Message-ID: <CAFEAcA99N1D9xvf+qKb2Ws-nyO8ak-UGcYST5m8_b0Hzm3Wr8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 5 March 2018 at 18:54, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>
> On 03/05/2018 07:45 PM, Farhan Ali wrote:
>>    0x000003ff90752026 <+110>:    svc    175
>
> sys_rt_sigprocmask. r0 should not be changed by the system call.
>
>>    0x000003ff90752028 <+112>:    lgr    %r5,%r0
>> => 0x000003ff9075202c <+116>:    lfpc    248(%r5)
>
> so r5 is zero and it was loaded from r0. r0 was loaded from r3 (which is the 2nd parameter to this
> function). Now this is odd.

...particularly given that the only place we call swapcontext()
the second parameter is always the address of a local variable
and can't be 0...

thanks
-- PMM
