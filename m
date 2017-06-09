Received: from eggs.gnu.org ([2001:4830:134:3::10]:58519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDJQ-0006ji-Rc
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDJN-0002cH-HP
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJDJN-0002c8-9Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:22:21 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d8eedf2b-0e1d-a677-b7d7-8dced658a55d@redhat.com>
Date: Fri, 9 Jun 2017 14:22:15 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 10/10] docs/colo-proxy.txt: Update
 colo-proxy usage of net driver with vnet_header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 17:55, Zhang Chen wrote:
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   docs/colo-proxy.txt | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
> index c4941de..f6a624f 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -182,6 +182,32 @@ Secondary(ip:3.3.3.8):
>   -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
>   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred=
0
>   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1
> +-object filter-rewriter,id=3Df3,netdev=3Dhn0,queue=3Dall
> +
> +If you want to use virtio-net-pci or other driver with vnet_header:

s/virtio-net-pci/virtio-net/ and s/driver/device/

Thanks

> +
> +Primary(ip:3.3.3.3):
> +-netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D=
/etc/qemu-ifdown
> +-device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +-chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,server,nowait
> +-chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server,nowait
> +-chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,server,nowait
> +-chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
> +-chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,server,now=
ait
> +-chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
> +-object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0=
,vnet_hdr_support
> +-object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3D=
compare_out,vnet_hdr_support
> +-object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3D=
compare0,vnet_hdr_support
> +-object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,outdev=3Dcompare_out0,vnet_hdr_support
> +
> +Secondary(ip:3.3.3.8):
> +-netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D=
/etc/qemu-ifdown
> +-device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +-chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
> +-chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> +-object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0=
,vnet_hdr_support
> +-object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred=
1,vnet_hdr_support
> +-object filter-rewriter,id=3Df3,netdev=3Dhn0,queue=3Dall,vnet_hdr_supp=
ort
>  =20
>   Note:
>     a.COLO-proxy must work with COLO-frame and Block-replication.
