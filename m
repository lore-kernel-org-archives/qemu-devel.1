Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70FEC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AAA206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e51wxIvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AAA206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFIN-0004ep-JV
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRFHZ-0003mj-Oz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRFHY-0004gv-Ua
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:19:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRFHY-0004cP-GG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587561555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDFsQPzmG+3WbEn8H/jDvNiZ1pEuF1fUzlWstAHuTxg=;
 b=e51wxIvG2KDC/CGSTjyhUqDKR4vtEl01FP77MPEXMkH3F6JQcLrxKk9Wm2GH+RuNJSHIHe
 Evre5i7cMfWEvgEEH0BqbI+yUhb01d+/1AUn07AgH4C/zlLqd0WkRS4KpAyDv8f4aOkETZ
 aY2b8s8u8eOFdSA7eWriTMdlZ+xZ9K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-vcI1EFf_NaazrZb_DLBIig-1; Wed, 22 Apr 2020 09:19:13 -0400
X-MC-Unique: vcI1EFf_NaazrZb_DLBIig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 227B41005510;
 Wed, 22 Apr 2020 13:19:11 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9353760C88;
 Wed, 22 Apr 2020 13:19:10 +0000 (UTC)
Subject: Re: [PATCH v2 14/14] qga: Fix qmp_guest_suspend_{disk, ram}() error
 handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bc42cda9-fb61-c12f-c64f-b2c358c60519@redhat.com>
Date: Wed, 22 Apr 2020 08:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422130719.28225-15-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 8:07 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> 
> qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
> first to check_suspend_mode(), then to acquire_privilege(), then to
> execute_async().  Continuing after errors here can only end in tears.
> For instance, we risk tripping error_setv()'s assertion.
> 
> Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
> Fixes: f54603b6aa765514b2519e74114a2f417759d727
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-win32.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


