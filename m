Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B08C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFC5206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP+zX/ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS4C-0007Gh-4O
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1isRya-0001kO-6q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1isRyV-0002aN-No
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:47:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1isRyV-0002Zc-IR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV5k4TzKWjBKJhukXd6s+AD/pumU6Z5zkhrMunoKB0o=;
 b=ZP+zX/ZY2K467Z81A8v0QxbeFcoqTxXbNC+9RSsaeYmRVNUFtc9o/tTFbGhf1O4smdKOyY
 LQH7EutmnnCBCdokAqHHeyCq9sXGyuhFbgXVT+JJ5GX0EzLKsyOcT1QB0AeLkPbbWnZhaS
 6BCPtM2+Y6rt8pUj7eKT7XMdVs1sHIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-USaj5mKrNe2rovSP4Ibu3g-1; Fri, 17 Jan 2020 08:47:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C5D800A02
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:47:43 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 837FB86CB7;
 Fri, 17 Jan 2020 13:47:43 +0000 (UTC)
Subject: Re: Extraneous nesting in QAPI schema
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87r214qk98.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aab70b86-8b0c-5058-c7f6-21ab3d352d46@redhat.com>
Date: Fri, 17 Jan 2020 07:47:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <87r214qk98.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: USaj5mKrNe2rovSP4Ibu3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 10:59 AM, Markus Armbruster wrote:
> Extra nesting is merely another set of braces in QMP.  It's bloody
> annoying in QAPIfied CLI using dotted keys syntax.  Example:
> 
> QMP command
> 
>      {"execute": "chardev-add",

<snipped, but concur>


> Let's start with trying to understand the sources of extra nesting.
> 
> The obvious source of nesting is struct members of struct or union type.
> The example above has two: backend and backend.data.addr.
> 
> This kind of nesting can sometimes be avoided by making the member
> (struct) type a base type of the containing type.  Possible when we can
> arrange the base types into a single chain.  In the example above, we'd
> make the implicit argument type of chardev-add explicit, then replace
> member 'backend': 'ChardevBackend' by 'base': 'ChardevBackend'.
> 
> A more general solution would be adding "unboxed" members to the schema
> language.  A member that is normally a JSON object on the wire would
> instead have its JSON object members "spliced in".  Worth the trouble?
> Not sure.

It may also be possible to permit a discriminated union to be the branch 
value of yet another discriminated union: as long as the set of member 
names made visible by the inner union do not collide with any of the 
visible members elsewhere in the outer union, this should be okay, and 
give the same effect of being an unboxed member.

> 
> Special case: &rest arguments.  Example 1: object-add argument @props:
> 
>      {"execute": "object-add",
>       "arguments": {
>           "qom-type": "memory-backend-file",
>           "id": "shmmem-shmem0",
>           "props": {"mem-path": "/dev/shm/my_shmem0",
>                     "size":4194304,
>                     "share":true}}}
> 
> Example 2:
> 
>      {"execute": "device_add",
>       "arguments": {
>           "driver": "virtio-scsi-pci",
>           "bus": "pci.0",
>           "id": "virtio_scsi_pci2",
>           "addr": "0xb"}}
> 
> object-add wraps the properties in an object.  Device_add doesn't, but
> it needs to bypass the generated marshaller with 'gen': false.  We could
> add support for &rest arguments to the schema language.  Worth the
> trouble?  Not sure.
> 
> Another source is "simple" unions.  Both backend and backend.data.addr
> are actually "simple" unions, giving rise to backend.data and
> backend.data.addr.data.
> 
> We wouldn't use "simple" unions today.  With "flat" unions, we'd avoid
> the .data.
> 
> How widespread are "simple" unions today?  Let's have a look.  Five
> occur as command arguments:
> 
> * ChardevBackend
> 
>    Used for command chardev-add and chardev-change argument @backend.
> 
> * SocketAddressLegacy
> 
>    Used for command nbd-server-start argument @addr, and in command
>    chardev-add and chardev-change argument @backend.

I really want to improve at least nbd-server-start to avoid the nesting 
(it was a pain to use that much nesting while working on incremental 
backup).

> 
> * TransactionAction
> 
>    Used for command transaction argument @actions.
> 
> * KeyValue
> 
>    Used for command send-key argument @keys, and in InputEvent (next
>    item)
> 
> * InputEvent
> 
>    Used for command input-send-event argument @events.
> 
> Six commands: chardev-add, chardev-change, nbd-server-start,
> transaction, send-key, input-send-event.  Could be worse.
> 
> Flattening could be done in at least two ways.  One, replace the nested
> commands by flat ones, deprecate.  Two, make the existing commands
> accept both nested and flat, deprecate use of nested.  Two is more
> difficult.

Agree that two is more difficult. For at least nbd-server-start, I'm 
fine with replace-and-deprecate.

> 
> Name clashes could prevent the flattening.  I haven't checked for them.
> 
> Three more "simple" unions appear to occur only in results:
> 
> * ImageInfoSpecific
> 
>    Occurs in value of commands query-named-block-nodes and query-block.
> 
> * MemoryDeviceInfo
> 
>    Occurs in value of command query-memory-devices.
> 
> * TpmTypeOptions
> 
>    Occurs in value of command query-tpm.
> 
> There, the only way to get rid of nesting is replace & deprecate.
> 
> I'd love to eliminate "simple" unions from the schema language.
> Possible because any "simple" union can also be expressed as a flat
> union.

And less special code to maintain.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


