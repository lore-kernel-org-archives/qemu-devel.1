Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgB6b-0001ou-0b
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgB6W-0000Gh-Il
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:07:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgB6W-0000G1-AP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:07:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8760k3zteg.fsf@dusky.pond.sub.org>
	<3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 15:07:41 +0100
In-Reply-To: <3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com> (Zhang
	Chen's message of "Tue, 21 Feb 2017 20:24:55 +0800")
Message-ID: <87fuj7r61e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>

Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:

> On 02/21/2017 07:15 PM, Markus Armbruster wrote:
>> Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:
>>
>>> We can call this qmp command to do checkpoint outside of qemu.
>>> Xen colo will need this function.
>> I know nothing about "Xen colo", but I'll try anyway.
>>
>> I *guess* "Xen colo" is a long-running activity, and the new commands
>> interact with it.  Correct?
>
> Yes, you are right.

We need to build a generic framework for interacting with long-running
activities.  But asking you to wait for it wouldn't be fair.

> By the way this patch has been reviewed by Eric black.
>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03435.html
>
>
>
>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>>> ---
>>>   migration/colo.c | 17 ++++++++++++++++
>>>   qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 77 insertions(+)
>>>
>>> diff --git a/migration/colo.c b/migration/colo.c
>>> index 6fc2ade..2f98a33 100644
>>> --- a/migration/colo.c
>>> +++ b/migration/colo.c
>>> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool primary,
>>>       }
>>>   }
>>>   +ReplicationResult *qmp_query_xen_replication_status(Error
>>> **errp)
>>> +{
>>> +    Error *err = NULL;
>>> +    ReplicationResult *result = g_new0(ReplicationResult, 1);
>>> +    replication_get_error_all(&err);
>>> +    result->status = err ?
>>> +                     REPLICATION_STATUS_ERROR :
>>> +                     REPLICATION_STATUS_NORMAL;
>> Reports only that there is an error, throws away the actual error
>> message.  Naive question: could the error message be good to know for
>> the QMP user?
>
> Yes, Xen colo will handle it.

Is that "yes, the QMP user could use the error message, but we're not
giving it to him regardless", or "no, the QMP user does not need to
know, and that's because we don't give it to him"?

Even if we want QMP clients to treat all errors the same, transmitting
the error message can still be useful for troubleshooting.  QMP itself
does that.  Quoting qmp-spec.txt:

    2.4.2 error
    -----------

    The format of an error response is:

    { "error": { "class": json-string, "desc": json-string }, "id": json-value }

     Where,

    - The "class" member contains the error class name (eg. "GenericError")
--> - The "desc" member is a human-readable error message. Clients should
-->   not attempt to parse this message.
    - The "id" member contains the transaction identification associated with
      the command execution if issued by the Client

>>> +    error_free(err);
>>> +    return result;
>>> +}
>>> +
>>> +void qmp_xen_do_checkpoint(Error **errp)
>>> +{
>>> +    replication_do_checkpoint_all(errp);
>>> +}
>>> +
>>>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>>>                                 Error **errp)
>>>   {
>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>> index 9445b93..719744a 100644
>>> --- a/qapi-schema.json
>>> +++ b/qapi-schema.json
>>> @@ -5931,6 +5931,66 @@
>>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>>>     ##
>>> +# @ReplicationStatus:
>>> +#
>>> +# Describe the status of replication.
>>> +#
>>> +# @error: Replication has an error.
>>> +#
>>> +# @normal: Replication is running normally.
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'enum': 'ReplicationStatus',
>>> +  'data': [ 'error', 'normal' ] }
>> Do you expect more status values in the future?
>>
>> If yes, what should clients do when they see a status value they don't
>> know?
>
> We will add other status for it, now, that's enough.

What should a QMP client do when it sees a ReplicationStatus value other
than 'error' and 'normal'?

You need to provide some guidance, or else you won't be able to add
status values without breaking clients!

>> If no, why not simply use bool?
>>
>>> +
>>> +##
>>> +# @ReplicationResult:
>>> +#
>>> +# The result format for 'query-xen-replication-status'.
>>> +#
>>> +# @status: enum of @ReplicationStatus, which shows current
>>> +#          replication error status
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'struct': 'ReplicationResult',
>>> +  'data': { 'status': 'ReplicationStatus'} }
>>> +
>>> +##
>>> +# @query-xen-replication-status:
>>> +#
>>> +# Query replication status while the vm is running.
>>> +#
>>> +# Returns: A @ReplicationResult objects showing the status.
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "query-xen-replication-status" }
>>> +# <- { "return": { "status": "normal" } }
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'command': 'query-xen-replication-status',
>>> +  'returns': 'ReplicationResult' }
>> The naming is a bit unfortunate: query-xen-replication-status returns
>> ReplicationResult, which contains ReplicationStatus.
>
> I will change the name in next version.
>
> Thanks
> Zhang Chen
>
>>
>>> +
>>> +##
>>> +# @xen-do-checkpoint:
>>> +#
>>> +# Xen uses this command to notify replication to trigger a checkpoint.
>>> +#
>>> +# Returns: nothing.
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "xen-do-checkpoint" }
>>> +# <- { "return": {} }
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'command': 'xen-do-checkpoint' }
>>> +
>>> +##
>>>   # @GICCapability:
>>>   #
>>>   # The struct describes capability for a specific GIC (Generic
>>
>> .
>>
