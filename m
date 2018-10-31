Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrjE-0001pp-2o
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrj8-0002Kr-FH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHrj7-0002En-5X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
	<87zhuudw4o.fsf@dusky.pond.sub.org>
Date: Wed, 31 Oct 2018 15:44:06 +0100
In-Reply-To: <87zhuudw4o.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 31 Oct 2018 15:32:55 +0100")
Message-ID: <87h8h2dvm1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: correctly parse uint64_t
 values from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Markus Armbruster <armbru@redhat.com> writes:

> David Hildenbrand <david@redhat.com> writes:
>
>> Right now, we parse uint64_t values just like int64_t values, resulting
>> in negative values getting accepted and certain valid large numbers only
>> being representable as negative numbers. Also, reported errors indicate
>> that an int64_t is expected.
>>
>> Parse uin64_t separately. We don't have to worry about ranges.
>
> The commit message should mention *why* we don't we have to worry about
> ranges.
>
>>
>> E.g. we can now also specify
>>     -device nvdimm,memdev=mem1,id=nv1,addr=0xFFFFFFFFC0000000
>> Instead of only going via negative values
>>     -device nvdimm,memdev=mem1,id=nv1,addr=-0x40000000
>>
>> Resulting in the same values
>>
>> (qemu) info memory-devices
>> Memory device [nvdimm]: "nv1"
>>   addr: 0xffffffffc0000000
>>   slot: 0
>>   node: 0
>>
>
> Suggest to mention this makes the string-input-visitor catch up with the
> qobject-input-visitor, which got changed similarly in commit
> 5923f85fb82.

One more thing: the qobject-input-visitor change also updated the
corresponding output visitor.  Shouldn't we do the same here?
