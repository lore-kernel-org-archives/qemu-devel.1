Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7177C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7674F207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB5CpJqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7674F207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTDn-0000yw-NB
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdT3t-0006Kz-Qm
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:27:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdT3q-0003D8-HC
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590474456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MbYIapNYHtq1pOP7/V9J/U44wylxQl0LQTb4S/ZHCNc=;
 b=jB5CpJqEJSWe4tlGpmq6NuRFZ+4fosZ/1dsFHozzR6DOMrEmN66folcLxwEoug4NHfkHku
 El009HUDAFUblJ4n65SvIFirwj/RSXbsGQ0fcfZ+6hn6LS7Hf3YBCosnh02pKOHZeMiihF
 Ot9aV22mi/ZIV0o2bW/OVXSWMbCOFIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-8PpN7Ig5OyWIid4YrbYZHw-1; Tue, 26 May 2020 02:27:33 -0400
X-MC-Unique: 8PpN7Ig5OyWIid4YrbYZHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A2DD835B40;
 Tue, 26 May 2020 06:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59F7979C47;
 Tue, 26 May 2020 06:27:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E09B8113864A; Tue, 26 May 2020 08:27:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
References: <5c6028bd-0bab-6c78-90fe-f00e23ab71b9@redhat.com>
 <03AEEA41-0543-4097-8FFB-9E41038F31EE@redhat.com>
 <87k110fqgl.fsf@dusky.pond.sub.org>
 <1c4c75af-a02b-e86f-23b3-a047809988bb@redhat.com>
Date: Tue, 26 May 2020 08:27:25 +0200
In-Reply-To: <1c4c75af-a02b-e86f-23b3-a047809988bb@redhat.com> (Paolo
 Bonzini's message of "Mon, 25 May 2020 10:26:37 +0200")
Message-ID: <87o8qb9po2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/05/20 09:01, Markus Armbruster wrote:
>>> Just remembered that we fail creating the machine and therefore abort. So not necessary :)
>> True.
>> 
>> But let's review briefly what happens when a realize method fails.
>> 
>> In theory, realize fails cleanly, i.e. doing nothing.  Another attempt
>> could be made then.
>> 
>> In practice, realize failure is always followed by destruction, unless
>> preempted by outright exit(1).
>> 
>> Destroying a device must also destroy its components.
>> 
>> Paolo, is destroying a realized device okay, or does it have to be
>> unrealized first?  I can't see automatic unrealize on destruction...
>
> It cannot happen, because a device must be unparented before it's
> destroyed and unparenting takes care of unrealizing the device.

I can't see where unparenting takes care of unrealizing.  Can you help
me?

>                                                                  So the
> stageobject lifetime should always proceed in this order:
>
>    created
>    created, with parent
>    created, with parent, with bus (if applicable)
>    realizing
>    realized
>    unrealizing
>    unrealized
>    unrealized, without parent, with bus (if applicable)
>    unrealized, without parent, without bus
>    finalizing (without references)
>    finalized
>    freed
>
> Where the second and third would be fixed by moving /machine/unattached
> from device_set_realized to qdev_realize.
>
> Paolo


