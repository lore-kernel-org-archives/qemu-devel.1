Received: from eggs.gnu.org ([2001:4830:134:3::10]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb8Z-0007eG-W9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb8V-0006HG-3l
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYb8U-0006GW-O6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:50:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5B16883B6
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 16:50:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-7-git-send-email-armbru@redhat.com>
	<c092a949-fd51-93a2-c94a-bed10697efaa@redhat.com>
Date: Fri, 21 Jul 2017 18:50:40 +0200
In-Reply-To: <c092a949-fd51-93a2-c94a-bed10697efaa@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 10:00:02 -0500")
Message-ID: <87lgnhag4f.fsf@dusky.pond.sub.org>
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
>> 
>> +    response = qmp("{'execute': 'device_add', 'arguments': %p }", args);
>> +
>
> I like this; in fact, in my earlier series attempting to remove
> qobject_from_jsonf(), I heavily relied on %p being useful, to the point
> that I even added a helper function to make it easier (off-hand, it was
> something like qmp_execute(const char *command, QDict *arguments))
>
>> @@ -674,6 +676,7 @@ static void pci_hotplug(void)
>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>          qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
>>      }
>> +
>>      qtest_shutdown(qs);
>
> Spurious whitespace addition?

Is it spurious if the result looks better?  ;)

There's a blank line after pci_test_start(), and that makes me want one
before the matching qtest_shutdown().

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
