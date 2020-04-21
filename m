Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4AC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33722206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/irwpvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33722206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvmX-0003Zl-SL
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQvjy-0000qS-DM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQvjx-0007Z7-Gc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:27:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jQvjx-0007YH-2M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3RIyp3k3WY4ae/Nr/nbgqE/rLJHMav9wSoI3NqDtmU=;
 b=E/irwpvEpDuYKQy2eZokr7atPMhsIEJkWsTs2wzGfw5coH8agDEMakIpIOsSwijNoMOA2u
 kqPFGPPJm6K3eO4a2G6QofL8kEZJqSs2h1ugelN4f87L/HogJVXB7vkpvVP2V8e92NLdpm
 F6Spyo1srF3vW4r+ffqHFbVxAlmF8o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-HkqSt9wxO8--ome4KF4Szw-1; Tue, 21 Apr 2020 12:27:12 -0400
X-MC-Unique: HkqSt9wxO8--ome4KF4Szw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D77DB23;
 Tue, 21 Apr 2020 16:27:11 +0000 (UTC)
Received: from work-vm (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C53A960C63;
 Tue, 21 Apr 2020 16:27:07 +0000 (UTC)
Date: Tue, 21 Apr 2020 17:27:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 02/17] hw/misc/temp-sensor: Add
 'query-temperature-sensors' QMP command
Message-ID: <20200421162705.GJ3029@work-vm>
References: <20200421121626.23791-1-f4bug@amsat.org>
 <20200421121626.23791-3-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200421121626.23791-3-f4bug@amsat.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Add a command to query current temperature from all sensors able
> to report it:
>=20
>   { "execute": "query-temperature-sensors" }
>   {
>       "return": [
>           {
>               "temperature": 25,
>               "name": "videocore"
>           },
>           {
>               "temperature": 25,
>               "name": "bcm2835-thermal-0"
>           }
>       ]
>   }
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  qapi/misc.json        | 24 ++++++++++++++++++++++
>  hw/misc/temp-sensor.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 99b90ac80b..51881931e2 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1550,3 +1550,27 @@
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> =20
> +##
> +# @TemperatureSensor:
> +#
> +# Temperature sensor information.
> +#
> +# @name: the name of the sensor
> +#
> +# @temperature: the current temperature of the sensor (in C)
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'TemperatureSensor',
> +  'data': { 'name': 'str',
> +            'temperature': 'number' } }
> +
> +##
> +# @query-temperature-sensors:
> +#
> +# Return a list of TemperatureSensor for devices that support
> +# the TYPE_TEMPSENSOR_INTERFACE.
> +#
> +# Since: 5.1
> +##
> +{ 'command': 'query-temperature-sensors', 'returns': ['TemperatureSensor=
']}
> diff --git a/hw/misc/temp-sensor.c b/hw/misc/temp-sensor.c
> index b7c1eb2d87..27750c533d 100644
> --- a/hw/misc/temp-sensor.c
> +++ b/hw/misc/temp-sensor.c
> @@ -10,6 +10,54 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/misc/temp-sensor.h"
> +#include "qapi/qapi-commands-misc.h"
> +#include "qapi/error.h"
> +
> +static int query_temperature_sensors_foreach(Object *obj, void *opaque)
> +{
> +    TemperatureSensorList **list =3D opaque;
> +    TempSensor *sensor;
> +    TempSensorClass *k;
> +
> +    if (!object_dynamic_cast(obj, TYPE_TEMPSENSOR_INTERFACE)) {
> +        return 0;
> +    }
> +
> +    k =3D TEMPSENSOR_INTERFACE_GET_CLASS(obj);
> +    if (!k->get_temperature) {
> +        return 0;
> +    }
> +
> +    sensor =3D TEMPSENSOR_INTERFACE(obj);
> +    for (size_t i =3D 0; i < k->sensor_count; i++) {
> +        TemperatureSensorList *info =3D g_malloc0(sizeof(*info));
> +        TemperatureSensor *value =3D g_malloc0(sizeof(*value));
> +
> +        if (k->get_name) {
> +            value->name =3D g_strdup(k->get_name(sensor, i));
> +        } else {
> +            value->name =3D g_strdup_printf("%s-%zu",
> +                                          object_get_typename(obj), i);
> +        }

How do the names work if you've got multiple of the same device; e.g.
is the get_name() method supposed to return the device path as well as
the sensor name?  if I have an emulated PCI device with two sensors on
and I then instantiate two of the PCI devices, do I get a name with the
PCI path in?

Dave

> +        value->temperature =3D k->get_temperature(sensor, i);
> +
> +        info->value =3D value;
> +        info->next =3D *list;
> +        *list =3D info;
> +    }
> +
> +    return 0;
> +}
> +
> +TemperatureSensorList *qmp_query_temperature_sensors(Error **errp)
> +{
> +    TemperatureSensorList *list =3D NULL;
> +
> +    object_child_foreach_recursive(object_get_root(),
> +                                   query_temperature_sensors_foreach,
> +                                   &list);
> +    return list;
> +}
> =20
>  static TypeInfo tempsensor_interface_type_info =3D {
>      .name =3D TYPE_TEMPSENSOR_INTERFACE,
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


