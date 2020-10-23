Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D83C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E870F20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJrn7q1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E870F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Jy-0003X2-Tl
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kVzjC-0002jT-Aw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kVzj7-0007yy-8I
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzr1vALh4LE1d5YLs8VX3KCFJrsTV0Ga25J1vN8fQ7o=;
 b=iJrn7q1CUvhyw92BkCQn8drmF8+sYqGwVpwVy+/8tZayR73xzbcFJgBwphWe3R6+xDJfth
 p/473U7wXQsgRjvkxyWN5m0bqSQ56mhuyYw2D6U1e5tJ9482ZbheYCofXxC9fxi1aJ5Zqc
 pUcTrwcn58hAUVNbecc21Ns4RlNPKE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-XeGeYx_UMLiSG7BwURZ8ow-1; Fri, 23 Oct 2020 12:15:31 -0400
X-MC-Unique: XeGeYx_UMLiSG7BwURZ8ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA46519611BC;
 Fri, 23 Oct 2020 16:15:29 +0000 (UTC)
Received: from [10.3.113.7] (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0441F10016DA;
 Fri, 23 Oct 2020 16:15:25 +0000 (UTC)
Subject: Re: [PATCH v4 1/7] nbd: Utilize QAPI_CLONE for type conversion
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-2-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <647e0bc9-b80b-cb68-f0e7-f132ab73bba0@redhat.com>
Date: Fri, 23 Oct 2020 11:15:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009215533.1194742-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 4:55 PM, Eric Blake wrote:
> Rather than open-coding the translation from the deprecated
> NbdServerAddOptions type to the preferred BlockExportOptionsNbd, it's
> better to utilize QAPI_CLONE_MEMBERS.  This solves a couple of issues:
> first, if we do any more refactoring of the base type (which an
> upcoming patch plans to do), we don't have to revisit the open-coding.
> Second, our assignment to arg->name is fishy: the generated QAPI code
> currently does not visit it if arg->has_name is false, but if it DID
> visit it, we would have introduced a double-free situation when arg is
> finally freed.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev-nbd.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

v5 will fix this nasty bug:


> @@ -195,7 +197,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
>       * the device name as a default here for compatibility.
>       */
>      if (!arg->has_name) {
> -        arg->name = arg->device;
> +        arg->has_name = true;
> +        arg->name = g_steal_pointer(&arg->device);
>      }

This causes assertion failures visible in at least iotest 149 and 192,
because arg->device was left NULL.  Using g_strdup() instead fixes that.

> 
>      export_opts = g_new(BlockExportOptions, 1);
> @@ -205,15 +208,9 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
>          .node_name              = g_strdup(bdrv_get_node_name(bs)),
>          .has_writable           = arg->has_writable,
>          .writable               = arg->writable,
> -        .u.nbd = {
> -            .has_name           = true,
> -            .name               = g_strdup(arg->name),
> -            .has_description    = arg->has_description,
> -            .description        = g_strdup(arg->description),
> -            .has_bitmap         = arg->has_bitmap,
> -            .bitmap             = g_strdup(arg->bitmap),
> -        },
>      };
> +    QAPI_CLONE_MEMBERS(BlockExportOptionsNbd, &export_opts->u.nbd,
> +                       qapi_NbdServerAddOptions_base(arg));
> 
>      /*
>       * nbd-server-add doesn't complain when a read-only device should be
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


