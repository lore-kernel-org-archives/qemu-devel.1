Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1yh2-0006MV-AV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1ygw-0000tA-Co
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:51:48 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:43557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1ygw-0000t2-6P
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:51:42 -0400
Received: by mail-pf0-x231.google.com with SMTP id d2so14808594pfh.0
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:51:42 -0700 (PDT)
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
	<96a6584b-ee29-13a2-622a-b07788ffcf79@linaro.org>
	<150765743910.11829.11218016346709035274@sif>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9dcf4529-73da-2355-8121-2299e1577253@linaro.org>
Date: Tue, 10 Oct 2017 10:51:38 -0700
MIME-Version: 1.0
In-Reply-To: <150765743910.11829.11218016346709035274@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>

On 10/10/2017 10:43 AM, Michael Roth wrote:
> Quoting Richard Henderson (2017-10-10 11:32:22)
>> On 10/10/2017 07:22 AM, Peter Maydell wrote:
>>> I can see a couple of options:
>>>  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
>>>      and move to that
>>>      [downsides: would be in the middle of QEMU's own release cycle,
>>>       pretty late to fix any problems with the new version;
>>>       rather a big change to put into stable]
>>>  (2) move to u-boot current head-of-unstable
>>>      [downsides: would mean running some random git commit version,
>>>       also not really very suitable for stable]
>>
>> It's always difficult to sync the release cycles of disjoint projects.
>>
>> You had nothing particularly good to say about using a non-released u-boot, so
>> really you have two options:
>>
>>   (a) Update u-boot for 2.12 and not 2.11,
>>   (b) Track u-boot during its release process, noticing and reporting problems,
>>       and updating to the final release when it appears.  If you go this route,
>>       you may well have to slip our release if theirs slips.
>>
>> The second option is not particularly appealing.
>>
>> Is there another possibility in which we split the packaging to cope with the
>> current u-boot?  Normally no one builds u-boot; we simply package it for
>> licensing.  If the packaging were in two parts, one could unpack the first part
>> only and not encounter the problem.
> 
> Would something like this be sufficient?
> 
> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323fda8..96c21e7a74 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -20,6 +20,7 @@ git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>  rm -rf .git roms/*/.git dtc/.git pixman/.git
> +tar cfj roms/u-boot.tar.bz2 roms/u-boot && rm -rf roms/u-boot
>  popd
>  tar cfj ${destination}.tar.bz2 ${destination}
>  rm -rf ${destination}
> 
> And then we can optionally just revert it once we move to a fixed
> u-boot? Although we'd need to take care in that case to make sure
> we don't use the wrong version of make-release for a particular
> point release.


That seems very reasonable to me.  It also avoids the problem that I would have
introduced wrt having two distribution tarballs.


r~
