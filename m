Received: from eggs.gnu.org ([2001:4830:134:3::10]:54638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYDCL-0003tj-UM
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYDCL-0002RZ-3N
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:44:50 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:33521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYDCK-0002RI-U0
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:44:49 -0500
Received: by mail-ua0-x22f.google.com with SMTP id i68so250767054uad.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:44:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c8f2b3c6-34b9-cfe1-0363-8afa5ab1ec0f@redhat.com>
References: <20170130131517.8092-1-sw@weilnetz.de>
	<c8f2b3c6-34b9-cfe1-0363-8afa5ab1ec0f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 14:44:27 +0000
Message-ID: <CAFEAcA-QvDbCiea05n0g56e1T-gapPALo+V=LmTSA2S3WR_XEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <dahi@linux.vnet.ibm.com>

On 30 January 2017 at 14:10, David Hildenbrand <david@redhat.com> wrote:
> Am 30.01.2017 um 14:15 schrieb Stefan Weil:
>> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>
>> v2: Re-sent as v1 was damaged by my mailer.
>>
>> This is also broken in Debian.
>>
>> In addition, there is no default CPU ("any"), so binfmt and related
>> actions currently don't work. I hacked my local installation by
>> duplicating the "qemu" cpu definition for "any", but maybe there is
>> a better solution.
>
> we have the "qemu" model for that (or simply drop the -cpu parameter
> completely). Eduardo currently proposed "max" as an alternative for x86.
> There is also no "any" model on x86.

"any" isn't quite the same as the proposed "max", necessarily.
For instance on ARM "any" turns on some features which in real
hardware you don't ever see in combination, because for userspace
they don't conflict and this lets us run the widest possible
range of userspace binaries.

If "any" isn't right for s390 then you should fix the code
in linux-user/main.c which picks the default CPU model (for
instance on x86 it selects either "qemu64" or "qemu32").

thanks
-- PMM
