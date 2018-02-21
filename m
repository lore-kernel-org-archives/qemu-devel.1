Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoXSi-0002Bs-MN
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoXSf-00081d-IL
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:41:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1eoXSf-00080w-ES
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:41:41 -0500
From: Bandan Das <bsd@redhat.com>
References: <20180220225904.16129-1-bsd@redhat.com>
	<20180220225904.16129-5-bsd@redhat.com>
	<20180221093524.GH17096@redhat.com>
Date: Wed, 21 Feb 2018 11:41:31 -0500
In-Reply-To: <20180221093524.GH17096@redhat.com> ("Daniel P.
	\=\?utf-8\?Q\?Ber\?\= \=\?utf-8\?Q\?rang\=C3\=A9\=22's\?\=
	message of "Wed, 21 Feb 2018 09:35:24 +0000")
Message-ID: <jpgpo4yjnwk.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] usb-mtp: Introduce write support
 for MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

>>  #define TYPE_USB_MTP "usb-mtp"
>> @@ -804,6 +815,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s,=
 MTPControl *c)
>>          CMD_GET_OBJECT_HANDLES,
>>          CMD_GET_OBJECT_INFO,
>>          CMD_DELETE_OBJECT,
>> +        CMD_SEND_OBJECT,
>
> Seems we should not advertize this for readonly devices.

Advertising CMD_SEND_OBJECT shows that it's supported but the device is
read-only probably due to a server side setting. It differentiates between
Operation_Not_Supported and Store_Read_Only.

I agree, we should not rely on the initiator to check for this.
I will add a check for readonly when accepting DELETE, OBJECT_INFO
and return the READ_ONLY response code.

Bandan


>>          CMD_GET_OBJECT,
>>          CMD_GET_PARTIAL_OBJECT,
>>          CMD_GET_OBJECT_PROPS_SUPPORTED,
>> @@ -1378,6 +1390,14 @@ static void usb_mtp_command(MTPState *s, MTPContr=
ol *c)
>>          nres =3D 1;
>>          res0 =3D data_in->length;
>>          break;
>> +    case CMD_SEND_OBJECT:
>> +        if (!s->write_pending) {
>> +            usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO,
>> +                                 c->trans, 0, 0, 0, 0);
>> +            return;
>> +        }
>> +        s->data_out =3D usb_mtp_data_alloc(c);
>> +        return;
>>      case CMD_GET_OBJECT_PROPS_SUPPORTED:
>>          if (c->argv[0] !=3D FMT_UNDEFINED_OBJECT &&
>>              c->argv[0] !=3D FMT_ASSOCIATION) {
>> @@ -1472,12 +1492,126 @@ static void usb_mtp_cancel_packet(USBDevice *de=
v, USBPacket *p)
>>      fprintf(stderr, "%s\n", __func__);
>>  }
>>=20=20
>> +static void usb_mtp_write_data(MTPState *s)
>> +{
>> +    MTPData *d =3D s->data_out;
>> +    MTPObject *parent =3D
>> +        usb_mtp_object_lookup(s, s->dataset.parent_handle);
>> +    char *path =3D NULL;
>> +    int rc =3D -1;
>> +    mode_t mask =3D 0644;
>> +
>> +    assert(d !=3D NULL);
>> +
>
>
> Somewhere in here should surely be validating the "readonly" flag.
>
>> +    if (parent =3D=3D NULL || !s->write_pending) {
>> +        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
>> +                             0, 0, 0, 0);
>> +        return;
>> +    }
>> +
>
> Regards,
> Daniel
