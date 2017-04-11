Received: from eggs.gnu.org ([2001:4830:134:3::10]:43647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cxv8a-0006US-4o
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cxv8X-00027S-3b
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:43:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cxv8W-000262-SG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:43:09 -0400
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
	<20170411124109.GB29540@HEDWIG.INI.CMU.EDU>
From: Alexander Graf <agraf@suse.de>
Message-ID: <e6635b63-351f-584c-4805-316d44b10673@suse.de>
Date: Tue, 11 Apr 2017 14:43:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170411124109.GB29540@HEDWIG.INI.CMU.EDU>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] kvm: better MWAIT emulation for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jim Mattson <jmattson@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On 04/11/2017 02:41 PM, Gabriel L. Somlo wrote:
> On Tue, Apr 11, 2017 at 01:45:35PM +0200, Alexander Graf wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>
>> Guests that are heavy on futexes end up IPI'ing each other a lot. That
>> can lead to significant slowdowns and latency increase for those guests
>> when running within KVM.
>>
>> If only a single guest is needed on a host, we have a lot of spare host
>> CPU time we can throw at the problem. Modern CPUs implement a feature
>> called "MWAIT" which allows guests to wake up sleeping remote CPUs without
>> an IPI - thus without an exit - at the expense of never going out of guest
>> context.
>>
>> The decision whether this is something sensible to use should be up to the
>> VM admin, so to user space. We can however allow MWAIT execution on systems
>> that support it properly hardware wise.
>>
>> This patch adds a CAP to user space and a KVM cpuid leaf to indicate
>> availability of native MWAIT execution. With that enabled, the worst a
>> guest can do is waste as many cycles as a "jmp ." would do, so it's not
>> a privilege problem.
> Did you mean "hlt" rather than "jmp" ?

No, hlt wouldn't waste cycles, "jmp ." does.

The point I'm trying to make here is that by removing the MWAIT trap we 
don't give the guest more CPU time than we would've granted it before.

>
>> We consciously do *not* expose the feature in our CPUID bitmap, as most
>> people will want to benefit from sleeping vCPUs to allow for over commit.
>>
>> Reported-by: "Gabriel L. Somlo" <gsomlo@gmail.com>
> That's maybe a bit inacurate, I didn't actually report anything *this*
> patch is trying to address (that was rather commit 87c00572ba05aa8c9d).
>
> Maybe
>
> Acked-by: Gabriel Somlo <gsomlo@gmail.com>
>
> would be a more accurate statement instead?

Works for me :). I'm sure whoever applies this can swizzle the tag?


Alex
