Received: from eggs.gnu.org ([2001:4830:134:3::10]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFoel-00033d-5Y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFoei-0004Pn-1j
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dFoeh-0004PX-Op
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:26:19 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170526142858.19931-6-maxime.coquelin@redhat.com>
	<20170530211512-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <89302a0b-c140-a9b0-32e7-9c140247c28e@redhat.com>
Date: Tue, 30 May 2017 23:26:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170530211512-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] vhost-user: add slave-req-fd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 05/30/2017 08:17 PM, Michael S. Tsirkin wrote:
> On Fri, May 26, 2017 at 04:28:57PM +0200, Maxime Coquelin wrote:
>> From: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
>>
>> Learn to give a socket to the slave to let him make requests to the
>> master.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
>> Signed-off-by: Maxime Coquelin<maxime.coquelin@redhat.com>
>> ---
>>   docs/specs/vhost-user.txt |  32 +++++++++++-
>>   hw/virtio/vhost-user.c    | 127 ++++++++++++++++++++++++++++++++++++=
++++++++++
>>   2 files changed, 157 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
>> index 036890f..5fa7016 100644
>> --- a/docs/specs/vhost-user.txt
>> +++ b/docs/specs/vhost-user.txt
>> @@ -139,6 +139,7 @@ in the ancillary data:
>>    * VHOST_USER_SET_VRING_KICK
>>    * VHOST_USER_SET_VRING_CALL
>>    * VHOST_USER_SET_VRING_ERR
>> + * VHOST_USER_SET_SLAVE_REQ_FD
>>  =20
>>   If Master is unable to send the full message or receives a wrong rep=
ly it will
>>   close the connection. An optional reconnection mechanism can be impl=
emented.
>> @@ -252,6 +253,18 @@ Once the source has finished migration, rings wil=
l be stopped by
>>   the source. No further update must be done before rings are
>>   restarted.
>>  =20
>> +Slave communication
>> +-------------------
>> +
>> +An optional communication channel is provided if the slave declares
>> +VHOST_USER_PROTOCOL_F_SLAVE_REQ protocol feature, to allow the slave =
to make
>> +requests to the master.
>> +
>> +The fd is provided via VHOST_USER_SET_SLAVE_REQ_FD ancillary data.
>> +
>> +A slave may then send VHOST_USER_SLAVE_* messages to the master
>> +using this fd communication channel.
>> +
>>   Protocol features
>>   -----------------
>>  =20
>> @@ -260,9 +273,10 @@ Protocol features
>>   #define VHOST_USER_PROTOCOL_F_RARP           2
>>   #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
>>   #define VHOST_USER_PROTOCOL_F_MTU            4
>> +#define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>>  =20
>> -Message types
>> --------------
>> +Master message types
>> +--------------------
>>  =20
>>    * VHOST_USER_GET_FEATURES
>>  =20
>=20
> So down the road, we should make sure a device without
> VHOST_USER_PROTOCOL_F_SLAVE_REQ does not advertise IOMMU
> since you don't handle these messages otherwise.

Right, I will add a check to ensure this, and make this clearer
in the IOMMU spec part.

Thanks,
Maxime
