Received: from eggs.gnu.org ([2001:4830:134:3::10]:35700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjnWx-0004mY-82
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjnWt-00042y-Be
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:45:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjnWt-00042s-3W
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:45:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
Date: Fri, 03 Mar 2017 14:45:51 +0100
In-Reply-To: <0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com> (Eric Blake's
	message of "Thu, 23 Feb 2017 09:34:57 -0600")
Message-ID: <87h93ascc0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Stefano Stabellini <sstabellini@kernel.org>, Wen Congyang <wencongyang@gmail.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 01:14 AM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>> 
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> You made a substantial change to this patch since v7 in response to my
> comments; when you do that, it's best to remove the R-b to make sure I
> re-review the changes and am still happy with them.
>
>> 
>> ---
>>  migration/colo.c | 23 +++++++++++++++++++++++
>>  qapi-schema.json | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 71 insertions(+)
>> 
>
>>  ##
>> +# @ReplicationStatus:
>> +#
>> +# The result format for 'query-xen-replication-status'.
>> +#
>> +# @status: true to error, false to normal.
>
> This is now a poor name for the parameter.  Please rename it; probably
> to @error (if you want to keep true meaning a problem has been
> detected), or to @okay (if you want to invert the sense, and @desc is
> only present when @okay is false).

We could replace both members by '*error': 'str', present exactly when
status is "bad".

>> +#
>> +# @desc: #optional the human readable error description string, when
>> +#        @status is 'true'.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'ReplicationStatus',
>> +  'data': { 'status': 'bool', '*desc': 'str' } }
>> +
>> +##
>> +# @query-xen-replication-status:
>> +#
>> +# Query replication status while the vm is running.
>> +#
>> +# Returns: A @ReplicationResult objects showing the status.
>
> s/objects/object/
>
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-xen-replication-status" }
>> +# <- { "return": { "status": "normal" } }
>
> This example is now wrong.
>
> You'll need a v9.
