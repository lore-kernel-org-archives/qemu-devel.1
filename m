Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0D92078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diNOim9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D92078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd6ew-0007qQ-Bu
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 02:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd6dF-00072D-CB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:30:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd6dE-0000SS-Ch
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590388239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YJM9lTB3qX8UiR9F8aM9QWLKWcVXnz4aOpUeRiAOxE=;
 b=diNOim9ykr9XgpmiqT2b4zO0Qln8GU2/ekcnpytGuDcqNJTsLSeRQ5EFe44dyxcaJ2ejfq
 2Jlc4+ZR4yEXjwqmF8515k/3Sty3ZIo7dY3YQBG67S5ZGNbXG/ANtv1mFXG+UQlXixSAjx
 2X65nMFQ/1nEMTTXyFAQzFmIoObm210=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-2Jfr7fiVNyu0-A5VfQyX5w-1; Mon, 25 May 2020 02:30:37 -0400
X-MC-Unique: 2Jfr7fiVNyu0-A5VfQyX5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 598D3107ACCA;
 Mon, 25 May 2020 06:30:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B8CD5D9C5;
 Mon, 25 May 2020 06:30:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17936113864A; Mon, 25 May 2020 08:30:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
 <871rnft498.fsf@dusky.pond.sub.org>
 <c3c59472-9f2a-f30a-deed-36192840a892@redhat.com>
 <871rner7ki.fsf@dusky.pond.sub.org>
 <75f22571-138a-337b-a1c3-e715b1622bae@redhat.com>
Date: Mon, 25 May 2020 08:30:25 +0200
In-Reply-To: <75f22571-138a-337b-a1c3-e715b1622bae@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 18:28:43 +0200")
Message-ID: <87wo50frwe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 20/05/20 16:42, Markus Armbruster wrote:
>> If something goes
>> wrong there, we execute
>> 
>>     fail:
>>         error_propagate(errp, local_err);
>>         if (unattached_parent) {
>>             /*
>>              * Beware, this doesn't just revert
>>              * object_property_add_child(), it also runs bus_remove()!
>>              */
>>             object_unparent(OBJECT(dev));
>>             unattached_count--;
>>         }
>> 
>> and bus_remove() drops the reference count to zero.
>
> Whoa whoa...  I didn't expect this from a failure to realize.

Me neither.  But by the time I understood what's going on here, my
appetite for big, structural QOM changes was pretty much gone, so I
merely added the "Beware" comment.

> I think we should move the whole /machine/unattached dance into
> qdev_realize, and just assert that a device being realized already has a
> parent.  Then the ref/unref _will_ be unnecessary.  In the meanwhile, I
> agree to either keep it or move it inside device_set_realized.

Could be done on top.  I might try for v2, if I can find the time.


