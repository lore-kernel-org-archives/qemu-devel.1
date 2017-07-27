Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1daeCR-0007rw-DQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1daeCN-0007fd-7e
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1daeCN-0007et-1L
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1321BB6F47
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:31:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-7-git-send-email-armbru@redhat.com>
	<0f75806a-fe58-2ae3-2ac2-e7eaea5992d5@redhat.com>
Date: Thu, 27 Jul 2017 10:31:08 +0200
In-Reply-To: <0f75806a-fe58-2ae3-2ac2-e7eaea5992d5@redhat.com> (Eric Blake's
	message of "Tue, 25 Jul 2017 09:10:13 -0500")
Message-ID: <87fudiffhv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/9] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/21/2017 08:53 AM, Markus Armbruster wrote:
>> Leaving interpolation into JSON to qmp() is more robust than building
>> QMP input manually, as explained in the commit before previous.
>> 
>> The case in qpci_plug_device_test() is a bit complicated: it
>> interpolates several JSON object members, not just a value.  Clean it
>> up by passing them in as QDict rather than string, so we can leave
>> interpolation to qmp() here and to qobject_from_jsonf() in callers.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
>> +                                             tmpshm);
>>  
>>      qtest_start("");
>>  
>> -    opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
>> -
>> -    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
>
> Wait, 'size':'1M' works?  I guess because it's a string, rather than a
> JSON number.  One of our intentional design choices in QMP was to
> represent everything as bytes, rather than as suffixed numbers, since
> machine-generated code can easily generate bytes anywhere that humans
> prefer a suffixed number.  But as you are not changing this interface,
> but merely refactoring how it is tested, it's more of a side comment
> than something that affects review.

Design mistake in legacy device "ivshmem".  Fixed in "ivshmem-plain" and
"ivshmem-doorbell", see commit 5400c02.
