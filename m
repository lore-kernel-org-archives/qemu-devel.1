Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A93A2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpk7nst0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A93A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJpt-0002ru-GQ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJpJ-0002St-6t
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:11:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJpI-0001Av-H4
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589962303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=USb1uo1agWy8BYBl02HfVQdqixLOt/7Ijmsuwb5OdZ4=;
 b=Bpk7nst06oBsM66PX3ACt7vbjAAlE/seRcYxybwKIl2+X6BSZQOy8S4yJIcN3SehNUAQFu
 ui9min7WcOXwSKSnYYJa+lSg4txNAg+5t5yWtQUFiE7AC4ZB+jcLhmf2kUuxdRVADAWXT2
 bLppeCKqTMdG8i1kDg4qMo/mCsa5Swc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-DckXvjGUOxOBCh0a2JfJOg-1; Wed, 20 May 2020 04:11:39 -0400
X-MC-Unique: DckXvjGUOxOBCh0a2JfJOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFC58464;
 Wed, 20 May 2020 08:11:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9494370873;
 Wed, 20 May 2020 08:11:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 182C511358BC; Wed, 20 May 2020 10:11:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
Date: Wed, 20 May 2020 10:11:31 +0200
In-Reply-To: <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 08:22:35 +0200")
Message-ID: <871rnft498.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/05/20 16:54, Markus Armbruster wrote:
>> +
>> +    object_ref(OBJECT(dev));
>> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate_prepend(errp, err,
>> +                                "Initialization of device %s failed: ",
>> +                                object_get_typename(OBJECT(dev)));
>> +    }
>> +    object_unref(OBJECT(dev));
>
> Why is the ref/unref pair needed?  Should it be done in the realized
> setter instead?

Copied from qdev_init_nofail(), where it is necessary (I figured out why
the hard way).  It doesn't seem to be necessary here, though.  Thanks!


