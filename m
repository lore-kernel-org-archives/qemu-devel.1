Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gURcd-0003oh-OA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 02:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gURcY-0004Pr-Mj
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 02:29:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gURcY-0004P5-FO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 02:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD5A63002F82
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 07:29:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181126225620.5301-1-ehabkost@redhat.com>
	<790ea478-b4b0-32a9-a83e-a884a20dc1bc@redhat.com>
	<20181204182133.GD18284@habkost.net>
Date: Wed, 05 Dec 2018 08:29:15 +0100
In-Reply-To: <20181204182133.GD18284@habkost.net> (Eduardo Habkost's message
	of "Tue, 4 Dec 2018 16:21:33 -0200")
Message-ID: <87in082zzo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] apic: Make APIC ID limit error message
 clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Dec 03, 2018 at 07:07:10PM -0200, Wainer dos Santos Moschetta wrote:
>> 
>> On 11/26/2018 08:56 PM, Eduardo Habkost wrote:
>> > Remove the "apic initialization failed" prefix (it conveys no
>> > useful information), replace "invalid" with "too large", and add
>> > an error hint with two possible solutions for the problem.
>> > 
>> > Before:
>> > 
>> >    $ qemu-system-x86_64 -machine q35 -smp 256
>> >    qemu-system-x86_64: apic initialization failed. APIC ID 255 is invalid
>> > 
>> > After:
>> > 
>> >    $ qemu-system-x86_64 -machine q35 -smp 256 -display none
>> >    qemu-system-x86_64: APIC ID 255 is too large
>> 
>> I would keep the problem "apic initialization failed" sentence. "APIC ID 255
>> is too large" is just the cause.
>
> I'm not sure I agree.  "APIC initialization failed" doesn't
> convey any useful information to the user, does it?

Concur.

>> >    Possible solutions:
>> >    * Lowering the number of VCPUs on the -smp option
>> >    * Using accel=kvm,kernel-irqchip=on or accel=kvm,kernel-irqchip=split
>> > 
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> > I'm not sure this is the best way to provide usage hints to the
>> > user.  Any suggestions?
>> 
>> As a noob, I can testify that this kind of suggestion is very useful
>> although there seems to not have many on QEMU. On the other hand, I
>> understand it can make qemu verbose and so annoy people. Thus, maybe those
>> suggestions could be enabled/disabled via options (e.g. -show-hints)?
>
> I can't imagine who would be annoyed by them.

A few lines of hints are fine.  Longer than that and the error becomes
hard to spot among the hints.
