Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C78C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020CC217D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9MA3x5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020CC217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTotB-0003c1-3p
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:44:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTos5-0002qZ-A1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTos4-0000qi-IC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:43:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTodZ-0006hY-Rx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588174116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S9uxGuo89lqDHaFh0CjJqlhlEyNKNG44WyZGfy8vqwI=;
 b=i9MA3x5k2PFfsn+yBBqpzuuhxvw1SevqrCIYv48dBinzYDX64dbODE5FFdQuWxd1yZxIf+
 j0noQ16dIx3tYUc/w7i6ogKGwl4ERJbDBTopZib7UWwZZ6+Mtk3mDbBjmx7eEQXXlO9BBl
 ZD5bb627px6tRKPlizSJwONUVdkrZ4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-Q5uklgRuOGCxmWlYyXxRlw-1; Wed, 29 Apr 2020 11:28:30 -0400
X-MC-Unique: Q5uklgRuOGCxmWlYyXxRlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35EF1005510;
 Wed, 29 Apr 2020 15:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A93F710013BD;
 Wed, 29 Apr 2020 15:28:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3264411358BC; Wed, 29 Apr 2020 17:28:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Failing property setters + hardwired devices + -global = a bad day
Date: Wed, 29 Apr 2020 17:28:25 +0200
Message-ID: <87mu6uia5i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's how we represent QOM properties:

    struct ObjectProperty
    {
        gchar *name;
        [...]
        ObjectPropertyAccessor *get;
        ObjectPropertyAccessor *set;
        ObjectPropertyInit *init;
        void *opaque;
        QObject *defval;
    };

=3D The setter =3D

A ->set() method looks like this:

    void TYPE_set_PROP(Object *obj, Visitor *v,
                       const char *name, void *opaque, Error **errp)

The bit to remember for later is that it can fail.

=3D Default defaults =3D

When an object gets created, its memory is zeroed, and then any class
properties with an ->init() are initialized with

    obj->init(obj, prop);

We have just one ->init():

    void object_property_init_defval(Object *obj, ObjectProperty *prop)

It initializes from ->defval using ->set().

Aside: feels overengineered, but let's move on.

For TYPE_DEVICE objects, "static" properties get initialized the same.

Aside: if I know what "static" means, I'll be hanged.

The bit to remember for later is that properties start at zero, and some
have their zero overwritten with ->set().

=3D "Compat" defaults =3D

TYPE_DEVICE objects and the accelerator (the thing you configure with
-accel) next undergo object_apply_compat_props().

TYPE_DEVICE objects do this from ->instance_post_init().

For the accelerator, we do it where we create it, in
do_configure_accelerator().

