Received: from eggs.gnu.org ([2001:4830:134:3::10]:44845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEF9o-0003xJ-Oa
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEF9l-00027I-Ju
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dEF9l-00027E-EC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FE9D3DBEB
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:19:52 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-7-git-send-email-vyasevic@redhat.com>
	<86965f80-c0a4-4033-a194-9a9e97c27a0f@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <2afaacc3-64a1-f2e3-3d9f-b86050f0c35a@redhat.com>
Date: Fri, 26 May 2017 09:19:45 -0400
MIME-Version: 1.0
In-Reply-To: <86965f80-c0a4-4033-a194-9a9e97c27a0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com, jdenemar@redhat.com

On 05/26/2017 09:16 AM, Eric Blake wrote:
> On 05/24/2017 01:05 PM, Vladislav Yasevich wrote:
>> Add a qmp command that can trigger guest announcements.
>>
>> Based on work of Germano Veit Michel <germano@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>> ---
>>  migration/savevm.c | 14 ++++++++++++++
>>  qapi-schema.json   | 19 +++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>
> 
>> +void qmp_announce_self(bool has_params, AnnounceParameters *params,
>> +                       Error **errp)
>> +{
>> +    AnnounceParameters announce_params;
>> +
>> +    memcpy(&announce_params, qemu_get_announce_params(),
>> +           sizeof(announce_params));
> 
> Shallow copies of a QAPI type happen to work when the type is all scalar
> (as AnnounceParameters currently is), but it's more robust to use
> QAPI_CLONE() or QAPI_CLONE_MEMBERS() so that any future non-scalar
> additions to the parameters type will be correctly copied without
> introducing memory leaks or double frees.
> 
> Even this might be better:
> AnnounceParameters announce_params = { 0 };
> qemu_set_announce_parameters(&announce_params, qemu_get_announce_params());
> 

Ok.

>> +
>> +    if (has_params)
>> +        qemu_set_announce_parameters(&announce_params, params);
>> +
>> +    qemu_announce_self(&announce_params);
>> +}
> The QMP changes look okay.  Do you have a testsuite covering the new QMP
> command somewhere in the series?
> 

There is basic test in patch 12.

Thanks
-vlad
