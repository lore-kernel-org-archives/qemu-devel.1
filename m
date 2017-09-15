Received: from eggs.gnu.org ([2001:4830:134:3::10]:47609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsqnD-0006jr-3x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsqnA-00075S-0i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dsqn9-00073z-Qb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:36:23 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-12-david@redhat.com> <87lglia85d.fsf@linaro.org>
	<febf18fb-7437-0ce0-6669-1c7e964eea07@redhat.com>
	<87vakk85k8.fsf@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7b5c88bf-50be-d692-2925-c549bfd79202@redhat.com>
Date: Fri, 15 Sep 2017 15:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <87vakk85k8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/22] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 15.09.2017 15:17, Alex Benn=C3=A9e wrote:
>=20
> David Hildenbrand <david@redhat.com> writes:
>=20
>> On 13.09.2017 18:13, Alex Benn=C3=A9e wrote:
>>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>>>> guest tries to bring these CPUs up but fails), because we don't supp=
ort
>>>> multiple CPUs on s390x under TCG.
>>>>
>>>> Let's bail out if more than 1 is specified, so we don't raise people=
's
>>>> hope.
>>>
>>> Why does this restriction exist? Without MTTCG enabled -smp > 1 shoul=
d
>>> be safe from any races.
>>
>> Because the actual SIGP code (instruction to start/stop ... CPUs) is n=
ot
>> implemented yet.
>=20
> Ahh OK, I assume something like ARM's PCSI interface then.
>=20
> When you do get around to implementing just ensure you use the async
> mechanism to initialise the target processor state to avoid races in
> MTTCG. Essentially you queue the work up on the target and then it is
> run before the powered up vCPU starts running code.

One step at a time, right now I only test with single threaded. MTTCG is
the next step. But I have a good feeling about mttcg, at least speaking
about the SIGP implementation (for the "critical" stuff - start, stop,
initialize - I reuse the KVM code which uses even sync work).

>=20
> --
> Alex Benn=C3=A9e
>=20


--=20

Thanks,

David
