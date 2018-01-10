Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZ9Sm-0000d2-Mm
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZ9Sk-0001MX-4n
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:02:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eZ9Sj-0001Lu-SD
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:02:10 -0500
References: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
	<B2D15215269B544CADD246097EACE7473AB32AAB@DGGEMM505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48f2d18b-b58c-dd08-29ff-34b5f8c2d780@redhat.com>
Date: Wed, 10 Jan 2018 14:01:49 +0800
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB32AAB@DGGEMM505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/4][RFC] tap: do not close fd if only
 vhost failed to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>



On 2018=E5=B9=B401=E6=9C=8810=E6=97=A5 12:18, Zhoujian (jay) wrote:
> Sorry about missing to cc Jason.
>
>
> Close the fd of the tap unconditionally when netdev_add tap,id=3Dnet0,v=
host=3Don failed
> in net_init_tap_one() will make the followed up device_add virtio-net-p=
ci,netdev=3Dnet0
> failed too, which prints:
>
>      TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
>      ioctl() failed: Bad file descriptor
>
> This patch makes the followed up device_add be able to fall back to use=
rspace virtio
> when netdev_add failed with vhost turning on but vhost force flag does =
not set.
>
> Here is the original discussion:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05205.html
>
>
> This is a RFC version, if I'm wrong, please let me know, thanks!
>
> PS: there're two places updated, see below.
>
>
>> -----Original Message-----
>> From: Zhoujian (jay)
>> Sent: Wednesday, January 10, 2018 12:40 AM
>> To: qemu-devel@nongnu.org
>> Cc: mst@redhat.com; imammedo@redhat.com; Huangweidong (C)
>> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; =
Gonglei
>> (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huaw=
ei.com>;
>> Zhoujian (jay) <jianjay.zhou@huawei.com>
>> Subject: [PATCH v5 2/4][RFC] tap: do not close fd if only vhost failed=
 to
>> initialize
>>
>> Making the followed up device_add to fall back to userspace virtio whe=
n
>> netdev_add fails if vhost force flag does not set.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>> ---
>>   net/tap.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 979e622..03f226f 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -642,7 +642,8 @@ static void net_init_tap_one(const NetdevTapOption=
s *tap,
>> NetClientState *peer,
>>                                const char *model, const char *name,
>>                                const char *ifname, const char *script,
>>                                const char *downscript, const char *vho=
stfdname,
>> -                             int vnet_hdr, int fd, Error **errp)
>> +                             int vnet_hdr, int fd, Error **errp,
>> +                             bool *vhost_init_failed)
>>   {
>>       Error *err =3D NULL;
>>       TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr)=
; @@ -
>> 687,6 +688,7 @@ static void net_init_tap_one(const NetdevTapOptions *t=
ap,
>> NetClientState *peer,
>>               vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err)=
;
>>               if (vhostfd =3D=3D -1) {
>>                   error_propagate(errp, err);
>> +                *vhost_init_failed =3D true;
>>                   return;
>>               }
>>           } else {
>> @@ -694,6 +696,7 @@ static void net_init_tap_one(const NetdevTapOption=
s *tap,
>> NetClientState *peer,
>>               if (vhostfd < 0) {
>>                   error_setg_errno(errp, errno,
>>                                    "tap: open vhost char device failed=
");
>> +                *vhost_init_failed =3D true;
>>                   return;
>>               }
>>               fcntl(vhostfd, F_SETFL, O_NONBLOCK); @@ -704,6 +707,7 @@=
 static
>> void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *pee=
r,
>>           if (!s->vhost_net) {
>>               error_setg(errp,
>>                          "vhost-net requested but could not be initial=
ized");
>> +            *vhost_init_failed =3D true;

Why not simply check s->vhost_net after call net_init_tap_one()?

Thanks

>>               return;
>>           }
>>       } else if (vhostfdname) {
>> @@ -748,6 +752,7 @@ int net_init_tap(const Netdev *netdev, const char =
*name,
>>       Error *err =3D NULL;
>>       const char *vhostfdname;
>>       char ifname[128];
>> +    bool vhost_init_failed =3D false;
>>
>>       assert(netdev->type =3D=3D NET_CLIENT_DRIVER_TAP);
>>       tap =3D &netdev->u.tap;
>> @@ -783,7 +788,7 @@ int net_init_tap(const Netdev *netdev, const char =
*name,
>>
>>           net_init_tap_one(tap, peer, "tap", name, NULL,
>>                            script, downscript,
>> -                         vhostfdname, vnet_hdr, fd, &err);
>> +                         vhostfdname, vnet_hdr, fd, &err,
>> + &vhost_init_failed);
>>           if (err) {
>>               error_propagate(errp, err);
>>               return -1;
>> @@ -835,7 +840,7 @@ int net_init_tap(const Netdev *netdev, const char =
*name,
>>               net_init_tap_one(tap, peer, "tap", name, ifname,
>>                                script, downscript,
>>                                tap->has_vhostfds ? vhost_fds[i] : NULL=
,
>> -                             vnet_hdr, fd, &err);
>> +                             vnet_hdr, fd, &err, &vhost_init_failed);
>>               if (err) {
>>                   error_propagate(errp, err);
>>                   goto free_fail;
>> @@ -874,10 +879,12 @@ free_fail:
>>
>>           net_init_tap_one(tap, peer, "bridge", name, ifname,
>>                            script, downscript, vhostfdname,
>> -                         vnet_hdr, fd, &err);
>> +                         vnet_hdr, fd, &err, &vhost_init_failed);
>>           if (err) {
>>               error_propagate(errp, err);
>> -            close(fd);
>> +            if (tap->has_vhostforce && tap->vhostforce && vhost_init_=
failed)
>> {
>> +                close(fd);
>> +            }
> This should be:
>         =20
>          if (!vhost_init_failed || (tap->has_vhostforce && tap->vhostfo=
rce)) {
>              close(fd);
>          }
>
>>               return -1;
>>           }
>>       } else {
>> @@ -913,10 +920,14 @@ free_fail:
>>               net_init_tap_one(tap, peer, "tap", name, ifname,
>>                                i >=3D 1 ? "no" : script,
>>                                i >=3D 1 ? "no" : downscript,
>> -                             vhostfdname, vnet_hdr, fd, &err);
>> +                             vhostfdname, vnet_hdr, fd, &err,
>> +                             &vhost_init_failed);
>>               if (err) {
>>                   error_propagate(errp, err);
>> -                close(fd);
>> +                if (tap->has_vhostforce && tap->vhostforce &&
>> +                        vhost_init_failed) {
>> +                    close(fd);
>> +                }
> Same here, this should be:
>
>           if (!vhost_init_failed || (tap->has_vhostforce && tap->vhostf=
orce)) {
>               close(fd);
>           }
>
>>                   return -1;
>>               }
>>           }
>> --
>> 1.8.3.1
>>
>
