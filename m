Received: from eggs.gnu.org ([2001:4830:134:3::10]:35815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBx7V-0008B7-4v
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBx7R-0002zM-47
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:12:21 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:50180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBx7Q-0002yi-Sa
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:12:17 -0500
Received: by mail-it0-x22b.google.com with SMTP id 72so1059887itl.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 22:12:16 -0800 (PST)
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
	<CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
	<e23177c9-36cb-2ad7-18c0-ebf3caaebb52@redhat.com>
	<20171106115931.GB3898@lemon>
	<fb7c5778-238d-ac99-26d6-8a6d9c80a0f4@redhat.com>
	<CANRm+Cw=F244w=6YMutjcvWin9_xiRt0Z1MvT=oi+7CXjU+DXw@mail.gmail.com>
	<78a404c5-fb2f-6fdf-c307-107ff1af4342@redhat.com>
	<5e0576f6-bb91-7e6e-7a1d-391d18717c0d@ozlabs.ru>
	<CANRm+CwnZCpEZ9qN9dB808Y-znyn_vcwtAWKfjxCrpo4Qv=U_Q@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f2d1d51e-16d4-ed20-cda2-fad6c7394cc0@ozlabs.ru>
Date: Tue, 7 Nov 2017 17:12:10 +1100
MIME-Version: 1.0
In-Reply-To: <CANRm+CwnZCpEZ9qN9dB808Y-znyn_vcwtAWKfjxCrpo4Qv=U_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu core file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 07/11/17 17:02, Wanpeng Li wrote:
> Hi Alexey,
> 2017-11-07 13:46 GMT+08:00 Alexey Kardashevskiy <aik@ozlabs.ru>:
>> On 07/11/17 01:08, Paolo Bonzini wrote:
>>> On 06/11/2017 13:18, Wanpeng Li wrote:
>>>> 2017-11-06 20:02 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>>> On 06/11/2017 12:59, Fam Zheng wrote:
>>>>>>>> Could you point out the patchset for the fix?
>>>>>>> Between 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c and
>>>>>>> 092aa2fc65b7a35121616aad8f39d47b8f921618.
>>>>>> Not sure how these relate to the core size, but I've tested upstream
>>>>>> (ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c) and with dump-guest-core=off the core
>>>>>> file is 363M, still significantly larger than rss (~73M).
>>>>>>
>>>>>> What is bloating the core file?
>>>>>
>>>>> My guess would have been fragmented heap.  The core file, unlike the
>>>>> RSS, includes all the mmaped memory (e.g. from shared libraries) that
>>>>> has never been used.
>>>>>
>>>>> For example, all the Ceph/Gluster/PulseAudio/SPICE/whatever libraries
>>>>> are included in the core file but likely are not in the RSS.
>>>>
>>>> Do you mean not use Memory API will avoid the fragmented heap?
>>>
>>> The high memory usage from the memory API causes excessive
>>> fragmentation.  Alexey's work should help reducing memory usage and thus
>>> the fragmentation.
>>
>> Since centos6 does not have this issue and centos7 does, I'd suggest
>> MALLOC_ARENA_MAX&co
>> https://www.gnu.org/software/libc/manual/html_node/Memory-Allocation-Tunables.html
> 
> Thanks for the inputs. What's the recommend glibc.malloc.arena_max
> value from you? :)

I have no idea, you have to try different values as you are the one who is
unhappy about the sizes :) I do not normally mess with this as things
should just work with the defaults whatever they are.


> 
>>
>> glibc changed some defaults between rhel/centos 6 and 7 if I recall
>> correctly, and these arenas now create big anon mappings per thread, these
>> are not really touched (so they do not use resident memory) but may appear
>> in these dumps, dunno.
>>
>> btw do you configure the machine to make "kill -11" produce qemu core dumps?
> 
> Yeah, some tuning in /etc/libvirt/qemu.conf, max_core="unlimited",
> dump_guest_core=0

dump_guest_core=0 should mean "no dumps", no?
Do you know how to enable this without libvirt?


-- 
Alexey
