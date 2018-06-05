Received: from eggs.gnu.org ([2001:4830:134:3::10]:48108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fQBW2-0003QW-8A
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fQBVz-00024D-1V
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:56:46 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:40255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fQBVy-00020n-TB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:56:42 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w55Cq8jn058523
	for <qemu-devel@nongnu.org>; Tue, 5 Jun 2018 08:56:37 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 114FA6D
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 08:56:37 -0400 (EDT)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id E59457E
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 08:56:36 -0400 (EDT)
Received: from mail-wm0-f70.google.com (mail-wm0-f70.google.com [74.125.82.70])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w55CuaWr046789
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 5 Jun 2018 08:56:36 -0400
Received: by mail-wm0-f70.google.com with SMTP id f65-v6so1349651wmd.2
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 05:56:36 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com.
	[74.125.82.41]) by smtp.gmail.com with ESMTPSA id
	e46-v6sm8537544edd.80.2018.06.05.05.56.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Jun 2018 05:56:34 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id v16-v6so4732703wmh.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 05:56:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911F3CAE@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F3CAE@SHSMSX101.ccr.corp.intel.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 5 Jun 2018 08:56:33 -0400
Message-ID: <CAHyh4xhbVROe3xUXwojOMBHKdTxNms7ZqRkhpm+1N0XZm3xBuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] vIOMMU Posted-interrupt implementation - atomic
 operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Thanks, Kevin.

On Tue, Jun 5, 2018 at 2:54 AM, Tian, Kevin <kevin.tian@intel.com> wrote:
>> From: Jintack Lim
>> Sent: Friday, June 1, 2018 11:47 AM
>>
>> Hi,
>>
>> I'm implementing Posted-interrupt functionality in vIOMMU. According
>> to Vt-d spec 5.2.3, IOMMU performs a coherent atomic read-modify-write
>> operation of the posted-interrupt descriptor. I wonder how can we
>> achieve this considering the guest can modify the same
>> posted-interrupt descriptor anytime. Is there any existing mechanism
>> that I can use in QEMU?
>>
>
> I don't think it's possible to emulate such operation in software, unless
> you want to change guest to be cooperative. Actually it is not necessary.
> VT-d does so due to some hardware implementation consideration.

Would you mind expanding this? I'm curious what it would be. Is it
because IOMMU can't do something like cmpxchg instructions?

> Since you are emulating on CPU, could just follow how CPU posted
> interrupt is conducted. If you look at SDM (29.6 Posted-Interrupt
> Processing):
>
>         "There is a requirement, however, that such modifications be
> done using locked read-modify-write instructions."
>
> [instructions] means you can do update multiple times when posting an
> interrupt, as long as each update is atomic.

Ah, that's a good point. So the unit of atomic operation doesn't need
to be the whole PI descriptor, but it can be any subset (e.g. just one
bit) of the descriptor? By looking at Linux kernel code, that seems to
be the case.

Best,
Jintack

>
> Thanks
> Kevin
>
