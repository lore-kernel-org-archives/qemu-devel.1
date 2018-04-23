Received: from eggs.gnu.org ([2001:4830:134:3::10]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fAeWB-0004xD-6I
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fAeW8-0000Ua-K2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:40:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fAeW8-0000Tu-BG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:40:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3NGaMYb082918
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:40:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hhje42b94-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:40:37 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 23 Apr 2018 10:40:37 -0600
Reply-To: muriloo@linux.ibm.com
References: <c7e00162-cf50-0194-d283-17e7dc8fae56@linux.ibm.com>
	<CAFEAcA-KJb6L0bCKQAE-TjfSQg6OSb0JvumGjVyYYTE46mdKbA@mail.gmail.com>
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Mon, 23 Apr 2018 13:40:32 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KJb6L0bCKQAE-TjfSQg6OSb0JvumGjVyYYTE46mdKbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <82a8982e-aa11-76c4-e010-3a37cf9b6816@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC] configure script mistakenly detects static
 libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/23/2018 01:16 PM, Peter Maydell wrote:
> On 23 April 2018 at 17:10, Murilo Opsfelder Araujo
> <muriloo@linux.ibm.com> wrote:
>> Hi, everyone!
>>
>> I'm facing an issue on how configure script detects static libraries and
>> would like to hear from community to find a common ground on how to
>> possibly fix it.
>>
>> Throughout configure, we use pkg-config command to verify if a library
>> is installed so qemu can be linked to it. This works fine when linking
>> qemu dynamically. However, configuring qemu with --static can mistakenly
>> detect a library that is actually not present on the system.
>>
>> For example, on Ubuntu Xenial, libcacard-dev package provides only
>> libcacard.so (not libcacard.a) and pkg-config reports success in both
>> cases:
>>
>>     $ pkg-config libcacard
>>     $ echo $?
>>     0
>>
>>     $ pkg-config --static libcacard
>>     $ echo $?
>>     0
>>
>> Since we use `pkg-config libcacard` to set smartcard=yes, this
>> mistakenly enables smartcard feature. This is acceptable with dynamic
>> linkage, but can be an issue with static linkage, where libcacard.a
>> doesn't exist on the system, resulting on a build error:
> 
> This seems to me to be an error in your distro's pkg-config information.
> If static linking against libcacard doesn't work, then
> "pkg-config --static libcacard" should fail.

I see in man(1) pkg-config that --static is merely used to compute
deeper dependency graph intended for static linking.

Since <package>.pc is present, pkg-config assumes the library exists and
--static is merely informational.

Do you think this should be reported to pkg-config project?

> Unfortunately IME the static linking support in distro-suppled
> pkgconfig files is rarely tested, so it's not uncommon for it to
> be broken.
> 
> From an upstream QEMU point of view, we primarily support --static
> for the benefit of the linux-user binaries, not for system emulation.
> So we care more if a "configure --disable-system --disable-tools --static"
> build doesn't work, than if the problem is only with features used
> by the system emulator binaries.

In this case, shouldn't we update configure script to emit a warning
message to user saying it's running a non-supported scenario when
--static is given without --disable-system and --disable-tools?

> thanks
> -- PMM
> 

Cheers
Murilo
