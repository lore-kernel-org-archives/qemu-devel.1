Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D812075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijU3Lwt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D812075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jee33-0002UZ-SO
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 08:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jee2J-0001zi-PN
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:22:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56159
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jee2H-0001cZ-Bg
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590754971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcI9xXuhkpNMXYh628O+C+PRWGCJEwOb245rFfV7jnI=;
 b=ijU3Lwt3Jwb5NuT9u1gKGVLbOEl3x0rfPww0Mb4rKWk28qAJGVQFQP8ik2wbm0lc8W71jM
 5tQBn/xCGVNM9kRK1zkzX1dNmkyLgRUPt/FwtWdMx5sZKLfuG/PbEzpo+H2/jz8P52N71/
 lJcN8Y7cL7bkyaR+whGBM0kzkFDfndU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Ck-41mlQP1yI6QDEZ-VkuA-1; Fri, 29 May 2020 08:22:49 -0400
X-MC-Unique: Ck-41mlQP1yI6QDEZ-VkuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BDA460;
 Fri, 29 May 2020 12:22:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91C1A784AF;
 Fri, 29 May 2020 12:22:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14ACC113864A; Fri, 29 May 2020 14:22:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
 <871rnft498.fsf@dusky.pond.sub.org>
 <c3c59472-9f2a-f30a-deed-36192840a892@redhat.com>
 <871rner7ki.fsf@dusky.pond.sub.org>
Date: Fri, 29 May 2020 14:22:46 +0200
In-Reply-To: <871rner7ki.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 20 May 2020 16:42:53 +0200")
Message-ID: <878shblyll.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
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

Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 20/05/20 10:11, Markus Armbruster wrote:
>>>> On 19/05/20 16:54, Markus Armbruster wrote:
>>>>> +
>>>>> +    object_ref(OBJECT(dev));
>>>>> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>>>> +    if (err) {
>>>>> +        error_propagate_prepend(errp, err,
>>>>> +                                "Initialization of device %s failed: ",
>>>>> +                                object_get_typename(OBJECT(dev)));
>>>>> +    }
>>>>> +    object_unref(OBJECT(dev));
>>>> Why is the ref/unref pair needed?  Should it be done in the realized
>>>> setter instead?
>>> Copied from qdev_init_nofail(), where it is necessary (I figured out why
>>> the hard way).  It doesn't seem to be necessary here, though.  Thanks!
>>
>> Why is it necessary there?  It seems a bit iffy.
>
> My exact thoughts a few days back.  One debugging session later, I
> understood, and put them right back.  Glad we have tests :)
>
> When object_property_set_bool() fails in qdev_init_nofail(), the
> reference count can drop to zero.  Certainly surprised me.  Have a look:
>
>         dev = qdev_create(bus, type_name);
>         // @dev is a weak reference, and @bus holds the only strong one
>         ...
>         qdev_init_nofail(dev);
>
> In qdev_init_nofail():
>
>         // object_ref(OBJECT(dev));
>         object_property_set_bool(OBJECT(dev), true, "realized", &err);
>
> This is a fancy way to call device_set_realized().  If something goes
> wrong there, we execute
>
>     fail:
>         error_propagate(errp, local_err);
>         if (unattached_parent) {
>             /*
>              * Beware, this doesn't just revert
>              * object_property_add_child(), it also runs bus_remove()!
>              */
>             object_unparent(OBJECT(dev));
>             unattached_count--;
>         }
>
> and bus_remove() drops the reference count to zero.
>
> Back in qdev_init_nofail(), we then use after free:
>     
>     if (err) {
>         error_reportf_err(err, "Initialization of device %s failed: ",
> --->                      object_get_typename(OBJECT(dev)));
>         exit(1);
>     }
>     // object_unref(OBJECT(dev));
>
> The ref/unref keeps around @dev long enough for adding @dev's type name
> to the error message.
>
> The equivalent new pattern doesn't have this issue:
>
>         dev = qdev_new(type_name);
>         // @dev is the only reference
>         ...
>         qdev_realize_and_unref(dev, bus, errp);
>
> In qdev_realize(), called via qdev_realize_and_unref():
>
>         qdev_set_parent_bus(dev, bus);
>         // @bus now holds the second reference
>
>         // object_ref(OBJECT(dev));
>         object_property_set_bool(OBJECT(dev), true, "realized", &err);
>
> In device_set_realized(), the reference count drops to one, namely
> @dev's reference.  That one goes away only in qdev_realize_and_unref(),
> after we added @dev's type name to the error message.
>
> However, a boring drive to the supermarket gave me this scenario:
>
>         dev = qdev_new(type_name);
>         // @dev is the only reference
>         ...
>         object_property_add_child(parent, name, OBJECT(dev));
>         // @parent holds the second reference
>         object_unref(dev);
>         // unusual, but not wrong; @parent holds the only reference now
>         ...
>         qdev_realize(dev, bus, errp);
>
> Here, the reference count can drop to zero when device_set_realized()
> fails, and qdev_realize()'s object_get_typename() is a use after free.
>
> Best to keep the ref/unref, I think.

Actually, best to get rid of the "Initialization of device FOO failed: "
prefix, because:

    $ qemu-system-x86_64 -device virtio-blk
    qemu-system-x86_64: -device virtio-blk: Initialization of device virtio-blk-pci failed: Initialization of device virtio-blk-device failed: drive property not set

Ugly as sin.

The prefix exists for cases like this:

    $ qemu-system-x86_64 -vga cirrus -global cirrus-vga.vgamem_mb=99
    qemu-system-x86_64: Initialization of device cirrus-vga failed: Invalid cirrus_vga ram size '99'

Ideally, we'd point to the user configuration that caused the failure,
in this case -global cirrus-vga.vgamem_mb=99.  But that would be work,
so we made do with mentioning the device type.

Prefix pileup is not possible with qdev_init_nofail(), because the error
is immediately fatal there.

With qdev_realize(), realize failure commonly ripples through QOM
composition tree parents all the way to board initialization, and the
prefix gets added at every step.

If we want to keep the prefix, we could keep qdev_init_nofail(), then
figure out when to use it instead of qdev_realize().  That's a lot of
work.  I doubt it's worthwhile now.

I'll drop it.  Speak up if you want me to reconsider.


