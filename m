Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1769C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626E207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go0Ezf0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626E207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiXxw-0003Yw-TX
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 02:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiXvR-0002H9-H7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:39:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiXvP-0007K0-N8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591684794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zv5BE2KhzcUzubKaV9kWGyuE5pv4vfX1LvcuVzUe5KE=;
 b=go0Ezf0vWsvvkHbAu+9NYjODCONb//ltdT2vI1dnpci/WWKphbxpy+aHPUU7dki2dUUw5a
 GAYvssgwqI2aoknDb35X+oERbnbNM79p1BMyexDjag1EyntGblLQG4Pszfs3Ck+QCkOZSI
 ezphX9jE7PWDsJbGV4uiGRHZ3EzOluc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-3LLireoTOreZTBCL0NYITQ-1; Tue, 09 Jun 2020 02:39:52 -0400
X-MC-Unique: 3LLireoTOreZTBCL0NYITQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECADA107ACCD
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 06:39:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90C9210013D6;
 Tue,  9 Jun 2020 06:39:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0681B11386A6; Tue,  9 Jun 2020 08:39:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 23/24] sd: Hide the qdev-but-not-quite thing created by
 sd_init()
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-24-armbru@redhat.com>
 <9c298cfe-de78-0ee9-5fc0-c58598dd4b71@redhat.com>
Date: Tue, 09 Jun 2020 08:39:49 +0200
In-Reply-To: <9c298cfe-de78-0ee9-5fc0-c58598dd4b71@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 8 Jun 2020 16:24:24
 +0200")
