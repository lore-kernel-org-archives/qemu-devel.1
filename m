Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE3AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059372072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYmRgCk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059372072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJqs-00047m-8g
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJpz-0003Hl-5m
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:12:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJpy-0001Dj-Fi
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589962345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+cYbCPxxrEHlKBr3J+lP8OgOaDBR6cRzf+f1b6XYZQ=;
 b=YYmRgCk1qefo/zJA3pwN9Zt/fqgSTkiptC3CvuYq9S8D3jVWQpeLrHmzbDzV5WkwREWqb5
 /TzY2WTSRhjUV5LJg8N2ibRGtQM7yp8Z3h9OPXmd/aSxfdvV7hxIIgypCoYR2MpAABs+1V
 hbfzg5pwPYmH53JpRF5IINXeY4rNVKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-MwUF1WMzP9eYxKBlo_Teog-1; Wed, 20 May 2020 04:12:23 -0400
X-MC-Unique: MwUF1WMzP9eYxKBlo_Teog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF032474
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:12:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3FE60610;
 Wed, 20 May 2020 08:12:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9367011358BC; Wed, 20 May 2020 10:12:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/55] qdev: Convert to qdev_unrealize() manually
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-8-armbru@redhat.com>
 <446dad72-8600-3c16-fc8b-d4f16609c2af@redhat.com>
Date: Wed, 20 May 2020 10:12:20 +0200
In-Reply-To: <446dad72-8600-3c16-fc8b-d4f16609c2af@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 08:25:23 +0200")
Message-ID: <87wo57rpnf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/05/20 16:55, Markus Armbruster wrote:
>> @@ -493,6 +493,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>>      return !err;
>>  }
>>  
>> +void qdev_unrealize(DeviceState *dev)
>> +{
>> +    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
>> +}
>> +
>>  /*
>>   * Realize @dev and drop a reference.
>>   * This is like qdev_realize(), except it steals a reference rather
>> @@ -512,11 +517,6 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
>>      return ret;
>>  }
>>  
>> -void qdev_unrealize(DeviceState *dev)
>> -{
>> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
>> -}
>> -
>>  static int qdev_assert_realized_properly(Object *obj, void *opaque)
>>  {
>>      DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
>
> Stray change (to squash in patch 3)?

Accident while reordering my patches for clarity.  Thanks!


