Received: from eggs.gnu.org ([2001:4830:134:3::10]:58251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehTPi-0002Px-7t
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 23:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehTDe-0003W1-6n
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 23:46:04 -0500
Received: from [45.249.212.35] (port=59528 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ehSQa-0008R9-7Z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 22:54:16 -0500
References: <1516936096-48900-1-git-send-email-jianjay.zhou@huawei.com>
	<0a1502a8-cbba-cf91-bf6b-e6058a4878e5@redhat.com>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <5A73E0BD.2030506@huawei.com>
Date: Fri, 2 Feb 2018 11:53:33 +0800
MIME-Version: 1.0
In-Reply-To: <0a1502a8-cbba-cf91-bf6b-e6058a4878e5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tap: close fd conditionally when error
 occured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: weidong.huang@huawei.com, mst@redhat.com, arei.gonglei@huawei.com, imammedo@redhat.com, wangxinxin.wang@huawei.com

Hi Jason,

On 2018/2/2 11:11, Jason Wang wrote:
>
>
> On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 11:08, Jay Zhou wrote:
>> If netdev_add tap,id=3Dnet0,...,vhost=3Don failed in net_init_tap_one(=
),
>> the followed up device_add virtio-net-pci,netdev=3Dnet0 will fail
>> too, prints:
>>
>>    TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
>>    ioctl() failed: Bad file descriptor
>>
>> The reason is that the fd of tap is closed when error occured after
>> calling net_init_tap_one().
>>
>> The fd should be closed when calling net_init_tap_one failed:
>>    - if tap_set_sndbuf() failed
>>    - if tap_set_sndbuf() succeeded but vhost failed to initialize with
>>      vhostforce flag on
>> The fd should not be closed just because vhost failed to initialize
>> but without vhostforce flag. So the followed up device_add can fall
>> back to userspace virtio successfully.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>> ---
>>   net/tap.c | 40 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 979e622..8042c7d 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -648,12 +648,6 @@ static void net_init_tap_one(const NetdevTapOptio=
ns
>> *tap, NetClientState *peer,
>>       TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr)=
;
>>       int vhostfd;
>> -    tap_set_sndbuf(s->fd, tap, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> -    }
>> -
>>       if (tap->has_fd || tap->has_fds) {
>>           snprintf(s->nc.info_str, sizeof(s->nc.info_str), "fd=3D%d", =
fd);
>>       } else if (tap->has_helper) {
>> @@ -781,6 +775,12 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
>>           vnet_hdr =3D tap_probe_vnet_hdr(fd);
>> +        tap_set_sndbuf(fd, tap, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return -1;
>> +        }
>> +
>>           net_init_tap_one(tap, peer, "tap", name, NULL,
>>                            script, downscript,
>>                            vhostfdname, vnet_hdr, fd, &err);
>> @@ -832,6 +832,12 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
>>                   goto free_fail;
>>               }
>> +            tap_set_sndbuf(fd, tap, &err);
>> +            if (err) {
>> +                error_propagate(errp, err);
>> +                goto free_fail;
>> +            }
>> +
>>               net_init_tap_one(tap, peer, "tap", name, ifname,
>>                                script, downscript,
>>                                tap->has_vhostfds ? vhost_fds[i] : NULL=
,
>> @@ -872,12 +878,21 @@ free_fail:
>>           fcntl(fd, F_SETFL, O_NONBLOCK);
>>           vnet_hdr =3D tap_probe_vnet_hdr(fd);
>> +        tap_set_sndbuf(fd, tap, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            close(fd);
>> +            return -1;
>> +        }
>> +
>>           net_init_tap_one(tap, peer, "bridge", name, ifname,
>>                            script, downscript, vhostfdname,
>>                            vnet_hdr, fd, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> -            close(fd);
>> +            if (tap->has_vhostforce && tap->vhostforce) {
>> +                close(fd);
>> +            }
>>               return -1;
>>           }
>>       } else {
>> @@ -910,13 +925,22 @@ free_fail:
>>                   }
>>               }
>> +            tap_set_sndbuf(fd, tap, &err);
>> +            if (err) {
>> +                error_propagate(errp, err);
>> +                close(fd);
>> +                return -1;
>> +            }
>> +
>>               net_init_tap_one(tap, peer, "tap", name, ifname,
>>                                i >=3D 1 ? "no" : script,
>>                                i >=3D 1 ? "no" : downscript,
>>                                vhostfdname, vnet_hdr, fd, &err);
>>               if (err) {
>>                   error_propagate(errp, err);
>> -                close(fd);
>> +                if (tap->has_vhostforce && tap->vhostforce) {
>> +                    close(fd);
>> +                }
>>                   return -1;
>>               }
>>           }
>
> Hi:
>
> I still fail to understand why not just pass force flag to net_tap_init=
_one(),
> and let it decide?

I'm a little confused here, as you suggested in version 1:

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02933.html

whether or not to close the fd should let the caller decide, so this is
the version 2.

If I misunderstood something, please let me know, thanks!

Regards,
Jay

>
> Thanks
>
>
>
>
> .
>
