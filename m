Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C160207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtDfcAlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C160207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4TN-0006dc-Os
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw4Sj-00068M-3f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:02:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw4Sg-0001Hm-7Z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594908129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rD5EqiNpdOppJF1VZBhryesAPmKgAol6GVQm2tsjP9Y=;
 b=KtDfcAlJtaDJ8wtgX06vJqhk9GZlL/kYWPdAOHRrS7ec4ViGS1EUCBv6EON6PbQJ3mnQLj
 z3Hs0wKvsb2YPHtTKwME9jGMkzLBd/x1xXu4/IE0HdclmpDIxnWrH+M3Jy3qeDATCCVpic
 PT7ElB6h9IkUnrWrWkL8B32uHOBVNnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-MKSuVWHZNNqwZERN59kMtA-1; Thu, 16 Jul 2020 10:02:07 -0400
X-MC-Unique: MKSuVWHZNNqwZERN59kMtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F91E801E6A;
 Thu, 16 Jul 2020 14:01:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC9CE5C221;
 Thu, 16 Jul 2020 14:01:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12B1511385E0; Thu, 16 Jul 2020 16:01:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
Date: Thu, 16 Jul 2020 16:01:18 +0200
In-Reply-To: <20200716044540.GL93134@umbus.fritz.box> (David Gibson's message
 of "Thu, 16 Jul 2020 14:45:40 +1000")
Message-ID: <87eepbmudt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
>> Some recent error handling cleanups unveiled issues with our support of
>> PCI bridges:
>> 
>> 1) QEMU aborts when using non-standard PCI bridge types,
>>    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
>> 
>> $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
>> Unexpected error in object_property_find() at qom/object.c:1240:
>> qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
>> Aborted (core dumped)
>
> Oops, I thought we had a check that we actually had a "pci-bridge"
> device before continuing with the hotplug, but I guess not.
>
>> This happens because we assume all PCI bridge types to have a "chassis_nr"
>> property. This property only exists with the standard PCI bridge type
>> "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
>> much simpler to check the presence of "chassis_nr" earlier.
>
> Hrm, right, 7ef1553dac was not really correct since add_drcs() really
> can fail.

Right.  I failed to see that we can run into a bridge without a
"chassis_nr" here.

>> 2) QEMU abort if same "chassis_nr" value is used several times,
>>    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
>>    object_property_add() & friends"
>> 
>> $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=1 \
>>                         -device pci-bridge,chassis_nr=1
>> Unexpected error in object_property_try_add() at qom/object.c:1167:
>> qemu-system-ppc64: -device pci-bridge,chassis_nr=1: attempt to add duplicate property '40000100' to object (type 'container')
>> Aborted (core dumped)

Before d2623129a7de, the error got *ignored* in
spapr_dr_connector_new():

    SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
                                             uint32_t id)
    {
        SpaprDrc *drc = SPAPR_DR_CONNECTOR(object_new(type));
        char *prop_name;

        drc->id = id;
        drc->owner = owner;
        prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                    spapr_drc_index(drc));
        object_property_add_child(owner, prop_name, OBJECT(drc), &error_abort);
        object_unref(OBJECT(drc));
--->    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
        g_free(prop_name);

        return drc;
    }

I doubt that's healthy.

>> This happens because we assume that "chassis_nr" values are unique, but
>> nobody enforces that and we end up generating duplicate DRC ids. The PCI
>> code doesn't really care for duplicate "chassis_nr" properties since it
>> is only used to initialize the "Chassis Number Register" of the bridge,
>> with no functional impact on QEMU. So, even if passing the same value
>> several times might look weird, it never broke anything before, so
>> I guess we don't necessarily want to enforce strict checking in the PCI
>> code now.
>
> Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
> supposed to be system-unique (well, unique within the PCI domain at
> least, I guess) as part of the hardware spec.  So specifying multiple
> chassis ids the same is a user error, but we need a better failure
> mode.
>
>> Workaround both issues in the PAPR code: check that the bridge has a
>> unique and non null "chassis_nr" when plugging it into its parent bus.
>>
>> Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
>
> Arguably, it's really fixing 7ef1553dac.

I agree 7ef1553dac broke the "use a bridge that doesn't have property
'chassis_nr' case.

I suspect the "duplicate chassis_nr" case has always been broken, and
d2623129a7de merely uncovered it.

If we can trigger the abort with hot-plug, then d2623129a7de made things
materially worse (new way to accidentally kill your guest and maybe lose
data), and I'd add a Fixes: blaming it.

>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>
> I had a few misgivings about the details of this, but I think I've
> convinced myself they're fine.  There's a couple of things I'd like to
> polish, but I'll do that as a follow up.


