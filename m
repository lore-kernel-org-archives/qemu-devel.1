Received: from eggs.gnu.org ([2001:4830:134:3::10]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZa7q-0006jp-6d
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZa7m-0002OM-82
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eZa7l-0002M4-Vb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:30:18 -0500
References: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
	<B2D15215269B544CADD246097EACE7473AB32AAB@DGGEMM505-MBS.china.huawei.com>
	<48f2d18b-b58c-dd08-29ff-34b5f8c2d780@redhat.com>
	<B2D15215269B544CADD246097EACE7473AB32F8F@DGGEMM505-MBS.china.huawei.com>
	<a3072d45-f628-418a-e293-83dff4d73f54@redhat.com>
	<B2D15215269B544CADD246097EACE7473AB36FE2@DGGEMM505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f90d96be-b58b-8ca1-d236-fe288c0a9b0c@redhat.com>
Date: Thu, 11 Jan 2018 18:30:05 +0800
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB36FE2@DGGEMM505-MBS.china.huawei.com>
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



On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 11:54, Zhoujian (jay) wrote:
> Hi Jason,
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Thursday, January 11, 2018 11:35 AM
>> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org
>> Cc: Huangweidong (C) <weidong.huang@huawei.com>; mst@redhat.com; wangx=
in (U)
>> <wangxinxin.wang@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>=
;
>> imammedo@redhat.com; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
>> Subject: Re: [Qemu-devel] [PATCH v5 2/4][RFC] tap: do not close fd if =
only
>> vhost failed to initialize
>>
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8810=E6=97=A5 15:39, Zhoujian (jay) wrote:
>>>>>> +            *vhost_init_failed =3D true;
>>>> Why not simply check s->vhost_net after call net_init_tap_one()?
>>> s->vhost_net is always NULL if net_init_tap_one() failed, it can't
>> distinguish
>>> failure reasons.
>> On which condition net_init_tap_one() fail but s->vhost_net is set?
> No, it does not exist, so we could not use s->vhost_net to decide
> whether close the fd of tap when error occurred.
>
>
> Maybe the patch below will be much better to understand, please have a =
look.
>
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..a5c5111 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -642,7 +642,8 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>                                const char *model, const char *name,
>                                const char *ifname, const char *script,
>                                const char *downscript, const char *vhos=
tfdname,
> -                             int vnet_hdr, int fd, Error **errp)
> +                             int vnet_hdr, int fd, Error **errp,
> +                             bool *error_is_set_sndbuf)
>   {
>       Error *err =3D NULL;
>       TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr);
> @@ -651,6 +652,9 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>       tap_set_sndbuf(s->fd, tap, &err);
>       if (err) {
>           error_propagate(errp, err);
> +        if (error_is_set_sndbuf) {
> +            *error_is_set_sndbuf =3D true;
> +        }
>           return;
>       }
>  =20
> @@ -748,6 +752,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>       Error *err =3D NULL;
>       const char *vhostfdname;
>       char ifname[128];
> +    bool error_is_set_sndbuf =3D false;
>  =20
>       assert(netdev->type =3D=3D NET_CLIENT_DRIVER_TAP);
>       tap =3D &netdev->u.tap;
> @@ -783,7 +788,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>  =20
>           net_init_tap_one(tap, peer, "tap", name, NULL,
>                            script, downscript,
> -                         vhostfdname, vnet_hdr, fd, &err);
> +                         vhostfdname, vnet_hdr, fd, &err, NULL);
>           if (err) {
>               error_propagate(errp, err);
>               return -1;
> @@ -835,7 +840,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               net_init_tap_one(tap, peer, "tap", name, ifname,
>                                script, downscript,
>                                tap->has_vhostfds ? vhost_fds[i] : NULL,
> -                             vnet_hdr, fd, &err);
> +                             vnet_hdr, fd, &err, NULL);
>               if (err) {
>                   error_propagate(errp, err);
>                   goto free_fail;
> @@ -874,10 +879,13 @@ free_fail:
>  =20
>           net_init_tap_one(tap, peer, "bridge", name, ifname,
>                            script, downscript, vhostfdname,
> -                         vnet_hdr, fd, &err);
> +                         vnet_hdr, fd, &err, &error_is_set_sndbuf);
>           if (err) {
>               error_propagate(errp, err);
> -            close(fd);
> +            if (error_is_set_sndbuf || (tap->has_vhostforce &&
> +                                        tap->vhostforce)) {
> +                close(fd);
> +            }
>               return -1;
>           }
>       } else {
> @@ -913,10 +921,14 @@ free_fail:
>               net_init_tap_one(tap, peer, "tap", name, ifname,
>                                i >=3D 1 ? "no" : script,
>                                i >=3D 1 ? "no" : downscript,
> -                             vhostfdname, vnet_hdr, fd, &err);
> +                             vhostfdname, vnet_hdr, fd, &err,
> +                             &error_is_set_sndbuf);
>               if (err) {
>                   error_propagate(errp, err);
> -                close(fd);
> +                if (error_is_set_sndbuf || (tap->has_vhostforce &&
> +                                            tap->vhostforce)) {
> +                    close(fd);
> +                }
>                   return -1;
>               }
>           }
>
>
>
> PS: I think I do not express the meaning clearly... I can express it in
> Chinese in private if necessary
>
> Regards,
> Jay

That's kind of ugly.

I would suggest do all the correct thing in net_tap_init_one().

Thanks
