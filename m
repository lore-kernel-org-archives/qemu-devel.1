Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE260C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0977420878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHCUSOVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0977420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUAp-0003W8-2u
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXTy0-0008Tb-6r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXTxv-00066k-2Z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603824302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZryAnamgoYu55ZEggUKNyRi7qSTAnJ9xlJ3QRoHz0lI=;
 b=WHCUSOVatBfUzLrpwc3hRQPOpKSaedX5dg2g129gb1ZaxZKFurtO+PvMQu89/oSup8IaFQ
 QDPHnr/hA7F/4RgCqC3BkJNVbZGTjK5IDTjJL5GQ3zKeH0zdYukXjHgUGVC8OMuHDOXqJE
 uIePtXv9/WBxU6e5L5WLhVziM0IeMnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-voIATndjN1akTHjPflgleA-1; Tue, 27 Oct 2020 14:44:57 -0400
X-MC-Unique: voIATndjN1akTHjPflgleA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CD964ACA;
 Tue, 27 Oct 2020 18:44:51 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4414B5B4BB;
 Tue, 27 Oct 2020 18:44:33 +0000 (UTC)
Subject: Re: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
To: Markus Armbruster <armbru@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-12-eblake@redhat.com>
 <873620vv3i.fsf@dusky.pond.sub.org>
 <677f78ec-4897-558c-1f51-35b6215caf64@redhat.com>
 <87r1pj65pz.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <38da85cd-83db-ea6d-9ebc-5838d776467a@redhat.com>
Date: Tue, 27 Oct 2020 13:44:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87r1pj65pz.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>,
 "open list:GLUSTER" <integration@gluster.org>, stefanha@redhat.com,
 Richard Henderson <rth@twiddle.net>, kwolf@redhat.com,
 vsementsov@virtuozzo.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 10:36 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 10/27/20 5:09 AM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> Anywhere we create a list of just one item or by prepending items
>>>> (typically because order doesn't matter), we can use the now-public
>>>> macro.  But places where we must keep the list in order by appending
>>>> remain open-coded.
>>>
>>> Should we rename the macro to QAPI_LIST_PREPEND()?
>>
>> That would make sense if we add a counterpart QAPI_LIST_APPEND.
> 
> It may make sense even if we don't.  QAPI_LIST_ADD() leaves the reader
> guessing whether we prepend or append.

That's a strong enough argument for me to make the rename in patch 2/11,
with minor rebase fallout in the rest of the series, and then this patch
gets a major rewrite (but I'm already not trying to get this patch into
5.2).


>>>> @@ -1224,10 +1224,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>>>      QTAILQ_FOREACH(mount, &mounts, next) {
>>>>          g_debug("Building guest fsinfo for '%s'", mount->dirname);
>>>>
>>>> -        new = g_malloc0(sizeof(*ret));
>>>
>>> Ugh!  Glad you get rid of this.
>>
>> Yep, C++ reserved words as a C variable name is always awkward.  It was
>> fun cleaning that up (several places in this patch).
> 
> I don't give a rat's ass about C++, actually.  I'm glad you got rid of
> the tacit "@new points to the same type as @ret does".
> 
> Clean:
> 
>              new = g_malloc0(sizeof(*new));
>              new = g_new0(GuestFilesystemInfoList, 1);
> 
> Clean (but I'd use g_new0() instead):
> 
>              new = g_malloc0(sizeof(GuestFilesystemInfoList));
> 
> Dirty:
> 
>              new = g_malloc0(sizeof(X));
> 
> where X is anything else.

Ah, I hadn't even spotted what you disliked, but yes, it makes total
sense that allocating for assignment to one variable by utilizing the
type from another puts unnecessary linkage that the two variables must
have the same type.


>>> Did you miss the spot where we add to this list?
>>>
>>>        /* Go through each extent */
>>>        for (i = 0; i < extents->NumberOfDiskExtents; i++) {
>>>            disk = g_malloc0(sizeof(GuestDiskAddress));
>>>
>>>            /* Disk numbers directly correspond to numbers used in UNCs
>>>             *
>>>             * See documentation for DISK_EXTENT:
>>>             * https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioctl-_disk_extent
>>>             *
>>>             * See also Naming Files, Paths and Namespaces:
>>>             * https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#win32-device-namespaces
>>>             */
>>>            disk->has_dev = true;
>>>            disk->dev = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
>>>                                        extents->Extents[i].DiskNumber);
>>>
>>>            get_single_disk_info(extents->Extents[i].DiskNumber, disk, &local_err);
>>>            if (local_err) {
>>>                error_propagate(errp, local_err);
>>>                goto out;
>>>            }
>>>            cur_item = g_malloc0(sizeof(*list));
>>>            cur_item->value = disk;
>>>            disk = NULL;
>>>            cur_item->next = list;
>>> --->       list = cur_item;
>>>        }
>>
>> This is appending, not prepending.
> 
> One of us is blind, and it might be me :)

Oh, I indeed misread this.  Yes, this is prepending after all, so I'll
use the macro here.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


