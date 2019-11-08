Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E71C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4812087E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW7KJpOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4812087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT9AW-0001uL-Fg
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 13:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iT99T-0001Q8-3D
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iT99Q-0001rM-EK
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:38:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iT99Q-0001qD-AL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573238306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KByHflPlHc58HzRs/gAcmPfH/3hoibSYtatpz9m6VwY=;
 b=NW7KJpOI7Js9PFJgCN3URO/6mbD5r4vMSF2mQowzPg4cp3TTIitpZoh3xHEJ5BYfEiDR68
 aHG3ZOcVw90rhLHnkxoHFHIk1Y5SsPmmP/fV9n7fiS67KonsXB+Vd9vzwsXh5u6E+6BcOM
 s2q2gVrnOh5wynYLq6trONWmjRBZ0rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ErjBPe7hN1mZCWAjhlN_dw-1; Fri, 08 Nov 2019 13:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 931CA8017DD;
 Fri,  8 Nov 2019 18:38:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D035D6AE;
 Fri,  8 Nov 2019 18:38:19 +0000 (UTC)
Date: Fri, 8 Nov 2019 18:38:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jfreimann@redhat.com
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
Message-ID: <20191108183817.GB2878@work-vm>
References: <20191108104307.125020-1-dgilbert@redhat.com>
 <157323517815.7743.2882918933706185467@37313f22b938>
MIME-Version: 1.0
In-Reply-To: <157323517815.7743.2882918933706185467@37313f22b938>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ErjBPe7hN1mZCWAjhlN_dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jens,
  the unplug failover stuff is triggering an assertion occasionally on
aarch64; but
  a) I'm not sure the right way to fix it
  b) And I'm out for a little over a week

so...

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20191108104307.125020-1-dgilbert@re=
dhat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   TEST    check-unit: tests/test-bdrv-drain
> wait_for_migration_fail: unexpected status status=3Dwait-unplug allow_act=
ive=3D1

In tests/migration-test.c we've got wait_for_migration_fail, and it's
expecting the state to be any one of:
   setup, failed or maybe active

but it's getting surprised by seeing a 'wait-unplug'

So the question is should we see a wait-unplug?

the migration code has:

    if (qemu_savevm_nr_failover_devices()) {
        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                          MIGRATION_STATUS_WAIT_UNPLUG);

Should qemu_savevm_nr_failover_devices() be true?
On aarch64 it seems to have a virtio-net device by default
and qemu_savevm_nr_failover_devices() checks for devices
having dev_unplug_pending but doesn't call it.

I see two fixes but am not sure which is right:
   a) Add 'wait-unplug' to the wait_for_migration_fail
      (easy)
   b) Actually call dev_unplug_pending in qemu_savevm_nr_failover_devices
      so that on a guest which has a virtio-net, but no failover device,
      the state isn't entered.

I think (b) is better, since we shouldn't be exposing the wait-unplug
event on setups that don't expect it; but I don't understand the unplug
enough to know if this is a safe change.

Thoughts?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


