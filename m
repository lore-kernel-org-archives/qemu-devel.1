Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ADC2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT5Gki4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ADC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUH3-0004v3-Tz
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUE3-0000zc-Q7
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUC2-0004C8-7r
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:40:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUC1-0004Bu-KA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588095528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNT5RViUplWAYbgoX/u4+txYoSzeFhpGUX3vACUAgDI=;
 b=YT5Gki4SCxE3KD1nDy3gb52V/LriF8DBPRd/xojrCtrWzAqzS9DjS4WVfTNVp29hw5hm4w
 NrwHKIFYfRzo+W80jb18jFWhfitEPtilGIEemL6h+/FJyEyI3+fED486CpQz7ZvpP0aVNw
 PscCcaH1ZVZQjOi4CLdP5lqf82MnSAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-eQgQTzPeOfKbpqov_sE-Gw-1; Tue, 28 Apr 2020 13:38:46 -0400
X-MC-Unique: eQgQTzPeOfKbpqov_sE-Gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E5D6107ACCA
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 17:38:45 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84B96579A9;
 Tue, 28 Apr 2020 17:38:44 +0000 (UTC)
Subject: Re: [PATCH 01/17] qom: Clearer reference counting in
 object_initialize_childv()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b47f6c7d-09d2-f0d6-54ac-180e4ed485e5@redhat.com>
Date: Tue, 28 Apr 2020 12:38:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qom/object.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 1812f79224..e06c78f9a5 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -571,18 +571,18 @@ void object_initialize_childv(Object *parentobj, const char *propname,
>           }
>       }
>   
> +out:
>       /*
> -     * Since object_property_add_child added a reference to the child object,
> -     * we can drop the reference added by object_initialize(), so the child
> -     * property will own the only reference to the object.
> +     * We want @obj's reference to be 1 on success, 0 on failure.
> +     * On success, it's 2: one taken by object_initialize(), and one
> +     * by object_property_add_child().
> +     * On failure in object_initialize() or earlier, it's 1.
> +     * On failure afterwards, it's also 1: object_unparent() releases
> +     * the reference taken by object_property_add_child().

Useful comment.

>        */
>       object_unref(obj);
>   
> -out:
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        object_unref(obj);
> -    }
> +    error_propagate(errp, local_err);

But looking at just the code (even without comments), this is safe - 
pre-patch, the only way to get to the out: label without a 'goto' is on 
the success path, at which point we can deduce that object_unref() is 
called exactly once whether on the success path or on the local_err 
path, at which point moving the label up and making the object_unref() 
unconditional is the same semantics.  With that hoisted, error_propagate 
is the only thing remaining under an 'if (local_err)' guard, and it is 
safe to call that when there is no error.  No semantic change, at which 
point all that remains to review is the accuracy of the comment.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


