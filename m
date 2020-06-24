Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E484120B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSg5pq7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E484120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0gb-0001DI-4u
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0fs-0000nC-66
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:22:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0fp-0002zS-Ll
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592986943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=br1GPiaFaAnYFVR7xm/sUIBxRJ2R2ci8XpWCvV+YlfI=;
 b=MSg5pq7mD+S8GBVfIg8iGpJyPzOh72z/RIVNO8wPfjStdtjVIguzF1odpRxUQuzD40ux6z
 QbHCTbvpRYEZiRXJBcQMXQzeZ3FJBKnQfHkuMmQtBnOqH3dLnD0PaFCCMXWtewQCwu5YHP
 9pn77fZx/mnKd8AnyL0ryaRNHVzkHfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-6Vke0o8JOfSxVoJSwH874g-1; Wed, 24 Jun 2020 04:22:21 -0400
X-MC-Unique: 6Vke0o8JOfSxVoJSwH874g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3289F80400C;
 Wed, 24 Jun 2020 08:22:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B23E60F89;
 Wed, 24 Jun 2020 08:22:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A55A1113846D; Wed, 24 Jun 2020 10:22:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] qom: Allow object_property_add_child() to fail
References: <20200623155452.30954-1-eric.auger@redhat.com>
Date: Wed, 24 Jun 2020 10:22:14 +0200
In-Reply-To: <20200623155452.30954-1-eric.auger@redhat.com> (Eric Auger's
 message of "Tue, 23 Jun 2020 17:54:52 +0200")
Message-ID: <87eeq4dgax.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> writes:

> object_property_add() does not allow object_property_try_add()
> to gracefully fail as &error_abort is passed as an error handle.
>
> However such failure can easily be triggered from the QMP shell when,
> for instance, one attempts to create an object with an id that already
> exists:
>
> For instance, call twice:
> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
> and QEMU aborts.
>
> This behavior is undesired as a user/management application mistake
> in reusing a property ID shouldn't result in loss of the VM and live
> data within.
>
> This patch introduces two new functions, object_property_add_err() and
> object_property_add_child_err() whose prototype features an error handle.
> object_property_add_child_err() now gets called from user_creatable_add_type.
> This solution was chosen instead of changing the prototype of existing
> functions because the number of existing callers is huge.
>
> The error now is returned gracefully to the QMP client.
>
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"return": {}}
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate property
> 'mem2' to object (type 'container')"}}
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Recent regression, my fault.  Please point that out, and add

  Fixes: d2623129a7dec1d3041ad1221dda1ca49c667532


