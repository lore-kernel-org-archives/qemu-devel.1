Received: from eggs.gnu.org ([2001:4830:134:3::10]:33770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gN7gX-00011x-ON
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gN7gU-0001AQ-Hh
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:47:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gN7gU-0001AE-CY
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:47:10 -0500
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-25-git-send-email-jasowang@redhat.com>
	<20181113154133.GA9113@dimastep-nix>
	<60759e6b-b125-a7ce-b5d1-78ef5bb3f8a0@redhat.com>
	<20181114162335.GA31235@dimastep-nix>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eb191136-36be-1067-ef71-d8203d16aff3@redhat.com>
Date: Thu, 15 Nov 2018 10:47:04 +0800
MIME-Version: 1.0
In-Reply-To: <20181114162335.GA31235@dimastep-nix>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL V2 24/26] net: ignore packet size greater
 than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


On 2018/11/15 =E4=B8=8A=E5=8D=8812:23, Dima Stepanov wrote:
> On Wed, Nov 14, 2018 at 10:59:32AM +0800, Jason Wang wrote:
>> On 2018/11/13 =E4=B8=8B=E5=8D=8811:41, Dima Stepanov wrote:
>>> Hi Jason,
>>>
>>> I know that this patch has been already merged to stable, but i have =
a
>>> question:
>>>
>>> On Fri, Oct 19, 2018 at 11:22:23AM +0800, Jason Wang wrote:
>>>> There should not be a reason for passing a packet size greater than
>>>> INT_MAX. It's usually a hint of bug somewhere, so ignore packet size
>>>> greater than INT_MAX in qemu_deliver_packet_iov()
>>>>
>>>> CC:qemu-stable@nongnu.org
>>>> Reported-by: Daniel Shapira<daniel@twistlock.com>
>>>> Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>> ---
>>>>   net/net.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/net.c b/net/net.c
>>>> index c66847e..07c194a 100644
>>>> --- a/net/net.c
>>>> +++ b/net/net.c
>>>> @@ -712,10 +712,15 @@ ssize_t qemu_deliver_packet_iov(NetClientState=
 *sender,
>>>>                                   void *opaque)
>>>>   {
>>>>       NetClientState *nc =3D opaque;
>>>> +    size_t size =3D iov_size(iov, iovcnt);
>>>>       int ret;
>>>> +    if (size > INT_MAX) {
>>>> +        return size;
>>> Is it okay that the function returns ssize_t (signed), but the type o=
f the
>>> size variable is size_t (unsigned)? For now the top level routine che=
cks
>>> the return value only for 0, but anyway we can return negative value
>>> here instead of positive. What do you think?
>>>
>>> Regards, Dima.
>>>
>> Any non zero value should be ok here. Actually I think because of the
>> conversion from size_t to ssize_t, caller actually see negative value?
> I believe it depends. If long (ssize_t and size_t type) is 8 bytes, the=
n
> the routine can sometimes return positive values and sometimes negative=
.
> I fully agree that in the current case any non zero value should be
> okay. I just wanted to point on the inconsistency in types and as a
> result a return value.


I see, want to post a patch for this?

Thanks


> Dima.
>> Thanks
>>
