Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA66C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E655620787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlM2ZGb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E655620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUOB-0007m2-4g
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUNW-0006xF-Vn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:52:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUNW-0001x7-8r
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l91ByIzyWDx8/5gMQOqCgljDdEdUtl/RgVQeoA1oJvA=;
 b=dlM2ZGb6czLnKU7wxIjxq7GMYYpV93vLJtH3vFVvLUD1QvrJZ22IST9scScb9K7ACpeGQF
 nJlk36+2prde2gedsZJVyp2v7AhmDOy1jLshlrJyPIclXBrI8pPhv6suyFZu6BkaYhELY0
 MwuXbIwEeffFWP44Zwn60hNW+8zBZP8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-iq5gfgRuPnSguMlZxVdpHA-1; Tue, 26 May 2020 03:51:59 -0400
X-MC-Unique: iq5gfgRuPnSguMlZxVdpHA-1
Received: by mail-ej1-f69.google.com with SMTP id h6so6926075ejb.17
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l91ByIzyWDx8/5gMQOqCgljDdEdUtl/RgVQeoA1oJvA=;
 b=tsHS2rEmFY5EZPOWGBrBcn87VYURqYr6xUZKQP5QAFBqGnx5hSjxbti9sIAN4m01Wz
 jdmW4bCr3A5QPO3f6mqWpPvYBo7jOOIdvaYJ/oNn5imq+lasHO+Gd4fwZlc94sOqde/S
 onocJ6SBjoC3jlmh/aqGczppLtTFHMuPlH5JvXn/LLDE+lLHoMG7vTbIDicsYw5BVfIQ
 /ssYd3L0PoVvhXWEo0taQLeampJzh81IYgkqU3bDa7ooIGuFip+yQl975QYnq6EtC+aD
 w50ddawc9kpN7mZ/zQsUJfxIrNF+YZaRVQ7FdoPrtjabqfOv1VTsmTEidaaPql0GMNqP
 S1Wg==
X-Gm-Message-State: AOAM533V2BLl+ZyHx1wnhxsBY+3b1tcVT6PRnnuHFt7F9zXmROYdR4Oh
 VBu3SO7LPcgBFXkcgY1R4KFSXUxAquVx8ZATAmNqoVvavf4eMl070W/hupdoMrD3EG4wuwO+syb
 Onb67zHQwRNMass0=
X-Received: by 2002:a17:906:198d:: with SMTP id
 g13mr25506ejd.281.1590479518668; 
 Tue, 26 May 2020 00:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjejWN4HqhxRsOWkm1lp7xpvtsb45gBSZjSehCRfsrfwwhP7ZEwgzhoOS1oVwsIfsqZkRsLA==
X-Received: by 2002:a17:906:198d:: with SMTP id
 g13mr25488ejd.281.1590479518431; 
 Tue, 26 May 2020 00:51:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id c23sm17181581ejm.116.2020.05.26.00.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:51:57 -0700 (PDT)
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
To: Markus Armbruster <armbru@redhat.com>
References: <5c6028bd-0bab-6c78-90fe-f00e23ab71b9@redhat.com>
 <03AEEA41-0543-4097-8FFB-9E41038F31EE@redhat.com>
 <87k110fqgl.fsf@dusky.pond.sub.org>
 <1c4c75af-a02b-e86f-23b3-a047809988bb@redhat.com>
 <87o8qb9po2.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f956d514-b051-04ac-f555-4deb6065cc1c@redhat.com>
Date: Tue, 26 May 2020 09:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87o8qb9po2.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 08:27, Markus Armbruster wrote:
>> It cannot happen, because a device must be unparented before it's
>> destroyed and unparenting takes care of unrealizing the device.
> 
> I can't see where unparenting takes care of unrealizing.  Can you help
> me?

Hidden in plain sight:

static void device_unparent(Object *obj)
{
    DeviceState *dev = DEVICE(obj);
    BusState *bus;

    if (dev->realized) {
        object_property_set_bool(obj, false, "realized", NULL);
    }
    ...
}

and the call stack is object_unparent -> object_property_del_child ->
object_finalize_child_property (via prop->release) -> class->unparent.

Thanks,

Paolo


