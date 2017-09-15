Received: from eggs.gnu.org ([2001:4830:134:3::10]:42564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsqUg-0004TX-0E
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsqUb-0004O5-UD
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:17:17 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:48543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dsqUb-0004MP-N4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:17:13 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r68so8254915wmg.3
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 06:17:13 -0700 (PDT)
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-12-david@redhat.com>
	<87lglia85d.fsf@linaro.org>
	<febf18fb-7437-0ce0-6669-1c7e964eea07@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <febf18fb-7437-0ce0-6669-1c7e964eea07@redhat.com>
Date: Fri, 15 Sep 2017 14:17:11 +0100
Message-ID: <87vakk85k8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 11/22] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


David Hildenbrand <david@redhat.com> writes:

> On 13.09.2017 18:13, Alex Bennée wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>>> guest tries to bring these CPUs up but fails), because we don't support
>>> multiple CPUs on s390x under TCG.
>>>
>>> Let's bail out if more than 1 is specified, so we don't raise people's
>>> hope.
>>
>> Why does this restriction exist? Without MTTCG enabled -smp > 1 should
>> be safe from any races.
>
> Because the actual SIGP code (instruction to start/stop ... CPUs) is not
> implemented yet.

Ahh OK, I assume something like ARM's PCSI interface then.

When you do get around to implementing just ensure you use the async
mechanism to initialise the target processor state to avoid races in
MTTCG. Essentially you queue the work up on the target and then it is
run before the powered up vCPU starts running code.

--
Alex Bennée
