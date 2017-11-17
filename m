Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFdut-0000cG-QR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFduq-00078M-MX
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:53658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eFduq-00077A-Ci
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:32 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <a4842f5b-4f81-1486-d044-a5ba623ccdf9@linux.intel.com>
Date: Fri, 17 Nov 2017 18:30:24 +0800
MIME-Version: 1.0
In-Reply-To: <cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org



On 11/17/2017 16:53, Kamil Rytarowski wrote:
> On 14.11.2017 09:54, Yu Ning wrote:
>> Hello,
>>
>> As some of you may have noticed, since QEMU 2.9.0, an accelerator known
>> as “hax” has been available for Windows and macOS builds of QEMU, thanks
>> to the hard work of Vincent Palatin and help from this community (Paolo
>> Bonzini, Stefan Weil, et al.).
>>
>> The accelerator requires a host kernel module (driver) known as Intel
>> Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on
>> Windows or intelhaxm.kext on macOS, similar to how the KVM accelerator
>> depends on kvm.ko on Linux.
>>
>> Today, we released the source code of the HAXM kernel module under the
>> BSD 3-clause license:
>>
>> https://github.com/intel/haxm
>>
>> We look forward to working with the community to improve HAXM (both the
>> kernel module and the accelerator). The code is accompanied by some
>> basic documentation (README.md and API.md), which is incomplete, but
>> hopefully helps people get started. If you have any questions or
>> suggestions, please create an issue or post a comment on GitHub.
>>
>> Thanks,
>> Yu
>>
> Please make it clear whether this module can be ported (as host) to
> other OSes

It was designed with only Windows and Mac hosts in mind, and we don't 
plan to support more host OSes. But porting HAXM to another host OS is 
possible.  If you take a look at the HAXM source tree, there are pretty 
clear boundaries between host-independent code (core/, include/*.h), 
Windows-specific code (windows/, include/windows/) and Mac-specific code 
(darwin/, include/darwin/).
>   and whether it can support arbitrary guests OSes (for the
> same CPU).

Unfortunately not, but again it can be done.  Initially HAXM was 
designed to support only two guest OSes, namely Android and Tizen. When 
we upstreamed the HAXM accelerator module to QEMU, we verified it using 
various desktop OS images, mostly Linux-based (Chrome OS, Debian, 
Ubuntu, CentOS, etc.), although there were a few others (FreeDOS, etc.).

Nevertheless, you may run into issues when you boot a completely 
different guest OS (e.g. Windows, which we have never tested), or even 
with one that is similar to what I've mentioned (e.g. Fedora, which IIRC 
will boot to a kernel panic).  In such cases, the culprit is usually 
bug(s) in the HAXM kernel module, causing incorrect behavior when the 
guest executes certain x86 instructions.  Once all the bugs exposed by a 
specific guest OS are fixed, that guest OS will work correctly.
