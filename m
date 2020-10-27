Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F37C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9B120719
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRdj9Bq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9B120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOvg-00044k-3c
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXO6R-00028z-2l
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXO6K-0003Sd-EY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603801758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1tmSouP9FgoLprIKqNcsQXgs78EzsKHxuFhXXG5kZI=;
 b=KRdj9Bq5LEPlHHZBgOqcd2VZKbFNwz4dU4H0SIXQvG5vCn03d0K+XEG3UhKdka7/B8g2Ul
 9ax0ry8yLzopX4AaglpHDkN/w2PlgcO+TEw4zl8YMW+zc4dBkcipHAYSq/v/dXu3Bb+g6r
 8pSV7bkGzEw+BD5H/Z0Qe9E5f23Pg/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-QIr2Vi7CNIi7T_xCOax94A-1; Tue, 27 Oct 2020 08:29:15 -0400
X-MC-Unique: QIr2Vi7CNIi7T_xCOax94A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17D2809DDA;
 Tue, 27 Oct 2020 12:29:11 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 739A41002388;
 Tue, 27 Oct 2020 12:28:49 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-12-eblake@redhat.com>
 <873620vv3i.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
Message-ID: <677f78ec-4897-558c-1f51-35b6215caf64@redhat.com>
Date: Tue, 27 Oct 2020 07:28:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <873620vv3i.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, pkrempa@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>, vsementsov@virtuozzo.com,
 stefanha@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 kwolf@redhat.com, "open list:GLUSTER" <integration@gluster.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 5:09 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Anywhere we create a list of just one item or by prepending items
