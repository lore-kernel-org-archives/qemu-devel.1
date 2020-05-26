Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA32070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UorbpD0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWAH-0003Kq-Km
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdW9U-0002t9-1D
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:45:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdW9R-0005z5-Js
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590486336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFOYWD2lYI0yWlCWuQIMOipd3Yb0QmTgzVcvmN1mJSU=;
 b=UorbpD0L9oJllC85DB7s4kqLeM3jDV6ZJ3ZmgudqsyrC6R4L6R4ZByaLyL528YCKcF+upu
 Nw1MC1RjauMM555tNcmtao7oR5M7rZxtoC33EXpmHQ8PLCJWw8fEh88mrctDwfAGQaVYtd
 VewFmCWjnTtilIq+Sfud9CgDrzd/qEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-egkSFX69MqKvusFuP3QHFw-1; Tue, 26 May 2020 05:45:32 -0400
X-MC-Unique: egkSFX69MqKvusFuP3QHFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C19680183C;
 Tue, 26 May 2020 09:45:31 +0000 (UTC)
Received: from gondolin (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0851C8ECE0;
 Tue, 26 May 2020 09:45:25 +0000 (UTC)
Date: Tue, 26 May 2020 11:45:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
Message-ID: <20200526114523.65082262.cohuck@redhat.com>
In-Reply-To: <20200519145551.22836-51-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-51-armbru@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 16:55:46 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> init_event_facility() creates the SCLP events bus with two SCLP event
> devices (sclpquiesce and sclp-cpu-hotplug).  It leaves the devices
> unrealized.  A comment explains they will be realized "via the bus".
> 
> The bus's realize method sclp_events_bus_realize() indeed realizes all
> unrealized devices on this bus.  It carries a TODO comment claiming
> this "has to be done in common code".  No other bus realize method
> realizes its devices.
> 
> The common code in question is bus_set_realized(), which has a TODO
> comment asking for recursive realization.  It's been asking for years.
> 
> The only devices sclp_events_bus_realize() will ever realize are the
> two init_event_facility() puts there.
> 
> Simplify as follows:
> 
> * Make the devices members of the event facility instance struct, just
>   like the bus.  object_initialize_child() is simpler than
>   object_property_add_child() and object_unref().
> 
> * Realize them in the event facility realize method.
> 
> This is in line with how such things are done elsewhere.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/s390x/event-facility.c | 59 ++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 35 deletions(-)

So, what should happen with this patch? Should it go with the rest of
the series, or should it go through the s390 tree?


