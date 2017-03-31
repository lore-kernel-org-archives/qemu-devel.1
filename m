Received: from eggs.gnu.org ([2001:4830:134:3::10]:42974)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ctrPI-0006TM-J1
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ctrPE-0003Up-Nl
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:55:40 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44270 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ctrPE-0003RG-Dr
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:55:36 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<32e1e781-f0b0-ac67-a5ce-74ccc64071a0@kamp.de>
	<20170320024649.GA18938@lemon.lan>
	<37879546-cf6e-01fa-adc6-c777e14eab0e@redhat.com>
	<20170320114926.GB17020@lemon.lan>
	<b3bf1d26-7caa-1d0d-c8a1-02f4c80e51e4@kamp.de>
	<fc755658-8d1d-db71-1f4d-2e18f5c3c4b2@kamp.de>
	<ff4b36e6-cf69-5b32-77b7-285adf4aaca0@redhat.com>
	<4aa3e0fc-1176-af7d-bef9-2b881a984605@kamp.de>
	<f0e9decf-7b92-9218-a43f-d7d6eee10208@redhat.com>
	<a7b9b590-a0b5-5b2f-3efa-bfafefc5037c@kamp.de>
	<df268a18-9b31-61d7-c449-e36f6ca12930@redhat.com>
	<293a74e1-f355-6969-9b76-9913e7f56930@kamp.de>
	<5cb7f3f5-cd3f-b54c-3109-140dee3b2cad@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <3c972a26-18a1-2636-ed80-6b73b972401d@kamp.de>
Date: Fri, 31 Mar 2017 09:55:31 +0200
MIME-Version: 1.0
In-Reply-To: <5cb7f3f5-cd3f-b54c-3109-140dee3b2cad@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] callout to *file in bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Am 27.03.2017 um 17:06 schrieb Paolo Bonzini:
>
> On 27/03/2017 15:21, Peter Lieven wrote:
>>>> I stumbled across the issue with lseek on a tmpfs because in the
>>>> build process for our templates
>>>> I temporarily have vmdks on a tmpfs and it takes ages before qemu-img
>>>> convert starts to run (it iterates
>>>> over every 64kb cluster with that callout to find_allocation and for
>>>> some reason lseek is very slow on tmpfs).
>>> Ok, thanks.  Perhaps it's worth benchmarking tmpfs specifically.  Apart
>>> from the system call overhead (which does not really matter if you're
>>> going to do a read), lseek on other filesystems should not be any slower
>>> than read.
>> Okay, but the even the read is not really necessary if the metadata is
>> correct?
> Yeah, what I mean is:
>
> - if you're going to do a read of non-zero blocks, the lseek you do
> before reading those blocks should not matter.
>
> - if you're going to skip the read of non-zero blocks, the lseek you do
> is always going to be faster than reading them and then checking with
> buffer_is_nonzero.
>
>> Would it be an idea to introduce an inverse flag live BDRV_BLOCK_NOT_ZERO
>> for cases where we know that there is really DATA and thus can avoid the
>> second callout?
> How would you know that a block is nonzero?

I would trust the metadata. At least for VMDK and QCOW2v3.
Bad idea?

Peter
