Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917D72080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQpFeSzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917D72080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYzg-0006Ap-RD
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyYyo-0005ac-Ux
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyYym-0003Qp-W5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595502096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeRLzb3kM21cmSt2NvxtYtfxkV7kdyTWjSpmfd0rO00=;
 b=MQpFeSziI5is8/DrGV1E9g04Cj26++YOea1P4viCmtshkhgFesTwXKNycMvjEn8Zzr3/4J
 TToQ3KBqpmAKUp1L3sIHSd3TlxRSDMchSaM0qRaWJUmSgCxxVXW3fMJQ85RbLE2CJbI6bP
 gUkZsH2Mvylz3E2PmrxQ/RPDyUR0S3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-hAmsf40XNzSwOFMyXJ5ywQ-1; Thu, 23 Jul 2020 07:01:25 -0400
X-MC-Unique: hAmsf40XNzSwOFMyXJ5ywQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79294106B24F;
 Thu, 23 Jul 2020 11:01:24 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-52.ams2.redhat.com
 [10.36.114.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFDBF8BED5;
 Thu, 23 Jul 2020 11:01:19 +0000 (UTC)
Subject: Re: [PATCH-for-5.1] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
To: Markus Armbruster <armbru@redhat.com>
References: <20200720123521.8135-1-philmd@redhat.com>
 <34e8619f-4301-d746-fe3f-c340040c22c1@redhat.com>
 <87r1t59sj7.fsf@dusky.pond.sub.org>
 <b7bdbf46-b410-3ff7-4536-86b2886dc201@redhat.com>
 <875zaeptqo.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ef6a2a6d-ba81-5ad0-eab0-6686eaf427cb@redhat.com>
Date: Thu, 23 Jul 2020 13:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875zaeptqo.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Igor, and question below

On 07/23/20 09:37, Markus Armbruster wrote:

> You must use ERRP_GUARD() in functions that dereference their @errp
> parameter (so that works even when the argument is null) or pass it to
> error_prepend() or error_append_hint() (so they get reached even when
> the argumentis &error_fatal).
>
> You should use Use ERRP_GUARD() to avoid clumsy error propagation.
>
> You should not use ERRP_GUARD() when propagation is not actually
> needed.

Thank you for the explanation. :)

Two patches from a series (work in progress) that I'd like to raise:

- [PATCH 2/6] x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in use
  http://mid.mail-archive.com/20200720141610.574308-3-imammedo@redhat.com
  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05852.html

- [PATCH 3/6] x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
  http://mid.mail-archive.com/20200720141610.574308-4-imammedo@redhat.com
  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05851.html

Both of these call error_append_hint(errp, ...). I think these functions
are never called against "error_fatal" (they are reached in "device_add"
and "device_del" monitor commands). But just for consistency with the
new rules, should these functions -- ich9_pm_device_pre_plug_cb() and
ich9_pm_device_unplug_request_cb() -- adopt ERRP_GUARD() in those
patches?

(If the answer is "yes", then could you please state that right under
those patches, so the feedback is easier for Igor to collect?

Plus I think commit e3fe3988d78 should be mentioned frequently, because
it's really helpful, and at least I wouldn't have remembered to check
"include/qapi/error.h" for the new rules; mea culpa :/)

Thanks!
Laszlo


