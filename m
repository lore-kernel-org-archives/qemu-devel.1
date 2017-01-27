Received: from eggs.gnu.org ([2001:4830:134:3::10]:33128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cX2l7-0006Cl-Fb
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cX2l2-0002c9-Ix
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:23:53 -0500
References: <20170126204547.9418-1-lvivier@redhat.com>
	<1566500454.13089168.1485507144455.JavaMail.zimbra@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a8bdc8da-a5ca-10f9-bd6b-0eada5b2d8de@redhat.com>
Date: Fri, 27 Jan 2017 10:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <1566500454.13089168.1485507144455.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: clock should count only if vm is
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 27/01/2017 09:52, Paolo Bonzini wrote:
> 
>> This is a port to ppc of the i386 commit:
>>     00f4d64 kvmclock: clock should count only if vm is running
>>
>> We remove timebase_/pre_save/post_load/ functions,
>> and use the VM state change handler to save and restore
>> the guest_timebase (on stop and continue).
>>
>> Time base offset has originally been introduced by commit
>>     98a8b52 spapr: Add support for time base offset migration
>>
>> So while VM is paused, the time is stopped. This allows to have
>> the same result with date (based on Time Base Register) and
>> hwclock (based on "get-time-of-day" RTAS call).
>>
>> Moreover in TCG mode, the Time Base is always paused, so this
>> patch also adjust the behavior between TCG and KVM.
>>
>> VM state field "time_of_the_day_ns" is now useless but we keep
>> it to be able to migrate to older version of the machine.
>>
>> As vmstate_ppc_timebase structure (with timebase_pre_save() and
>> timebase_post_load() functions) was only used by vmstate_spapr,
>> we register the VM state change handler only in ppc_spapr_init().
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> I think you should keep the pre_save handler, otherwise after
> migration the timebase register will be off by as long as the
> time needed to do the final RAM transfer.  See commit 6053a86
> ("kvmclock: reduce kvmclock difference on migration", 2016-12-22).

I will.

Thank you,
Laurent
