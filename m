Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D2EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE37206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5BQKT4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE37206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJ0J-0003ij-75
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 01:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jwIzc-0003C7-Cr
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:33:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jwIzZ-0004v6-Hm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594963983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9kggi+ZEqEOoDN9bqFMB91/EhttHJqL/akxG2l4I1M=;
 b=a5BQKT4SPBjwNirP7GtmmZ+ClIhEJbd8bTb15lENXfPufEPG6QQkWpggZRaf3ocYMZQDjl
 fMrGtUXArUaw71v09BteBmn1LH8QmfIjD/N98904pGJgtnYw4XZ7DubPEcr5upUGb8btyg
 G31rDF/MgeBu5tQeZgKBBd2LuTXn2tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-AVt7XhWCN0ClwNhgV-cpdw-1; Fri, 17 Jul 2020 01:33:02 -0400
X-MC-Unique: AVt7XhWCN0ClwNhgV-cpdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E70E1080;
 Fri, 17 Jul 2020 05:33:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F15F724A9;
 Fri, 17 Jul 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F049611386A6; Fri, 17 Jul 2020 07:32:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH-for-5.2 v2 2/2] block/block-backend: Let
 blk_attach_dev() provide helpful error
References: <20200716123704.6557-1-f4bug@amsat.org>
 <20200716123704.6557-3-f4bug@amsat.org>
 <20200716130440.GT227735@redhat.com>
Date: Fri, 17 Jul 2020 07:32:55 +0200
In-Reply-To: <20200716130440.GT227735@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Thu, 16 Jul 2020 14:04:40 +0100")
Message-ID: <87o8oek8oo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 16, 2020 at 02:37:04PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Let blk_attach_dev() take an Error* object to return helpful
>> information. Adapt the callers.
>>=20
>>   $ qemu-system-arm -M n800
>>   qemu-system-arm: sd_init failed: cannot attach blk 'sd0' to device 'sd=
-card'
>>   blk 'sd0' is already attached by device 'omap2-mmc'
>>   Drive 'sd0' is already in use because it has been automatically connec=
ted to another device
>>   (do you need 'if=3Dnone' in the drive options?)
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> v2: Rebased after 668f62ec62 ("error: Eliminate error_propagate()")
>> ---
>>  include/sysemu/block-backend.h   |  2 +-
>>  block/block-backend.c            | 11 ++++++++++-
>>  hw/block/fdc.c                   |  4 +---
>>  hw/block/swim.c                  |  4 +---
>>  hw/block/xen-block.c             |  5 +++--
>>  hw/core/qdev-properties-system.c | 16 +++++++++-------
>>  hw/ide/qdev.c                    |  4 +---
>>  hw/scsi/scsi-disk.c              |  4 +---
>>  8 files changed, 27 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backe=
nd.h
>> index 8203d7f6f9..118fbad0b4 100644
>> --- a/include/sysemu/block-backend.h
>> +++ b/include/sysemu/block-backend.h
>> @@ -113,7 +113,7 @@ BlockDeviceIoStatus blk_iostatus(const BlockBackend =
*blk);
>>  void blk_iostatus_disable(BlockBackend *blk);
>>  void blk_iostatus_reset(BlockBackend *blk);
>>  void blk_iostatus_set_err(BlockBackend *blk, int error);
>> -int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
>> +int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp);
>>  void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
>>  DeviceState *blk_get_attached_dev(BlockBackend *blk);
>>  char *blk_get_attached_dev_id(BlockBackend *blk);
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 63ff940ef9..b7be0a4619 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -884,12 +884,21 @@ void blk_get_perm(BlockBackend *blk, uint64_t *per=
m, uint64_t *shared_perm)
>> =20
>>  /*
>>   * Attach device model @dev to @blk.
>> + *
>> + * @blk: Block backend
>> + * @dev: Device to attach the block backend to
>> + * @errp: pointer to NULL initialized error object
>> + *
>>   * Return 0 on success, -EBUSY when a device model is attached already.
>>   */
>> -int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
>> +int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp)
>>  {
>>      trace_blk_attach_dev(blk_name(blk), object_get_typename(OBJECT(dev)=
));
>>      if (blk->dev) {
>> +        error_setg(errp, "cannot attach blk '%s' to device '%s'",
>> +                   blk_name(blk), object_get_typename(OBJECT(dev)));
>> +        error_append_hint(errp, "blk '%s' is already attached by device=
 '%s'\n",
>> +                          blk_name(blk), object_get_typename(OBJECT(blk=
->dev)));
>
> I would have a preference for expanding the main error message and not
> using a hint.  Any hint is completely thrown away when using QMP :-(

Hints work best in cases like

    error message
    hint suggesting things to try to fix it, in CLI syntax

    error message rejecting a configuration value
    hint listing possible values, in CLI syntax

Why "in CLI syntax"?  Well, we need to use *some* syntax to be useful.
Hints have always been phrased for the CLI, simply because the hint
feature grew out of my disgust over the loss of lovingly written CLI
hints in the conversion to Error.

Hints in CLI syntax would be misleading QMP.  We never extended QMP to
transport hints.

Hints may tempt you in a case like

    error message that is painfully long, because it really tries hard to e=
xplain, which is laudable in theory, but sadly illegible in practice; also,=
 interminable sentences, meh, this is an error message, not a Joyce novel

to get something like

    terse error message
    Explanation that is rather long, because it really tries hard to
    explain.  It can be multiple sentences, and lines are wrapped at a
    reasonable length.
   =20
Comes out okay in the CLI, but the explanation is lost in QMP.

I don't have a good solution to offer for errors that genuinely need
explaining.


