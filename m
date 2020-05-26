Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26802C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E7B2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij5rRWiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E7B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdU9E-0004D9-2O
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdU8S-0002u0-Db
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:36:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdU8N-0007GI-Q2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590478583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OCYvOr0/xh1BojeQQyHgRBgdRbNe8jupvY2kk4dXTA4=;
 b=ij5rRWiRq0ZDqlSK0exn0inrswQynY8dKgd1Iz9fsaSg+YjW9vm1uLA8TFacnNN4bYa3GQ
 4srTlLPe320LrbC+uzbEjvang7Eyyel81qDAVegmrOhH7ZwfJHPUwOAzaXzk4Jd6vneZXY
 6IV9qI3w2jEJaRcKrXCuagUoOfru8as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Ljy5lUU1Nam0lpEOGC0mvg-1; Tue, 26 May 2020 03:36:18 -0400
X-MC-Unique: Ljy5lUU1Nam0lpEOGC0mvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240FF107ACCA;
 Tue, 26 May 2020 07:36:17 +0000 (UTC)
Received: from [10.36.114.130] (ovpn-114-130.ams2.redhat.com [10.36.114.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3BC510013DB;
 Tue, 26 May 2020 07:36:10 +0000 (UTC)
Subject: Re: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
From: David Hildenbrand <david@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-5-philmd@redhat.com>
 <9b722de0-686d-8f86-35f3-6987bccbe4c9@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f5855883-6774-8a48-d958-4e8247b83b03@redhat.com>
Date: Tue, 26 May 2020 09:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9b722de0-686d-8f86-35f3-6987bccbe4c9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26.05.20 09:35, David Hildenbrand wrote:
> On 25.05.20 17:06, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  qapi/machine.json          | 90 ++++++++++++++++++++++++++++++++++++++
>>  qapi/misc.json             | 90 --------------------------------------
>>  include/sysemu/balloon.h   |  2 +-
>>  balloon.c                  |  2 +-
>>  hw/virtio/virtio-balloon.c |  2 +-
>>  monitor/hmp-cmds.c         |  1 +
>>  6 files changed, 94 insertions(+), 93 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index ca7d58f0c9..ae42d69495 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -921,3 +921,93 @@
>>    'data': 'NumaOptions',
>>    'allow-preconfig': true
>>  }
>> +
>> +##
>> +# @balloon:
>> +#
>> +# Request the balloon driver to change its balloon size.
>> +#
>> +# @value: the target logical size of the VM in bytes
>> +#         We can deduce the size of the balloon using this formula:
>> +#            logical_vm_size = vm_ram_size - balloon_size
>> +#         From it we have: balloon_size = vm_ram_size - @value
>> +#
>> +# Returns: - Nothing on success
>> +#          - If the balloon driver is enabled but not functional because the KVM
>> +#            kernel module cannot support it, KvmMissingCap
>> +#          - If no balloon device is present, DeviceNotActive
>> +#
>> +# Notes: This command just issues a request to the guest.  When it returns,
>> +#        the balloon size may not have changed.  A guest can change the balloon
>> +#        size independent of this command.
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
>> +# <- { "return": {} }
>> +#
>> +# With a 2.5GiB guest this command inflated the ballon to 3GiB.
>> +#
>> +##
>> +{ 'command': 'balloon', 'data': {'value': 'int'} }
>> +
>> +##
>> +# @BalloonInfo:
>> +#
>> +# Information about the guest balloon device.
>> +#
>> +# @actual: the logical size of the VM in bytes
>> +#          Formula used: logical_vm_size = vm_ram_size - balloon_size
>> +#
>> +# Since: 0.14.0
>> +#
>> +##
>> +{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
>> +
>> +##
>> +# @query-balloon:
>> +#
>> +# Return information about the balloon device.
>> +#
>> +# Returns: - @BalloonInfo on success
>> +#          - If the balloon driver is enabled but not functional because the KVM
>> +#            kernel module cannot support it, KvmMissingCap
>> +#          - If no balloon device is present, DeviceNotActive
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-balloon" }
>> +# <- { "return": {
>> +#          "actual": 1073741824,
>> +#       }
>> +#    }
>> +#
>> +##
>> +{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
>> +
>> +##
>> +# @BALLOON_CHANGE:
>> +#
>> +# Emitted when the guest changes the actual BALLOON level. This value is
>> +# equivalent to the @actual field return by the 'query-balloon' command
>> +#
>> +# @actual: the logical size of the VM in bytes
>> +#          Formula used: logical_vm_size = vm_ram_size - balloon_size
>> +#
>> +# Note: this event is rate-limited.
>> +#
>> +# Since: 1.2
>> +#
>> +# Example:
>> +#
>> +# <- { "event": "BALLOON_CHANGE",
>> +#      "data": { "actual": 944766976 },
>> +#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
>> +#
>> +##
>> +{ 'event': 'BALLOON_CHANGE',
>> +  'data': { 'actual': 'int' } }
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 446fc8ff83..26b5115638 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -186,65 +186,6 @@
>>  { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
>>    'allow-preconfig': true }
>>  
>> -##
>> -# @BalloonInfo:
>> -#
>> -# Information about the guest balloon device.
>> -#
>> -# @actual: the logical size of the VM in bytes
>> -#          Formula used: logical_vm_size = vm_ram_size - balloon_size
>> -#
>> -# Since: 0.14.0
>> -#
>> -##
>> -{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
>> -
>> -##
>> -# @query-balloon:
>> -#
>> -# Return information about the balloon device.
>> -#
>> -# Returns: - @BalloonInfo on success
>> -#          - If the balloon driver is enabled but not functional because the KVM
>> -#            kernel module cannot support it, KvmMissingCap
>> -#          - If no balloon device is present, DeviceNotActive
>> -#
>> -# Since: 0.14.0
>> -#
>> -# Example:
>> -#
>> -# -> { "execute": "query-balloon" }
>> -# <- { "return": {
>> -#          "actual": 1073741824,
>> -#       }
>> -#    }
>> -#
>> -##
>> -{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
>> -
>> -##
>> -# @BALLOON_CHANGE:
>> -#
>> -# Emitted when the guest changes the actual BALLOON level. This value is
>> -# equivalent to the @actual field return by the 'query-balloon' command
>> -#
>> -# @actual: the logical size of the VM in bytes
>> -#          Formula used: logical_vm_size = vm_ram_size - balloon_size
>> -#
>> -# Note: this event is rate-limited.
>> -#
>> -# Since: 1.2
>> -#
>> -# Example:
>> -#
>> -# <- { "event": "BALLOON_CHANGE",
>> -#      "data": { "actual": 944766976 },
>> -#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
>> -#
>> -##
>> -{ 'event': 'BALLOON_CHANGE',
>> -  'data': { 'actual': 'int' } }
>> -
>>  ##
>>  # @PciMemoryRange:
>>  #
>> @@ -753,37 +694,6 @@
>>  ##
>>  { 'command': 'inject-nmi' }
>>  
>> -##
>> -# @balloon:
>> -#
>> -# Request the balloon driver to change its balloon size.
>> -#
>> -# @value: the target logical size of the VM in bytes
>> -#         We can deduce the size of the balloon using this formula:
>> -#            logical_vm_size = vm_ram_size - balloon_size
>> -#         From it we have: balloon_size = vm_ram_size - @value
>> -#
>> -# Returns: - Nothing on success
>> -#          - If the balloon driver is enabled but not functional because the KVM
>> -#            kernel module cannot support it, KvmMissingCap
>> -#          - If no balloon device is present, DeviceNotActive
>> -#
>> -# Notes: This command just issues a request to the guest.  When it returns,
>> -#        the balloon size may not have changed.  A guest can change the balloon
>> -#        size independent of this command.
>> -#
>> -# Since: 0.14.0
>> -#
>> -# Example:
>> -#
>> -# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
>> -# <- { "return": {} }
>> -#
>> -# With a 2.5GiB guest this command inflated the ballon to 3GiB.
>> -#
>> -##
>> -{ 'command': 'balloon', 'data': {'value': 'int'} }
>> -
>>  ##
>>  # @human-monitor-command:
>>  #
>> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
>> index aea0c44985..b3de4b92b9 100644
>> --- a/include/sysemu/balloon.h
>> +++ b/include/sysemu/balloon.h
>> @@ -15,7 +15,7 @@
>>  #define QEMU_BALLOON_H
>>  
>>  #include "exec/cpu-common.h"
>> -#include "qapi/qapi-types-misc.h"
>> +#include "qapi/qapi-types-machine.h"
>>  
>>  typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
>>  typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
>> diff --git a/balloon.c b/balloon.c
>> index f104b42961..ee9c59252d 100644
>> --- a/balloon.c
>> +++ b/balloon.c
>> @@ -30,7 +30,7 @@
>>  #include "sysemu/balloon.h"
>>  #include "trace-root.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-machine.h"
>>  #include "qapi/qmp/qerror.h"
>>  
>>  static QEMUBalloonEvent *balloon_event_fn;
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 065cd450f1..ec3aac1e80 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -24,7 +24,7 @@
>>  #include "hw/virtio/virtio-balloon.h"
>>  #include "exec/address-spaces.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-events-misc.h"
>> +#include "qapi/qapi-events-machine.h"
>>  #include "qapi/visitor.h"
>>  #include "trace.h"
>>  #include "qemu/error-report.h"
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 9c61e769ca..376590c073 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -32,6 +32,7 @@
>>  #include "qapi/qapi-commands-block.h"
>>  #include "qapi/qapi-commands-char.h"
>>  #include "qapi/qapi-commands-control.h"
>> +#include "qapi/qapi-commands-machine.h"
>>  #include "qapi/qapi-commands-migration.h"
>>  #include "qapi/qapi-commands-misc.h"
>>  #include "qapi/qapi-commands-net.h"
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I yet have to craft a patch to fixup the wrong documentation :)
> 

Oh, I see you already included a fixup, nice!

-- 
Thanks,

David / dhildenb


