Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3FBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853FA2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGpXQK6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853FA2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxt43-0000Ao-Kb
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxt3M-00087u-20
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:15:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxt3J-0002a5-Ia
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595340927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TWZZc08bR/R5gYa4XoMBT7aOMj3w+UIygCk6SaTras=;
 b=KGpXQK6tDHfJO6bnyjObP5epjZYwyLh2DAkvO7ih4YUFhsH0NqEClEbW1uTdOOZ+I8V7e9
 UfxYX/FxjSXahKS57gZ77lq43aCvSvSenbh88YHpKEe8GnYEHIsSHg17L2xAsZv1E9T52/
 gPIMQy0xuDPeU+hB0sloml4iqGWILl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-k4IDA6l3MWyTAJ040FNDrQ-1; Tue, 21 Jul 2020 10:15:23 -0400
X-MC-Unique: k4IDA6l3MWyTAJ040FNDrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2361310059A4;
 Tue, 21 Jul 2020 14:15:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1EBE2B5BF;
 Tue, 21 Jul 2020 14:15:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 272B7111CA27; Tue, 21 Jul 2020 16:15:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] virtio: Drop broken and superfluous
 object_property_set_link()
References: <20200721121153.1128844-1-armbru@redhat.com>
 <17baa82c-9341-4b3d-1e20-27a2c8a88818@redhat.com>
Date: Tue, 21 Jul 2020 16:15:17 +0200
In-Reply-To: <17baa82c-9341-4b3d-1e20-27a2c8a88818@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jul 2020 14:21:01
 +0200")
Message-ID: <87a6zt7y4q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:15:27
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, frederic.konrad@adacore.com,
 arei.gonglei@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/21/20 2:11 PM, Markus Armbruster wrote:
>
> Is there a line missing here?
>
>> virtio_crypto_pci_realize() and copies the value of vcrypto->vdev's
>
>                               ^^^
>

Scratch "and".  I started describing two of the four cases together,
then changed my mind and described just one, keeping other three under
"Same for" below.  I accidentally left the "and" behind.

>> property "cryptodev" to vcrypto's property:
>>=20
>>     object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf=
.rng),
>>                              NULL);
>>=20
>> Since it does so only after realize, this always fails, but the error
>> is ignored.
>>=20
>> It's actually superfluous: vcrypto's property is an alias of
>> vcrypto->vdev's property, created by virtio_instance_init_common().
>>=20
>> Drop the call.
>>=20
>> Same for virtio_ccw_crypto_realize(), virtio_rng_pci_realize(),
>> virtio_ccw_rng_realize().
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>


