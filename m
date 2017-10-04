Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzn8S-0005Tz-A2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzn8P-0007lK-4t
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzn8O-0007kc-UL
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:07:01 -0400
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
	<b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b42b017-e216-854f-a4a1-4393811cb69f@redhat.com>
Date: Wed, 4 Oct 2017 19:06:57 +0200
MIME-Version: 1.0
In-Reply-To: <b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 04.10.2017 17:18, Pierre Morel wrote:
> On 04/10/2017 15:53, Thomas Huth wrote:
>> The "sclp" device is just an internal device that can not be instantia=
ted
>> by the users. If they try to use it, they only get a simple error
>> message:
>>
>> $ qemu-system-s390x -nographic -device sclp
>> qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
>> handled by this machine
>>
>> Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
>> a non-pluggable sysbus device, there is really no way that the "sclp"
>> device can be used by the user, so let's set the user_creatable =3D fa=
lse
>> accordingly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 hw/s390x/sclp.c | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 30aefbf..9be0cb8 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void
>> *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->realize =3D sclp_realize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->categ=
ories);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Reason: Creates TYPE_SCLP_EVENT_FACILITY i=
n sclp_init
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * which is a non-pluggable sysbus device
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D false;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc->read_SCP_info =3D read_SCP_info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc->read_storage_element0_info =3D read=
_storage_element0_info;
>>
>=20
> I must miss something.
> Why is the sclp device not a SYS_BUS_DEVICE ?
> The problem seems to come from the heterogeneity of the sclp and sclp
> generated devices.

I wonder whether it should rather be the other way round: Why is
TYPE_SCLP_EVENT_FACILITY a sysbus device? Sysbus is an abstraction for
simple on-board devices, while TYPE_SCLP_EVENT_FACILITY seems rather to
be a pseudo-device... so it should rather simply be of TYPE_DEVICE
instead? Or do I miss something?

 Thomas
