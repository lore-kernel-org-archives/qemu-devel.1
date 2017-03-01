Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cj9xU-00079f-Jv
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cj9xR-00029G-A8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:30:44 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cj9xR-00028g-3t
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:30:41 -0500
Received: by mail-qk0-x244.google.com with SMTP id n186so13260342qkb.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:30:41 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
	<bf246870-6e7c-f540-7cd4-3a20d5912162@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ea3392d8-cd07-64e0-134a-4f111fe853db@twiddle.net>
Date: Thu, 2 Mar 2017 06:30:33 +1100
MIME-Version: 1.0
In-Reply-To: <bf246870-6e7c-f540-7cd4-3a20d5912162@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

On 03/01/2017 07:00 PM, Thomas Huth wrote:
>> Primarily, it does not raise an exception for error.
>
> Protection and page faults should be generated properly via
> trigger_access_exception() there ... or did I miss something?

So why does s390_cpu_virt_mem_rw document that it returns non-zero if there was 
an error?

I see you do raise an exception on the TCG path (via translate_pages), but not 
the KVM path.  That is very confusing.

> AR = Access Register ... they are needed when the CPU runs in access
> register mode (i.e. the AS PSW bits are 01). AFAIK we don't emulate this
> in QEMU yet, but the KVM_S390_MEM_OP ioctl already supports it.

Hmm.  I guess I don't know how to read that then.

>> Your writes need to look a lot more like fast_memmove in mem_helper.c,
>> except that of course only the destination needs translation.
>
> I still think that s390_cpu_virt_mem_write() should be fine here, too.

Ideally you'd interact with the TCG TLB in some way so that you didn't have to 
manage your own translation and your own exceptions.  That's what fast_memmove 
does.

>
>> Of course, in practice we could reduce this to just one cpu_stl_data for
>> STFL and one or two cpu_stq_data for STFLE.
>
> I think STFLE can store more than two 64-bit words, can't it?

Technically, yes.  But there are less than 128 bits defined.  Certainly much 
less than the 4k bits that Michal prepares for.


r~
