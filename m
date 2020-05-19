Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846C32070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTMpDDRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846C32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javP3-0004eC-Ms
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javOQ-00049k-Vf
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:06:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javOP-0008Lp-Jh
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589868379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jtATvTQBNc4suCy7biJO5PlybJPA4W3Qrk6JdztKAzo=;
 b=eTMpDDRdlv4OSVq5K4L4u2ITTMMGq/iWR1MJ+h6aKF+OUwLniXeRRbGbWRL6VR6DLIQNVF
 K87RXgiU2JxVNa99UBE7Ts3r4Y+qAXPQKftNZYW8TqfxmnVek0x1grPW20cBCWfqgbKMl9
 JamUQpoMguxHKUx/NVx2JlEqxFCjrlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-9kGkY2NsO1SQv5NZzyGIYw-1; Tue, 19 May 2020 02:06:18 -0400
X-MC-Unique: 9kGkY2NsO1SQv5NZzyGIYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9218100CC86;
 Tue, 19 May 2020 06:06:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44FB55D9DD;
 Tue, 19 May 2020 06:06:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72C2911358BC; Tue, 19 May 2020 08:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 10/24] macio: Bury unwanted "macio-gpio" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-11-armbru@redhat.com>
 <78981f13-9a12-adac-b2ef-545eccc252dc@ilande.co.uk>
Date: Tue, 19 May 2020 08:06:14 +0200
In-Reply-To: <78981f13-9a12-adac-b2ef-545eccc252dc@ilande.co.uk> (Mark
 Cave-Ayland's message of "Mon, 18 May 2020 21:35:10 +0100")
Message-ID: <87lflo5ui1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 18/05/2020 06:03, Markus Armbruster wrote:
>
>> These devices go with the "via-pmu" device, which is controlled by
>> property "has-pmu".  macio_newworld_init() creates it unconditionally,
>> because the property has not been set then.  macio_newworld_realize()
>> realizes it only when the property is true.  Works, although it can
>> leave an unrealized device hanging around in the QOM composition tree.
>> Affects machine mac99 with via=cuda (default).
>> 
>> Bury the unwanted device by making macio_newworld_realize() unparent
>> it.  Visible in "info qom-tree":
>> 
>>      /machine (mac99-machine)
>>        [...]
>>        /unattached (container)
>>          /device[9] (macio-newworld)
>>            [...]
>>            /escc-legacy-port[8] (qemu:memory-region)
>>            /escc-legacy-port[9] (qemu:memory-region)
>>            /escc-legacy[0] (qemu:memory-region)
>>     -      /gpio (macio-gpio)
>>     -        /gpio[0] (qemu:memory-region)
>>            /ide[0] (macio-ide)
>>              /ide.0 (IDE)
>>              /pmac-ide[0] (qemu:memory-region)
>> 
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: qemu-ppc@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/misc/macio/macio.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index 3779865ab2..b3dddf8be7 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -368,6 +368,8 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
>>          memory_region_add_subregion(&s->bar, 0x16000,
>>                                      sysbus_mmio_get_region(sysbus_dev, 0));
>>      } else {
>> +        object_unparent(OBJECT(&ns->gpio));
>> +
>>          /* CUDA */
>>          object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->cuda),
>>                                  TYPE_CUDA, &error_abort, NULL);
>
> This one is a little more interesting because it comes back to the previous
> discussions around if you have a device that contains other devices, should you init
> all the children in your container device init, and the realize all your children in
> your container device realize?

You have to initialize them in the container's instance_init method to
make their properties accessible.

You have to realize them in the container's realize method if
realization can fail, or if it has visible side effects.

Many, many places keep initialization and realization together.
Historical reasons, ignorance, laziness, all excusable.

Doing both in realize is safe (I think), but you'll have to refactor
when you need to expose the properties for configuration.  Cleaning that
up proactively feels unnecessary.

Doing both in instance_init necessitates a fragile, non-local
correctness argument around "can't fail" and "doesn't do anything
untoward".  Best avoided, I think.

> If so I guess this patch isn't technically wrong, but it is somewhat misleading given
> that the existing init/realize pattern here is incorrect. Perhaps it should go ahead
> and make everything work the "right way"?

The code being patched here works the nice way: instance_init method
macio_newworld_init() initializes ns->gpio, and realize method
macio_realize_ide() realizes it.  Let's keep it that way.


