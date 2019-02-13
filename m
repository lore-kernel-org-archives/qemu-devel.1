Received: from eggs.gnu.org ([209.51.188.92]:37837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtxCV-00014B-T0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtxCU-0002jH-Vi
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtxCU-0002hO-NK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:15:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C6CF13CF4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 16:15:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <871s4chvb2.fsf@dusky.pond.sub.org>
	<9e429792-cbea-c96c-ad48-7f5bdd7ef781@redhat.com>
Date: Wed, 13 Feb 2019 17:15:50 +0100
In-Reply-To: <9e429792-cbea-c96c-ad48-7f5bdd7ef781@redhat.com> (Paolo
	Bonzini's message of "Wed, 13 Feb 2019 15:18:31 +0100")
Message-ID: <87bm3f4qbt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Seeking QEMU makefile advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/02/19 10:49, Markus Armbruster wrote:
>> * Define QAPI_COMMON_MODULES, QAPI_TARGET_MODULES and QAPI_MODULES in
>>   Makefile.obj
>> 
>> * Add to util-obj-y in Makefile.obj
>> 
>> * Add to obj-y in Makefile.target
>
> Why can't both be in Makefile.objs, or in qapi/Makefile.objs?

When I try either place, I get

      LINK    x86_64-softmmu/qemu-system-x86_64
    monitor.o: In function `qmp_query_qmp_schema':
    /work/armbru/qemu/monitor.c:1136: undefined reference to `qmp_schema_qlit'
    [more errors...]

Compiling with V=1 confirms qapi-introspect.o isn't in $(all-obj-y).

I think this is the case because Makefile.target has

    all-obj-y := $(obj-y)

before

    include $(SRC_PATH)/Makefile.objs

If I move the former below the latter (without really understanding the
consequences), I get

    make[1]: *** No rule to make target '9pfs/', needed by 'qemu-system-x86_64'.
    make[1]: *** No rule to make target 'acpi/', needed by 'qemu-system-x86_64'.
    make[1]: *** No rule to make target 'adc/', needed by 'qemu-system-x86_64'.
    [many, many more...]

What now?