>> (typically because order doesn't matter), we can use the now-public
>> macro.  But places where we must keep the list in order by appending
>> remain open-coded.
> 
> Should we rename the macro to QAPI_LIST_PREPEND()?

That would make sense if we add a counterpart QAPI_LIST_APPEND.

> 
> How many places append?  If it's more than just a few, an attempt to
> factor out the common code is in order.  Not in this patch, of course.
> Not even in this series.

Quite a few.  The most common pattern for appending is like this from
qemu-img.c:

ImageInfoList *head = NULL, *elem;
ImageInfoList **last = &head;
...
while (...) {
    elem = g_new0(ImageInfoList, 1);
    elem->value = info;
    *last = elem;
    last = &elem->next;
}

although I saw several other patterns as well.  And we frequently have
this comment, such as from block/qapi.c:
        /* XXX: waiting for the qapi to support qemu-queue.h types */

Several of the existing append spots could be switched to prepend with
no change to semantics (the resulting list would be presented to the
user in the opposite order, but the semantics of that item were a set
rather than an ordered list so other than tweaking the testsuite, it
would not matter), while others absolutely have to append to maintain
correct order.

Part of me wonders if it would be worth adjusting the QAPI generator to
create a head and tail pointer for _every_ FOOList member, rather than
just a head pointer.  Or to create a function for an O(n) reversal of an
existing list, then flipping spots to construct lists in reverse order
followed by a list reverse (no change in big-O complexity, more code
reuse, but slightly more CPU time). But as you observe, that quickly
goes beyond the scope of this series.


>> +++ b/docs/devel/writing-qmp-commands.txt
>> @@ -531,15 +531,10 @@ TimerAlarmMethodList *qmp_query_alarm_methods(Error **errp)
>>      bool current = true;
>>
>>      for (p = alarm_timers; p->name; p++) {
>> -        TimerAlarmMethodList *info = g_malloc0(sizeof(*info));

[1]

>> -        info->value = g_malloc0(sizeof(*info->value));

[2]

>> -        info->value->method_name = g_strdup(p->name);
>> -        info->value->current = current;
>> -
>> -        current = false;
>> -
>> -        info->next = method_list;
>> -        method_list = info;
>> +	TimerAlarmMethod *value = g_new0(TimerAlarmMethod, 1);
> 
> Can just as well use g_new(), as QAPI_LIST_ADD() will set both members
> of @value.  Same elsewhere.

Not quite.  Allocation [1] can use g_new() instead of g_malloc0()
because we fill both members of info, but allocation [2] is unchanged by
this code transformation (I did not want to research whether the code
was filling all members of info->value (probably true, but it was
unrelated to my rewrite).  Switching to QAPI_LIST_ADD is what moves
allocation [1] into the macro (where it indeed uses g_new), but
QAPI_LIST_ADD has no impact on the contents of value in allocation [2]
(which is the only allocation left locally in this hunk).

However, the fact that I changed from g_malloc0(sizeof(*info->value)) to
g_new0(TimerAlarmMethod, 1), instead of keeping it as
g_malloc0(sizeof(*value)), is indeed a case of me doing a bit more than
a strict mechanical conversion; this was one of the hunks I touched
earlier in my audit.


>> @@ -655,15 +656,9 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>>              qemu_opts_del(opts);
>>          }
>>
>> -        if (gconf->server == NULL) {
>> -            gconf->server = g_new0(SocketAddressList, 1);
>> -            gconf->server->value = gsconf;
>> -            curr = gconf->server;
>> -        } else {
>> -            curr->next = g_new0(SocketAddressList, 1);
>> -            curr->next->value = gsconf;
>> -            curr = curr->next;
>> -        }
>> +        *curr = g_new0(SocketAddressList, 1);
>> +        (*curr)->value = gsconf;
>> +        curr = &(*curr)->next;
>>          gsconf = NULL;
>>
>>          qobject_unref(backing_options);
> 
> The change to qemu_gluster_parse_json() looks unrelated.

Indeed, this is also one of the earlier files I touched, where I saw
that our 'append' pattern can be simplified, but it's separate from the
'prepend' pattern that this patch should be touching.  I guess I'll need
to clean this patch up to be more strictly mechanical.

> 
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 78553125d311..8dd7ef4c5935 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -776,15 +776,14 @@ static int qmp_query_chardev_foreach(Object *obj, void *data)
>>  {
>>      Chardev *chr = CHARDEV(obj);
>>      ChardevInfoList **list = data;
>> -    ChardevInfoList *info = g_malloc0(sizeof(*info));
>> +    ChardevInfo *value;
>>
>> -    info->value = g_malloc0(sizeof(*info->value));
>> -    info->value->label = g_strdup(chr->label);
>> -    info->value->filename = g_strdup(chr->filename);
>> -    info->value->frontend_open = chr->be && chr->be->fe_open;
>> +    value = g_malloc0(sizeof(*value));
> 
> You could use an initializer instead, like you do in the next hunk.  Up
> to you.

Yeah, the further I got into the manual audit, the less I was rewriting
code to minimize lines, such as consistently initializing variables at
their declaration.

>> +++ b/hw/core/machine.c
>> @@ -492,11 +492,7 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,
>>
>>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
>>  {
>> -    strList *item = g_new0(strList, 1);
>> -
>> -    item->value = g_strdup(type);
>> -    item->next = mc->allowed_dynamic_sysbus_devices;
>> -    mc->allowed_dynamic_sysbus_devices = item;
>> +    QAPI_LIST_ADD(mc->allowed_dynamic_sysbus_devices, g_strdup(type));
> 
> Side effect in a macro argument.  Works, because QAPI_LIST_ADD() expands
> @element exactly once.  Sure we want to rely on it?
> 
> If yes, please add a contract to QAPI_LIST_ADD() that documents it.

Multiple instances depend on it, so yes, I think it's worth documenting.

> 
> More instances below.

Indeed.


>> +++ b/hw/net/rocker/rocker_fp.c
>> @@ -51,14 +51,14 @@ bool fp_port_get_link_up(FpPort *port)
>>      return !qemu_get_queue(port->nic)->link_down;
>>  }
>>
>> -void fp_port_get_info(FpPort *port, RockerPortList *info)
>> +void fp_port_get_info(FpPort *port, RockerPort *value)
>>  {
>> -    info->value->name = g_strdup(port->name);
>> -    info->value->enabled = port->enabled;
>> -    info->value->link_up = fp_port_get_link_up(port);
>> -    info->value->speed = port->speed;
>> -    info->value->duplex = port->duplex;
>> -    info->value->autoneg = port->autoneg;
>> +    value->name = g_strdup(port->name);
>> +    value->enabled = port->enabled;
>> +    value->link_up = fp_port_get_link_up(port);
>> +    value->speed = port->speed;
>> +    value->duplex = port->duplex;
>> +    value->autoneg = port->autoneg;
>>  }
> 
> This cleanup of fp_port_get_info() could be a separate patch.  Up to
> you.
> 
> You could move the allocation into fp_port_get_info(), like this:
> 
>    RockerPort *fp_port_get_info(FpPort *port)
>    {
>        RockerPort *value = g_malloc0(sizeof(*value));
> 
>        value->name = g_strdup(port->name);
>        value->enabled = port->enabled;
>        value->link_up = fp_port_get_link_up(port);
>        value->speed = port->speed;
>        value->duplex = port->duplex;
>        value->autoneg = port->autoneg;
>        return value;
>    }
> 
> Also up to you.

Yeah, I thought about splitting that one out.  I think you've convinced
me it is worth it.

>> +++ b/monitor/hmp-cmds.c
>> @@ -1248,7 +1248,8 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
>>      const char *cap = qdict_get_str(qdict, "capability");
>>      bool state = qdict_get_bool(qdict, "state");
>>      Error *err = NULL;
>> -    MigrationCapabilityStatusList *caps = g_malloc0(sizeof(*caps));
>> +    MigrationCapabilityStatusList *caps = NULL;
>> +    MigrationCapabilityStatus *value = NULL;
> 
> No need to initialize @value.
> 
>>      int val;
>>
>>      val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
>> @@ -1256,10 +1257,10 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
>>          goto end;
>>      }
>>
>> -    caps->value = g_malloc0(sizeof(*caps->value));
>> -    caps->value->capability = val;
>> -    caps->value->state = state;
>> -    caps->next = NULL;
>> +    value = g_malloc0(sizeof(*value));
>> +    value->capability = val;
>> +    value->state = state;
>> +    QAPI_LIST_ADD(caps, value);
>>      qmp_migrate_set_capabilities(caps, &err);
>>
>>  end:
>        qapi_free_MigrationCapabilityStatusList(caps);
> 
> This could be moved before the label now.  No need to initialize @caps
> to null then.  Up to you.
> 
>        hmp_handle_error(mon, err);
>    }
> 

Since the conversion was all manual, I don't mind making it look nicer,
when it is still minimally invasive.

> 
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 2103507936ea..4cfa8bccc5e7 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1643,14 +1643,13 @@ static void do_dirty_bitmap_merge(const char *dst_node, const char *dst_name,
>>                                    Error **errp)
>>  {
>>      BlockDirtyBitmapMergeSource *merge_src;
>> -    BlockDirtyBitmapMergeSourceList *list;
>> +    BlockDirtyBitmapMergeSourceList *list = NULL;
>>
>>      merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
>>      merge_src->type = QTYPE_QDICT;
>>      merge_src->u.external.node = g_strdup(src_node);
>>      merge_src->u.external.name = g_strdup(src_name);
>> -    list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
>> -    list->value = merge_src;
>> +    QAPI_LIST_ADD(list, merge_src);
>>      qmp_block_dirty_bitmap_merge(dst_node, dst_name, list, errp);
>>      qapi_free_BlockDirtyBitmapMergeSourceList(list);
>>  }
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 3bffee99d4c9..06540425ded2 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1211,7 +1211,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>  {
>>      FsMountList mounts;
>>      struct FsMount *mount;
>> -    GuestFilesystemInfoList *new, *ret = NULL;
>> +    GuestFilesystemInfoList *ret = NULL;
>>      Error *local_err = NULL;
>>
>>      QTAILQ_INIT(&mounts);
>> @@ -1224,10 +1224,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>      QTAILQ_FOREACH(mount, &mounts, next) {
>>          g_debug("Building guest fsinfo for '%s'", mount->dirname);
>>
>> -        new = g_malloc0(sizeof(*ret));
> 
> Ugh!  Glad you get rid of this.

Yep, C++ reserved words as a C variable name is always awkward.  It was
fun cleaning that up (several places in this patch).


>> +++ b/qga/commands-win32.c
>> @@ -926,10 +926,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
>>                  error_free(local_err);
>>                  goto out;
>>              }
>> -            list = g_malloc0(sizeof(*list));
>> -            list->value = disk;
>> +            QAPI_LIST_ADD(list, disk);
>>              disk = NULL;
>> -            list->next = NULL;
>>              goto out;
> 
> Both old and new code tacitly rely on @list being empty.  Okay.

This was population of a single element into list (so prepending vs.
appending doesn't matter, and we can use the prepend macro), while...

> 
>>          } else {
>>              error_setg_win32(errp, GetLastError(),
> 
> Did you miss the spot where we add to this list?
> 
>        /* Go through each extent */
>        for (i = 0; i < extents->NumberOfDiskExtents; i++) {
>            disk = g_malloc0(sizeof(GuestDiskAddress));
> 
>            /* Disk numbers directly correspond to numbers used in UNCs
>             *
>             * See documentation for DISK_EXTENT:
>             * https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioctl-_disk_extent
>             *
>             * See also Naming Files, Paths and Namespaces:
>             * https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#win32-device-namespaces
>             */
>            disk->has_dev = true;
>            disk->dev = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
>                                        extents->Extents[i].DiskNumber);
> 
>            get_single_disk_info(extents->Extents[i].DiskNumber, disk, &local_err);
>            if (local_err) {
>                error_propagate(errp, local_err);
>                goto out;
>            }
>            cur_item = g_malloc0(sizeof(*list));
>            cur_item->value = disk;
>            disk = NULL;
>            cur_item->next = list;
> --->       list = cur_item;
>        }

This is appending, not prepending.  Using the macro here would have
reversed the multi-element list seen by the user.  I did not check
whether the QMP is documenting that particular list more as a set (where
order does not matter, so prepending is fine) or as an ordered list, but
instead conservatively left it to appending.  As we said earlier,
further cleanups of all append places may be worth its own later series.

>> +++ b/qom/qom-qmp-cmds.c
>> @@ -46,14 +46,12 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
>>
>>      object_property_iter_init(&iter, obj);
>>      while ((prop = object_property_iter_next(&iter))) {
>> -        ObjectPropertyInfoList *entry = g_malloc0(sizeof(*entry));
>> +        ObjectPropertyInfo *value = g_malloc0(sizeof(ObjectPropertyInfo));
>>
>> -        entry->value = g_malloc0(sizeof(ObjectPropertyInfo));
>> -        entry->next = props;
>> -        props = entry;
>> +        QAPI_LIST_ADD(props, value);
>>
>> -        entry->value->name = g_strdup(prop->name);
>> -        entry->value->type = g_strdup(prop->type);
>> +        value->name = g_strdup(prop->name);
>> +        value->type = g_strdup(prop->type);
> 
> This is the minimally invasive patch.  Best to stick to minimal in a big
> series like this one, to ease review as much as possible.
> 
> If that wasn't an issue, I'd suggest finishing the list element before
> inserting it into the list:
> 
>         ObjectPropertyInfo *value = g_malloc0(sizeof(ObjectPropertyInfo));
> 
>         value->name = g_strdup(prop->name);
>         value->type = g_strdup(prop->type);
>         QAPI_LIST_ADD(props, value);
> 
> There might be more instances.

Agreed (both that sticking to minimally invasive is good, and on the
fact that this patch points out a number of future potential cleanups).

> 
> The macro definitely makes the code easier to read.  Yes, please!
> 
> The patch feels almost ready.

Thanks for the careful review!

Right now, my thoughts are to get 1-10 into 5.2, then turn this one
patch into a more-complete series for post-5.2 that address more cases
of QAPI list management (splitting this patch into at least 3 based on
the comments above, then new patches to make appending use more
consistent patterns before adding macros to ease that as well).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