Message-ID: <87lfkwspxm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/28/20 1:04 PM, Markus Armbruster wrote:
>> Commit 260bc9d8aa "hw/sd/sd.c: QOMify" QOMified only the device
>> itself, not its users.  It kept sd_init() around for non-QOMified
>> users.
>>=20
>> More than four years later, three such users remain: omap1 (machines
>> cheetah, sx1, sx1-v1) and omap2 (machines n800, n810) are not
>> QOMified, and pl181 (machines integratorcp, realview-eb,
>> realview-eb-mpcore, realview-pb-a8 realview-pbx-a9, versatileab,
>> versatilepb, vexpress-a15, vexpress-a9) is not QOMified properly.
>>=20
>> The issue I presently have with this: an "sd-card" device should plug
>> into an "sd-bus" (its DeviceClass member bus_type says so), but
>> sd_init() leaves it unplugged.  This is normally a bug (I just fixed
>> some instances), and I'd like to assert proper pluggedness to prevent
>> regressions.  However, the qdev-but-not-quite thing returned by
>> sd_init() would fail the assertion.  Meh.
>>=20
>> Make sd_init() hide it from QOM/qdev.  Visible in "info qom-tree",
>> here's the change for cheetah:
>>=20
>>      /machine (cheetah-machine)
>>        [...]
>>        /unattached (container)
>>          [...]
>>          /device[5] (serial-mm)
>>            /serial (serial)
>>            /serial[0] (qemu:memory-region)
>>     -    /device[6] (sd-card)
>>     -    /device[7] (omap-gpio)
>>     +    /device[6] (omap-gpio)
>>          [rest of device[*] renumbered...]
>>=20
>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
>>  1 file changed, 28 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 3c06a0ac6d..7070a116ea 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -83,6 +83,10 @@ enum SDCardStates {
>>  struct SDState {
>>      DeviceState parent_obj;
>> =20
>> +    /* If true, created by sd_init() for a non-qdevified caller */
>> +    /* TODO purge them with fire */
>> +    bool me_no_qdev_me_kill_mammoth_with_rocks;
>
> Your next patch does not use me_no_qdev_me_kill_mammoth_with_rocks in
> qdev_assert_realized_properly().

It doesn't have to, because this qdev-but-not-quite thing isn't visible
there.

> Suggestion for less ugly hack:
>
> static int qdev_assert_realized_properly(Object *obj, void *opaque)
> {
>     DeviceState *dev =3D DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
>     DeviceClass *dc;
>
>     if (dev) {
>         if (object_dynamic_cast(OBJECT(obj), TYPE_SD_CARD)) {
>             /* bla bla bla */
>             return 17;
>         }
>         dc =3D DEVICE_GET_CLASS(dev);
>         assert(dev->realized);
>         assert(dev->parent_bus || !dc->bus_type);
>     }
>     return 0;
> }

Now qdev_assert_realized_properly() knows about the caveman.  I don't
like that.

My hack keeps the knowledge strictly local, and protects all users of
QOM from getting exposed to the caveman, not just the "realized
properly" assertion.  My hack is locally ugly, but I consider that a
feature ;)

My patch could be made smaller: @me_no_qdev_me_kill_mammoth_with_rocks
exists only to make the parts supporting the caveman more immediately
obvious.

>
>> +
>>      /* SD Memory Card Registers */
>>      uint32_t ocr;
>>      uint8_t scr[8];
>> @@ -129,6 +133,8 @@ struct SDState {
>>      bool cmd_line;
>>  };
>> =20
>> +static void sd_realize(DeviceState *dev, Error **errp);
>> +
>>  static const char *sd_state_name(enum SDCardStates state)
>>  {
>>      static const char *state_name[] =3D {
>> @@ -590,7 +596,7 @@ static void sd_cardchange(void *opaque, bool load, E=
rror **errp)
>>  {
>>      SDState *sd =3D opaque;
>>      DeviceState *dev =3D DEVICE(sd);
>> -    SDBus *sdbus =3D SD_BUS(qdev_get_parent_bus(dev));
>> +    SDBus *sdbus;
>>      bool inserted =3D sd_get_inserted(sd);
>>      bool readonly =3D sd_get_readonly(sd);
>> =20
>> @@ -601,19 +607,17 @@ static void sd_cardchange(void *opaque, bool load,=
 Error **errp)
>>          trace_sdcard_ejected();
>>      }
>> =20
>> -    /* The IRQ notification is for legacy non-QOM SD controller devices=
;
>> -     * QOMified controllers use the SDBus APIs.
>> -     */
>> -    if (sdbus) {
>> -        sdbus_set_inserted(sdbus, inserted);
>> -        if (inserted) {
>> -            sdbus_set_readonly(sdbus, readonly);
>> -        }
>> -    } else {
>> +    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
>>          qemu_set_irq(sd->inserted_cb, inserted);
>>          if (inserted) {
>>              qemu_set_irq(sd->readonly_cb, readonly);
>>          }
>> +    } else {
>> +        sdbus =3D SD_BUS(qdev_get_parent_bus(dev));
>> +        sdbus_set_inserted(sdbus, inserted);
>> +        if (inserted) {
>> +            sdbus_set_readonly(sdbus, readonly);
>> +        }
>>      }
>>  }
>> =20
>> @@ -697,6 +701,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>>  {
>>      Object *obj;
>>      DeviceState *dev;
>> +    SDState *sd;
>>      Error *err =3D NULL;
>> =20
>>      obj =3D object_new(TYPE_SD_CARD);
>> @@ -707,13 +712,24 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>>          return NULL;
>>      }
>>      qdev_prop_set_bit(dev, "spi", is_spi);
>> -    object_property_set_bool(obj, true, "realized", &err);
>> +
>> +    /*
>> +     * Realizing the device properly would put it into the QOM
>> +     * composition tree even though it is not plugged into an
>> +     * appropriate bus.  That's a no-no.  Hide the device from
>> +     * QOM/qdev, and call its qdev realize callback directly.
>> +     */
>> +    object_ref(obj);
>> +    object_unparent(obj);
>> +    sd_realize(dev, &err);
>>      if (err) {
>>          error_reportf_err(err, "sd_init failed: ");
>>          return NULL;
>>      }
>> =20
>> -    return SD_CARD(dev);
>> +    sd =3D SD_CARD(dev);
>> +    sd->me_no_qdev_me_kill_mammoth_with_rocks =3D true;
>> +    return sd;
>>  }
>> =20
>>  void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
>>=20


