Received: from eggs.gnu.org ([2001:4830:134:3::10]:33246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTNvT-0008Rt-DD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTNvQ-0007LF-Bb
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTNvQ-0007Jb-64
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:43:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170630133139.7907-1-vadim.galitsyn@profitbricks.com>
	<20170630133139.7907-2-vadim.galitsyn@profitbricks.com>
	<87lgo0900x.fsf@dusky.pond.sub.org>
Date: Fri, 07 Jul 2017 09:43:36 +0200
In-Reply-To: <87lgo0900x.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 07 Jul 2017 09:30:38 +0200")
Message-ID: <877ezk7kuv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] hmp,
 qmp: introduce memory-size-summary commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Mohammed Gamal <mohammed.gamal@profitbricks.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Markus Armbruster <armbru@redhat.com> writes:

> Sorry for the late review, got a bit overwhelmed...
>
> Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:
>
>> Commands above provide the following memory information in bytes:
>>
>>   * base-memory - amount of unremovable memory specified
>>     with '-m' option at the start of the QEMU process.
>>
>>   * hotpluggable-memory - amount of memory that was hot-plugged.
>>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>>     value is reported.
>>
>>   * balloon-actual-memory - size of the memory that remains
>>     available to the guest after ballooning, as reported by the
>>     guest. If the guest has not reported its memory, this value
>>     equals to @base-memory + @hot-plug-memory. If ballooning
>>     is not enabled, no value is reported.
>>
>> NOTE:
>>
>>     Parameter @balloon-actual-memory reports the same as
>>     "info balloon" command when ballooning is enabled. The idea
>>     to have it in scope of this command(s) comes from
>>     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.
[...]
>>  9 files changed, 113 insertions(+), 1 deletion(-)
>>  rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (60%)
>
> No test coverage?

Maybe no need, because ...

[...]
> query-memory-size-summary combines three queries:
>
> (1) base-memory (query can't fail)
>
> (2) hotpluggable-memory (query must not fail, i.e. &error_abort)
>
> (3) balloon-actual-memory (query can fail, and we throw away the error
>     then)
>
> Including (3) adds a failure mode.  The fact that we sweep the failure
> under the rug doesn't change that.
>
> Why is this a good idea?

... with (3) and its failure mode removed, there's less need for
specific tests.  The (future, hopefully near future) generic smoke test
of queries that can't fail should do.

[...]
