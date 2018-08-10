Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo5Fz-0001OP-4J
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo5Fv-0001cZ-S8
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:06:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fo5Fv-0001bx-MR
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:06:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2E3340216F5
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 11:06:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com> (Paolo
	Bonzini's message of "Fri, 10 Aug 2018 12:19:08 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 10 Aug 2018 13:06:44 +0200
Message-ID: <87zhxuv5tn.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/08/2018 13:48, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/alpha-softmmu.mak       | 2 --
>>  default-configs/arm-softmmu.mak         | 2 --
>>  default-configs/hppa-softmmu.mak        | 3 ---
>>  default-configs/i386-softmmu.mak        | 2 --
>>  default-configs/mips-softmmu-common.mak | 2 --
>>  default-configs/ppc-softmmu.mak         | 1 -
>>  default-configs/ppcemb-softmmu.mak      | 2 --
>>  default-configs/sh4-softmmu.mak         | 2 --
>>  default-configs/sh4eb-softmmu.mak       | 2 --
>>  default-configs/sparc64-softmmu.mak     | 2 --
>>  default-configs/x86_64-softmmu.mak      | 2 --
>>  11 files changed, 22 deletions(-)
>
> I don't think CONFIG_SERIAL_ISA should be in pci.mak though, and
> CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
> CONFIG_SERIAL_PCI.  Perhaps introduce a superio.mak with all the legacy
> ISA devices?

Hi

Several things here.

a- I am just removing bits that are duplicated in this patch
   So I think it should got in as it is.

b- SuperIO: I would really be able to remove isapc machine type and
   isa-bus and related friends. (Yes, as put before, I know that all
   pc's have an isa bus, but no need for things like mmouse nowadays)

c- untangling piix and q35 is a bit of work.  The things that I remember
   from memory:
   * tests: we have tests for both on the same file (we can split the
     file)
   * is_default.  This is a mess.  I tried to disable "piix" machine
     types leaving only q35, and then tests complain that there is no
     default machine type.  I think that we should remove all the
     is_default logic and just choose the 1st for the list of machines
     (but that is one idea that I haven't triued to follow yet).

And that is before we start doing things like network isa cards, isa
sound cards, vmport (I hate that), parallel port, whatdog, etc, etc.

Later, Juan.
