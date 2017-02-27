Received: from eggs.gnu.org ([2001:4830:134:3::10]:43692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciHFm-0002nM-9H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciHFj-0005a2-14
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ciHFi-0005Za-N8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:05:54 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<b0b04c02-7c97-ea04-1e38-99fd9344edae@redhat.com>
	<58AD4F8F.5030703@huawei.com> <58AD5125.4010306@huawei.com>
	<b792c68e-d67a-ac24-26ea-aaf24f1f9437@redhat.com>
	<58B398F8.1020205@huawei.com>
	<c7883f1d-99ed-d082-3eee-7e0c641257e6@redhat.com>
	<58B3A688.5040707@huawei.com>
	<3196d413-e99a-561a-310d-4d2fa93559d9@redhat.com>
	<58B3CCFE.5070909@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <562f8a27-63dc-6be8-ca2d-cf91c1ce4fe8@redhat.com>
Date: Mon, 27 Feb 2017 17:05:48 +0800
MIME-Version: 1.0
In-Reply-To: <58B3CCFE.5070909@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] filter-rewriter: fix memory leak
 for connection in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8827=E6=97=A5 14:53, Hailiang Zhang wrote:
>> I think the issue is that your code can not differ A from B.
>>
>
> We have a parameter 'fin_ack_seq' recording the sequence of
> 'FIN=3D1,ACK=3D1,seq=3Dw,ack=3Du+1' and if the ack value from the oppos=
ite
> side is is 'w+1', we can consider this connection is closed, no ?=20

Let's see what happens, consider VM is doing active close (reuse the=20
figure above):

(VM)
Client:                                    Server:

ESTABLISHED|                               |
            | -> FIN=3D1,seq=3Du   ->           |

handle_secondary():
fin_ack_seq =3D u
tcp_state =3D TCPS_LAST_ACK

FIN_WAIT_1 |                               |
            | <- ACK=3D1,seq=3Dv,ack=3Du+1 <-     |

handle_primary():
fin_ack_seq =3D ack + 1
g_hash_table_remove()

But we probably want it to be removed in TIME_WAIT_CLOSED.

Thanks
