Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF56C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3521655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amhJOO6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F3521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifm4z-0000Q2-Ts
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ifm2g-00075j-Ey
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ifm2e-0003g9-Rw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:35:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ifm2e-0001p0-HE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:35:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDEYclF170505;
 Fri, 13 Dec 2019 14:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=xMiolp/H/Iim5eeBzqEUfs+luAlp1Ehcsbcp9ZRhKjU=;
 b=amhJOO6J2Z7jlSm9FW9iBikWwVto8nXc/7fWuIEjWAFSF1T2E7NpXuTtdzFuA56ynGL6
 0FnoqKA+zNnETwx1wJePKPuF1fihNCjHY+T/s79ycrtOrRkxbAw9dJYVAnrSSv2CtrPn
 ESIBTptdmMUOeahJl5ZfIUiyUwP9kwf2iUFbhIpuGSlXXEc5OwVNTlulhQ6SPWXEADcy
 Fo1P/snfTeYDmmMEIGL470Mf05HtGjCeWOMoem8J7IR6MwnT49JbbVb4v088TD1RnFVr
 P1Km6r3g6J07zhUj6IN99TmZSVsMvRC45FlcdCJB3qvAGo3C7PcX4y2MqvZW8q4riI3N Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2wr4qs1ahr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 14:34:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDEYLWH089828;
 Fri, 13 Dec 2019 14:34:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2wumw78wqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 14:34:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDEXTxa024831;
 Fri, 13 Dec 2019 14:33:30 GMT
Received: from [10.175.208.200] (/10.175.208.200)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Dec 2019 06:33:28 -0800
Subject: Re: [PATCH 092/104] virtiofsd: add man page
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-93-dgilbert@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <378b3033-4ea6-96fc-3301-f3d4c20ed159@oracle.com>
Date: Fri, 13 Dec 2019 14:33:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-93-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 16:38, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   Makefile                       |  7 +++
>   tools/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
>   create mode 100644 tools/virtiofsd/virtiofsd.texi
> 

... deleted ...

> +@c man begin EXAMPLES
> +Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{/var/run/vm001-vhost-fs.sock}:
> +
> +@example
> +host# virtiofsd --socket-path=/var/run/vm001-vhost-fs.sock -o source=/var/lib/fs/vm001
> +host# qemu-system-x86_64 \
> +    -chardev socket,id=char0,path=/var/run/vm001-vhost-fs.sock \
> +    -device vhost-user-fs-pci,chardev=char0,tag=myfs \
> +    -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
> +    -numa node,memdev=mem \
> +    ...
> +guest# mount -t virtio_fs \
> +    -o default_permissions,allow_other,user_id=0,group_id=0,rootmode=040000,dax \
> +    myfs /mnt



Should this be 'mount -t virtiofs myfs /mnt' like on 
https://virtio-fs.gitlab.io/howto-qemu.html ?

otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


