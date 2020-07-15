Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A1C433F7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B682065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUgpfsw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B682065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviYH-0004zZ-In
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jviXP-0004YR-LB
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:37:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jviXN-0005fl-Oc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594823852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xzMN/nz2MzB/U0PZCalICT7o3gXKSTQ2LLc8gwVmpOk=;
 b=VUgpfsw/h5gW/v3g0y+azLXajNTEPbd5FAdTsy0p2qsdmWsy5NwVqgizUnSaAxLHbgBBfu
 msLI85S5Yv6yeKHFpKfuvKXLUqAJFPpe2bFadK641zEBQv36zjHqiH8eSUq4YZWsisrR8H
 6bj5VEPMF5uFZSR03EBi/wUuBoIEo2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-87vCqAviPvmKG_mR9KYd1A-1; Wed, 15 Jul 2020 10:37:30 -0400
X-MC-Unique: 87vCqAviPvmKG_mR9KYd1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64A81030C53;
 Wed, 15 Jul 2020 14:37:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 901911053B14;
 Wed, 15 Jul 2020 14:37:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 066D111386A6; Wed, 15 Jul 2020 16:37:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pratik Parvati <pratikp@vayavyalabs.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
Date: Wed, 15 Jul 2020 16:37:18 +0200
In-Reply-To: <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 (Pratik Parvati's message of "Wed, 15 Jul 2020 19:28:24 +0530")
Message-ID: <87lfjkvo81.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pratik Parvati <pratikp@vayavyalabs.com> writes:

> Hi Markus and Philippe,
>
> Thanks for your reply. Now I am pretty clear about Qdev and sysbus helper
> function.
>
> Can you please explain to me in brief on buses and device hierarchies (i.e.
> BusState and DeviceState) and how they are related to each other? As I can
> see, the DeviceState class inherits the BusState
>
> struct DeviceState {
>     /*< private >*/
>     Object parent_obj;
>     /*< public >*/
>
>     const char *id;
>     char *canonical_path;
>     bool realized;
>     bool pending_deleted_event;
>     QemuOpts *opts;
>     int hotplugged;
>     bool allow_unplug_during_migration;
>     BusState *parent_bus; \\ BusState is inherited here
>     QLIST_HEAD(, NamedGPIOList) gpios;
>     QLIST_HEAD(, BusState) child_bus;
>     int num_child_bus;
>     int instance_id_alias;
>     int alias_required_for_version;
>     ResettableState reset;
> };
>
> and BusState, in turn, inherits the DeviceState as
>
> /**
>  * BusState:
>  * @hotplug_handler: link to a hotplug handler associated with bus.
>  * @reset: ResettableState for the bus; handled by Resettable interface.
>  */struct BusState {
>     Object obj;
>     DeviceState *parent; \\ DeviceState is inherited here
>     char *name;
>     HotplugHandler *hotplug_handler;
>     int max_index;
>     bool realized;
>     int num_children;
>     QTAILQ_HEAD(, BusChild) children;
>     QLIST_ENTRY(BusState) sibling;
>     ResettableState reset;
> };
>
> I am a bit confused. Can you brief me this relation!

We sorely lack introductory documentation on both qdev and QOM.  I
believe most developers are more or less confused about them most of the
time.  I've done a bit of work on both, so I'm probably less confused
than average.  I'm cc'ing maintainers in the hope of reducing average
confusion among participants in this thread.

DeviceState does not inherit from BusState, and BusState does not
inherit from DeviceState.  The relation you marked in the code is
actually "has a".

A DeviceState may have a BusState, namely the bus the device is plugged
into.  "May", because some devices are bus-less (their
DEVICE_GET_CLASS(dev)->bus_type is null), and the others get plugged
into their bus only at realize time.

Example: PCI device "pci-serial" plugs into a PCI bus.

Example: device "serial" does not plug into a bus (its used as component
device of "pci-serial" and other devices).

Example: device "pc-dimm" does not plug into a bus.

A bus has a DeviceState, namely the device providing this bus.

Example: device "i440FX-pcihost" provides PCI bus "pci.0".

Both DeviceState and BusState are QOM subtypes of Object.  I prefer to
avoid use of "inherit" for that, because it can mean different things to
different people.


