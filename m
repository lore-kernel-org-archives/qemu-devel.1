Received: from eggs.gnu.org ([2001:4830:134:3::10]:58210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYaAA-0007ms-Pt
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYaA5-0000uT-JP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:48:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYaA5-0000uE-D1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:48:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49499800AF
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:48:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-3-git-send-email-armbru@redhat.com>
	<8dcd89b7-8f87-00fa-8b67-594b1463a988@redhat.com>
Date: Fri, 21 Jul 2017 17:48:12 +0200
In-Reply-To: <8dcd89b7-8f87-00fa-8b67-594b1463a988@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 09:24:24 -0500")
Message-ID: <87tw25bxkz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/9] qtest: Document calling conventions
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
>> From: Eric Blake <eblake@redhat.com>
>> 
>> We have two flavors of vararg usage in qtest; make it clear that
>> qmp() has different semantics than hmp(), and let the compiler
>> enforce that hmp() is used correctly. However, qmp() (and friends)
>> only accept a subset of printf flags look-alikes (namely, those
>> that our JSON parser understands), and what is worse, qmp("true")
>> (the JSON keyword 'true') is different from qmp("%s", "true")
>> (the JSON string '"true"'), so marking those as printf-like would
>> produce more harm from bogus warnings than it helps (we may have
>> made a mistake in previously marking qobject_from_jsonf(), but
>> this patch is not addressing that).
>> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20170720214008.28494-5-eblake@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> As you pointed out on the other thread,
>
>> @@ -134,7 +137,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
>>  /**
>>   * qtest_hmp:
>>   * @s: #QTestState instance to operate on.
>> - * @fmt...: HMP command to send to QEMU
>> + * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
>>   *
>>   * Send HMP command to QEMU via QMP's human-monitor-command.
>>   * QMP events are discarded.
>
> I accidentally killed the attribute here,
>
>> @@ -592,7 +598,7 @@ static inline QDict *qmp_eventwait_ref(const char *event)
>>  
>>  /**
>>   * hmp:
>> - * @fmt...: HMP command to send to QEMU
>> + * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
>>   *
>>   * Send HMP command to QEMU via QMP's human-monitor-command.
>>   *
>
> and here.

Putting them back is easier than updating commit message 1/9.
