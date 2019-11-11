Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D0C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA93F206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTovPwVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA93F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6m7-00074M-OZ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iU6lC-0006OY-Gb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iU6lA-0000hG-Nj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:17:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iU6lA-0000h6-HS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573467443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hB+02TOM2itiemu0NxlGKSixLqLWbMMO37xJFMDuthc=;
 b=GTovPwVcavAnM4F70GW3HHutr+TcTFVuDLNcqXoG82U1x9sMDeIE4cDpYMNpp/3f0t0IGG
 Q8NPMr8WS49UEz+b7G/LBgGd9t8USc1Kb8OOo8TjHDHsmXWHxT+VV3jRKa3W8YVrCTAp0Q
 GFOcbUW1vrX0uaVl4t2IxNznSkdyFag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-8eJ0BAopP2iyv2R_OumgQA-1; Mon, 11 Nov 2019 05:16:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED97B107B7D6;
 Mon, 11 Nov 2019 10:16:00 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03F2C3DA3;
 Mon, 11 Nov 2019 10:15:55 +0000 (UTC)
Date: Mon, 11 Nov 2019 11:15:54 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
Message-ID: <20191111101554.m3lwn4divi7643ri@jenstp.localdomain>
References: <20191108104307.125020-1-dgilbert@redhat.com>
 <157323517815.7743.2882918933706185467@37313f22b938>
 <20191108183817.GB2878@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191108183817.GB2878@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8eJ0BAopP2iyv2R_OumgQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 06:38:17PM +0000, Dr. David Alan Gilbert wrote:
>Hi Jens,
>  the unplug failover stuff is triggering an assertion occasionally on
>aarch64; but
>  a) I'm not sure the right way to fix it
>  b) And I'm out for a little over a week
>
>so...

I'll take care of it.=20

>
>* no-reply@patchew.org (no-reply@patchew.org) wrote:
>> Patchew URL: https://patchew.org/QEMU/20191108104307.125020-1-dgilbert@r=
edhat.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the =
testing commands and
>> their output below. If you have Docker installed, you can probably repro=
duce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>>   TEST    check-unit: tests/test-bdrv-drain
>> wait_for_migration_fail: unexpected status status=3Dwait-unplug allow_ac=
tive=3D1
>
>In tests/migration-test.c we've got wait_for_migration_fail, and it's
>expecting the state to be any one of:
>   setup, failed or maybe active
>
>but it's getting surprised by seeing a 'wait-unplug'
>
>So the question is should we see a wait-unplug?
>
>the migration code has:
>
>    if (qemu_savevm_nr_failover_devices()) {
>        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                          MIGRATION_STATUS_WAIT_UNPLUG);
>
>Should qemu_savevm_nr_failover_devices() be true?
>On aarch64 it seems to have a virtio-net device by default
>and qemu_savevm_nr_failover_devices() checks for devices
>having dev_unplug_pending but doesn't call it.
>
>I see two fixes but am not sure which is right:
>   a) Add 'wait-unplug' to the wait_for_migration_fail
>      (easy)
>   b) Actually call dev_unplug_pending in qemu_savevm_nr_failover_devices
>      so that on a guest which has a virtio-net, but no failover device,
>      the state isn't entered.

I also prefer b over a, but I should only set up dev_unplug_pending when
failover=3Don to avoid this. I'll send a patch.

regards
Jens


