Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCNYW-0003Nk-Vb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCNYT-00025e-Q4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:26:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eCNYT-00022x-H2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:25:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEC39C047B89
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 10:25:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-11-quintela@redhat.com>
	<20171011092815.GE20372@redhat.com> <87376q10oh.fsf@secure.laptop>
	<87o9ofeb4q.fsf@dusky.pond.sub.org> <87lgjh6rb4.fsf@secure.mitica>
Date: Wed, 08 Nov 2017 11:25:52 +0100
In-Reply-To: <87lgjh6rb4.fsf@secure.mitica> (Juan Quintela's message of "Wed,
	08 Nov 2017 10:41:19 +0100")
Message-ID: <87tvy5qd73.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/10] migration: [RFC] Use proper types in
 json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>>> On Tue, Oct 10, 2017 at 08:15:42PM +0200, Juan Quintela wrote:
>>>>> We use int for everything (int64_t), and then we check that value is
>>>>> between 0 and 255.  Change it to the valid types.
>>>>> 
>>>>> For qmp, the only real change is that now max_bandwidth allows to use
>>>>> the k/M/G suffixes.
>>
>> Are you sure?
>
> No.  That is why I ask O:-)

Fair enough :)

>> QAPI type 'size' is integer in JSON.  No suffixes.  The QObject input
>> visitor does suffixes only when visiting v->keyval is true.
>
> Aha.  So patch can go in.
>
>>> if you set:
>>>
>>>      "max-bandwidth":  1024
>>>
>>> it understand 1024M, and it outputs that big number
>>>
>>>       "max-bandwidth":  $((1024*1024*1024))
>>>
>>> (no, I don't know the value from memory)
>>>
>>> And yes, for migrate_set_parameter, we introduced it on 2.10.  We should
>>> have done the right thing, but  I didn't catch the error (Markus did,
>>> but too late, release were already done)
>>
>> I suspect you're talking about *HMP*.  hmp_migrate_set_parameter(), to
>> be precise:
>>
>>     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>>         p->has_max_bandwidth = true;
>>         /*
>>          * Can't use visit_type_size() here, because it
>>          * defaults to Bytes rather than Mebibytes.
>>          */
>>         ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
>>         if (ret < 0 || valuebw > INT64_MAX
>>             || (size_t)valuebw != valuebw) {
>>             error_setg(&err, "Invalid size %s", valuestr);
>>             break;
>>         }
>>         p->max_bandwidth = valuebw;
>>         break;
>
> Ok. Understood.  Thanks.
>
>
>>>> As long as QEMU's JSON parser accepts both number & string values
>>>> for the 'size' type it is still backwards compatible if an app
>>>> continues to use 1024 instead of "1k"
>>>>
>>>> On *output* though (ie 'info migrate-parameters') this is not
>>>> compatible for applications, unless QEMU *always* uses the
>>>> numeric format when generating values. ie it must always
>>>> report 1024, and never "1k", as apps won't be expecting a string
>>>> with suffix.  I can't 100% tell whether this is the case or not,
>>>> so CC'ing Markus to confirm if changing "int" to "size" is
>>>> guaranteed back-compat in both directions
>>>
>>> This is why I asked.  My *understanding* was that my changes are NOP
>>> if you use the old interface, but I don't claim to be an expert on QAPI.
>>>
>>> (qemu) migrate_set_parameter 100
>>> (qemu) info migrate_parameters 
>>> ...
>>> max-bandwidth: 104857600 bytes/second
>>> ...
>>> (qemu) migrate_set_parameter max-bandwidth 1M
>>> (qemu) info migrate_parameters 
>>> ...
>>> max-bandwidth: 1048576 bytes/second
>>> ...
>>> (qemu) 
>>>
>>> This is the output with my changes applied, so I think that it works
>>> correctly on your example.
>>
>> This is HMP.  Not a stable interface.  QMP is a stable interface, but it
>> should not be affected by this patch.  Is your commit message
>> misleading?
>
> Yeap.  The part about RFC was because I didn't really understood what
> was happening here, and wanted "adult supervision".
>
> My reading from your answer is that patch can go in, right?

I think so.
