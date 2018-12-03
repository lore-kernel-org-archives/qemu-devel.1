Received: from eggs.gnu.org ([2001:4830:134:3::10]:37476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl9g-0005t1-53
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl9b-0007WP-7O
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:08:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTl9b-0007Vj-1z
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:08:39 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-4-jasowang@redhat.com>
	<e6049f2d-36b3-04b7-18ea-e0eebae5777c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e36156d-a392-0d18-4cc6-df233772fa40@redhat.com>
Date: Mon, 3 Dec 2018 18:08:28 +0800
MIME-Version: 1.0
In-Reply-To: <e6049f2d-36b3-04b7-18ea-e0eebae5777c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.1 3/4] virtio-net-test: accept
 variable length argument in pci_test_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: liq3ea@gmail.com, ppandit@redhat.com, liq3ea@163.com, pbonzini@redhat.com, mst@redhat.com


On 2018/11/30 =E4=B8=8B=E5=8D=8811:02, Eric Blake wrote:
> On 11/28/18 9:12 PM, Jason Wang wrote:
>> This allows flexibility to be reused for all kinds of command line
>> used by other tests.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> =C2=A0 tests/virtio-net-test.c | 17 +++++++++++------
>> =C2=A0 1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
>> index 231e7c767e..33d26ab079 100644
>> --- a/tests/virtio-net-test.c
>> +++ b/tests/virtio-net-test.c
>> @@ -51,17 +51,20 @@ static QVirtioPCIDevice=20
>> *virtio_net_pci_init(QPCIBus *bus, int slot)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev;
>> =C2=A0 }
>> =C2=A0 -static QOSState *pci_test_start(int socket)
>> +static QOSState *pci_test_start(const char *cmd, ...)
>
> This should probably be tagged with GCC_FMT_ATTR(1, 2).


Ok.


>
>
>> @@ -218,11 +221,13 @@ static void pci_basic(gconstpointer data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QVirtQueue *tvq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int socket) =3D data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int sv[2], ret;
>> +=C2=A0=C2=A0=C2=A0 const char *cmd =3D "-netdev socket,fd=3D%d,id=3Dh=
s0 -device "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virtio-net-pci=
,netdev=3Dhs0";
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D socketpair(PF_UNIX, SOCK=
_STREAM, 0, sv);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmpint(ret, !=3D, -1);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 qs =3D pci_test_start(sv[1]);
>> +=C2=A0=C2=A0=C2=A0 qs =3D pci_test_start(cmd, sv[1]);
>
> Do you really need an intermediate 'cmd' variable, or can you just=20
> inline the string constant command at the point of the call?=20
> -Wformat=3Dnon-literal may warn if you don't inline.
>

Fixed and post V4.

Thanks
