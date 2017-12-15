Received: from eggs.gnu.org ([2001:4830:134:3::10]:49962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePqTQ-0004BZ-1s
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePqTN-0004pM-0O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:56:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePqTM-0004oi-Nq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:56:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
	<de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
	<87ind9xrl6.fsf@dusky.pond.sub.org>
	<949be39f-d2a9-29b4-d9b7-46378d827161@linux.vnet.ibm.com>
Date: Fri, 15 Dec 2017 14:56:18 +0100
In-Reply-To: <949be39f-d2a9-29b4-d9b7-46378d827161@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Thu, 14 Dec 2017 17:46:15 -0200")
Message-ID: <87ind8nlh9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

> On 12/14/2017 01:21 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 12/13/2017 12:15 PM, Daniel Henrique Barboza wrote:
>>>> Commit 755f196898 ("qapi: Convert the cpu command") added the qmp_cpu
>>>> function in qmp.c, leaving it blank. It the same commit, a working
>>>> hmp_cpu was implemented. Since then, no further changes were made in
>>>> qmp_cpu, resulting now in a working 'cpu' command that works in HMP
>>>> and a 'cpu' command in QMP that does nothing.
>>>>
>>>> Regardless of what constraints were involved that time in not implemeting
>>>> qmp_cpu, at this moment it is possible to have both.
>> If I remember that part of history correctly, implementing the command
>> in QMP was just as possible back then, but deemed a Bad Idea for the
>> reason Eric explains below.
>>
>> What I don't quite remember is why we had to implement it in QMP as a
>> no-op.  Might have been due to the way QMP and HMP were entangled back
>> then.
> Speaking of QMP and HMP 'entanglement', is the content of the wiki
> still valid?
>
> https://wiki.qemu.org/Features/QAPI

Looks quite stale to me.  I'm sorry this made you go down this rabbit
hole.

Paolo, we have numerous Features/ pages, and I suspect many of them are
too outdated to serve any purpose but confusing readers.  In theory,
"somebody" could go through them to identify stale ones.  In practice,
"somebody" doesn't exist, I'm afraid.  Should we summarily delete
Features/ pages that haven't seen an update in say more than a year?  Or
at least mark them as obsolete somehow?

> And under "HMP Conversion" we have:
>
> "For HMP commands that don't have QMP equivalents today, new QMP functions
> will be added to support these commands."

QMP need not provide the exact same commands.  It must provide
"equivalence".  Selecting a CPU is an instructive example.  HMP does it
with state: each HMP monitor has a current CPU, controlled with HMP
command cpu.  HMP commands implicitly use their monitor's current CPU.
In contrast, QMP eschews state, and makes the CPU explicit instead: you
specify the it as an argument.

> This in particular gave me the motivation to go ahead and implement qmp_cpu.
> But then again, the last entry on Status is "3/6/2011" so yeah, I
> should have
> asked here first whether the info from this wiki was relevant before sending
> the patch.

Touching base with the maintainer(s) first generally doesn't hurt.

[...]