This provides for defaults that depend on the accelerator, the machine
type, or certain legacy command line option desugaring (don't ask).

These default values are stored as strings, and applied with
object_property_parse(), which uses ->set().

The bit to remember for later is that some properties have their default
default overwritten with ->set() one or more times.

=3D -global defaults =3D

TYPE_DEVICE objects next undergo qdev_prop_set_globals(), still from
->instance_post_init().  This applies the user's -global options.

These default values are also stored as strings, and also applied with
object_property_parse(), which uses ->set().

The bit to remember for later is that some properties have their
built-in default overwritten with ->set() one more time.

=3D Configuration =3D

Now we come to a fork in the road: devices created with configuration
taken from -device / device_add, and devices the code creates by itself.

=3D=3D -device / device_add =3D=3D

This is qdev_device_add().  Works as follows:

    1. create object (this applies the various defaults)
    2. Pass the users KEY=3DVALUE,... to object_property_parse() one by
       one
    3. realize

The bit to remember for later is that properties of user-creatable
devices get overwritten with ->set one final time.

=3D=3D Hardwired devices =3D=3D

Common pattern:

    1. create object (this applies the various defaults)
    2. set properties with qdev_prop_set_FOO() one by one
    3. realize

=3D Handling ->set() failure =3D

Here's how the uses of ->set() we've seen so far handle failure:

* Default defaults

  An ->init() method cannot fail; object_property_init_defval() passes
  &error_abort.

  Rationale: if the defaults we bake into QEMU don't work, it's a
  programming error.

* "Compat" defaults

  do_configure_accelerator() can fail, but an ->instance_post_init()
  method can't; object_apply_compat_props() uses &error_abort, except
  for the legacy command line option desugaring, where it uses
  &error_fatal.

  Rationale: if the defaults we bake into QEMU don't work, it's a
  programming error.  If legacy CLI options can't be applied, it's a
  fatal error.

* -global defaults

  An ->instance_post_init() method can't fail; qdev_prop_set_globals()
  uses &error_fatal.

  Rationale: if the user's -global can't be applied, it's a fatal error.

  Except it *ignores* errors afterward initial configuration (after
  qdev_machine_creation_done()).

  Rationale: silently ignoring the user's -global for hot-plugged
  devices is bad, killing the VM is worse.  We suck.

* -device / device_add

  qdev_device_add() fails cleanly.

  Rationale: sometimes we manage not to suck.

* Hardwired devices

  The qdev_prop_set_FOO() can't fail; they pass &error_abort.

  Rationale: if the configuration we bake into QEMU doesn't work, it's a
  programming error.

  Except qdev_prop_set_drive() can fail.  Of its 43 callers, 9 pass
  &error_abort, 27 pass &error_fatal, and 7 try to handle failure.
  Of these seven, several are obviously wrong.

  Rationale: uh, we like exceptions?

=3D Can this get more depressing? =3D

Yes!

->set() can run many times, yet I found three ->set() methods that can't
handle overwriting non-zero:

* set_netdev() fails with "Property NETDEV doesn't take value VALUE"

  Reproducer:

    $ upstream-qemu -nodefaults -S -monitor stdio -display none -nic user -=
netdev user,id=3Dfoo -global e1000.netdev=3Dfoo
    QEMU 5.0.0 monitor - type 'help' for more information
    (qemu) Unexpected error in error_set_from_qdev_prop_error() at /work/ar=
mbru/qemu/hw/core/qdev-properties.c:1105:
    upstream-qemu: Property 'e1000.netdev' doesn't take value '__org.qemu.n=
ic0
    '
    Aborted (core dumped)

  The abort is courtesy qdev_prop_set_net().

* set_drive() leaves the old value attached to the device, which is wrong

  Reproducer:

    $ upstream-qemu -S -monitor stdio -display none -fda tmp.qcow2 -drive i=
f=3Dnone,file=3Dtest.qcow2 -global isa-fdc.driveA=3Dnone0
    QEMU 5.0.0 monitor - type 'help' for more information
    (qemu) info block
    floppy0 (#block162): tmp.qcow2 (qcow2)
  --->  Attached to:      /machine/unattached/device[16]
        Removable device: not locked, tray closed
        Cache mode:       writeback
        Backing file:     tmp.img (chain depth: 1)

    none0 (#block535): test.qcow2 (qcow2)
  --->  Attached to:      /machine/unattached/device[15]
        Cache mode:       writeback
        Backing file:     f29.raw (chain depth: 1)

    ide1-cd0: [not inserted]
        Attached to:      /machine/unattached/device[23]
        Removable device: not locked, tray closed

    sd0: [not inserted]
        Removable device: not locked, tray closed

  device[15] is "isa-fdc".

  device[16] is the "floppy" hanging of "isa-fdc".  Magic in fdc.c moved
  it from "isa-fdc" (don't ask).

* set_chr() calls qemu_chr_fe_init() again without qemu_chr_fe_deinit(),
  which is wrong

  Reproducer:

    $ upstream-qemu -nodefaults -S -monitor stdio -display none -chardev nu=
ll,id=3Dfoo -chardev null,id=3Dbar -serial chardev:foo -global isa-serial.c=
hardev=3Dbar

The "if the configuration we bake into QEMU doesn't work, it's a
programming error" idea needs amending: "doesn't work with any -global
shenanigans users may come up with".

I guess these ->set() flaws are fixable.

The knee-jerk fix is to have ->set() fail rather than screw up.  This is
what set_netdev() does.  It founders on the amended "if the
configuration we bake into QEMU don't work, it's a programming error"
idea: ->set() can then fail there because -global set it up for failure.

Making all the qdev_prop_set_FOO() users handle errors would be a lot of
work: in addition to the 43 users of qdev_prop_set_drive(), we have more
than 50 of qdev_prop_set_chr() and almost 40 of
qdev_set_nic_properties().  Infeasible for me.  Bye, bye knee-jerk fix.

Is there any sane use for configuring backends via any of the default
mechanisms?

I'm aware of one, but it's outdated: -global isa-fdc.driveA=3D...  Use
-device floppy instead.

I'd love to deprecate -global wholesale, but we can't as long as we
don't have better means to configure onboard devices.  Can we deprecate
its use with backend properties at least?

While we're talking about deprecation: what about use of -global with
hot-plugged devices?  Remember, bad -global gets silently ignored there.


