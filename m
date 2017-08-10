Received: from eggs.gnu.org ([2001:4830:134:3::10]:35673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfige-0003Rt-Fc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfigd-0002qO-9Q
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfigd-0002pt-32
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:19:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28B04C00F7E9
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 08:19:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-20-eblake@redhat.com>
	<87o9ron34y.fsf@dusky.pond.sub.org>
	<77053a1d-b68e-0f7c-16dd-0be36f629728@redhat.com>
Date: Thu, 10 Aug 2017 10:19:19 +0200
In-Reply-To: <77053a1d-b68e-0f7c-16dd-0be36f629728@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 11:41:56 -0500")
Message-ID: <87zib7hm2g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 19/22] libqtest: Add qmp_args_dict()
 helper
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

> On 08/09/2017 10:59 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Leaving interpolation into JSON to qobject_from_jsonf() is more
>>> robust than building QMP input manually; however, we have a few
>>> places where code is already creating a QDict to interpolate
>>> individual arguments, which cannot be reproduced with the
>>> qobject_from_jsonf() parser.  Expose a public wrapper
>>> qmp_args_dict() for the internal helper qmp_args_dict_async()
>>> that we needed earlier for qmp_args(), and fix a test to use
>>> the new helper.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>
>>> +++ b/tests/device-introspect-test.c
>>> @@ -36,8 +36,7 @@ static QList *qom_list_types(const char *implements, bool abstract)
>>>      if (implements) {
>>>          qdict_put_str(args, "implements", implements);
>>>      }
>>> -    resp = qmp("{'execute': 'qom-list-types',"
>>> -               " 'arguments': %p }", args);
>>> +    resp = qmp_args_dict("qom-list-types", args);
>>>      g_assert(qdict_haskey(resp, "return"));
>>>      ret = qdict_get_qlist(resp, "return");
>>>      QINCREF(ret);
>> 
>> If we had five of these, the helper would be worth its keep.
>
> This patch only  has one client, but 20/22 adds another.  Is having 2
> clients sufficient to keep it (not quite the 5 that makes it obvious,
> but still a good reuse of code)?

Your idea to use macros might make this a moot question.  Let's revisit
it in v2.
