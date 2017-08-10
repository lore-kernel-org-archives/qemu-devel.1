Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqRp-0008V1-Cm
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqRo-0006Xp-0c
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfqRn-0006XK-NQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:36:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-3-git-send-email-armbru@redhat.com>
	<b0769260-8342-8a90-8a1e-d6545e0c64a1@redhat.com>
Date: Thu, 10 Aug 2017 18:36:30 +0200
In-Reply-To: <b0769260-8342-8a90-8a1e-d6545e0c64a1@redhat.com> (Paolo
	Bonzini's message of "Thu, 10 Aug 2017 17:02:49 +0200")
Message-ID: <87efsj8jn5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, el13635@mail.ntua.gr

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/08/2017 14:25, Markus Armbruster wrote:
>> We've wanted -object to support non-scalar properties for a while.
>> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
>> authorization API".  Review led to the conclusion that we need to
>> replace rather than add to QemuOpts.  Initial work towards that goal
>> has been merged to provide -blockdev (commit 8746709), but there's
>> substantial work left, mostly due to an bewildering array of
>> compatibility problems.
>> 
>> Even if a full solution is still out of reach, we can have a partial
>> solution now: accept -object argument in JSON syntax.  This should
>> unblock development work that needs non-scalar properties with -object
>> 
>> The implementation is similar to -blockdev, except we use the new
>> infrastructure only for the new JSON case, and stick to QemuOpts for
>> the existing KEY=VALUE,... case, to sidestep compatibility problems.
>> 
>> If we did this for more options, we'd have to factor out common code.
>> But for one option, this will do.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi-schema.json | 14 +++++++++++---
>>  vl.c             | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+), 3 deletions(-)
>> 
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 802ea53..7ed1db1 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -3618,15 +3618,23 @@
>>  { 'command': 'netdev_del', 'data': {'id': 'str'} }
>>  
>>  ##
>> -# @object-add:
>> +# @ObjectOptions:
>>  #
>> -# Create a QOM object.
>> +# Options for creating an object.
>>  #
>>  # @qom-type: the class name for the object to be created
>>  #
>>  # @id: the name of the new object
>>  #
>>  # @props: a dictionary of properties to be passed to the backend
>> +##
>> +{ 'struct': 'ObjectOptions',
>> +  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
>> +
>> +##
>> +# @object-add:
>> +#
>> +# Create a QOM object.
>>  #
>>  # Returns: Nothing on success
>>  #          Error if @qom-type is not a valid class name
>> @@ -3642,7 +3650,7 @@
>>  #
>>  ##
>>  { 'command': 'object-add',
>> -  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
>> +  'data': 'ObjectOptions' }
>>  
>>  ##
>>  # @object-del:
>> diff --git a/vl.c b/vl.c
>> index fd98ed1..db4680b 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2854,8 +2854,32 @@ static bool object_create_delayed(const char *type)
>>      return !object_create_initial(type);
>>  }
>>  
>> +typedef struct ObjectOptionsQueueEntry {
>> +    ObjectOptions *oo;
>> +    Location loc;
>> +    QSIMPLEQ_ENTRY(ObjectOptionsQueueEntry) entry;
>> +} ObjectOptionsQueueEntry;
>> +
>> +typedef QSIMPLEQ_HEAD(ObjectOptionsQueue, ObjectOptionsQueueEntry)
>> +    ObjectOptionsQueue;
>> +
>> +ObjectOptionsQueue oo_queue = QSIMPLEQ_HEAD_INITIALIZER(oo_queue);
>> +
>> +
>>  static void object_create(bool (*type_predicate)(const char *))
>>  {
>> +    ObjectOptionsQueueEntry *e;
>> +
>> +    QSIMPLEQ_FOREACH(e, &oo_queue, entry) {
>> +        if (!type_predicate(e->oo->qom_type)) {
>> +            continue;
>> +        }
>> +        loc_push_restore(&e->loc);
>> +        qmp_object_add(e->oo->qom_type, e->oo->id,
>> +                       e->oo->has_props, e->oo->props, &error_fatal);
>> +        loc_pop(&e->loc);
>> +    }
>> +
>>      if (qemu_opts_foreach(qemu_find_opts("object"),
>>                            user_creatable_add_opts_foreach,
>>                            type_predicate, NULL)) {
>> @@ -4078,6 +4102,29 @@ int main(int argc, char **argv, char **envp)
>>  #endif
>>                  break;
>>              case QEMU_OPTION_object:
>> +                /*
>> +                 * TODO Use qobject_input_visitor_new_str() instead of
>> +                 * QemuOpts, not in addition to.  Not done now because
>> +                 * keyval_parse() isn't wart-compatible with QemuOpts.
>> +                 */
>> +                if (optarg[0] == '{') {
>> +                    Visitor *v;
>> +                    ObjectOptionsQueueEntry *e;
>> +
>> +                    v = qobject_input_visitor_new_str(optarg, "qom-type",
>> +                                                      &err);
>> +                    if (!v) {
>> +                        error_report_err(err);
>> +                        exit(1);
>> +                    }
>> +
>> +                    e = g_new(ObjectOptionsQueueEntry, 1);
>> +                    visit_type_ObjectOptions(v, NULL, &e->oo, &error_fatal);
>> +                    visit_free(v);
>> +                    loc_save(&e->loc);
>> +                    QSIMPLEQ_INSERT_TAIL(&oo_queue, e, entry);
>> +                    break;
>> +                }
>>                  opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
>>                                                 optarg, true);
>>                  if (!opts) {
>> @@ -4525,6 +4572,14 @@ int main(int argc, char **argv, char **envp)
>>  
>>      object_create(object_create_delayed);
>>  
>> +    while (!QSIMPLEQ_EMPTY(&oo_queue)) {
>> +        ObjectOptionsQueueEntry *e = QSIMPLEQ_FIRST(&oo_queue);
>> +
>> +        QSIMPLEQ_REMOVE_HEAD(&oo_queue, entry);
>> +        qapi_free_ObjectOptions(e->oo);
>> +        g_free(e);
>> +    }
>
> Why not free the queue entry in object_create, and assert here that it's
> empty?

Assumes object_create_delayed(TYPE) == !object_create_initial(TYPE),
which is the case.  Fewer assumptions is good.  Less code is also good.
Pick your goodness, please :)

>
> Paolo
>
>> +
>>  #ifdef CONFIG_TPM
>>      if (tpm_init() < 0) {
>>          exit(1);
>> 
