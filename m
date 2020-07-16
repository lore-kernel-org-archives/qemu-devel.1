Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D97C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92AB207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX9Yr7wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92AB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwCGm-0002tM-1v
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 18:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jwCG4-0002QB-Bo
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:21:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jwCG1-0007mK-PL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594938096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+q7/sEJ73N6zfPZJBh83bZ1wXwyZ+AGf4cECSGLmj4s=;
 b=dX9Yr7wZKcNB2htFwvCFO5OHks+avWy6XjXx2j8KIsM0+hIKhi7le6NqkoC/e9VOeRajZ8
 dTA5kaXQOlr8FXo7y2CH/TTvmoaw0uaEFZTVkdNfnWfJKea1ZVa0fpK9fDZjBrKedJP0n2
 AsdDLijvOWti3zHI1ITB4Zn+W4mEDK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-dKrHDvqUNzerexU-E5ZBzA-1; Thu, 16 Jul 2020 18:21:33 -0400
X-MC-Unique: dKrHDvqUNzerexU-E5ZBzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F4701085;
 Thu, 16 Jul 2020 22:21:32 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2575D9E4;
 Thu, 16 Jul 2020 22:21:31 +0000 (UTC)
Date: Thu, 16 Jul 2020 18:21:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200716222130.GO1274972@habkost.net>
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfjkvo81.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 18:21:36
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 04:37:18PM +0200, Markus Armbruster wrote:
> Pratik Parvati <pratikp@vayavyalabs.com> writes:
> 
> > Hi Markus and Philippe,
> >
> > Thanks for your reply. Now I am pretty clear about Qdev and sysbus helper
> > function.
> >
> > Can you please explain to me in brief on buses and device hierarchies (i.e.
> > BusState and DeviceState) and how they are related to each other? As I can
> > see, the DeviceState class inherits the BusState
> >
> > struct DeviceState {
> >     /*< private >*/
> >     Object parent_obj;
> >     /*< public >*/
> >
> >     const char *id;
> >     char *canonical_path;
> >     bool realized;
> >     bool pending_deleted_event;
> >     QemuOpts *opts;
> >     int hotplugged;
> >     bool allow_unplug_during_migration;
> >     BusState *parent_bus; \\ BusState is inherited here
> >     QLIST_HEAD(, NamedGPIOList) gpios;
> >     QLIST_HEAD(, BusState) child_bus;
> >     int num_child_bus;
> >     int instance_id_alias;
> >     int alias_required_for_version;
> >     ResettableState reset;
> > };
> >
> > and BusState, in turn, inherits the DeviceState as
> >
> > /**
> >  * BusState:
> >  * @hotplug_handler: link to a hotplug handler associated with bus.
> >  * @reset: ResettableState for the bus; handled by Resettable interface.
> >  */struct BusState {
> >     Object obj;
> >     DeviceState *parent; \\ DeviceState is inherited here
> >     char *name;
> >     HotplugHandler *hotplug_handler;
> >     int max_index;
> >     bool realized;
> >     int num_children;
> >     QTAILQ_HEAD(, BusChild) children;
> >     QLIST_ENTRY(BusState) sibling;
> >     ResettableState reset;
> > };
> >
> > I am a bit confused. Can you brief me this relation!
> 
> We sorely lack introductory documentation on both qdev and QOM.  I
> believe most developers are more or less confused about them most of the
> time.  I've done a bit of work on both, so I'm probably less confused
> than average.  I'm cc'ing maintainers in the hope of reducing average
> confusion among participants in this thread.
> 
> DeviceState does not inherit from BusState, and BusState does not
> inherit from DeviceState.  The relation you marked in the code is
> actually "has a".
> 
> A DeviceState may have a BusState, namely the bus the device is plugged
> into.  "May", because some devices are bus-less (their
> DEVICE_GET_CLASS(dev)->bus_type is null), and the others get plugged
> into their bus only at realize time.
> 
> Example: PCI device "pci-serial" plugs into a PCI bus.
> 
> Example: device "serial" does not plug into a bus (its used as component
> device of "pci-serial" and other devices).
> 
> Example: device "pc-dimm" does not plug into a bus.
> 
> A bus has a DeviceState, namely the device providing this bus.
> 
> Example: device "i440FX-pcihost" provides PCI bus "pci.0".
> 
> Both DeviceState and BusState are QOM subtypes of Object.  I prefer to
> avoid use of "inherit" for that, because it can mean different things to
> different people.

I'd also note that the use of "parent" in the code is also
ambiguous.  It can mean:

* QOM parent type, i.e. TypeInfo.parent.  Related fields:
  * parent_class members of class structs
  * parent_obj members of object structs
* QOM composition tree parent object, i.e. Object::parent
* qdev device parent bus, i.e. DeviceState::parent_bus
* parent device of of qdev bus, i.e. BusState::parent

-- 
Eduardo


