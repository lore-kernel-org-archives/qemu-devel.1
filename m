Received: from eggs.gnu.org ([2001:4830:134:3::10]:42424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAeue-00038E-O7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAeuY-0003ZN-TU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAeuY-0003Z3-NB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCF4F30820C0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 17:38:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-15-armbru@redhat.com>
	<20181008180358.GT5738@habkost.net>
Date: Thu, 11 Oct 2018 19:38:08 +0200
In-Reply-To: <20181008180358.GT5738@habkost.net> (Eduardo Habkost's message of
	"Mon, 8 Oct 2018 15:03:58 -0300")
Message-ID: <878t34z8n3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/31] numa: Fix QMP command set-numa-node
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Oct 08, 2018 at 07:31:08PM +0200, Markus Armbruster wrote:
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  parse_numa_node() does that, and then exit()s.  It
>> also passes &error_fatal to machine_set_cpu_numa_node().  Both wrong.
>> Attempting to configure numa when the machine doesn't support it kills
>> the VM:
>> 
>>     $ qemu-system-x86_64 -nodefaults -S -display none -M none -preconfig -qmp stdio
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
>>     {"execute": "qmp_capabilities"}
>>     {"return": {}}
>>     {"execute": "set-numa-node", "arguments": {"type": "node"}}
>>     NUMA is not supported by this machine-type
>>     $ echo $?
>>     1
>> 
>> Messed up when commit 64c2a8f6d3f and 7c88e65d9e9 (v2.10.0) added
>> incorrect error handling right next to correct examples.  Latent bug
>> until commit f3be67812c2 (v3.0.0) made it accessible via QMP.  Fairly
>> harmless in practice, because it's limited to RUN_STATE_PRECONFIG.
>> The fix is obvious: replace error_report(); exit() by error_setg();
>> return.
>> 
>> This affects parse_numa_node()'s other caller
>> numa_complete_configuration(): since it ignores errors, the "NUMA is
>> not supported by this machine-type" is now ignored, too.  But that
>> error is as unexpected there as any other.  Change it to abort on
>> error instead.
>> 
>> Fixes: f3be67812c226162f86ce92634bd913714445420
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> 
>> fixup! numa: Fix QMP command set-numa-node error handling
>
> I assume this last line was kept by mistake, and I'm removing it
> while committing.

Oops.
