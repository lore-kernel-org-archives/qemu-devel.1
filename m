Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1472076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h34yq3uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1472076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiFTV-0000Cj-H7
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiFSh-0008Dh-Fu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:57:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiFSg-0005cC-5q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591613821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDYIA+dcZWv6n9m/U9J2FGEvSj5aJbCfVaDwOoUPqWA=;
 b=h34yq3uY9CfaQaT40oda+ILXJswR5QW9y8uMX2hPhEw0efE6DlLlk8f7xsdntLdFIgmqij
 xcJgygJAGNEJIhsibxBJgJf0TG0XSlkdal++oL35zChkJ7aKDXI8tygu3yuSdKzPPZHHhg
 4N7dQSd4R7DfyDjJ+XbJPhvsPqe48M0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-xtwe7_w-OGeByMvv82UbCg-1; Mon, 08 Jun 2020 06:56:59 -0400
X-MC-Unique: xtwe7_w-OGeByMvv82UbCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D39B1005510;
 Mon,  8 Jun 2020 10:56:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F1B5C1C5;
 Mon,  8 Jun 2020 10:56:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87FB511386A6; Mon,  8 Jun 2020 12:56:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/55] qdev: Rework how we plug into the parent bus
References: <20200519145551.22836-1-armbru@redhat.com>
 <5f7c749a-ccbe-5ff6-3889-696d5de05fc0@redhat.com>
Date: Mon, 08 Jun 2020 12:56:49 +0200
In-Reply-To: <5f7c749a-ccbe-5ff6-3889-696d5de05fc0@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 08:46:02 +0200")
Message-ID: <878sgxvn9q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/05/20 16:54, Markus Armbruster wrote:
>> Paolo recently suggested "to move the bus argument (and thus
>> qdev_set_parent_bus) to qdev_init"[1], and that it "would be quite
>> large but hopefully scriptable"[2].  Nerd sniped!
>> 
>> The series is big, but at least the bigger patches are all mechanical.
>> 
>> It is based on my "[PATCH 00/24] Fixes around device realization".
>> 
>> I'm abstaining from cc'ing maintainers on mechanical conversions.  I
>> still cc: for patches I deem interesting, with related patches thrown
>> in for context.  Let me know if you think I should cc: more widely.
>> 
>> PATCH 01-02  	Preliminary cleanup
>> PATCH 03     	New qdev infrastructure
>>       	     	Commit message explains why the current state is
>>       	     	problematic, and how my work improves it.
>> PATCH 04-11  	Convert direct users of qdev
>> PATCH 12-16  	Convert PCI
>> PATCH 17-20  	Convert ISA
>> PATCH 21-24  	Convert SSI
>> PATCH 25-28  	Convert USB
>> PATCH 29     	Garbage collection
>> PATCH 30-32  	Convert aux-bus
>> PATCH 33-40  	Clean up around child device initialization
>> PATCH 41-49  	Convert sysbus
>> PATCH 50     	Stop pretending recursive realization is about to become
>>       	     	real
>> PATCH 51-53  	Convert bus-less devices
>> PATCH 54	Garbage collection
>> PATCH 55	Maintain MAINTAINERS
>
> Great stuff, I only had some comments on the commit messages.  I still
> have to review patches 47 and 48 more corefully.

Does this translate into any Reviewed-bys?  On v2, maybe?


