Received: from eggs.gnu.org ([2001:4830:134:3::10]:33448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBwyC-0006PJ-Oh
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBwyB-00089k-JD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:02:44 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:44053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eBwyB-00089T-EJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:02:43 -0500
Received: by mail-oi0-x235.google.com with SMTP id v132so9385919oie.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 22:02:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e0576f6-bb91-7e6e-7a1d-391d18717c0d@ozlabs.ru>
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
	<CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
	<e23177c9-36cb-2ad7-18c0-ebf3caaebb52@redhat.com>
	<20171106115931.GB3898@lemon>
	<fb7c5778-238d-ac99-26d6-8a6d9c80a0f4@redhat.com>
	<CANRm+Cw=F244w=6YMutjcvWin9_xiRt0Z1MvT=oi+7CXjU+DXw@mail.gmail.com>
	<78a404c5-fb2f-6fdf-c307-107ff1af4342@redhat.com>
	<5e0576f6-bb91-7e6e-7a1d-391d18717c0d@ozlabs.ru>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 7 Nov 2017 14:02:41 +0800
Message-ID: <CANRm+CwnZCpEZ9qN9dB808Y-znyn_vcwtAWKfjxCrpo4Qv=U_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu core file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Alexey,
2017-11-07 13:46 GMT+08:00 Alexey Kardashevskiy <aik@ozlabs.ru>:
> On 07/11/17 01:08, Paolo Bonzini wrote:
>> On 06/11/2017 13:18, Wanpeng Li wrote:
>>> 2017-11-06 20:02 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>> On 06/11/2017 12:59, Fam Zheng wrote:
>>>>>>> Could you point out the patchset for the fix?
>>>>>> Between 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c and
>>>>>> 092aa2fc65b7a35121616aad8f39d47b8f921618.
>>>>> Not sure how these relate to the core size, but I've tested upstream
>>>>> (ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c) and with dump-guest-core=off the core
>>>>> file is 363M, still significantly larger than rss (~73M).
>>>>>
>>>>> What is bloating the core file?
>>>>
>>>> My guess would have been fragmented heap.  The core file, unlike the
>>>> RSS, includes all the mmaped memory (e.g. from shared libraries) that
>>>> has never been used.
>>>>
>>>> For example, all the Ceph/Gluster/PulseAudio/SPICE/whatever libraries
>>>> are included in the core file but likely are not in the RSS.
>>>
>>> Do you mean not use Memory API will avoid the fragmented heap?
>>
>> The high memory usage from the memory API causes excessive
>> fragmentation.  Alexey's work should help reducing memory usage and thus
>> the fragmentation.
>
> Since centos6 does not have this issue and centos7 does, I'd suggest
> MALLOC_ARENA_MAX&co
> https://www.gnu.org/software/libc/manual/html_node/Memory-Allocation-Tunables.html

Thanks for the inputs. What's the recommend glibc.malloc.arena_max
value from you? :)

>
> glibc changed some defaults between rhel/centos 6 and 7 if I recall
> correctly, and these arenas now create big anon mappings per thread, these
> are not really touched (so they do not use resident memory) but may appear
> in these dumps, dunno.
>
> btw do you configure the machine to make "kill -11" produce qemu core dumps?

Yeah, some tuning in /etc/libvirt/qemu.conf, max_core="unlimited",
dump_guest_core=0

Regards,
Wanpeng Li
